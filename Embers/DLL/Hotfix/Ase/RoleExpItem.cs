using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RoleExpItem : LoopListViewItem2
{
	[SerializeField]
	private Image roleIcon;

	[SerializeField]
	private Image heroExpFill;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private TextMeshProUGUI exp;

	private RoleExpData viewModel;

	public void Init(RoleExpData data)
	{
		viewModel = data;
		BindingSet<RoleExpItem, RoleExpData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((RoleExpData vm) => $"Lv.{vm.HeroModel.Level}");
		bindingSet.Bind(heroExpFill).For((Image v) => v.fillAmount).To((RoleExpData vm) => vm.ExpFill);
		bindingSet.Bind(roleIcon).For((Image v) => v.sprite).ToExpression((RoleExpData vm) => $"{vm.HeroModel.Id}SquareHead")
			.WithConversion("ItemIcon")
			.OneWay();
		bindingSet.Bind<TextMeshProUGUI>(exp).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((RoleExpData vm) => $"<size=35>EXP</size>\u00a0<size=40>+{vm.ExpAdd}</size>");
		bindingSet.Build();
	}

	public void RefreshData(RoleExpData data)
	{
		this.SetDataContext(data);
	}
}
