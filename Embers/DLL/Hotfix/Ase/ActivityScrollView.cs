#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class ActivityScrollView : UGuiView, IBeginDragHandler, IEventSystemHandler, IDragHandler
{
	[SerializeField]
	private float stayTime;

	[SerializeField]
	private float scrollTime;

	[SerializeField]
	private float endTime;

	[SerializeField]
	private GameObject main;

	[SerializeField]
	private Image image1;

	[SerializeField]
	private Button btnImage1;

	[SerializeField]
	private Image image2;

	[SerializeField]
	private Button btnImage2;

	[SerializeField]
	private Image image3;

	[SerializeField]
	private Button btnImage3;

	[SerializeField]
	private RectTransform pointRoot;

	[SerializeField]
	private TabItem pointTpl;

	private GameObjectPool pointPool;

	private ActivityScrollViewModel _viewModel;

	private List<TabItemData> pointTabDatas = new List<TabItemData>();

	private float iconWidth;

	private int totalCount;

	private int preCount;

	private int curCount;

	private int nextCount;

	private Image preImg;

	private Image curImg;

	private Image nextImg;

	private bool scrolling;

	private Timer scrollTimer;

	[SerializeField]
	private float dragDistance = 50f;

	private Vector2 startDragPosition;

	private int CurCount
	{
		get
		{
			return curCount;
		}
		set
		{
			if (value != curCount)
			{
				curCount = value;
				RefreshPointState();
			}
		}
	}

	protected override void OnInit(object userData)
	{
		iconWidth = image1.rectTransform.sizeDelta.x;
		pointPool = new GameObjectPool(pointTpl.gameObject, pointRoot);
		base.OnInit(userData);
		_viewModel = GetUserData<ActivityScrollViewModel>(userData);
		BindingSet<ActivityScrollView, ActivityScrollViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(image1).For((Image v) => v.sprite).To((ActivityScrollViewModel vm) => vm.Image1)
			.WithConversion("ItemIcon");
		bindingSet.Bind(image2).For((Image v) => v.sprite).To((ActivityScrollViewModel vm) => vm.Image2)
			.WithConversion("ItemIcon");
		bindingSet.Bind(image3).For((Image v) => v.sprite).To((ActivityScrollViewModel vm) => vm.Image3)
			.WithConversion("ItemIcon");
		bindingSet.Bind().For((ActivityScrollView v) => v.Refresh).To((ActivityScrollViewModel vm) => vm.RefreshRequest);
		bindingSet.Bind(main).For((GameObject v) => v.activeSelf).To((ActivityScrollViewModel vm) => vm.ShowMain);
		bindingSet.Build();
		btnImage1.onClick.AddListener(delegate
		{
			OnBtnImageClick(1);
		});
		btnImage2.onClick.AddListener(delegate
		{
			OnBtnImageClick(2);
		});
		btnImage3.onClick.AddListener(delegate
		{
			OnBtnImageClick(3);
		});
		image1.name = "1";
		image2.name = "2";
		image3.name = "3";
		ResetScroll();
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
		image1.rectTransform.anchoredPosition = new Vector2(0f - iconWidth, 0f);
		image2.rectTransform.anchoredPosition = Vector2.zero;
		image3.rectTransform.anchoredPosition = new Vector2(iconWidth, 0f);
		preImg = image1;
		curImg = image2;
		nextImg = image3;
		RefreshImages();
		if (totalCount >= 2)
		{
			Stay();
		}
	}

	private void InitPointTabs()
	{
		pointPool.RecycleAll();
		pointTabDatas.Clear();
		if (_viewModel.BannerConfigs != null)
		{
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
		RefreshPointState();
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
			if (curImg == null || nextImg == null)
			{
				ClearTimer();
				SetScrolling(scrolling: false);
			}
			else
			{
				time += Time.deltaTime;
				curImg.rectTransform.anchoredPosition = new Vector2(curImg.rectTransform.anchoredPosition.x - scrollSpeed * Time.deltaTime, 0f);
				nextImg.rectTransform.anchoredPosition = new Vector2(nextImg.rectTransform.anchoredPosition.x - scrollSpeed * Time.deltaTime, 0f);
				if (time >= scrollTime)
				{
					FinishScroll(next: true);
				}
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
			if (curImg == null || preImg == null)
			{
				ClearTimer();
				SetScrolling(scrolling: false);
			}
			else
			{
				time += Time.deltaTime;
				curImg.rectTransform.anchoredPosition = new Vector2(curImg.rectTransform.anchoredPosition.x + scrollSpeed * Time.deltaTime, 0f);
				preImg.rectTransform.anchoredPosition = new Vector2(preImg.rectTransform.anchoredPosition.x + scrollSpeed * Time.deltaTime, 0f);
				if (time >= scrollTime)
				{
					FinishScroll(next: false);
				}
			}
		}, isLooped: true, useRealTime: false, this);
		scrollTimer = timer;
	}

	private void FinishScroll(bool next)
	{
		try
		{
			ClearTimer();
			SetScrolling(scrolling: false);
			if (next)
			{
				nextImg.rectTransform.anchoredPosition = Vector2.zero;
				curImg.rectTransform.anchoredPosition = new Vector2(iconWidth, 0f);
				Image image = nextImg;
				nextImg = curImg;
				curImg = image;
			}
			else
			{
				preImg.rectTransform.anchoredPosition = Vector2.zero;
				curImg.rectTransform.anchoredPosition = new Vector2(0f - iconWidth, 0f);
				Image image2 = preImg;
				preImg = curImg;
				curImg = image2;
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
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private void RefreshImages()
	{
		int num = ((preCount > 0) ? (preCount - 1) : 0);
		int num2 = ((CurCount > 0) ? (CurCount - 1) : 0);
		int num3 = ((nextCount > 0) ? (nextCount - 1) : 0);
		if (_viewModel.BannerConfigs.Count > num && _viewModel.BannerConfigs.Count > num2 && _viewModel.BannerConfigs.Count > num3)
		{
			string text = _viewModel.BannerConfigs[num]?.LittleImg ?? "";
			if (preImg.name == "1")
			{
				_viewModel.Image1 = text;
			}
			else if (preImg.name == "2")
			{
				_viewModel.Image2 = text;
			}
			else if (preImg.name == "3")
			{
				_viewModel.Image3 = text;
			}
			string text2 = _viewModel.BannerConfigs[num2]?.LittleImg ?? "";
			if (curImg.name == "1")
			{
				_viewModel.Image1 = text2;
			}
			else if (curImg.name == "2")
			{
				_viewModel.Image2 = text2;
			}
			else if (curImg.name == "3")
			{
				_viewModel.Image3 = text2;
			}
			string text3 = _viewModel.BannerConfigs[num3]?.LittleImg ?? "";
			if (nextImg.name == "1")
			{
				_viewModel.Image1 = text3;
			}
			else if (nextImg.name == "2")
			{
				_viewModel.Image2 = text3;
			}
			else if (nextImg.name == "3")
			{
				_viewModel.Image3 = text3;
			}
		}
	}

	private void SetScrolling(bool scrolling)
	{
		this.scrolling = scrolling;
		image1.raycastTarget = !scrolling;
		image2.raycastTarget = !scrolling;
		image3.raycastTarget = !scrolling;
	}

	private void OnBtnImageClick(int imageIndex)
	{
		Image image = null;
		switch (imageIndex)
		{
		case 1:
			image = image1;
			break;
		case 2:
			image = image2;
			break;
		case 3:
			image = image3;
			break;
		}
		if (!(image == null))
		{
			if (curImg != null && image.name == curImg.name)
			{
				_viewModel.OnBannerClick(_viewModel.BannerConfigs[CurCount - 1]);
			}
			else if (nextImg != null && image.name == nextImg.name)
			{
				_viewModel.OnBannerClick(_viewModel.BannerConfigs[nextCount - 1]);
			}
			else if (preImg != null && image.name == preImg.name)
			{
				_viewModel.OnBannerClick(_viewModel.BannerConfigs[preCount - 1]);
			}
		}
	}

	private void RefreshPointState()
	{
		foreach (TabItemData pointTabData in pointTabDatas)
		{
			pointTabData.IsSelected = pointTabData.TabIndex == CurCount;
		}
	}

	private void ClearTimer()
	{
		scrollTimer?.Pause();
		scrollTimer?.Cancel();
		scrollTimer = null;
	}

	protected override void OnDestroy()
	{
		ClearTimer();
		pointPool?.Dispose();
		pointPool = null;
		base.OnDestroy();
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!scrolling)
		{
			startDragPosition = eventData.position;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!scrolling)
		{
			float num = eventData.position.x - startDragPosition.x;
			if (num >= dragDistance)
			{
				DragPre();
			}
			else if (num <= 0f - dragDistance)
			{
				DragNext();
			}
		}
	}

	private void DragPre()
	{
		CancelInvoke("ScrollToNext");
		ScrollToPre();
	}

	private void DragNext()
	{
		CancelInvoke("ScrollToNext");
		ScrollToNext();
	}
}
