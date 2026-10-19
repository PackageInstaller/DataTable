using System.Linq;
using ACT.Game.Data;
using Fundamental;

namespace ACT.UI;

public class UnreadMailAction : RedDotDisplayAction
{
	public int mailId;

	public UnreadMailAction()
	{
		comment = "有未读邮件";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Singleton<MailboxCacheManager>.instance.allDisplayableMailList.Any((Mail m) => m.State == 0 && m.Id == mailId);
	}
}
