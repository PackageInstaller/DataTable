using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HLFriendFarmWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI leftIncreaseText;

	[SerializeField]
	private TextMeshProUGUI leftGetText;

	[SerializeField]
	private List<HLPlantItem> HlPlantItemDataList;

	private HLFriendFarmViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HLFriendFarmViewModel>();
		BindingSet<HLFriendFarmWindow, HLFriendFarmViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HLFriendFarmWindow v) => v.CloseWindow).To((HLFriendFarmViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((HLFriendFarmWindow v) => v.OpenUguiWindow).To((HLFriendFarmViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<TextMeshProUGUI>(leftIncreaseText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HLFriendFarmViewModel vm) => $"剩余增产次数:{vm.LeftIncreaseText}");
		bindingSet.Bind<TextMeshProUGUI>(leftGetText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HLFriendFarmViewModel vm) => $"剩余获取次数:{vm.LeftHarvestText}");
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HLFriendFarmViewModel vm) => vm.Close);
		bindingSet.Build();
		LoadPlantItem();
	}

	private void LoadPlantItem()
	{
		for (int i = 0; i < viewModel.HlPlantItemDataList.Count; i++)
		{
			HlPlantItemDataList[i].Init(viewModel.HlPlantItemDataList[i]);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
