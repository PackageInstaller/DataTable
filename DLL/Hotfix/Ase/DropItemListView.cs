using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DropItemListView : AnimationUIView
{
	[SerializeField]
	private RectTransform listRectTransform;

	[SerializeField]
	private LoopListView2 dropItemList;

	[SerializeField]
	private Button bgBtn;

	private ScrollRect scrollRectCom;

	private DropItemListViewModel _viewModel;

	public void Init(DropItemListViewModel viewModel)
	{
		_viewModel = viewModel;
		scrollRectCom = dropItemList.transform.GetComponent<ScrollRect>();
		BindingSet<DropItemListView, DropItemListViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(bgBtn).For((Button v) => v.onClick).To((DropItemListViewModel vm) => vm.Hide);
		bindingSet.Build();
		dropItemList.InitListView(_viewModel.PointDatas.Count, OnGetItemByIndex);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.PointDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("DropPointItem");
		if (loopListViewItem != null)
		{
			DropPointItem component = loopListViewItem.GetComponent<DropPointItem>();
			DropPointItemData dropPointItemData = new DropPointItemData(_viewModel, _viewModel.PointDatas[index]);
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(dropPointItemData);
			}
			else
			{
				component.RefreshData(dropPointItemData);
			}
			if (dropPointItemData.PointData.PointInfo.PointType == InteractivePoint.PointType.NormalTp && dropPointItemData.PointData.PointInfo.Id == 10102)
			{
				Singleton<GuidanceManager>.Instance.RegisterGuidanceUIs(Name, new List<GuidanceManager.GuidanceUIConfig>
				{
					new GuidanceManager.GuidanceUIConfig
					{
						uiKey = "10102",
						targetUI = loopListViewItem.GetComponent<RectTransform>()
					}
				});
			}
		}
		return loopListViewItem;
	}

	public void RefreshPointsData(Vector2 worldPos, List<InteractivePointData> pointDatas)
	{
		_viewModel.PointDatas = pointDatas;
		dropItemList.SetListItemCount(pointDatas.Count);
		dropItemList.RefreshAllShownItem();
		Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), (Vector3)worldPos);
		Vector2 anchoredPosition = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(RectTransform, vector, UIUtilly.GetUICamera(), ref anchoredPosition);
		listRectTransform.anchoredPosition = anchoredPosition;
		scrollRectCom.enabled = pointDatas.Count > 5;
	}
}
