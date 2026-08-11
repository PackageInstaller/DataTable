using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class BTBuffView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private TextMeshProUGUI buffid;

	[SerializeField]
	private TextMeshProUGUI limitTime;

	[SerializeField]
	private TextMeshProUGUI maxLimitTime;

	[SerializeField]
	private TextMeshProUGUI coolingTime;

	[SerializeField]
	private TextMeshProUGUI maxCoolingTime;

	[SerializeField]
	private TextMeshProUGUI state;

	[SerializeField]
	private TextMeshProUGUI isLoop;

	[SerializeField]
	private TextMeshProUGUI layer;

	private BTBuffViewModel viewModel;

	public void Init(BTBuffViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<BTBuffView, BTBuffViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(buffid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"Id：{vm.BuffId}");
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"描述：{vm.Desc}");
		bindingSet.Bind<TextMeshProUGUI>(limitTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"LimitTime：{vm.LimitTime}");
		bindingSet.Bind<TextMeshProUGUI>(maxLimitTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"MaxLimitTime：{vm.MaxLimitTime}");
		bindingSet.Bind<TextMeshProUGUI>(coolingTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"CoolingTime：{vm.CoolingTime}");
		bindingSet.Bind<TextMeshProUGUI>(maxCoolingTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"MaxCoolingTime：{vm.MaxCoolingTime}");
		bindingSet.Bind<TextMeshProUGUI>(state).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"State：{vm.State.ToString()}");
		bindingSet.Bind<TextMeshProUGUI>(isLoop).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"isLoop：{vm.IsLoop}");
		bindingSet.Bind<TextMeshProUGUI>(layer).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTBuffViewModel vm) => $"layer：{vm.Layer}");
		bindingSet.Build();
	}

	public void RefreshData(BTBuffViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
