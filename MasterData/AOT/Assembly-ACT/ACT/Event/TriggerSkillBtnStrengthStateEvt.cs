using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Event;

public class TriggerSkillBtnStrengthStateEvt : BaseEventContent
{
	public EntityId entityId;

	public BtnType btnType;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		btnType = BtnType.none;
	}
}
