using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]设置CD是否暂停", 0)]
[Category("Logic/Attribute")]
[Description("设置CD是否暂停")]
[ExposeAsDefinition]
public class SetCDPause : CallableActionNode<int, int, bool>
{
	public override void Invoke(int target, int abilityID, bool isPause)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.SetPauseCD(entityWithEntityID, abilityID, isPause);
		}
	}
}
