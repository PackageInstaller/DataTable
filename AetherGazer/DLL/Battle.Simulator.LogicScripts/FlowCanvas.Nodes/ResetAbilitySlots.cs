using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除技能槽（过时）", 0)]
[Category("Logic/Abilities")]
[Description("将技能槽中所有值置零")]
public class ResetAbilitySlots : CallableActionNode<int>
{
	public override void Invoke(int simEntityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			for (int i = 0; i < entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length; i++)
			{
				entityWithEntityID.entityBlackboard.var.mAbilitySlots[i] = 0;
			}
		}
	}
}
