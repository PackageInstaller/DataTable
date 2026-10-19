using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Event;

public class UIEntityGetHitEvt : BaseEventContent
{
	public CmdHit cmdHit;

	public EntityId uid;
}
