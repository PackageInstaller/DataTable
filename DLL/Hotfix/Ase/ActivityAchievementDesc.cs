using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ActivityAchievementDesc : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI lvTxt;

	[SerializeField]
	private TextMeshProUGUI descTxt;

	private ActivityAchievementDescData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ActivityAchievementDescData>(userData);
		BindingSet<ActivityAchievementDesc, ActivityAchievementDescData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(lvTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityAchievementDescData vm) => $"LV{vm.LvTxt}：");
		bindingSet.Bind<TextMeshProUGUI>(descTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementDescData vm) => vm.DescTxt);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is ActivityAchievementDescData dataContext)
		{
			viewModel = dataContext;
			this.SetDataContext(dataContext);
		}
	}
}
