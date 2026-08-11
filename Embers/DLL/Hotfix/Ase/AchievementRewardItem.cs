using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

internal class AchievementRewardItem : UGuiView
{
	[SerializeField]
	private Image rarity;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private GameObject receivedObj;

	private AchievementRewardItemData viewModel;

	public void Init(AchievementRewardItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AchievementRewardItem, AchievementRewardItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((AchievementRewardItemData vm) => $"RarityBG_Large_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((AchievementRewardItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).ToExpression((AchievementRewardItemData vm) => vm.State == 2);
		bindingSet.Bind(receivedObj).For((GameObject v) => v.activeSelf).ToExpression((AchievementRewardItemData vm) => vm.State == 3);
		bindingSet.Build();
	}

	public void RefreshAchievementData(AchievementRewardItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
