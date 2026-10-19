using System.Linq;
using ACT.Game.Data;
using Fundamental;

namespace ACT.UI;

public class HasUnreadMailAction : RedDotDisplayAction
{
	public HasUnreadMailAction()
	{
		comment = "有未读邮件";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Singleton<MailboxCacheManager>.instance.allDisplayableMailList.Any((Mail m) => m.State == 0);
	}
}
