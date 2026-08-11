namespace Ase;

public class GuildPlayerItemData : PlayerItemBaseData
{
	public GuildPlayerItemData()
	{
	}

	public GuildPlayerItemData(OptionBase parent, PlayerDataBase playerDataBase)
		: base(parent, playerDataBase)
	{
	}

	public void OnBtnRefuseClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "RefuseApplication"));
	}

	public void OnBtnPassClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "PassApplication"));
	}

	public void OnBtnInviteClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "Invite"));
	}
}
