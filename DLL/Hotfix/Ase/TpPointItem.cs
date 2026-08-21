using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TpPointItem : InteractivePoint
{
	[SerializeField]
	private Image highLightIcon;

	[SerializeField]
	private Image lockIcon;

	[SerializeField]
	private RectTransform nameBg;

	[SerializeField]
	private new TextMeshProUGUI name;

	private TpPointItemData _viewModel;

	public void Init(TpPointItemData data)
	{
		base.Init(data);
		_viewModel = data;
		BindingSet<TpPointItem, TpPointItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TpPointItemData vm) => vm.PointInfo.Name);
		bindingSet.Bind(nameBg).For((RectTransform v) => v.localScale).To((TpPointItemData vm) => vm.NameBgScale);
		bindingSet.Bind(nameBg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TpPointItemData vm) => !vm.IsLock);
		bindingSet.Bind(icon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TpPointItemData vm) => !vm.IsLock);
		bindingSet.Bind(highLightIcon).For((Image v) => v.sprite).To((TpPointItemData vm) => vm.HighLightIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(lockIcon).For((Image v) => v.sprite).To((TpPointItemData vm) => vm.LockIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(lockIcon.gameObject).For((GameObject v) => v.activeSelf).To((TpPointItemData vm) => vm.IsLock);
		bindingSet.Bind(highLightIcon.gameObject).For((GameObject v) => v.activeSelf).To((TpPointItemData vm) => vm.IsHighlight);
		bindingSet.Build();
	}

	public void RefreshData(DRTransferPoint drData, DRMap drMap, Vector2 mapSize, float sceneRatio = 0f)
	{
		_viewModel.RefreshData(drData, drMap, mapSize, sceneRatio);
		base.gameObject.name = $"tpPoint{drData.Id}";
	}

	public void RefreshState(bool active)
	{
		_viewModel.RefreshState(active);
	}

	public new InteractivePointData GetPointData()
	{
		return _viewModel;
	}
}
