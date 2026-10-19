using ACT.MultiPlayer;

namespace ACT.Event;

public class DamageNumberSpawnEvt : BaseEventContent
{
	public CmdDamageNumber cmdDamageNumber;

	public override void ReleaseEvt()
	{
		cmdDamageNumber = default;
	}
}
