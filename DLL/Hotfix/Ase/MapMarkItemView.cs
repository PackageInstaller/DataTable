using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapMarkItemView : MapMarkItemViewBase
{
	[SerializeField]
	private List<GameObject> taskEffects;

	[SerializeField]
	private List<GameObject> tpPointEffects;

	[SerializeField]
	private RectTransform pointRange;

	[SerializeField]
	private GameObject bubble1;

	[SerializeField]
	private Image bubbleIcon1;

	[SerializeField]
	private bool _isDynamicEffect;

	[SerializeField]
	private GameObject _scanEffectPfb;

	[SerializeField]
	private GameObject _taskPointEffectPfb;

	[SerializeField]
	private GameObject _tpEffectPfb;

	private Transform parentRoot;

	private Transform overlayParentRoot;

	private bool _showScanEffect;

	private GameObject _showScanEffectGO;

	private bool _showTaskEffect;

	private GameObject _showTaskEffectGO;

	private bool _showTPEffect;

	private GameObject _showTPEffectGO;

	public bool ShowScanEffect
	{
		get
		{
			return _showScanEffect;
		}
		set
		{
			if (value != _showScanEffect)
			{
				_showScanEffect = value;
				CheckDynamicEffectNode(_showScanEffect, ref _showScanEffectGO, pointRange);
			}
		}
	}

	public bool ShowTaskEffect
	{
		get
		{
			return _showTaskEffect;
		}
		set
		{
			if (value != _showTaskEffect)
			{
				_showTaskEffect = value;
				CheckDynamicEffectNode(_showTaskEffect, ref _showTaskEffectGO, item);
			}
		}
	}

	public bool ShowTPEffect
	{
		get
		{
			return _showTPEffect;
		}
		set
		{
			if (value != _showTPEffect)
			{
				_showTPEffect = value;
				CheckDynamicEffectNode(_showTPEffect, ref _showTPEffectGO, item);
			}
		}
	}

	private void CheckDynamicEffectNode(bool isShow, ref GameObject effectGO, Transform parent)
	{
		if (isShow)
		{
			if (effectGO == null && parent != null)
			{
				effectGO = Object.Instantiate(_tpEffectPfb, parent);
			}
		}
		else if (!isShow && effectGO != null)
		{
			Object.Destroy(effectGO);
			effectGO = null;
		}
	}

	private void RegisterDynamicEffect(BindingSet<MapMarkItemView, MapMarkItemViewModel> bindingSet)
	{
		if (_isDynamicEffect)
		{
			bindingSet.Bind(this).For((MapMarkItemView v) => v.ShowTaskEffect).ToExpression((MapMarkItemViewModel vm) => vm.ShowTaskEffect && vm.ShowIcon);
			bindingSet.Bind(this).For((MapMarkItemView v) => v.ShowTPEffect).ToExpression((MapMarkItemViewModel vm) => vm.ShowBonfireEffect && vm.ShowIcon);
			bindingSet.Bind(this).For((MapMarkItemView v) => v.ShowScanEffect).To((MapMarkItemViewModel vm) => vm.ShowMarkRange);
		}
	}

	public override void Init(MapMarkItemViewModel viewModel, Transform normalParent, Transform overlayParent)
	{
		base.Init(viewModel, normalParent, overlayParent);
		BindingSet<MapMarkItemView, MapMarkItemViewModel> bindingSet = this.CreateBindingSet(base.viewModel);
		if (taskEffects != null)
		{
			foreach (GameObject taskEffect in taskEffects)
			{
				bindingSet.Bind(taskEffect).For((GameObject v) => v.activeSelf).ToExpression((MapMarkItemViewModel vm) => vm.ShowTaskEffect && vm.ShowIcon);
			}
		}
		if (tpPointEffects != null)
		{
			foreach (GameObject tpPointEffect in tpPointEffects)
			{
				bindingSet.Bind(tpPointEffect).For((GameObject v) => v.activeSelf).ToExpression((MapMarkItemViewModel vm) => vm.ShowBonfireEffect && vm.ShowIcon);
			}
		}
		if (bubble1 != null && bubbleIcon1 != null)
		{
			bindingSet.Bind(bubble1).For((GameObject v) => v.activeSelf).ToExpression((MapMarkItemViewModel vm) => vm.BubbleCount > 0);
			bindingSet.Bind(bubbleIcon1).For((Image v) => v.sprite).To((MapMarkItemViewModel vm) => vm.BubbleIcon1)
				.WithConversion("ItemIcon");
		}
		if (outsideIcon != null)
		{
			bindingSet.Bind(outsideIcon).For((Image v) => v.sprite).To((MapMarkItemViewModel vm) => vm.OutsideIcon)
				.WithConversion("ItemIcon");
		}
		if (pointRange != null)
		{
			bindingSet.Bind(pointRange).For((RectTransform v) => v.sizeDelta).To((MapMarkItemViewModel vm) => vm.MarkRange);
			bindingSet.Bind(pointRange.gameObject).For((GameObject v) => v.activeSelf).To((MapMarkItemViewModel vm) => vm.ShowMarkRange);
		}
		RegisterDynamicEffect(bindingSet);
		bindingSet.Build();
		viewModel.SetMarkItemSize(item.sizeDelta * item.localScale);
	}

	public override void RefreshData(MapMarkItemViewModel viewModel)
	{
		base.RefreshData(viewModel);
		this.SetDataContext(viewModel);
		viewModel.SetMarkItemSize(item.sizeDelta * item.localScale);
	}

	protected override void OnDestroy()
	{
		if (_isDynamicEffect)
		{
			if (_showScanEffectGO != null)
			{
				Object.Destroy(_showScanEffectGO);
			}
			if (_showTaskEffectGO != null)
			{
				Object.Destroy(_showTaskEffectGO);
			}
			if (_showTPEffectGO != null)
			{
				Object.Destroy(_showTPEffectGO);
			}
		}
		base.OnDestroy();
	}
}
