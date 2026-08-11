using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildPlayerItem : PlayerItemBase
{
	[SerializeField]
	private Button btnRefuse;

	[SerializeField]
	private Button btnPass;

	[SerializeField]
	private Button btnInvite;

	private GuildPlayerItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildPlayerItemData>(userData);
		BindingSet<GuildPlayerItem, GuildPlayerItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (btnRefuse != null)
		{
			bindingSet.Bind(btnRefuse).For((Button v) => v.onClick).To((GuildPlayerItemData vm) => vm.OnBtnRefuseClick);
		}
		if (btnPass != null)
		{
			bindingSet.Bind(btnPass).For((Button v) => v.onClick).To((GuildPlayerItemData vm) => vm.OnBtnPassClick);
		}
		if (btnInvite != null)
		{
			bindingSet.Bind(btnInvite).For((Button v) => v.onClick).To((GuildPlayerItemData vm) => vm.OnBtnInviteClick);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is GuildPlayerItemData guildPlayerItemData)
		{
			_viewModel = guildPlayerItemData;
			this.SetDataContext(guildPlayerItemData);
		}
	}
}
