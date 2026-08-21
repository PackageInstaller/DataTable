using GameFramework.Runtime;

namespace Ase;

public class CampaignMessage : MessageBase
{
	public CampaignMsgType Type;

	public CampaignMessage(object sender, CampaignMsgType type)
		: base(sender)
	{
		Type = type;
	}
}
