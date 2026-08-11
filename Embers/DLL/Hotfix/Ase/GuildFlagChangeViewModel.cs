using GameFramework.Runtime;

namespace Ase;

public class GuildFlagChangeViewModel : OptionBase
{
	private GuildDefinition.Flag guildFlag;

	private TabItemData curFlagTab;

	private SimpleCommand changeFlagCmd;

	private ISubscription<GuildMessage> onGuildMessage;

	public GuildDefinition.Flag GuildFlag
	{
		get
		{
			return guildFlag;
		}
		set
		{
			Set(ref guildFlag, value, "GuildFlag");
		}
	}

	public SimpleCommand ChangeFlagCmd => changeFlagCmd;

	public GuildFlagChangeViewModel()
	{
	}

	public GuildFlagChangeViewModel(OptionBase parent, GuildDefinition.Flag defaultFlag)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		GuildFlag = defaultFlag;
		changeFlagCmd = new SimpleCommand(TreyChangeFlag);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData flagTabSelected)
		{
			SetFlagTabSelected(flagTabSelected);
		}
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.GuildPermissionChange)
		{
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
			if (myGuildData == null || !GuildDefinition.CheckGuildMemberPermission(myGuildData.Position, GuildDefinition.GuildPermissions.GuildInfoChange))
			{
				Close();
			}
		}
	}

	private void SetFlagTabSelected(TabItemData tabItemData)
	{
		if (curFlagTab != null)
		{
			curFlagTab.IsSelected = false;
		}
		curFlagTab = tabItemData;
		curFlagTab.IsSelected = true;
		GuildFlag = (GuildDefinition.Flag)curFlagTab.TabIndex;
	}

	private async void TreyChangeFlag()
	{
		changeFlagCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestChangeGuildFlag((int)GuildFlag);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("修改成功");
			Close();
		}
		else
		{
			changeFlagCmd.Enabled = true;
		}
	}

	protected override void Dispose(bool disposing)
	{
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}
}
