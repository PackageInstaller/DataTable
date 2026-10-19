using ACT.Utility;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Tip", "Action", new string[] { "tip", "ui", "hud", "text" })]
public class ActionTip : ConfigAction
{
	public int tipTextId;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		GameUtility.OpenToolTip(tipTextId);
	}
}
