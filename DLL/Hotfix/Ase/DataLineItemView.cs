using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class DataLineItemView : UGuiView
{
	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI damage;

	[SerializeField]
	private TextMeshProUGUI dps;

	[SerializeField]
	private TextMeshProUGUI damageProportion;

	[SerializeField]
	private TextMeshProUGUI energyProportion;

	public void Init(BattleStatisticDetailData viewModel)
	{
		BindingSet<DataLineItemView, BattleStatisticDetailData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleStatisticDetailData vm) => vm.SkillName);
		bindingSet.Bind<TextMeshProUGUI>(damage).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleStatisticDetailData vm) => vm.Damage);
		bindingSet.Bind<TextMeshProUGUI>(dps).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleStatisticDetailData vm) => vm.Dps);
		bindingSet.Bind<TextMeshProUGUI>(damageProportion).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatisticDetailData vm) => $"{vm.DamageProportion * 100f}%");
		bindingSet.Bind<TextMeshProUGUI>(energyProportion).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatisticDetailData vm) => $"{vm.EnergyProportion * 100f}%");
		bindingSet.Build();
	}

	public void RefreshData(BattleStatisticDetailData viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
