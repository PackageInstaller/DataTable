using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StatusAttrItemView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private TextMeshProUGUI outerValueText;

	[SerializeField]
	private TextMeshProUGUI deltaText;

	[SerializeField]
	private GameObject evenBg;

	[SerializeField]
	private GameObject oddBg;

	private Color positiveColor = Color.green;

	private Color negativeColor = Color.red;

	private StatusAttrItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<StatusAttrItemViewModel>(userData);
		BindingSet<StatusAttrItemView, StatusAttrItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((StatusAttrItemViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)nameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StatusAttrItemViewModel vm) => vm.Name);
		}
		if ((UnityEngine.Object)(object)outerValueText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(outerValueText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StatusAttrItemViewModel vm) => vm.OuterValue);
		}
		if ((UnityEngine.Object)(object)deltaText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(deltaText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StatusAttrItemViewModel vm) => vm.DeltaValue);
			bindingSet.Bind<TextMeshProUGUI>(deltaText).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((StatusAttrItemViewModel vm) => vm.IsPositive ? positiveColor : (vm.IsNegative ? negativeColor : Color.white));
		}
		bindingSet.Build();
		ApplyBackground(viewModel?.Index ?? 0);
	}

	public override void RefreshData(object userData)
	{
		if (userData is StatusAttrItemViewModel statusAttrItemViewModel)
		{
			viewModel = statusAttrItemViewModel;
			this.SetDataContext(statusAttrItemViewModel);
			ApplyBackground(statusAttrItemViewModel.Index);
		}
	}

	public void SetColors(Color positive, Color negative)
	{
		positiveColor = positive;
		negativeColor = negative;
	}

	private void ApplyBackground(int idx)
	{
		if (evenBg != null)
		{
			evenBg.SetActive(idx % 2 == 0);
		}
		if (oddBg != null)
		{
			oddBg.SetActive(idx % 2 == 1);
		}
	}
}
