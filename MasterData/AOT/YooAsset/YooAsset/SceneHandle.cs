using System;
using UnityEngine.SceneManagement;

namespace YooAsset;

public class SceneHandle : HandleBase
{
	private Action<SceneHandle> _callback;

	internal string PackageName { get; set; }

	public string SceneName
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return string.Empty;
			}
			return Provider.SceneName;
		}
	}

	public Scene SceneObject
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return default;
			}
			return Provider.SceneObject;
		}
	}

	public event Action<SceneHandle> Completed
	{
		add
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("SceneHandle is invalid !");
			}
			if (Provider.IsDone)
			{
				value(this);
			}
			else
			{
				_callback = (Action<SceneHandle>)Delegate.Combine(_callback, value);
			}
		}
		remove
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("SceneHandle is invalid !");
			}
			_callback = (Action<SceneHandle>)Delegate.Remove(_callback, value);
		}
	}

	internal SceneHandle(ProviderOperation provider)
		: base(provider)
	{
	}

	internal override void InvokeCallback()
	{
		_callback?.Invoke(this);
	}

	internal void WaitForAsyncComplete()
	{
		if (IsValidWithWarning)
		{
			Provider.WaitForAsyncComplete();
		}
	}

	public bool ActivateScene()
	{
		if (!IsValidWithWarning)
		{
			return false;
		}
		if (SceneObject.IsValid() && SceneObject.isLoaded)
		{
			return SceneManager.SetActiveScene(SceneObject);
		}
		YooLogger.Warning("Scene is invalid or not loaded : " + SceneObject.name);
		return false;
	}

	public bool UnSuspend()
	{
		if (!IsValidWithWarning)
		{
			return false;
		}
		if (Provider is SceneProvider)
		{
			(Provider as SceneProvider).UnSuspendLoad();
			return true;
		}
		throw new NotImplementedException();
	}

	public UnloadSceneOperation UnloadAsync()
	{
		string packageName = GetAssetInfo().PackageName;
		if (!IsValidWithWarning)
		{
			UnloadSceneOperation unloadSceneOperation = new UnloadSceneOperation("SceneHandle is invalid.");
			OperationSystem.StartOperation(packageName, unloadSceneOperation);
			return unloadSceneOperation;
		}
		UnloadSceneOperation unloadSceneOperation2 = new UnloadSceneOperation(Provider);
		OperationSystem.StartOperation(packageName, unloadSceneOperation2);
		return unloadSceneOperation2;
	}
}
