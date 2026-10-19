using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class EvtFindSwitchPos : BaseEvt
{
	public Entity beforeEntity;

	public TargetBounds forwardBounds;

	public TargetBounds backBounds;

	public SwitchSkillPosData data;

	public override void Reset()
	{
		beforeEntity = default;
	}
}
