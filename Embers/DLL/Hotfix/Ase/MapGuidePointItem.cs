using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapGuidePointItem : UIView
{
	[SerializeField]
	private RectTransform pointRect;

	[SerializeField]
	private Image icon1;

	[SerializeField]
	private Button btnGuide;

	[SerializeField]
	private GameObject bubbleRoot;

	[SerializeField]
	private Image icon2;

	[SerializeField]
	private Image icon3;

	private MapGuidePointItemData _viewModel;

	public void Init(MapGuidePointItemData viewModel)
	{
		_viewModel = viewModel;
		BindingSet<MapGuidePointItem, MapGuidePointItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(pointRect).For((RectTransform v) => v.anchoredPosition).To((MapGuidePointItemData vm) => vm.ShowPos);
		bindingSet.Bind(pointRect).For((RectTransform v) => v.localEulerAngles).To((MapGuidePointItemData vm) => vm.CurAngle);
		bindingSet.Bind(icon1).For((Image v) => v.sprite).To((MapGuidePointItemData vm) => vm.GuideIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnGuide).For((Button v) => v.onClick).To((MapGuidePointItemData vm) => vm.OnClick);
		bindingSet.Bind(bubbleRoot).For((GameObject v) => v.activeSelf).ToExpression((MapGuidePointItemData vm) => vm.GuideCount > 1);
		bindingSet.Bind(icon2.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MapGuidePointItemData vm) => vm.GuideCount > 1);
		bindingSet.Bind(icon2).For((Image v) => v.sprite).To((MapGuidePointItemData vm) => vm.GuideIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon3.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MapGuidePointItemData vm) => vm.GuideCount > 2);
		bindingSet.Bind(icon3).For((Image v) => v.sprite).To((MapGuidePointItemData vm) => vm.GuideIcon3)
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon1.rectTransform).For((RectTransform v) => v.localEulerAngles).ToExpression((MapGuidePointItemData vm) => -vm.CurAngle);
		bindingSet.Bind(icon2.rectTransform).For((RectTransform v) => v.localEulerAngles).ToExpression((MapGuidePointItemData vm) => -vm.CurAngle);
		bindingSet.Bind(icon3.rectTransform).For((RectTransform v) => v.localEulerAngles).ToExpression((MapGuidePointItemData vm) => -vm.CurAngle);
		bindingSet.Build();
	}

	public void RefreshData(MapGuidePointItemData viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void ItemScale(float scale)
	{
		pointRect.localScale = Vector2.one * scale;
	}
}
