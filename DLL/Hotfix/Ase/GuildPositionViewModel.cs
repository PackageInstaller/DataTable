using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GuildPositionViewModel : OptionBase
{
	private int curTabIndex = 1;

	private TabItemData curSelectTabData;

	private MyGuildData myGuildData;

	private GuildMemberData masterData;

	private List<GuildMemberData> viceMasterData = new List<GuildMemberData>();

	private List<GuildMemberData> excellentMemberData = new List<GuildMemberData>();

	private InteractionRequest tabOnCickRst = new InteractionRequest();

	public int CurTabIndex
	{
		get
		{
			return curTabIndex;
		}
		set
		{
			Set(ref curTabIndex, value, "CurTabIndex");
		}
	}

	public MyGuildData MyGuildData => myGuildData;

	public InteractionRequest TabOnCickRst => tabOnCickRst;

	public GuildMemberData MasterData => masterData;

	public List<GuildMemberData> ViceMasterData => viceMasterData;

	public List<GuildMemberData> ExcellentMemberData => excellentMemberData;

	public GuildPositionViewModel()
	{
	}

	public GuildPositionViewModel(OptionBase parent)
	{
		base.parent = parent;
		myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		masterData = myGuildData.Master;
		viceMasterData = myGuildData.Members.FindAll((GuildMemberData p) => p.Position == GuildDefinition.GuildPositions.ViceMaster);
		excellentMemberData = myGuildData.Members.FindAll((GuildMemberData p) => p.Position == GuildDefinition.GuildPositions.ExcellentMember);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			if (curSelectTabData != null)
			{
				curSelectTabData.IsSelected = false;
			}
			curSelectTabData = tabItemData;
			curSelectTabData.IsSelected = true;
			CurTabIndex = tabItemData.TabIndex;
			tabOnCickRst.Raise();
		}
	}
}
