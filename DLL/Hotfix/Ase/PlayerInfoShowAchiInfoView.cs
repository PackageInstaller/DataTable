using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerInfoShowAchiInfoView : UGuiView
{
	[SerializeField]
	private Image showAchiInfoIcon;

	[SerializeField]
	private Image showAchiInfoIconBG;

	[SerializeField]
	private TextMeshProUGUI showAchiInfoTxt;

	private PlayerInfoShowAchiInfoViewModel viewModel;

	public void Init(PlayerInfoShowAchiInfoViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PlayerInfoShowAchiInfoView, PlayerInfoShowAchiInfoViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(showAchiInfoIcon).For((Image v) => v.sprite).ToExpression((PlayerInfoShowAchiInfoViewModel vm) => vm.AchiIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(showAchiInfoIconBG).For((Image v) => v.sprite).ToExpression((PlayerInfoShowAchiInfoViewModel vm) => $"achievements_Iconbg_{vm.AchiRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(showAchiInfoTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerInfoShowAchiInfoViewModel vm) => vm.AchiDesc);
		bindingSet.Build();
	}
}
