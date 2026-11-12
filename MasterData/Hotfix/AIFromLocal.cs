using System;
using UnityEngine;

public class AIFromLocal
{
	public object obj;

	private Action<GameObject> initDelegate;

	private Action enableDelegate;

	private Action specialEnableDelegate;

	private Action startDelegate;

	private Action updateDelegate;

	private Action pauseDelegate;

	private Action resumeDelegate;

	private Action stopDelegate;

	private Action disableDelegate;

	private Action specialDisableDelegate;

	private Action LevelStartDelegate;

	private Action LevelEndDelegate;

	private Action LoadLevelControllerDelegate;

	private Action LoadDynamicModuleLevelControllerMethod;

	public bool Initialize(string typeString, GameObject owner)
	{
		LocalTypeCache localTypeCache = MonoSingleton<HybridCLRManager>.Instance.LoadLocalTypes(typeString);
		if (localTypeCache == null)
		{
			return false;
		}
		obj = Activator.CreateInstance(localTypeCache.type);
		if (localTypeCache.initMethod != null)
		{
			initDelegate = (Action<GameObject>)Delegate.CreateDelegate(typeof(Action<GameObject>), obj, localTypeCache.initMethod);
		}
		if (localTypeCache.specialEnableMethod != null)
		{
			specialEnableDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.specialEnableMethod);
		}
		if (localTypeCache.enableMethod != null)
		{
			enableDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.enableMethod);
		}
		if (localTypeCache.startMethod != null)
		{
			startDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.startMethod);
		}
		if (localTypeCache.updateMethod != null)
		{
			updateDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.updateMethod);
		}
		if (localTypeCache.pauseMethod != null)
		{
			pauseDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.pauseMethod);
		}
		if (localTypeCache.resumeMethod != null)
		{
			resumeDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.resumeMethod);
		}
		if (localTypeCache.stopMethod != null)
		{
			stopDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.stopMethod);
		}
		if (localTypeCache.disableMethod != null)
		{
			disableDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.disableMethod);
		}
		if (localTypeCache.specialDisableMethod != null)
		{
			specialDisableDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.specialDisableMethod);
		}
		if (localTypeCache.LevelStartMethod != null)
		{
			LevelStartDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.LevelStartMethod);
		}
		if (localTypeCache.LevelEndMethod != null)
		{
			LevelEndDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.LevelEndMethod);
		}
		if (localTypeCache.LoadLevelControllerMethod != null)
		{
			LoadLevelControllerDelegate = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.LoadLevelControllerMethod);
		}
		if (localTypeCache.LoadDynamicModuleLevelControllerMethod != null)
		{
			LoadDynamicModuleLevelControllerMethod = (Action)Delegate.CreateDelegate(typeof(Action), obj, localTypeCache.LoadDynamicModuleLevelControllerMethod);
		}
		Init(owner);
		return true;
	}

	public void Init(GameObject owner)
	{
		initDelegate?.Invoke(owner);
	}

	public void SpecialEnable()
	{
		specialEnableDelegate?.Invoke();
	}

	public void Enable()
	{
		enableDelegate?.Invoke();
	}

	public void Start()
	{
		startDelegate?.Invoke();
	}

	public void Update()
	{
		updateDelegate?.Invoke();
	}

	public void Pause()
	{
		pauseDelegate?.Invoke();
	}

	public void Resume()
	{
		resumeDelegate?.Invoke();
	}

	public void Stop()
	{
		stopDelegate?.Invoke();
	}

	public void Disable()
	{
		disableDelegate?.Invoke();
	}

	public void SpecialDisable()
	{
		specialDisableDelegate?.Invoke();
	}

	public void LevelStart()
	{
		LevelStartDelegate?.Invoke();
	}

	public void LevelEnd()
	{
		LevelEndDelegate?.Invoke();
	}

	public void LoadLevelController()
	{
		LoadLevelControllerDelegate?.Invoke();
	}

	public void LoadDynamicModuleLevelController()
	{
		LoadDynamicModuleLevelControllerMethod?.Invoke();
	}
}
