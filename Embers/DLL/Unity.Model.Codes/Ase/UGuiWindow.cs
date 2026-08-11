#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.U2D;

namespace Ase;

public abstract class UGuiWindow : Window
{
	private IBundle formData;

	[SerializeField]
	private ProcessType processType;

	[SerializeField]
	private OuterModule outerModule;

	[SerializeField]
	private WindowAlphaType windowAlphaType;

	[FormerlySerializedAs("guidanceUIs")]
	[SerializeField]
	public List<UIContrl> uiContrls = new List<UIContrl>();

	protected int pageId;

	protected string pageType;

	protected string entrance;

	private Action<UGuiView> _removeChildViewDelegate;

	[HideInInspector]
	[SerializeField]
	public List<SpriteAtlas> __ReferencesAtlas = new List<SpriteAtlas>();

	private List<string> childPaths = new List<string>();

	protected List<UGuiView> childViewList = new List<UGuiView>();

	public ProcessType ProcessType => processType;

	public OuterModule OuterModule => outerModule;

	public WindowAlphaType WindowAlphaType => windowAlphaType;

	public int PageId => pageId;

	public string PageType => pageType;

	public string Entrance
	{
		get
		{
			return entrance;
		}
		set
		{
			entrance = value;
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		formData = bundle;
		_removeChildViewDelegate = ClearView;
		GameEntry.UI.OnWindowLoad(GetAssetPath(), GetUIGroup(), this, GetUserData());
		InitGuidanceConfig();
		OnInit();
	}

	public virtual object GetUserData()
	{
		if (formData == null)
		{
			return null;
		}
		return formData.Get("windowData");
	}

	public virtual string GetAssetPath()
	{
		if (formData == null)
		{
			return string.Empty;
		}
		return formData.Get<string>("assetPath");
	}

	public async UniTask<T> LoadAssetAsync<T>(string path) where T : UnityEngine.Object
	{
		try
		{
			return await GameEntry.Resource.LoadAssetAsync<T>(path);
		}
		catch (Exception ex)
		{
			Log.Error("LoadAssetAsync 发生异常！" + GetType().Name + " " + path + " / " + ex.Message + " / " + ex.StackTrace);
			return null;
		}
	}

	public async UniTask<Sprite> LoadSpriteAsync(string path, string packageName = "")
	{
		try
		{
			return await GameEntry.Resource.LoadSpriteAsync(path, GetType().Name ?? "", packageName);
		}
		catch (Exception ex)
		{
			Log.Error("LoadSpriteAsync 发生异常！" + GetType().Name + " " + path + " / " + ex.Message + " / " + ex.StackTrace);
			return null;
		}
	}

	public UniTask<GameObject> InstantiateAsync(string path, Transform parent, string packageName = "")
	{
		return GameEntry.Resource.InstantiateAsync(path, parent, packageName);
	}

	public virtual string GetUIGroup()
	{
		if (formData == null)
		{
			return string.Empty;
		}
		return formData.Get<string>("uiGroup");
	}

	protected virtual void OnInit()
	{
	}

	protected T GetData<T>()
	{
		return formData.Get<T>("windowData");
	}

	protected override void OnShow()
	{
		GameEntry.UI.OnWindowShow(this);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		UIWindowHelper.OnWindowEnable(this);
	}

	protected override void OnHide()
	{
		GameEntry.UI.OnWindowHide(this);
	}

	protected override void OnDismiss()
	{
		GameEntry.UI.OnWindowClose(this);
	}

	protected void Close()
	{
		this.ClearAllBindings();
		RemoveGuidanceConfig();
		Dismiss();
	}

	public virtual void OnCached()
	{
		Close();
	}

	public virtual bool CloseInversion()
	{
		return false;
	}

	protected virtual void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		Visibility = (bool)e.Context;
	}

	protected virtual void OnDismissRequest(object sender, InteractionEventArgs args)
	{
		Close();
	}

	protected override void OnDestroy()
	{
		if (childViewList != null)
		{
			for (int i = 0; i < childViewList.Count; i++)
			{
				UGuiView uGuiView = childViewList[i];
				if (!uGuiView.IsDestroyed())
				{
					uGuiView.ClearAllBindings();
					UnityEngine.Object.Destroy(uGuiView.gameObject);
				}
			}
			childViewList.Clear();
		}
		if (childPaths != null)
		{
			for (int j = 0; j < childPaths.Count; j++)
			{
				GameEntry.Resource.UnloadAsset(childPaths[j]);
			}
			childPaths.Clear();
		}
		GameEntry.Resource.UnLoadSpriteGroup(GetType().Name ?? "");
		base.OnDestroy();
	}

	public virtual bool SetViewAlpha(int a)
	{
		if ((UnityEngine.Object)(object)CanvasGroup != null)
		{
			CanvasGroup.alpha = a;
			return true;
		}
		Log.Error($"{GetType()} 找不到 CanvasGroup 组件");
		return false;
	}

	protected virtual void SetChildViewVisibility(object sender, InteractionEventArgs e)
	{
		ShowViewArg showViewArg = (ShowViewArg)e.Context;
		for (int i = 0; i < childViewList.Count; i++)
		{
			if (childViewList[i].GetDataContext() == showViewArg.UserData)
			{
				childViewList[i].Visibility = showViewArg.IsShow;
			}
		}
	}

	private void InitGuidanceConfig()
	{
		UIWindowHelper.AddGuidanceKey(Name, uiContrls);
	}

	private void RemoveGuidanceConfig()
	{
		UIWindowHelper.RemoveGuidanceKey(Name, uiContrls);
	}

	protected virtual async void OpenUguiWindow(object sender, InteractionEventArgs args)
	{
		Action callback = null;
		try
		{
			callback = args.Callback;
			OpenViewArg openViewArg = (OpenViewArg)args.Context;
			ViewConfig? drViewConfig = null;
			if (openViewArg.CallBack != null)
			{
				callback = (Action)Delegate.Combine(callback, openViewArg.CallBack);
			}
			string vPath;
			if (openViewArg.Path == null)
			{
				ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(openViewArg.ViewName));
				if (viewConfigs == null)
				{
					throw new Exception("找不到类型" + openViewArg.ViewName + " 的视图路径");
				}
				vPath = viewConfigs[0].ViewPath;
				drViewConfig = viewConfigs[0];
			}
			else
			{
				vPath = openViewArg.Path;
			}
			if (!openViewArg.IsOpenWindow)
			{
				string uIFormAsset = AssetUtility.GetUIFormAsset(vPath);
				if (!childPaths.Contains(uIFormAsset))
				{
					childPaths.Add(uIFormAsset);
				}
			}
			if (!(await CheckOpenWindow(openViewArg, vPath, drViewConfig, openViewArg.Entrance, callback)))
			{
				if (openViewArg.IsOpenWindow)
				{
					await CheckOpenWindow(vPath, openViewArg.UserData, callback, openViewArg.UiGroupName, drViewConfig, openViewArg.Entrance);
				}
				else
				{
					await CheckOpenView(openViewArg.ViewName, vPath, openViewArg.UserData, drViewConfig, openViewArg.Entrance, callback);
				}
			}
		}
		catch (Exception ex)
		{
			callback?.Invoke();
			Log.Error("打开界面发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	protected virtual void AfterOpenView()
	{
	}

	protected virtual async Task<bool> CheckOpenWindow(OpenViewArg openViewArg, string path, ViewConfig? configSettingData, string entrance, Action callback)
	{
		return false;
	}

	protected async Task<UGuiWindow> CheckOpenWindow(string path, object userData, Action callback, string uiGroupName, ViewConfig? viewConfig, string entrance)
	{
		UGuiWindow w = await GameEntry.UI.OpenWindow<UGuiWindow>(path, uiGroupName, userData);
		if (w != null)
		{
			w.OnDismissed += Handler;
		}
		if (viewConfig.HasValue)
		{
			w.pageId = viewConfig.Value.Id;
			w.pageType = viewConfig.Value.PageType;
		}
		w.Entrance = entrance;
		w.AfterOpenView();
		return w;
		void Handler(object window, EventArgs e)
		{
			w.OnDismissed -= Handler;
			callback?.Invoke();
		}
	}

	protected async Task<UGuiView> CheckOpenView(string viewName, string path, object userData, ViewConfig? viewConfig, string entrance, Action callback = null)
	{
		UGuiView uGuiView = HasView(viewName);
		if (uGuiView == null)
		{
			uGuiView = await GameEntry.UI.OpenUIView<UGuiView>(path);
			AddChildView(uGuiView);
			uGuiView.Visibility = true;
			uGuiView.Init(userData);
			uGuiView.AssetPath = path;
			uGuiView.ClearViewInfoInWindow = _removeChildViewDelegate;
			if (callback != null)
			{
				uGuiView.OnDisabled += Handler;
			}
		}
		else
		{
			uGuiView.Visibility = true;
			uGuiView.SetDataContext(userData);
		}
		if (viewConfig.HasValue)
		{
			uGuiView.PageId = viewConfig.Value.Id;
			uGuiView.PageType = viewConfig.Value.PageType;
		}
		uGuiView.Entrance = entrance;
		uGuiView.AfterOpenView();
		return uGuiView;
		void Handler(object view, EventArgs e)
		{
			callback?.Invoke();
		}
	}

	protected async Task<T> OpenView<T>(string path, object userData, string entrance) where T : UGuiView
	{
		ViewConfig[] viewConfig = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(typeof(T).FullName));
		UGuiView uGuiView = HasView(typeof(T).FullName);
		if (uGuiView == null)
		{
			uGuiView = await GameEntry.UI.OpenUIView<UGuiView>(path);
			childPaths.Add(AssetUtility.GetUIFormAsset(path));
			AddChildView(uGuiView);
			uGuiView.Visibility = true;
			uGuiView.Init(userData);
			uGuiView.AssetPath = path;
			uGuiView.ClearViewInfoInWindow = _removeChildViewDelegate;
		}
		else
		{
			uGuiView.Visibility = true;
			uGuiView.SetDataContext(userData);
		}
		if (viewConfig != null && viewConfig.Length != 0)
		{
			uGuiView.PageId = viewConfig[0].Id;
			uGuiView.PageType = viewConfig[0].PageType;
		}
		uGuiView.Entrance = entrance;
		uGuiView.AfterOpenView();
		return (T)uGuiView;
	}

	protected void ClearView(UGuiView view)
	{
		if (childViewList != null && childViewList.Count > 0)
		{
			childViewList.Remove(view);
		}
		if (childPaths != null && childPaths.Count > 0 && !string.IsNullOrEmpty(view.AssetPath))
		{
			string uIFormAsset = AssetUtility.GetUIFormAsset(view.AssetPath);
			if (childPaths.Remove(uIFormAsset))
			{
				GameEntry.Resource.UnloadAsset(uIFormAsset);
			}
		}
	}

	private void AddChildView(UGuiView childView)
	{
		if (childViewList == null)
		{
			childViewList = new List<UGuiView>();
		}
		childViewList.Add(childView);
		AddView(childView);
	}

	private UGuiView HasView(string viewTypeName)
	{
		if (childViewList == null || childViewList.Count == 0)
		{
			return null;
		}
		for (int num = childViewList.Count - 1; num >= 0; num--)
		{
			if (childViewList[num] == null || childViewList[num].IsDestroyed())
			{
				childViewList.RemoveAt(num);
			}
		}
		for (int i = 0; i < childViewList.Count; i++)
		{
			if (childViewList[i].GetType().ToString().Equals(viewTypeName))
			{
				return childViewList[i];
			}
		}
		return null;
	}
}
