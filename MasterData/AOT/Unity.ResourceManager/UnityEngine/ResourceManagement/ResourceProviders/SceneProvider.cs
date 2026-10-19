using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.Profiling;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.SceneManagement;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public class SceneProvider : ISceneProvider2, ISceneProvider
{
	private class SceneOp : AsyncOperationBase<SceneInstance>, IUpdateReceiver
	{
		private bool m_ActivateOnLoad;

		private SceneInstance m_Inst;

		private IResourceLocation m_Location;

		private LoadSceneParameters m_LoadSceneParameters;

		private int m_Priority;

		private AsyncOperationHandle<IList<AsyncOperationHandle>> m_DepOp;

		private ResourceManager m_ResourceManager;

		private ISceneProvider2 m_provider;

		protected override string DebugName => string.Format("Scene({0})", (m_Location == null) ? "Invalid" : AsyncOperationBase<SceneInstance>.ShortenPath(m_ResourceManager.TransformInternalId(m_Location), keepExtension: false));

		protected override float Progress
		{
			get
			{
				float num = 0.9f;
				float num2 = 0.1f;
				float num3 = 0f;
				if (m_Inst.m_Operation != null)
				{
					num3 += m_Inst.m_Operation.progress * num2;
				}
				if (!m_DepOp.IsDone)
				{
					return num3 + m_DepOp.PercentComplete * num;
				}
				return num3 + num;
			}
		}

		public SceneOp(ResourceManager rm, ISceneProvider2 provider)
		{
			m_ResourceManager = rm;
			m_provider = provider;
		}

		internal override DownloadStatus GetDownloadStatus(HashSet<object> visited)
		{
			if (!m_DepOp.IsValid())
			{
				return new DownloadStatus
				{
					IsDone = IsDone
				};
			}
			return m_DepOp.InternalGetDownloadStatus(visited);
		}

		public void Init(IResourceLocation location, LoadSceneMode loadSceneMode, bool activateOnLoad, int priority, AsyncOperationHandle<IList<AsyncOperationHandle>> depOp)
		{
			Init(location, new LoadSceneParameters(loadSceneMode), activateOnLoad, priority, depOp);
		}

		public void Init(IResourceLocation location, LoadSceneParameters loadSceneParameters, bool activateOnLoad, int priority, AsyncOperationHandle<IList<AsyncOperationHandle>> depOp)
		{
			m_DepOp = (depOp.IsValid() ? depOp.Acquire() : depOp);
			m_Location = location;
			m_LoadSceneParameters = loadSceneParameters;
			m_ActivateOnLoad = activateOnLoad;
			m_Priority = priority;
		}

		protected override bool InvokeWaitForCompletion()
		{
			if (m_DepOp.IsValid() && !m_DepOp.IsDone)
			{
				m_DepOp.WaitForCompletion();
			}
			m_RM?.Update(Time.unscaledDeltaTime);
			if (!HasExecuted)
			{
				InvokeExecute();
			}
			Stopwatch stopwatch = new Stopwatch();
			stopwatch.Start();
			while (!IsDone)
			{
				((IUpdateReceiver)this).Update(Time.unscaledDeltaTime);
				if (m_Inst.m_Operation.progress == 0f && stopwatch.ElapsedMilliseconds > 5000)
				{
					throw new Exception("Infinite loop detected within LoadSceneAsync.WaitForCompletion. For more information see the notes under the Scenes section of the \"Synchronous Addressables\" page of the Addressables documentation, or consider using asynchronous scene loading code.");
				}
				if (m_Inst.m_Operation.allowSceneActivation && Mathf.Approximately(m_Inst.m_Operation.progress, 0.9f))
				{
					Result = m_Inst;
					return true;
				}
			}
			return IsDone;
		}

		public override void GetDependencies(List<AsyncOperationHandle> deps)
		{
			if (m_DepOp.IsValid())
			{
				deps.Add(m_DepOp);
			}
		}

		protected override void Execute()
		{
			bool loadingFromBundle = false;
			if (m_DepOp.IsValid())
			{
				foreach (AsyncOperationHandle item in m_DepOp.Result)
				{
					if (item.Result is IAssetBundleResource assetBundleResource && assetBundleResource.GetAssetBundle() != null)
					{
						loadingFromBundle = true;
					}
				}
			}
			if (!m_DepOp.IsValid() || m_DepOp.OperationException == null)
			{
				m_Inst = InternalLoadScene(m_Location, loadingFromBundle, m_LoadSceneParameters, m_ActivateOnLoad, m_Priority);
				((IUpdateReceiver)this).Update(0f);
			}
			else
			{
				Complete(m_Inst, success: false, m_DepOp.OperationException);
			}
			HasExecuted = true;
		}

		internal SceneInstance InternalLoadScene(IResourceLocation location, bool loadingFromBundle, LoadSceneParameters loadSceneParameters, bool activateOnLoad, int priority)
		{
			string path = m_ResourceManager.TransformInternalId(location);
			AsyncOperation asyncOperation = InternalLoad(path, loadingFromBundle, loadSceneParameters);
			asyncOperation.allowSceneActivation = activateOnLoad;
			asyncOperation.priority = priority;
			return new SceneInstance
			{
				m_Operation = asyncOperation,
				Scene = SceneManager.GetSceneAt(SceneManager.sceneCount - 1)
			};
		}

		private AsyncOperation InternalLoad(string path, bool loadingFromBundle, LoadSceneParameters loadSceneParameters)
		{
			ProfilerRuntime.AddSceneOperation(Handle, m_Location, ContentStatus.Loading);
			return SceneManager.LoadSceneAsync(path, loadSceneParameters);
		}

		protected override void Destroy()
		{
			if (m_Inst.Scene.IsValid())
			{
				m_provider.ReleaseScene(m_ResourceManager, Handle, UnloadSceneOptions.None).ReleaseHandleOnCompletion();
			}
			if (m_DepOp.IsValid())
			{
				m_DepOp.Release();
			}
			base.Destroy();
		}

		void IUpdateReceiver.Update(float unscaledDeltaTime)
		{
			if (m_Inst.m_Operation != null && (m_Inst.m_Operation.isDone || (!m_Inst.m_Operation.allowSceneActivation && Mathf.Approximately(m_Inst.m_Operation.progress, 0.9f))))
			{
				m_ResourceManager.RemoveUpdateReciever(this);
				ProfilerRuntime.AddSceneOperation(Handle, m_Location, ContentStatus.Active);
				Complete(m_Inst, true, (string)null);
			}
		}
	}

	private class UnloadSceneOp : AsyncOperationBase<SceneInstance>
	{
		private SceneInstance m_Instance;

		private AsyncOperationHandle<SceneInstance> m_sceneLoadHandle;

		private UnloadSceneOptions m_UnloadOptions;

		protected override float Progress => m_sceneLoadHandle.PercentComplete;

		public void Init(AsyncOperationHandle<SceneInstance> sceneLoadHandle, UnloadSceneOptions options)
		{
			if (sceneLoadHandle.IsValid())
			{
				m_sceneLoadHandle = sceneLoadHandle;
				m_Instance = m_sceneLoadHandle.Result;
			}
			m_UnloadOptions = options;
		}

		protected override void Execute()
		{
			if (m_sceneLoadHandle.IsValid() && m_Instance.Scene.isLoaded)
			{
				ProfilerRuntime.SceneReleased(m_sceneLoadHandle);
				AsyncOperation asyncOperation = SceneManager.UnloadSceneAsync(m_Instance.Scene, m_UnloadOptions);
				if (asyncOperation == null)
				{
					UnloadSceneCompleted(null);
				}
				else
				{
					asyncOperation.completed += UnloadSceneCompleted;
				}
			}
			else
			{
				UnloadSceneCompleted(null);
			}
			HasExecuted = true;
		}

		protected override bool InvokeWaitForCompletion()
		{
			m_RM?.Update(Time.unscaledDeltaTime);
			if (!HasExecuted)
			{
				InvokeExecute();
			}
			Debug.LogWarning("Cannot unload a Scene with WaitForCompletion. Scenes must be unloaded asynchronously.");
			return true;
		}

		private void UnloadSceneCompleted(AsyncOperation obj)
		{
			Complete(m_Instance, success: true, "");
			if (m_sceneLoadHandle.IsValid() && m_sceneLoadHandle.ReferenceCount > 0)
			{
				m_sceneLoadHandle.Release();
			}
		}
	}

	public AsyncOperationHandle<SceneInstance> ProvideScene(ResourceManager resourceManager, IResourceLocation location, LoadSceneMode loadSceneMode, bool activateOnLoad, int priority)
	{
		return ProvideScene(resourceManager, location, new LoadSceneParameters(loadSceneMode), activateOnLoad, priority);
	}

	public AsyncOperationHandle<SceneInstance> ProvideScene(ResourceManager resourceManager, IResourceLocation location, LoadSceneParameters loadSceneParameters, bool activateOnLoad, int priority)
	{
		AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = default;
		if (location.HasDependencies)
		{
			asyncOperationHandle = resourceManager.ProvideResourceGroupCached(location.Dependencies, location.DependencyHashCode, typeof(IAssetBundleResource), null);
		}
		SceneOp sceneOp = new SceneOp(resourceManager, this);
		sceneOp.Init(location, loadSceneParameters, activateOnLoad, priority, asyncOperationHandle);
		AsyncOperationHandle<SceneInstance> result = resourceManager.StartOperation(sceneOp, asyncOperationHandle);
		if (asyncOperationHandle.IsValid())
		{
			asyncOperationHandle.Release();
		}
		return result;
	}

	public AsyncOperationHandle<SceneInstance> ReleaseScene(ResourceManager resourceManager, AsyncOperationHandle<SceneInstance> sceneLoadHandle)
	{
		return ((ISceneProvider2)this).ReleaseScene(resourceManager, sceneLoadHandle, UnloadSceneOptions.None);
	}

	AsyncOperationHandle<SceneInstance> ISceneProvider2.ReleaseScene(ResourceManager resourceManager, AsyncOperationHandle<SceneInstance> sceneLoadHandle, UnloadSceneOptions unloadOptions)
	{
		UnloadSceneOp unloadSceneOp = new UnloadSceneOp();
		unloadSceneOp.Init(sceneLoadHandle, unloadOptions);
		return resourceManager.StartOperation(unloadSceneOp, sceneLoadHandle);
	}
}
