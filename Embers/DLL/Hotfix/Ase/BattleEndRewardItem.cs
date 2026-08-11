using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class BattleEndRewardItem : KnapsackItemNew
{
	[SerializeField]
	private GameObject extraObj;

	[SerializeField]
	private TextMeshProUGUI extraText;

	[SerializeField]
	private GameObject lockObj;

	private BattleEndRewardItemData viewModel;

	public void Init(BattleEndRewardItemData data)
	{
		Init((KnapsackItemViewModel)data);
		viewModel = data;
		BindingSet<BattleEndRewardItem, BattleEndRewardItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(extraObj).For((GameObject v) => v.activeSelf).To((BattleEndRewardItemData vm) => vm.IsExtraItem);
		bindingSet.Bind<TextMeshProUGUI>(extraText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleEndRewardItemData vm) => vm.ExtraText);
		if (lockObj != null)
		{
			bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((BattleEndRewardItemData vm) => vm.IsLock);
		}
		bindingSet.Build();
	}

	public void RefreshData(BattleEndRewardItemData data)
	{
		this.SetDataContext(data);
	}
}
