using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameGuideWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private List<TabItemNormal> tagList;

	private GameGuideViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameGuideViewModel>();
		BindingSet<GameGuideWindow, GameGuideViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameGuideViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GameGuideWindow v) => v.OpenUguiWindow).To((GameGuideViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameGuideWindow v) => v.CloseWindow).To((GameGuideViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		InitTagList();
	}

	private void InitTagList()
	{
		if (tagList.Count != viewModel.TagDataList.Count)
		{
			Toast.ShowError("数量不匹配,请检查资源");
			return;
		}
		for (int i = 0; i < tagList.Count; i++)
		{
			tagList[i].Init(viewModel.TagDataList[i]);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
