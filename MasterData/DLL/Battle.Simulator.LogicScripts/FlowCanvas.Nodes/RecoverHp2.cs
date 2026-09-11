using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("回血(单次溢出量)", 0)]
[Category("Logic/Attribute")]
[Description("回血,百分比向下取整, 可以同时填两个;\n得到本次回血的溢出值, 在帧末统一处理, 不能给血量小于0的实体回血")]
public class RecoverHp2 : FlowControlNode
{
	private long m_overValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		ValueInput<int> attackerIDInput = AddValueInput<int>("造成回血的实体ID", "attackerIDInput");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID", "abilityIDInput");
		ValueInput<int> percentInput = AddValueInput<int>("千分比", "percentInput");
		ValueInput<int> valueInput = AddValueInput<int>("固定值", "valueInput");
		AddValueOutput("实体ID", "EntityID", () => entityIDInput.value);
		AddValueOutput("本次溢出值", "overValue", () => m_overValue);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (!base.mSimContext.hasSEntityGameOver)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					long num = valueInput.value + entityWithEntityID.entityBlackboard.var.mMaxHP * percentInput.value / 1000;
					m_overValue = IntMath.Max(num + entityWithEntityID.entityBlackboard.var.mHP - entityWithEntityID.entityBlackboard.var.mMaxHP, 0L);
					AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(attackerIDInput.value), 2176, out var baseValue, out var _, out var _);
					DamageType damageType = (DamageType)baseValue;
					if (damageType != DamageType.CritRecover)
					{
						damageType = DamageType.Recover;
					}
					AbilitiesProcessor.TryGetRootAbilityID(abilityIDInput.value, thrownIDInput.value, base.graph.mSimContext, out var rootAbilityID);
					if (entityWithEntityID.hasEntityActionModifyHP)
					{
						entityWithEntityID.entityActionModifyHP.mStatus = EntityActionStatus.E_ACTIVE;
						entityWithEntityID.entityActionModifyHP.mModifyInfoList.Add(new ModifyHPInfo
						{
							mAmount = num,
							mDamageType = damageType,
							mActionID = abilityIDInput.value,
							mCasterID = attackerIDInput.value,
							mThrownID = thrownIDInput.value,
							mRootAbilityID = rootAbilityID
						});
					}
					else
					{
						List<ModifyHPInfo> list = FrameListPool<ModifyHPInfo>.Claim();
						list.Add(new ModifyHPInfo
						{
							mAmount = num,
							mDamageType = damageType,
							mActionID = abilityIDInput.value,
							mCasterID = attackerIDInput.value,
							mThrownID = thrownIDInput.value,
							mRootAbilityID = rootAbilityID
						});
						entityWithEntityID.AddEntityActionModifyHP(EntityActionStatus.E_ACTIVE, list);
					}
					output.Call(f);
				}
			}
		});
	}
}
