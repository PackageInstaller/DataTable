using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class KillRewardItem : KnapsackItemNew
{
	[SerializeField]
	private Image rewardGlow;

	[SerializeField]
	private Image rewardGlow2;

	private KnapsackItemViewModel viewModel;

	public new void Init(KnapsackItemViewModel data)
	{
		base.Init(data);
		viewModel = data;
		BindingSet<KillRewardItem, KnapsackItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (rewardGlow != null)
		{
			bindingSet.Bind(rewardGlow).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => $"battle_item_line_{vm.Quality}")
				.WithConversion("ItemIcon");
		}
		if (rewardGlow2 != null)
		{
			bindingSet.Bind(rewardGlow2).For((Image v) => v.sprite).ToExpression((KnapsackItemViewModel vm) => $"battle_item_line_{vm.Quality}")
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
	}

	public void RefreshData(BattleEndRewardItemData data)
	{
		this.SetDataContext(data);
	}
}
