using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

internal class AchievementItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI rate;

	[SerializeField]
	private Image fill;

	[SerializeField]
	private Button openBtn;

	[SerializeField]
	private GameObject redPoint;

	private AchievementItemData viewModel;

	public void Init(AchievementItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AchievementItem, AchievementItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((AchievementItemData vm) => vm.Img)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(rate).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((AchievementItemData vm) => $"{vm.Rate}%");
		bindingSet.Bind(fill).For((Image v) => v.fillAmount).To((AchievementItemData vm) => vm.Fill);
		bindingSet.Bind(openBtn).For((Button v) => v.onClick).To((AchievementItemData vm) => vm.OnClick);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((AchievementItemData vm) => vm.ShowRedPoint);
		bindingSet.Build();
	}

	public void RefreshAchievementData(AchievementItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
