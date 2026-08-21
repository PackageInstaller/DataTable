using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置中断的技能ID（按规则来）", 0)]
[Category("Logic/Abilities")]
[Description("设置中断的技能ID")]
public class SetBrokenAbilityIDByRule : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int abilityID)
	{
		AbilitiesProcessor.SetNextFrameAbility(base.parentNode.mSimContext.GetEntityWithEntityID(entityID), abilityID, forceBroken: false);
	}
}
