#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapPointInfoView : AnimationUIView
{
	[SerializeField]
	protected TextMeshProUGUI mainTitle;

	private RectTransform mainTitleRect;

	[SerializeField]
	protected Image titleIcon;

	[SerializeField]
	protected GameObject childTitlePart;

	[SerializeField]
	protected TextMeshProUGUI childTitle;

	[SerializeField]
	protected GameObject pointIconPart;

	[SerializeField]
	protected Image pointIcon;

	private string pointIconPath;

	[SerializeField]
	protected GameObject detailDescPart;

	[SerializeField]
	protected TextMeshProUGUI detailDescContent;

	[SerializeField]
	protected Transform targetGroupRoot;

	[SerializeField]
	protected GameObject targetItemTpl;

	private List<GameObject> targetItems = new List<GameObject>();

	[SerializeField]
	protected GameObject rewardPart;

	[SerializeField]
	protected LoopListView2 rewardScrollView;

	[SerializeField]
	protected Button funcBtn;

	[SerializeField]
	protected TextMeshProUGUI funcBtnText;

	[SerializeField]
	private ButtonLong outsideMask;

	private MapPointInfoViewModel _viewModel;

	private string titleIconAssetPath;

	private string assetTag = "MapPointInfoView";

	protected override void OnInit(object userData)
	{
		mainTitleRect = ((Component)(object)mainTitle).GetComponent<RectTransform>();
		_viewModel = GetUserData<MapPointInfoViewModel>(userData);
		BindingSet<MapPointInfoView, MapPointInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((MapPointInfoView v) => v.OnVisibleChanged).To((MapPointInfoViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(outsideMask).For((ButtonLong v) => v.onClick).To((MapPointInfoViewModel vm) => vm.Hide);
		bindingSet.Bind(outsideMask).For((ButtonLong v) => v.onLongClick).To((MapPointInfoViewModel vm) => vm.Hide);
		bindingSet.Bind<TextMeshProUGUI>(mainTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapPointInfoViewModel vm) => vm.MainTitleText);
		bindingSet.Bind<TextMeshProUGUI>(childTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapPointInfoViewModel vm) => vm.ChildTitleText);
		bindingSet.Bind<TextMeshProUGUI>(detailDescContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapPointInfoViewModel vm) => vm.DetailText);
		bindingSet.Bind<TextMeshProUGUI>(funcBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapPointInfoViewModel vm) => vm.FuncBtnText);
		bindingSet.Bind(funcBtn).For((Button v) => v.onClick).To((MapPointInfoViewModel vm) => vm.OnFuncBtnClick);
		bindingSet.Bind(funcBtn.gameObject).For((GameObject v) => v.activeSelf).To((MapPointInfoViewModel vm) => vm.ShowFuncBtn);
		bindingSet.Build();
		rewardScrollView.InitListView(_viewModel.RewardDataList.Count, OnGetRewardItemByIndex);
	}

	public void Show(InteractivePointData pointItemData)
	{
		_viewModel.Refresh(pointItemData);
		Refresh();
		Show();
	}

	public async void Refresh()
	{
		if (_viewModel == null || _viewModel.PointInfo == null)
		{
			return;
		}
		InteractivePoint.PointType pointType = _viewModel.PointInfo.PointType;
		bool isTask = pointType.Equals(InteractivePoint.PointType.MainTask) || pointType.Equals(InteractivePoint.PointType.SideTask) || pointType.Equals(InteractivePoint.PointType.DailyTask) || pointType.Equals(InteractivePoint.PointType.MonsterTask);
		Vector2 vector = (isTask ? new Vector2(0f, 1f) : new Vector2(0.5f, 1f));
		mainTitleRect.anchorMin = vector;
		mainTitleRect.anchorMax = vector;
		mainTitleRect.pivot = vector;
		mainTitleRect.anchoredPosition = (isTask ? new Vector2(70f, 0f) : new Vector2(14f, 0f));
		titleIconAssetPath = _viewModel.MainTitleIcon;
		try
		{
			Sprite sprite = await LoadSpriteAsync(AssetUtility.GetTextureIconSprite(titleIconAssetPath));
			if (sprite == null)
			{
				return;
			}
			titleIcon.sprite = sprite;
			titleIcon.SetNativeSize();
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		if (isTask)
		{
			childTitlePart.SetActive(value: true);
			pointIconPart.SetActive(value: false);
			RefreshTargetGroup();
			rewardScrollView.SetListItemCount(_viewModel.RewardDataList.Count);
			rewardScrollView.RefreshAllShownItem();
			rewardPart.gameObject.SetActive(_viewModel.RewardDataList.Count > 0);
			return;
		}
		childTitlePart.SetActive(value: false);
		targetGroupRoot.gameObject.SetActive(value: false);
		rewardPart.gameObject.SetActive(value: false);
		try
		{
			pointIconPath = _viewModel.PointIcon;
			Sprite sprite2 = await LoadSpriteAsync(AssetUtility.GetTextureAsset(pointIconPath));
			if (!(sprite2 == null))
			{
				pointIcon.sprite = sprite2;
				pointIconPart.SetActive(value: true);
			}
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
	}

	private void RefreshTargetGroup()
	{
		for (int i = 0; i < _viewModel.TargetList.Count; i++)
		{
			if (targetItems.Count <= i)
			{
				targetItems.Add(UnityEngine.Object.Instantiate(targetItemTpl, targetGroupRoot));
			}
			TaskTargetData taskTargetData = _viewModel.TargetList[i];
			((TMP_Text)targetItems[i].transform.GetChild(0).GetComponent<TextMeshProUGUI>()).text = $"{taskTargetData.TargetDesc} ({taskTargetData.ProgressValue}/{taskTargetData.TargetValue})";
			targetItems[i].SetActive(value: true);
		}
		if (targetItems.Count > _viewModel.TargetList.Count)
		{
			for (int j = _viewModel.TargetList.Count; j < targetItems.Count; j++)
			{
				targetItems[j].SetActive(value: false);
			}
		}
		targetGroupRoot.gameObject.SetActive(_viewModel.TargetList.Count > 0);
	}

	public LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 arg1, int itemIndex)
	{
		if (itemIndex < 0 || itemIndex > _viewModel.RewardDataList.Count)
		{
			return null;
		}
		KnapsackItemViewModel viewModel = _viewModel.RewardDataList[itemIndex];
		LoopListViewItem2 loopListViewItem = arg1.NewListViewItem("PropSmallItem");
		KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel);
		}
		else
		{
			component.RefreshData(viewModel);
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
