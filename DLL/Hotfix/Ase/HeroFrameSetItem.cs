using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroFrameSetItem : UGuiView
{
	[SerializeField]
	private Image frame;

	[SerializeField]
	private GameObject btnPart;

	[SerializeField]
	private Button btnApply;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private GameObject btnApplyMask;

	private HeroFrameSetItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroFrameSetItemData>(userData);
		BindingSet<HeroFrameSetItem, HeroFrameSetItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(frame.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroFrameSetItemData vm) => !string.IsNullOrEmpty(vm.Frame));
		bindingSet.Bind(frame).For((Image v) => v.sprite).To((HeroFrameSetItemData vm) => vm.Frame)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnPart).For((GameObject v) => v.activeSelf).To((HeroFrameSetItemData vm) => vm.ShowBtnPart);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroFrameSetItemData vm) => vm.BtnText);
		bindingSet.Bind(btnApply).For((Button v) => v.enabled).ToExpression((HeroFrameSetItemData vm) => !vm.ShowBtnMask);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((HeroFrameSetItemData vm) => vm.OnBtnApplyClick);
		bindingSet.Bind(btnApplyMask).For((GameObject v) => v.activeSelf).To((HeroFrameSetItemData vm) => vm.ShowBtnMask);
		bindingSet.Build();
	}
}
