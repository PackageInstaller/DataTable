using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Mail
{
	public readonly int id;

	public readonly int mailBoxType;

	public readonly int notice;

	public readonly int mailPriority;

	public readonly List<ItemKv> mailItem;

	public readonly int mailTitle;

	public readonly int mailShow;

	public readonly int[] changeable = new int[0];

	public readonly int sender;

	public readonly int timeType;

	public readonly long[] timePara = new long[0];

	public readonly long[] timeInterval = new long[0];

	public readonly List<ItemKv> playerPara;

	public readonly int triggerType;

	public Mail(int id, int mailBoxType, int notice, int mailPriority, List<ItemKv> mailItem, int mailTitle, int mailShow, int[] changeable, int sender, int timeType, long[] timePara, long[] timeInterval, List<ItemKv> playerPara, int triggerType)
	{
		this.id = id;
		this.mailBoxType = mailBoxType;
		this.notice = notice;
		this.mailPriority = mailPriority;
		this.mailItem = mailItem;
		this.mailTitle = mailTitle;
		this.mailShow = mailShow;
		this.changeable = changeable;
		this.sender = sender;
		this.timeType = timeType;
		this.timePara = timePara;
		this.timeInterval = timeInterval;
		this.playerPara = playerPara;
		this.triggerType = triggerType;
	}
}
