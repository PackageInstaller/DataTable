#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
public sealed class UIComponent : GameFrameworkComponent
{
	[Serializable]
	private sealed class UIGroup
	{
		[SerializeField]
		private string m_Name = null;

		[SerializeField]
		private int m_Depth = 0;

		public string Name => m_Name;

		public int Depth => m_Depth;
	}

	[SerializeField]
	private string m_UIHelperTypeName = "GameFramework.Runtime.DefaultUIHelper";

	[SerializeField]
	private Transform m_InstanceRoot = null;

	[SerializeField]
	private Camera m_UICamera;

	[SerializeField]
	private Canvas m_Canvas = null;

	[SerializeField]
	private CanvasScaler m_CanvasScaler = null;

	private GlobalWindowManager globalWindowManager;

	private Dictionary<string, WindowContainer> uiGroups = new Dictionary<string, WindowContainer>();

	private ResourceComponent resource;

	private IUIHelper uiHelper;

	public Camera UICamera => m_UICamera;

	public int UIGroupCount => uiGroups.Count;

	public RectTransform RootTransform => m_InstanceRoot.GetComponent<RectTransform>();

	public Canvas Canvas => m_Canvas;

	public CanvasScaler Scaler => m_CanvasScaler;

	public override void Init()
	{
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Error("Base component is invalid.");
			return;
		}
		resource = GameEntryRuntime.GetComponent<ResourceComponent>();
		globalWindowManager = m_InstanceRoot.GetComponent<GlobalWindowManager>();
		if (globalWindowManager == null)
		{
			globalWindowManager = m_InstanceRoot.gameObject.AddComponent<GlobalWindowManager>();
		}
		InitUIHelper();
	}

	private void InitUIHelper()
	{
		if (string.IsNullOrEmpty(m_UIHelperTypeName))
		{
			return;
		}
		Type type = Utility.Assembly.GetType(m_UIHelperTypeName);
		if (type == null)
		{
			Log.Error("Can not find UI helper type '{0}'.", m_UIHelperTypeName);
			return;
		}
		uiHelper = (IUIHelper)Activator.CreateInstance(type);
		if (uiHelper == null)
		{
			Log.Error("Can not create UI helper instance '{0}'.", m_UIHelperTypeName);
		}
	}

	public bool HasUIGroup(string uiGroupName)
	{
		if (uiGroups.ContainsKey(uiGroupName))
		{
			return true;
		}
		return false;
	}

	public bool AddUIGroup(string uiGroupName)
	{
		if (HasUIGroup(uiGroupName))
		{
			return false;
		}
		uiGroups.Add(uiGroupName, WindowContainer.Create(uiGroupName));
		return true;
	}

	public WindowContainer GetUIGroup(string uiGroupName)
	{
		uiGroups.TryGetValue(uiGroupName, out var value);
		return value;
	}

	public async UniTask<T> LoadWindow<T>(string uiFormAssetName, string uiGroupName, object userData) where T : IWindow
	{
		T loadWindow = await LoadWindowAsync<T>(GetUIGroup(uiGroupName), uiFormAssetName);
		IBundle bundle = new Bundle();
		if (userData != null)
		{
			bundle.Put("windowData", userData);
			bundle.Put("assetPath", uiFormAssetName);
			bundle.Put("uiGroup", uiGroupName);
		}
		loadWindow.Create(bundle);
		loadWindow.AssetPath = uiFormAssetName;
		return loadWindow;
	}

	public async UniTask<T> OpenUIWindow<T>(string uiFormAssetName, string uiGroupName) where T : IWindow
	{
		return await OpenUIWindow<T>(uiFormAssetName, uiGroupName, null, null);
	}

	public async UniTask<T> OpenUIWindow<T>(string uiFormAssetName, string uiGroupName, object userData) where T : IWindow
	{
		return await OpenUIWindow<T>(uiFormAssetName, uiGroupName, userData, null);
	}

	public async UniTask<T> OpenUIWindow<T>(string uiFormAssetName, string uiGroupName, object userData, Action callback) where T : IWindow
	{
		T loadWindow = await LoadWindowAsync<T>(GetUIGroup(uiGroupName), uiFormAssetName);
		if (loadWindow == null)
		{
			throw new GameFrameworkException($"load ui window error.  window : {typeof(T)}");
		}
		if (callback != null)
		{
			loadWindow.OnDismissed += Handler;
		}
		IBundle bundle = new Bundle();
		if (userData != null)
		{
			bundle.Put("windowData", userData);
			bundle.Put("assetPath", uiFormAssetName);
			bundle.Put("uiGroup", uiGroupName);
		}
		loadWindow.Create(bundle);
		loadWindow.AssetPath = uiFormAssetName;
		await loadWindow.Show();
		return loadWindow;
		void Handler(object window, EventArgs e)
		{
			Window window2 = (Window)window;
			window2.OnDismissed -= Handler;
			callback();
		}
	}

	public async UniTask<T> OpenUGUIView<T>(string uiFormAssetName) where T : IUIView
	{
		T loadWindow = await LoadViewAsync<T>(uiFormAssetName);
		if (loadWindow == null)
		{
			throw new GameFrameworkException($"load ui window error.  window : {typeof(T)}");
		}
		return loadWindow;
	}

	public async UniTask<T> OpenResUIWindow<T>(string uiFormAssetName, string uiGroupName, Action callback, object userData) where T : IWindow
	{
		WindowContainer uiGroup = GetUIGroup(uiGroupName);
		if (uiGroup == null)
		{
			throw new GameFrameworkException(Utility.Text.Format("UI group '{0}' is not exist.", uiGroupName));
		}
		T target = await DoLoadResWindowAsync<T>(uiFormAssetName);
		target.WindowManager = uiGroup;
		target.AssetPath = uiFormAssetName;
		if (callback != null)
		{
			target.OnDismissed += Handler;
		}
		IBundle bundle = new Bundle();
		bundle.Put("windowData", userData);
		bundle.Put("assetPath", uiFormAssetName);
		bundle.Put("uiGroup", uiGroupName);
		target.Create(bundle);
		target.Show();
		return target;
		void Handler(object window, EventArgs e)
		{
			Window window2 = (Window)window;
			window2.OnDismissed -= Handler;
			callback();
		}
	}

	public async UniTask<T> OpenResUIWindow<T>(string uiFormAssetName, string uiGroupName, object userData) where T : IWindow
	{
		WindowContainer uiGroup = GetUIGroup(uiGroupName);
		if (uiGroup == null)
		{
			Log.Error(Utility.Text.Format("UI group '{0}' is not exist.", uiGroupName));
			throw new GameFrameworkException(Utility.Text.Format("UI group '{0}' is not exist.", uiGroupName));
		}
		T target = await DoLoadResWindowAsync<T>(uiFormAssetName);
		target.WindowManager = uiGroup;
		target.AssetPath = uiFormAssetName;
		IBundle bundle = new Bundle();
		bundle.Put("windowData", userData);
		bundle.Put("assetPath", uiFormAssetName);
		bundle.Put("uiGroup", uiGroupName);
		target.Create(bundle);
		target.Show();
		return target;
	}

	public async UniTask OnWindowLoad(string uiFormAssetName, string uiGroupName, IWindow window, object userData)
	{
		if (uiHelper != null)
		{
			await uiHelper.OnWindowLoad(uiFormAssetName, uiGroupName, window, userData);
		}
	}

	public async UniTask OnWindowShow(IWindow window)
	{
		if (uiHelper != null)
		{
			await uiHelper.OnWindowShow(window);
		}
	}

	public async UniTask OnWindowHide(IWindow window)
	{
		if (uiHelper != null)
		{
			await uiHelper.OnWindowHide(window);
		}
	}

	public async UniTask OnWindowClose(IWindow window)
	{
		if (uiHelper != null)
		{
			await uiHelper.OnWindowDismiss(window);
			resource.UnloadAsset(window.AssetPath);
		}
	}

	public void HideUIGroup(string uiGroupName)
	{
		WindowContainer uIGroup = GetUIGroup(uiGroupName);
		if ((bool)uIGroup)
		{
			uIGroup.Alpha = 0f;
			uIGroup.Interactable = false;
			uIGroup.CanvasGroup.blocksRaycasts = false;
		}
	}

	public void ShowUIGroup(string uiGroupName)
	{
		WindowContainer uIGroup = GetUIGroup(uiGroupName);
		if ((bool)uIGroup)
		{
			uIGroup.Alpha = 1f;
			uIGroup.Interactable = true;
			uIGroup.CanvasGroup.blocksRaycasts = true;
		}
	}

	public async void SwitchUIGroup(string oldGroupName, string newGroupName, bool waitExcute = false)
	{
		if (waitExcute)
		{
			await Task.Delay(TimeSpan.FromSeconds(0.01));
		}
		Func();
		void Func()
		{
			ShowUIGroup(newGroupName);
			HideUIGroup(oldGroupName);
		}
	}

	private async UniTask<T> LoadWindowAsync<T>(IWindowManager windowManager, string uiFormAssetName) where T : IWindow
	{
		if (windowManager == null)
		{
			windowManager = globalWindowManager;
		}
		T target = await DoLoadWindowAsync<T>(uiFormAssetName);
		if (target != null)
		{
			target.WindowManager = windowManager;
		}
		return target;
	}

	private async UniTask<T> DoLoadWindowAsync<T>(string uiFormAssetName) where T : IWindow
	{
		GameObject viewTemplateGo = await resource.LoadAssetAsync<GameObject>(uiFormAssetName);
		if (viewTemplateGo == null)
		{
			throw new GameFrameworkException("load ui window object error. assetName : " + uiFormAssetName + ".");
		}
		GameObject go = UnityEngine.Object.Instantiate(viewTemplateGo);
		go.name = viewTemplateGo.name;
		T view = go.GetComponent<T>();
		if (view == null && go != null)
		{
			UnityEngine.Object.Destroy(go);
		}
		return view;
	}

	private async UniTask<T> DoLoadResWindowAsync<T>(string uiFormAssetName) where T : IWindow
	{
		GameObject viewTemplateGo = (await Resources.LoadAsync<GameObject>(uiFormAssetName)) as GameObject;
		if (viewTemplateGo == null)
		{
			Log.Error("load ui window object error. assetName : " + uiFormAssetName + ".");
			throw new GameFrameworkException("load ui window object error. assetName : " + uiFormAssetName + ".");
		}
		GameObject go = UnityEngine.Object.Instantiate(viewTemplateGo);
		go.name = viewTemplateGo.name;
		T view = go.GetComponent<T>();
		if (view == null && go != null)
		{
			Log.Error($"加载UI预制体成功. 但是没有找到【{typeof(T)}】组件.");
			UnityEngine.Object.Destroy(go);
		}
		return view;
	}

	private async UniTask<T> LoadViewAsync<T>(string uiFormAssetName) where T : IUIView
	{
		return await DoLoadViewAsync<T>(uiFormAssetName);
	}

	private async UniTask<T> DoLoadViewAsync<T>(string uiFormAssetName) where T : IUIView
	{
		GameObject viewTemplateGo = await resource.LoadAssetAsync<GameObject>(uiFormAssetName);
		if (viewTemplateGo == null)
		{
			throw new GameFrameworkException("load ui window object error. assetName : " + uiFormAssetName + ".");
		}
		GameObject go = UnityEngine.Object.Instantiate(viewTemplateGo);
		go.name = viewTemplateGo.name;
		T view = go.GetComponent<T>();
		if (view == null && go != null)
		{
			UnityEngine.Object.Destroy(go);
		}
		return view;
	}
}
