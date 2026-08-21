using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockPopupSampleWindow : UGuiWindow
{
	[SerializeField]
	private Button outsideBtn;

	[SerializeField]
	private Image titleBg;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private TextMeshProUGUI armourName;

	[SerializeField]
	private Image armourImg;

	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private TextMeshProUGUI desc;

	private RockPopupViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<RockPopupViewModel>();
		BindingSet<RockPopupSampleWindow, RockPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((RockPopupSampleWindow v) => v.CloseWindow).To((RockPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(armourName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockPopupViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind(armourImg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(titleBg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => $"Prop_Title_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => $"Prop_Bg_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		if (entryIcon != null)
		{
			bindingSet.Bind(entryIcon).For((Image v) => v.sprite).To((RockPopupViewModel vm) => vm.EntryIconPath)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockPopupViewModel vm) => vm.ArmourData.Description);
		bindingSet.Bind(outsideBtn.gameObject).For((GameObject v) => v.activeSelf).To((RockPopupViewModel vm) => vm.ShowOutsideMask);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((RockPopupViewModel vm) => vm.Close);
		bindingSet.Build();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
