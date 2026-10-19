using System;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine.Profiling;
using UnityEngine.ResourceManagement.Profiling;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("Assets from Bundles Provider")]
public class BundledAssetProvider : ResourceProviderBase
{
	internal class InternalOp
	{
		private AssetBundle m_AssetBundle;

		private AssetBundleRequest m_PreloadRequest;

		private AssetBundleRequest m_RequestOperation;

		private object m_Result;

		private ProvideHandle m_ProvideHandle;

		private string subObjectName;

		internal static T LoadBundleFromDependecies<T>(IList<object> results) where T : class, IAssetBundleResource
		{
			if (results == null || results.Count == 0)
			{
				return null;
			}
			IAssetBundleResource assetBundleResource = null;
			bool flag = true;
			for (int i = 0; i < results.Count; i++)
			{
				if (results[i] is IAssetBundleResource assetBundleResource2)
				{
					assetBundleResource2.GetAssetBundle();
					if (flag)
					{
						assetBundleResource = assetBundleResource2;
					}
					flag = false;
				}
			}
			return assetBundleResource as T;
		}

		public void Start(ProvideHandle provideHandle)
		{
			provideHandle.SetProgressCallback(ProgressCallback);
			provideHandle.SetWaitForCompletionCallback(WaitForCompletionHandler);
			subObjectName = null;
			m_ProvideHandle = provideHandle;
			m_RequestOperation = null;
			List<object> list = new List<object>();
			m_ProvideHandle.GetDependencies(list);
			IAssetBundleResource assetBundleResource = LoadBundleFromDependecies<IAssetBundleResource>(list);
			if (assetBundleResource == null)
			{
				m_ProvideHandle.Complete<AssetBundle>(null, status: false, new Exception("Unable to load dependent bundle from location " + m_ProvideHandle.Location));
				return;
			}
			m_AssetBundle = assetBundleResource.GetAssetBundle();
			if (m_AssetBundle == null)
			{
				m_ProvideHandle.Complete<AssetBundle>(null, status: false, new Exception("Unable to load dependent bundle from location " + m_ProvideHandle.Location));
				return;
			}
			if (assetBundleResource is AssetBundleResource assetBundleResource2)
			{
				m_PreloadRequest = assetBundleResource2.GetAssetPreloadRequest();
			}
			if (m_PreloadRequest == null || m_PreloadRequest.isDone)
			{
				BeginAssetLoad();
				return;
			}
			m_PreloadRequest.completed += (AsyncOperation operation) =>
			{
				BeginAssetLoad();
			};
		}

		private void BeginAssetLoad()
		{
			if (m_AssetBundle == null)
			{
				m_ProvideHandle.Complete<AssetBundle>(null, status: false, new Exception("Unable to load dependent bundle from location " + m_ProvideHandle.Location));
				return;
			}
			string text = m_ProvideHandle.ResourceManager.TransformInternalId(m_ProvideHandle.Location);
			string mainKey;
			string subKey;
			if (m_ProvideHandle.Type.IsArray)
			{
				m_RequestOperation = m_AssetBundle.LoadAssetWithSubAssetsAsync(text, m_ProvideHandle.Type.GetElementType());
			}
			else if (m_ProvideHandle.Type.IsGenericType && typeof(IList<>) == m_ProvideHandle.Type.GetGenericTypeDefinition())
			{
				m_RequestOperation = m_AssetBundle.LoadAssetWithSubAssetsAsync(text, m_ProvideHandle.Type.GetGenericArguments()[0]);
			}
			else if (ResourceManagerConfig.ExtractKeyAndSubKey(text, out mainKey, out subKey))
			{
				subObjectName = subKey;
				m_RequestOperation = m_AssetBundle.LoadAssetWithSubAssetsAsync(mainKey, m_ProvideHandle.Type);
			}
			else
			{
				m_RequestOperation = m_AssetBundle.LoadAssetAsync(text, m_ProvideHandle.Type);
			}
			if (m_RequestOperation == null)
			{
				return;
			}
			if (m_RequestOperation.isDone)
			{
				ActionComplete(m_RequestOperation);
				return;
			}
			if (Profiler.enabled && m_ProvideHandle.IsValid)
			{
				ProfilerRuntime.AddAssetOperation(m_ProvideHandle, ContentStatus.Loading);
			}
			m_RequestOperation.completed += ActionComplete;
		}

		private bool WaitForCompletionHandler()
		{
			if (m_PreloadRequest != null && !m_PreloadRequest.isDone)
			{
				return m_PreloadRequest.asset == null;
			}
			if (m_Result != null)
			{
				return true;
			}
			if (m_RequestOperation == null)
			{
				return false;
			}
			if (m_RequestOperation.isDone)
			{
				return true;
			}
			return m_RequestOperation.asset != null;
		}

		private void ActionComplete(AsyncOperation obj)
		{
			if (m_RequestOperation != null)
			{
				if (m_ProvideHandle.Type.IsArray)
				{
					GetArrayResult(m_RequestOperation.allAssets);
				}
				else if (m_ProvideHandle.Type.IsGenericType && typeof(IList<>) == m_ProvideHandle.Type.GetGenericTypeDefinition())
				{
					GetListResult(m_RequestOperation.allAssets);
				}
				else if (string.IsNullOrEmpty(subObjectName))
				{
					GetAssetResult(m_RequestOperation.asset);
				}
				else
				{
					GetAssetSubObjectResult(m_RequestOperation.allAssets);
				}
			}
			CompleteOperation();
		}

		private void GetArrayResult(Object[] allAssets)
		{
			m_Result = ResourceManagerConfig.CreateArrayResult(m_ProvideHandle.Type, allAssets);
		}

		private void GetListResult(Object[] allAssets)
		{
			m_Result = ResourceManagerConfig.CreateListResult(m_ProvideHandle.Type, allAssets);
		}

		private void GetAssetResult(Object asset)
		{
			m_Result = ((asset != null && m_ProvideHandle.Type.IsAssignableFrom(asset.GetType())) ? asset : null);
		}

		private void GetAssetSubObjectResult(Object[] allAssets)
		{
			foreach (Object obj in allAssets)
			{
				if (obj.name == subObjectName && m_ProvideHandle.Type.IsAssignableFrom(obj.GetType()))
				{
					m_Result = obj;
					break;
				}
			}
		}

		private void CompleteOperation()
		{
			if (Profiler.enabled && m_Result != null && m_ProvideHandle.IsValid)
			{
				ProfilerRuntime.AddAssetOperation(m_ProvideHandle, ContentStatus.Active);
			}
			Exception exception = ((m_Result == null) ? new Exception($"Unable to load asset of type {m_ProvideHandle.Type} from location {m_ProvideHandle.Location}.") : null);
			m_ProvideHandle.Complete(m_Result, m_Result != null, exception);
		}

		public float ProgressCallback()
		{
			if (m_RequestOperation == null)
			{
				return 0f;
			}
			return m_RequestOperation.progress;
		}
	}

	public override void Provide(ProvideHandle provideHandle)
	{
		new InternalOp().Start(provideHandle);
	}
}
