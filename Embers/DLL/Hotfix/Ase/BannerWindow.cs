#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BannerWindow : UGuiWindow
{
	[SerializeField]
	private RectTransform singleRect;

	[SerializeField]
	private float stayTime;

	[SerializeField]
	private float scrollTime;

	[SerializeField]
	private float endTime;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private GameObject switchGo;

	[SerializeField]
	private Button btnPre;

	[SerializeField]
	private Button btnNext;

	[SerializeField]
	private RectTransform pointRoot;

	[SerializeField]
	private TabItem pointTpl;

	private GameObjectPool pointPool;

	[SerializeField]
	private RectTransform preRect;

	[SerializeField]
	private RectTransform curRect;

	[SerializeField]
	private RectTransform nextRect;

	[SerializeField]
	private RectTransform imagePage;

	private float iconWidth;

	private int totalCount;

	private int preCount;

	private int curCount;

	private int nextCount;

	private bool scrolling;

	private Timer scrollTimer;

	private BannerViewModel _viewModel;

	private List<TabItemData> pointTabDatas = new List<TabItemData>();

	private GameObject _singlePrefab;

	private int CurCount
	{
		get
		{
			return curCount;
		}
		set
		{
			if (value == curCount)
			{
				return;
			}
			curCount = value;
			foreach (TabItemData pointTabData in pointTabDatas)
			{
				pointTabData.IsSelected = pointTabData.TabIndex == value;
			}
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		iconWidth = imagePage.sizeDelta.x;
		pointPool = new GameObjectPool(pointTpl.gameObject, pointRoot);
		base.OnCreate(bundle);
		_viewModel = GetData<BannerViewModel>();
		BindingSet<BannerWindow, BannerViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((BannerWindow v) => v.OnDismissRequest).To((BannerViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BannerWindow v) => v.OpenUguiWindow).To((BannerViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((BannerViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((BannerViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind().For((BannerWindow v) => v.Refresh).To((BannerViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		RefreshSingleImage();
		_viewModel.StartTimer();
	}

	private async void RefreshSingleImage()
	{
		if (singleRect == null)
		{
			return;
		}
		if (_viewModel?.SingleBannerInfo?.Config == null || string.IsNullOrEmpty(_viewModel.SingleBannerInfo.Config.Img))
		{
			singleRect.gameObject.SetActive(value: false);
			return;
		}
		try
		{
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(_viewModel.SingleBannerInfo.Config.Img), singleRect.transform);
			if (!(gameObject != null))
			{
				singleRect.gameObject.SetActive(value: false);
				return;
			}
			_singlePrefab = gameObject;
			_singlePrefab.GetComponentInChildren<Button>()?.onClick.RemoveAllListeners();
			_singlePrefab.GetComponentInChildren<Button>()?.onClick.AddListener(OnSingleImageClick);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		singleRect.gameObject.SetActive(value: true);
		_viewModel.SetSingleBannerShowed();
	}

	private void OnSingleImageClick()
	{
		_viewModel.OnSingleBannerClick();
	}

	private void ClearSingle()
	{
		if (_singlePrefab != null)
		{
			UnityEngine.Object.DestroyImmediate(_singlePrefab);
			_singlePrefab = null;
		}
	}

	private void Refresh(object sender, InteractionEventArgs e)
	{
		ResetScroll();
	}

	private void ResetScroll()
	{
		CancelInvoke("ScrollToNext");
		ClearTimer();
		SetScrolling(scrolling: false);
		InitPointTabs();
		InitParams();
		preRect.anchoredPosition = new Vector2(0f - iconWidth, 0f);
		curRect.anchoredPosition = Vector2.zero;
		nextRect.anchoredPosition = new Vector2(iconWidth, 0f);
		if (_viewModel.BannerConfigs != null && _viewModel.BannerConfigs.Count > 0)
		{
			RefreshImages(init: true);
			if (totalCount >= 2)
			{
				Stay();
			}
		}
	}

	private void InitPointTabs()
	{
		pointPool.RecycleAll();
		pointTabDatas.Clear();
		if (_viewModel.BannerConfigs == null)
		{
			return;
		}
		for (int i = 0; i < _viewModel.BannerConfigs.Count; i++)
		{
			TabItem component = pointPool.Allocate(out var newCreate).GetComponent<TabItem>();
			TabItemData tabItemData = new TabItemData(_viewModel, i + 1);
			if (newCreate)
			{
				component.Init(tabItemData);
			}
			else
			{
				component.RefreshData(tabItemData);
			}
			pointTabDatas.Add(tabItemData);
			component.transform.SetAsLastSibling();
		}
	}

	private void InitParams()
	{
		totalCount = _viewModel.BannerConfigs.Count;
		if (totalCount > 0)
		{
			CurCount = 1;
			preCount = totalCount;
			nextCount = ((totalCount < CurCount + 1) ? 1 : (CurCount + 1));
		}
		else
		{
			preCount = 0;
			CurCount = 0;
			nextCount = 0;
		}
	}

	private void DragPre()
	{
		if (!scrolling)
		{
			CancelInvoke("ScrollToNext");
			ScrollToPre();
		}
	}

	private void DragNext()
	{
		if (!scrolling)
		{
			CancelInvoke("ScrollToNext");
			ScrollToNext();
		}
	}

	private void Stay()
	{
		CancelInvoke("ScrollToNext");
		float time = ((CurCount == totalCount) ? endTime : stayTime);
		Invoke("ScrollToNext", time);
	}

	private void ScrollToNext()
	{
		float scrollSpeed = iconWidth / scrollTime;
		float time = 0f;
		ClearTimer();
		SetScrolling(scrolling: true);
		Timer timer = Timer.Register(Time.deltaTime, null, delegate
		{
			time += Time.deltaTime;
			curRect.anchoredPosition = new Vector2(curRect.anchoredPosition.x - scrollSpeed * Time.deltaTime, 0f);
			nextRect.anchoredPosition = new Vector2(nextRect.anchoredPosition.x - scrollSpeed * Time.deltaTime, 0f);
			if (time >= scrollTime)
			{
				FinishScroll(next: true);
			}
		}, isLooped: true, useRealTime: false, this);
		scrollTimer = timer;
	}

	private void ScrollToPre()
	{
		float scrollSpeed = iconWidth / scrollTime;
		float time = 0f;
		ClearTimer();
		SetScrolling(scrolling: true);
		Timer timer = Timer.Register(Time.deltaTime, null, delegate
		{
			time += Time.deltaTime;
			curRect.anchoredPosition = new Vector2(curRect.anchoredPosition.x + scrollSpeed * Time.deltaTime, 0f);
			preRect.anchoredPosition = new Vector2(preRect.anchoredPosition.x + scrollSpeed * Time.deltaTime, 0f);
			if (time >= scrollTime)
			{
				FinishScroll(next: false);
			}
		}, isLooped: true, useRealTime: false, this);
		scrollTimer = timer;
	}

	private void FinishScroll(bool next)
	{
		ClearTimer();
		SetScrolling(scrolling: false);
		if (next)
		{
			nextRect.anchoredPosition = Vector2.zero;
			curRect.anchoredPosition = new Vector2(iconWidth, 0f);
			RectTransform rectTransform = nextRect;
			nextRect = curRect;
			curRect = rectTransform;
		}
		else
		{
			preRect.anchoredPosition = Vector2.zero;
			curRect.anchoredPosition = new Vector2(0f - iconWidth, 0f);
			RectTransform rectTransform2 = preRect;
			preRect = curRect;
			curRect = rectTransform2;
		}
		if (next)
		{
			CurCount = ((totalCount <= CurCount) ? 1 : (CurCount + 1));
		}
		else
		{
			CurCount = ((CurCount > 1) ? (CurCount - 1) : totalCount);
		}
		preCount = ((CurCount > 1) ? (CurCount - 1) : totalCount);
		nextCount = ((totalCount <= CurCount) ? 1 : (CurCount + 1));
		RefreshImages();
		Stay();
	}

	private void RefreshImages(bool init = false)
	{
		if (init)
		{
			RefreshImage(2);
		}
		else
		{
			RefreshButton(2);
		}
		RefreshImage(1);
		RefreshImage(3);
	}

	private async void RefreshImage(int index)
	{
		RectTransform rect = null;
		string text = "";
		List<DRBanner> bannerConfigs = _viewModel.BannerConfigs;
		int num = ((preCount > 0) ? (preCount - 1) : 0);
		int num2 = ((CurCount > 0) ? (CurCount - 1) : 0);
		int num3 = ((nextCount > 0) ? (nextCount - 1) : 0);
		switch (index)
		{
		case 1:
			rect = preRect;
			text = ((bannerConfigs.Count > num) ? bannerConfigs[num].Img : "");
			break;
		case 2:
			rect = curRect;
			text = ((bannerConfigs.Count > num2) ? bannerConfigs[num2].Img : "");
			break;
		case 3:
			rect = nextRect;
			text = ((bannerConfigs.Count > num3) ? bannerConfigs[num3].Img : "");
			break;
		}
		if (rect == null || string.IsNullOrEmpty(text))
		{
			return;
		}
		rect.gameObject.SetActive(value: false);
		if (rect.childCount > 0)
		{
			for (int num4 = rect.childCount - 1; num4 >= 0; num4--)
			{
				UnityEngine.Object.DestroyImmediate(rect.GetChild(num4).gameObject);
			}
		}
		try
		{
			if (await InstantiateAsync(AssetUtility.GetUIItemAsset(text), rect.transform) != null)
			{
				RefreshButton(index);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		rect.gameObject.SetActive(value: true);
	}

	private void RefreshButton(int index)
	{
		switch (index)
		{
		case 1:
			preRect.GetComponentInChildren<Button>()?.onClick.RemoveAllListeners();
			preRect.GetComponentInChildren<Button>()?.onClick.AddListener(delegate
			{
				OnBtnImageClick(1);
			});
			break;
		case 2:
			curRect.GetComponentInChildren<Button>()?.onClick.RemoveAllListeners();
			curRect.GetComponentInChildren<Button>()?.onClick.AddListener(delegate
			{
				OnBtnImageClick(2);
			});
			break;
		case 3:
			nextRect.GetComponentInChildren<Button>()?.onClick.RemoveAllListeners();
			nextRect.GetComponentInChildren<Button>()?.onClick.AddListener(delegate
			{
				OnBtnImageClick(3);
			});
			break;
		}
	}

	private void SetScrolling(bool scrolling)
	{
		this.scrolling = scrolling;
		CanvasGroup component = preRect.GetComponent<CanvasGroup>();
		if ((UnityEngine.Object)(object)component != null)
		{
			component.blocksRaycasts = !scrolling;
		}
		CanvasGroup component2 = curRect.GetComponent<CanvasGroup>();
		if ((UnityEngine.Object)(object)component2 != null)
		{
			component2.blocksRaycasts = !scrolling;
		}
		CanvasGroup component3 = nextRect.GetComponent<CanvasGroup>();
		if ((UnityEngine.Object)(object)component3 != null)
		{
			component3.blocksRaycasts = !scrolling;
		}
	}

	private void OnBtnImageClick(int imageIndex)
	{
		switch (imageIndex)
		{
		case 1:
			_viewModel.OnBannerClick(_viewModel.BannerConfigs[preCount - 1]);
			break;
		case 2:
			_viewModel.OnBannerClick(_viewModel.BannerConfigs[CurCount - 1]);
			break;
		case 3:
			_viewModel.OnBannerClick(_viewModel.BannerConfigs[nextCount - 1]);
			break;
		}
	}

	private void ClearTimer()
	{
		scrollTimer?.Pause();
		scrollTimer?.Cancel();
		scrollTimer = null;
	}

	private void DestroyItems()
	{
		if (preRect.childCount > 0)
		{
			for (int num = preRect.childCount - 1; num >= 0; num--)
			{
				UnityEngine.Object.DestroyImmediate(preRect.GetChild(num).gameObject);
			}
		}
		if (curRect.childCount > 0)
		{
			for (int num2 = curRect.childCount - 1; num2 >= 0; num2--)
			{
				UnityEngine.Object.DestroyImmediate(curRect.GetChild(num2).gameObject);
			}
		}
		if (nextRect.childCount > 0)
		{
			for (int num3 = nextRect.childCount - 1; num3 >= 0; num3--)
			{
				UnityEngine.Object.DestroyImmediate(nextRect.GetChild(num3).gameObject);
			}
		}
	}

	protected override void OnDestroy()
	{
		ClearTimer();
		pointPool?.Dispose();
		pointPool = null;
		DestroyItems();
		base.OnDestroy();
	}
}
