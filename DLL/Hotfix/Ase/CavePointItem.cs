using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CavePointItem : InteractivePoint
{
	[SerializeField]
	private Image highLightIcon;

	[SerializeField]
	private Image lockIcon;

	[SerializeField]
	private Image normalIcon;

	[SerializeField]
	private GameObject indexTag;

	[SerializeField]
	private TextMeshProUGUI indexTagText;

	[SerializeField]
	private GameObject bubble1;

	[SerializeField]
	private GameObject bubble2;

	[SerializeField]
	private Image bubbleIcon1;

	[SerializeField]
	private Image bubbleIcon2;

	[SerializeField]
	private Button bubbleBtn;

	[SerializeField]
	private GameObject track1;

	[SerializeField]
	private GameObject track2;

	private Vector3[] areaCorners;

	private float[] guideAngles;

	private CavePointItemData _viewModel;

	private RectTransform normalRoot;

	private RectTransform overlayRoot;

	public CavePointItemData ViewModel => _viewModel;

	public void Init(CavePointItemData data, Vector3[] areaCorners, float[] guideAngles, RectTransform normalRoot = null, RectTransform overlayRoot = null)
	{
		base.Init(data);
		this.areaCorners = areaCorners;
		this.guideAngles = guideAngles;
		this.normalRoot = normalRoot;
		this.overlayRoot = overlayRoot;
		_viewModel = data;
		BindingSet<CavePointItem, CavePointItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(normalIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CavePointItemData vm) => !vm.IsLock && !vm.IsHighlight);
		bindingSet.Bind(lockIcon.gameObject).For((GameObject v) => v.activeSelf).To((CavePointItemData vm) => vm.IsLock);
		bindingSet.Bind(highLightIcon.gameObject).For((GameObject v) => v.activeSelf).To((CavePointItemData vm) => vm.IsHighlight);
		bindingSet.Bind(indexTag).For((GameObject v) => v.activeSelf).To((CavePointItemData vm) => vm.ShowPointIndex);
		bindingSet.Bind<TextMeshProUGUI>(indexTagText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CavePointItemData vm) => vm.CavePointIndex);
		bindingSet.Bind(bubble1).For((GameObject v) => v.activeSelf).ToExpression((CavePointItemData vm) => vm.BubbleCount > 0);
		bindingSet.Bind(bubble2).For((GameObject v) => v.activeSelf).ToExpression((CavePointItemData vm) => vm.BubbleCount > 1);
		bindingSet.Bind(bubbleIcon1).For((Image v) => v.sprite).To((CavePointItemData vm) => vm.BubbleIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bubbleIcon2).For((Image v) => v.sprite).To((CavePointItemData vm) => vm.BubbleIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bubbleBtn).For((Button v) => v.onClick).To((CavePointItemData vm) => vm.OnBubbleBtnClick);
		bindingSet.Bind(bubbleBtn).For((Button v) => v.enabled).To((CavePointItemData vm) => vm.TaskBtnEnable);
		bindingSet.Bind(track1).For((GameObject v) => v.activeSelf).ToExpression((CavePointItemData vm) => !vm.Task1.Empty && vm.Task1.TrackState);
		bindingSet.Bind(track2).For((GameObject v) => v.activeSelf).ToExpression((CavePointItemData vm) => !vm.Task2.Empty && vm.Task2.TrackState);
		bindingSet.Bind(btn).For((Button v) => v.enabled).To((CavePointItemData vm) => vm.BtnEnable);
		bindingSet.Build();
		_viewModel.SetItem(this);
	}

	public void RefreshData(DRCavernPoint drData, Vector2 mapSize)
	{
		_viewModel.RefreshData(drData, mapSize);
		base.gameObject.name = $"CavePoint{drData.Id}";
	}

	public void RefreshRoot()
	{
		if (_viewModel != null && !(normalRoot == null) && !(overlayRoot == null))
		{
			base.transform.SetParent(_viewModel.TaskBtnEnable ? overlayRoot : normalRoot);
		}
	}

	public void RefreshState(bool active)
	{
		_viewModel.RefreshState(active);
	}

	public MapGuidePointData UpdateVisualData()
	{
		if (!Visibility || _viewModel == null)
		{
			return null;
		}
		TaskDataViewModel taskDataViewModel = null;
		if (_viewModel.Task1 != null && !_viewModel.Task1.Empty && _viewModel.Task1.TrackState)
		{
			taskDataViewModel = _viewModel.Task1;
		}
		else if (_viewModel.Task2 != null && !_viewModel.Task2.Empty && _viewModel.Task2.TrackState)
		{
			taskDataViewModel = _viewModel.Task2;
		}
		if (taskDataViewModel == null)
		{
			return null;
		}
		PointType taskPointType = InteractivePoint.GetTaskPointType(taskDataViewModel.TaskType);
		PointInfo pointInfo = new PointInfo(taskPointType, InteractivePoint.GetPointIcon(taskPointType), Vector2.zero, Vector2.zero, Vector2.zero);
		pointInfo.SceneToUiRatio = _viewModel.PointInfo.SceneToUiRatio;
		pointInfo.Pos = _viewModel.PointInfo.Pos;
		return InteractivePoint.UpdatePointVisualDataWithRectangle(areaCorners, guideAngles, RectTransform, base.transform.parent.GetComponent<RectTransform>(), pointInfo);
	}

	public new InteractivePointData GetPointData()
	{
		return _viewModel;
	}
}
