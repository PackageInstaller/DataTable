#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class UGuiView : UIView
{
	[SerializeField]
	public List<UIContrl> uiContrls = new List<UIContrl>();

	private bool mIsInitHandlerCalled;

	private int pageId;

	private string pageType;

	private string entrance;

	public bool IsInitHandlerCalled
	{
		get
		{
			return mIsInitHandlerCalled;
		}
		private set
		{
			mIsInitHandlerCalled = value;
		}
	}

	public Action<UGuiView> ClearViewInfoInWindow { get; set; }

	public int PageId
	{
		get
		{
			return pageId;
		}
		set
		{
			pageId = value;
		}
	}

	public string PageType
	{
		get
		{
			return pageType;
		}
		set
		{
			pageType = value;
		}
	}

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

	public void Init(object userData = null)
	{
		IsInitHandlerCalled = true;
		OnInit(userData);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		InitGuidanceConfig();
	}

	protected virtual void OnInit(object userData)
	{
	}

	protected virtual void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		Visibility = (bool)e.Context;
	}

	public virtual void OnShow()
	{
	}

	public virtual void RefreshData(object userData)
	{
	}

	private async void InitGuidanceConfig()
	{
		await UniTask.WaitForEndOfFrame();
		if (!IsDestroyed())
		{
			UIWindowHelper.AddGuidanceKey(Name, uiContrls);
		}
	}

	private void RemoveGuidanceConfig()
	{
		UIWindowHelper.RemoveGuidanceKey(Name, uiContrls);
	}

	public async UniTask<T> LoadAssetAsync<T>(string path) where T : UnityEngine.Object
	{
		return await GameEntry.Resource.LoadAssetAsync<T>(path);
	}

	public async UniTask<Sprite> LoadSpriteAsync(string path, string packageName = "")
	{
		return await GameEntry.Resource.LoadSpriteAsync(path, $"{GetInstanceID()}", packageName);
	}

	public UniTask<GameObject> InstantiateAsync(string path, Transform parent, string packageName = "")
	{
		return GameEntry.Resource.InstantiateAsync(path, parent, packageName);
	}

	protected override void OnDestroy()
	{
		RemoveGuidanceConfig();
		AfterCloseView();
		GameEntry.Resource.UnLoadSpriteGroup($"{GetInstanceID()}");
		ClearViewInfoInWindow = null;
		base.OnDestroy();
	}

	protected T GetUserData<T>(object userData) where T : new()
	{
		if (userData == null)
		{
			Log.Error($"{GetType()} 界面初始化数据userData为空！");
			return new T();
		}
		try
		{
			return (T)userData;
		}
		catch (Exception ex)
		{
			Log.Error($"{GetType()} 界面初始化数据userData异常:{ex.StackTrace}");
		}
		return new T();
	}

	public virtual void AfterOpenView()
	{
	}

	public virtual void AfterCloseView()
	{
	}
}
