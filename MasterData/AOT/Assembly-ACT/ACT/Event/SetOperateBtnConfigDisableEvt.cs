using ACT.UI;
using Bamboo.ECS;

namespace ACT.Event;

public class SetOperateBtnConfigDisableEvt : BaseEventContent
{
	public EntityId entityId;

	public CustomUICompType customUICompType;

	public bool enterDisableState;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		customUICompType = CustomUICompType.None;
		enterDisableState = false;
	}
}
