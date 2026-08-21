using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildFlagChangeWindow : UGuiWindow
{
	[SerializeField]
	private List<TabItem> guildFlags;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnChange;

	private GuildFlagChangeViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildFlagChangeViewModel>();
		BindingSet<GuildFlagChangeWindow, GuildFlagChangeViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildFlagChangeWindow v) => v.OnDismissRequest).To((GuildFlagChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildFlagChangeWindow v) => v.OpenUguiWindow).To((GuildFlagChangeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((GuildFlagChangeViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((GuildFlagChangeViewModel vm) => vm.Close);
		bindingSet.Bind(btnChange).For((Button v) => v.onClick).To((GuildFlagChangeViewModel vm) => vm.ChangeFlagCmd);
		bindingSet.Build();
		if (guildFlags == null)
		{
			return;
		}
		for (int num = 1; num <= guildFlags.Count; num++)
		{
			if (Enum.IsDefined(typeof(GuildDefinition.Flag), num))
			{
				guildFlags[num - 1].Init(new TabItemData(_viewModel, num));
				if (num == (int)_viewModel.GuildFlag)
				{
					guildFlags[num - 1].ViewModel.TabOnClick();
				}
			}
		}
	}
}
