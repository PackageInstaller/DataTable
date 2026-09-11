using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据输入获取技能ID", 0)]
[Category("Logic/Attribute")]
[Description("设置CD时间")]
[ExposeAsDefinition]
public class GetAbilityIDByInput : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int entityID, int input)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null)
		{
			int num = 0;
			RoleConfig roleConfig = entityWithEntityID.entityConfig.mConfig as RoleConfig;
			switch (input)
			{
			case 5:
				_ = roleConfig.Melees.Count;
				num = roleConfig.Melees.get_Item(entityWithEntityID.entityBlackboard.var.meleeIndex);
				if (entityWithEntityID.entityBlackboard.var.meleeIndex < entityWithEntityID.entityBlackboard.var.mMeleesSlots.Count)
				{
					return AbilitiesProcessor.CheckSlot(entityWithEntityID.entityBlackboard.var.mMeleesSlots[entityWithEntityID.entityBlackboard.var.meleeIndex], num);
				}
				break;
			case 6:
				if (entityWithEntityID.hasEntityActionMoveDirection)
				{
					return AbilitiesProcessor.CheckSlot(entityWithEntityID.entityBlackboard.var.mAvoidForwardSlots, roleConfig.AvoidAbility.get_Item(0));
				}
				return AbilitiesProcessor.CheckSlot(entityWithEntityID.entityBlackboard.var.mAvoidBackSlots, roleConfig.AvoidAbility.get_Item(1));
			default:
				if (input < roleConfig.Ability.Count)
				{
					num = roleConfig.Ability.get_Item(input);
					if (input < entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length)
					{
						return AbilitiesProcessor.CheckSlot(entityWithEntityID.entityBlackboard.var.mAbilitySlots[input], num);
					}
				}
				break;
			}
		}
		return 0;
	}
}
