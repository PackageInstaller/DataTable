using ACT.Model;

namespace ACT.UI;

public class AccomplishmentDetailsViewTabActive : RedDotDisplayAction
{
	private int groupId = -1;

	public AccomplishmentDetailsViewTabActive(int groupId)
	{
		comment = "成就有奖励未领取";
		this.groupId = groupId;
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<AccomplishmentModel>.Interface.GroupHasClaimable(groupId);
	}
}
