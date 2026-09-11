using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("扣血(通用)", 0)]
[Category("Logic/Attribute")]
[Description("扣血")]
[ExposeAsDefinition]
public class ModifyHPCommand : CallableActionNode<int, int, int, int, DamageType, SkillDamageType, int, int>
{
	public override void Invoke(int attackerId, int targetId, int abilityID, int damge, DamageType damageType, SkillDamageType elementType, int thrownID, int shapePartID)
	{
		if (!base.parentNode.mSimContext.hasSEntityGameOver)
		{
			SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(targetId);
			AbilitiesProcessor.TryGetRootAbilityID(abilityID, thrownID, base.parentNode.mSimContext, out var rootAbilityID);
			if (entityWithEntityID.hasEntityActionModifyHP)
			{
				entityWithEntityID.entityActionModifyHP.mStatus = EntityActionStatus.E_ACTIVE;
				entityWithEntityID.entityActionModifyHP.mModifyInfoList.Add(new ModifyHPInfo
				{
					mAmount = -damge,
					mDamageType = damageType,
					mActionID = abilityID,
					mCasterID = attackerId,
					mThrownID = thrownID,
					mRealDamage = -damge,
					mPartID = shapePartID,
					mRootAbilityID = rootAbilityID
				});
			}
			else
			{
				List<ModifyHPInfo> list = FrameListPool<ModifyHPInfo>.Claim();
				list.Add(new ModifyHPInfo
				{
					mAmount = -damge,
					mDamageType = damageType,
					mActionID = abilityID,
					mCasterID = attackerId,
					mThrownID = thrownID,
					mRealDamage = -damge,
					mPartID = shapePartID,
					mRootAbilityID = rootAbilityID
				});
				entityWithEntityID.AddEntityActionModifyHP(EntityActionStatus.E_ACTIVE, list);
			}
		}
	}
}
