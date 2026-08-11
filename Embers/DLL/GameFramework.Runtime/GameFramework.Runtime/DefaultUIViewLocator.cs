using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

public class DefaultUIViewLocator : UIViewLocatorBase
{
	private GlobalWindowManagerBase globalWindowManager;

	private Dictionary<string, WeakReference> templates = new Dictionary<string, WeakReference>();

	protected string Normalize(string name)
	{
		int num = name.IndexOf('.');
		if (num < 0)
		{
			return name;
		}
		return name.Substring(0, num);
	}

	protected virtual IWindowManager GetDefaultWindowManager()
	{
		if (globalWindowManager != null)
		{
			return globalWindowManager;
		}
		globalWindowManager = UnityEngine.Object.FindObjectOfType<GlobalWindowManagerBase>();
		if (globalWindowManager == null)
		{
			throw new NotFoundException("GlobalWindowManager");
		}
		return globalWindowManager;
	}

	public override T LoadView<T>(string name)
	{
		return DoLoadView<T>(name);
	}

	protected virtual T DoLoadView<T>(string name)
	{
		name = Normalize(name);
		GameObject gameObject = null;
		try
		{
			if (templates.TryGetValue(name, out var value) && value.IsAlive)
			{
				gameObject = (GameObject)value.Target;
				if (gameObject != null)
				{
					string name2 = gameObject.name;
				}
			}
		}
		catch (Exception)
		{
			gameObject = null;
		}
		if (gameObject == null)
		{
			gameObject = Resources.Load<GameObject>(name);
			if (gameObject != null)
			{
				gameObject.SetActive(value: false);
				templates[name] = new WeakReference(gameObject);
			}
		}
		if (gameObject == null || gameObject.GetComponent<T>() == null)
		{
			return default(T);
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject);
		gameObject2.name = gameObject.name;
		T component = gameObject2.GetComponent<T>();
		if (component == null && gameObject2 != null)
		{
			UnityEngine.Object.Destroy(gameObject2);
		}
		return component;
	}

	public override IProgressResult<float, T> LoadViewAsync<T>(string name)
	{
		ProgressResult<float, T> progressResult = new ProgressResult<float, T>();
		Executors.RunOnCoroutineNoReturn(DoLoad(progressResult, name));
		return progressResult;
	}

	protected virtual IEnumerator DoLoad<T>(IProgressPromise<float, T> promise, string name, IWindowManager windowManager = null)
	{
		name = Normalize(name);
		GameObject viewTemplateGo = null;
		try
		{
			if (templates.TryGetValue(name, out var weakRef) && weakRef.IsAlive)
			{
				viewTemplateGo = (GameObject)weakRef.Target;
				if (viewTemplateGo != null)
				{
					_ = viewTemplateGo.name;
				}
			}
		}
		catch (Exception)
		{
			viewTemplateGo = null;
		}
		if (viewTemplateGo == null)
		{
			ResourceRequest request = Resources.LoadAsync<GameObject>(name);
			while (!request.isDone)
			{
				promise.UpdateProgress(request.progress);
				yield return null;
			}
			viewTemplateGo = (GameObject)request.asset;
			if (viewTemplateGo != null)
			{
				viewTemplateGo.SetActive(value: false);
				templates[name] = new WeakReference(viewTemplateGo);
			}
		}
		if (viewTemplateGo == null || viewTemplateGo.GetComponent<T>() == null)
		{
			promise.UpdateProgress(1f);
			promise.SetException(new NotFoundException(name));
			yield break;
		}
		GameObject go = UnityEngine.Object.Instantiate(viewTemplateGo);
		go.name = viewTemplateGo.name;
		T view = go.GetComponent<T>();
		if (view == null)
		{
			UnityEngine.Object.Destroy(go);
			promise.SetException(new NotFoundException(name));
			yield break;
		}
		if (windowManager != null && view is IWindow)
		{
			(view as IWindow).WindowManager = windowManager;
		}
		promise.UpdateProgress(1f);
		promise.SetResult(view);
	}

	public override T LoadWindow<T>(string name)
	{
		return LoadWindow<T>(null, name);
	}

	public override T LoadWindow<T>(IWindowManager windowManager, string name)
	{
		if (windowManager == null)
		{
			windowManager = GetDefaultWindowManager();
		}
		T val = DoLoadView<T>(name);
		if (val != null)
		{
			val.WindowManager = windowManager;
		}
		return val;
	}

	public override IProgressResult<float, T> LoadWindowAsync<T>(string name)
	{
		return LoadWindowAsync<T>(null, name);
	}

	public override IProgressResult<float, T> LoadWindowAsync<T>(IWindowManager windowManager, string name)
	{
		if (windowManager == null)
		{
			windowManager = GetDefaultWindowManager();
		}
		ProgressResult<float, T> progressResult = new ProgressResult<float, T>();
		Executors.RunOnCoroutineNoReturn(DoLoad(progressResult, name, windowManager));
		return progressResult;
	}
}
