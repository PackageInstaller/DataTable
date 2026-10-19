using ACT.Model;

namespace ACT.UI;

public class AccomplishmentEntranceActive : RedDotDisplayAction
{
	private int typeId = -1;

	public AccomplishmentEntranceActive(int typeId)
	{
		comment = "成就有奖励未领取";
		this.typeId = typeId;
	}

	public override bool Do(RedDotTrieNode node)
	{
		return Model<AccomplishmentModel>.Interface.MainHasClaimable(typeId);
	}
}
