using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class PassportLevelItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private List<PassportRewardItem> passportRewardItemList;

	[SerializeField]
	private GameObject showObj;

	private PassportLevelItemData viewModel;

	public void Init(PassportLevelItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportLevelItem, PassportLevelItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PassportLevelItemData vm) => $"{vm.Level}级");
		if (showObj != null)
		{
			bindingSet.Bind(showObj).For((GameObject v) => v.activeSelf).ToExpression((PassportLevelItemData vm) => vm.PassportLevel == vm.Level);
		}
		bindingSet.Build();
		InitPassRewardItem();
	}

	public int GetLevel()
	{
		return viewModel.Level;
	}

	private void InitPassRewardItem()
	{
		for (int i = 0; i < passportRewardItemList.Count; i++)
		{
			passportRewardItemList[i].Init(viewModel.PassportRewardItemDataList[i]);
		}
	}

	public void RefreshLevelData(PassportLevelItemData viewModel)
	{
		this.viewModel = viewModel;
		for (int i = 0; i < passportRewardItemList.Count; i++)
		{
			passportRewardItemList[i].RefreshPassRewardItemData(viewModel.PassportRewardItemDataList[i]);
		}
		this.SetDataContext(viewModel);
	}
}
