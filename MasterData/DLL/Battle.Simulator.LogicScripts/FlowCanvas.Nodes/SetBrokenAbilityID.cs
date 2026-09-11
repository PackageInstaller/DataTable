using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置中断的技能ID(连招打断)", 0)]
[Category("Logic/Abilities")]
[Description("设置中断的技能ID")]
public class SetBrokenAbilityID : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, forceBroken: true);
		CDProcessor.SetCD(entityWithEntityID, abilityID, 0, 0);
	}
}
