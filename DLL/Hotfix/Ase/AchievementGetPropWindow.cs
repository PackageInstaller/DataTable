using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

internal class AchievementGetPropWindow : UGuiWindow
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private List<GameObject> effectList;

	private AchievementGetPropViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AchievementGetPropViewModel>();
		BindingSet<AchievementGetPropWindow, AchievementGetPropViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((AchievementGetPropWindow v) => v.CloseWindow).To((AchievementGetPropViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AchievementGetPropWindow v) => v.OpenUguiWindow).To((AchievementGetPropViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((AchievementGetPropViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementGetPropViewModel vm) => vm.Title);
		bindingSet.Build();
		base.transform.GetComponent<AutoDispose>()?.AddDisposeAction((Action<GameObject>)delegate
		{
			Dismiss();
		});
		if (effectList.Count >= viewModel.Rarity)
		{
			effectList[viewModel.Rarity - 1].gameObject.SetActive(value: true);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
