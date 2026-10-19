using ACT.UI;
using Bamboo.ECS;

namespace ACT.Event;

public class PromptOperateBtnEvt : BaseEventContent
{
	public EntityId entityId;

	public CustomUICompType customUICompType;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		customUICompType = CustomUICompType.None;
	}
}
