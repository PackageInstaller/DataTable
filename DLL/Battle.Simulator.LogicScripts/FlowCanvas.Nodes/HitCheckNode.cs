using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("伤害判定(过时)", 0)]
[Category("Logic/Config")]
[Description("伤害判定, 需要在伤害结算前调用, 最好就只是在技能执行后面使用, 没有命中历史, 伤害表还是需要给这个技能配置一个倍率")]
public class HitCheckNode : FlowNode
{
	private List<EntityShape> entityShapes = new List<EntityShape>();

	private HitCheckInfo checkInfo = new HitCheckInfo();

	private bool HitCheck(int targetEntityID, int casterEntityID, int abilityID, HitCheckInfo hitCheckInfo, bool canBeParry, int thrownID, Int3 aimDirection, Int3 position, Int3 forward, int hitIndex, int stateIndex, int attributeIDOfAttacker)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetEntityID);
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
		entityShapes.Clear();
		SimShapeProcessor.GetAllShape(simEntityByMultiColliders, entityShapes);
		if (entityShapes.Count <= 0)
		{
			return false;
		}
		aimDirection = IntMath.VectorOfAngle(IntMath.AngleOfVector(aimDirection) - new Int(hitCheckInfo.OffsetOfFoward));
		if (CommonProcessor.ParryingCheck(base.mSimContext, casterEntityID, simEntityByMultiColliders.creationIndex, abilityID, hitCheckInfo.HitCheckID, entityWithEntityID.entityShape.mShape.WorldPos, aimDirection, canBeParry, thrownID, !hitCheckInfo.IsOnlyReduceHP))
		{
			return false;
		}
		if (CommonProcessor.IsInUltimateAvoidOfTarget(base.mSimContext, casterEntityID, entityWithEntityID.creationIndex, abilityID, hitCheckInfo.HitCheckID, position, out var _, thrownID, !hitCheckInfo.IsOnlyReduceHP))
		{
			return false;
		}
		if (!simEntityByMultiColliders.hasEntityRemotePlayer || !simEntityByMultiColliders.hasEntityConfig || (simEntityByMultiColliders.hasEntityBlackboard && simEntityByMultiColliders.entityBlackboard.var.mHP <= 0))
		{
			return false;
		}
		if (AttributeProcessor.IsIgnoreHit(simEntityByMultiColliders))
		{
			return false;
		}
		AbilitiesProcessor.ProcessHitting(casterEntityID, thrownID, abilityID, stateIndex, attributeIDOfAttacker, hitIndex, hitCheckInfo, position, forward, aimDirection, simEntityByMultiColliders, entityWithEntityID);
		return true;
	}

	protected override void RegisterPorts()
	{
		FlowOutput m_trueOut = AddFlowOutput("true");
		FlowOutput m_falseOut = AddFlowOutput("false");
		FlowOutput m_error = AddFlowOutput("Error");
		ValueInput<int> m_attackerIDInput = AddValueInput<int>("攻击者ID");
		ValueInput<int> m_targetIDInput = AddValueInput<int>("受击者ID");
		ValueInput<int> m_abilityIDInput = AddValueInput<int>("AbilityID");
		ValueInput<int> m_thrownIDInput = AddValueInput<int>("抛掷物唯一ID");
		ValueInput<bool> m_canBeParryInput = AddValueInput<bool>("能否被格挡");
		ValueInput<int> m_HitAirBackDistance = AddValueInput<int>("空中击退距离(构造hitcheckinfo)");
		ValueInput<int> m_HitCheckID = AddValueInput<int>("第几次判定(构造hitcheckinfo)");
		ValueInput<int> m_HitDownDuration = AddValueInput<int>("击落时长(构造hitcheckinfo)");
		ValueInput<int> m_HitHeight = AddValueInput<int>("击飞高度(构造hitcheckinfo)");
		ValueInput<int> m_HorizontalAcceleratedASpeed = AddValueInput<int>("水平加速度(构造hitcheckinfo)");
		ValueInput<int> m_HorizontalSpeed = AddValueInput<int>("水平速度(构造hitcheckinfo)");
		ValueInput<int> m_HorizontalSpeedOnFloat = AddValueInput<int>("落地水平速度(构造hitcheckinfo)");
		ValueInput<bool> m_IsLargeHitBack = AddValueInput<bool>("大击退(构造hitcheckinfo)");
		ValueInput<bool> m_IsOnlyReduceHP = AddValueInput<bool>("仅扣血(构造hitcheckinfo)");
		ValueInput<bool> m_IsThump = AddValueInput<bool>("重击(构造hitcheckinfo)");
		ValueInput<bool> m_UseHitDownDuration = AddValueInput<bool>("使用击落时长(构造hitcheckinfo)");
		AddFlowInput("", delegate(Flow f)
		{
			int value = m_thrownIDInput.value;
			int num = m_attackerIDInput.value;
			int abilityID = m_abilityIDInput.value;
			checkInfo.HitAirBackDistance = m_HitAirBackDistance.value;
			checkInfo.HitCheckID = m_HitCheckID.value;
			checkInfo.HitDownDuration = m_HitDownDuration.value;
			checkInfo.HitHeight = m_HitHeight.value;
			checkInfo.HorizontalAcceleratedASpeed = m_HorizontalAcceleratedASpeed.value;
			checkInfo.HorizontalSpeed = m_HorizontalSpeed.value;
			checkInfo.HorizontalSpeedOnFloat = m_HorizontalSpeedOnFloat.value;
			checkInfo.IsLargeHitBack = m_IsLargeHitBack.value;
			checkInfo.IsOnlyReduceHP = m_IsOnlyReduceHP.value;
			checkInfo.IsThump = m_IsThump.value;
			checkInfo.UseHitDownDuration = m_UseHitDownDuration.value;
			int stateIndex = 0;
			int num2 = 0;
			Int3 mForward;
			Int3 mPosition;
			if (value != 0)
			{
				if (!ThrownProcessor.TryGetThrown(base.graph.mSimContext, value, out var thrownState))
				{
					m_error.Call(f);
					return;
				}
				num = thrownState.mCasterID;
				abilityID = thrownState.mAbilityID;
				mForward = thrownState.mForward;
				mPosition = thrownState.mPosition;
				num2 = thrownState.mAttributeID;
			}
			else
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(num);
				if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon)
				{
					m_error.Call(f);
					return;
				}
				mForward = entityWithEntityID.entityPositon.mForward;
				mPosition = entityWithEntityID.entityPositon.mPosition;
				if (entityWithEntityID.hasEntityActionAbility)
				{
					stateIndex = entityWithEntityID.entityActionAbility.mCurrentStateIndex;
				}
				num2 = entityWithEntityID.entityBlackboard.var.mAttributeID;
			}
			if (HitCheck(m_targetIDInput.value, num, abilityID, checkInfo, m_canBeParryInput.value, value, mForward, mPosition, mForward, checkInfo.HitCheckID, stateIndex, num2))
			{
				m_trueOut.Call(f);
			}
			else
			{
				m_falseOut.Call(f);
			}
		});
	}
}
