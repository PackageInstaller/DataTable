using System.Collections.Generic;

namespace Ase;

public class GuildEventMsgViewModel : OptionBase
{
	private List<GuildEventMsgData> eventMsgDatas = new List<GuildEventMsgData>();

	public List<GuildEventMsgData> EventMsgDatas => eventMsgDatas;

	public GuildEventMsgViewModel()
	{
	}

	public GuildEventMsgViewModel(OptionBase parent)
	{
		base.parent = parent;
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		if (myGuildData != null && myGuildData.EventMsgDatas != null)
		{
			for (int num = myGuildData.EventMsgDatas.Count - 1; num >= 0; num--)
			{
				eventMsgDatas.Add(myGuildData.EventMsgDatas[num]);
			}
		}
	}
}
