using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class PlayerInfoCopyInfoItem : UGuiView
{
	[SerializeField]
	private LoadUISprite copyIcon;

	[SerializeField]
	private TextMeshProUGUI scoreTxt;

	[SerializeField]
	private TextMeshProUGUI copyNameTxt;

	private PlayerInfoCopyInfoItemViewModel viewModel;

	public void Init(PlayerInfoCopyInfoItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PlayerInfoCopyInfoItem, PlayerInfoCopyInfoItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(copyNameTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerInfoCopyInfoItemViewModel vm) => vm.CopyName);
		bindingSet.Bind<TextMeshProUGUI>(scoreTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerInfoCopyInfoItemViewModel vm) => vm.ScoreTxt);
		bindingSet.Bind(copyIcon).For((LoadUISprite v) => v.Path).ToExpression((PlayerInfoCopyInfoItemViewModel vm) => $"Copy/CopySelect/{vm.CopyIcon}");
		bindingSet.Build();
	}
}
