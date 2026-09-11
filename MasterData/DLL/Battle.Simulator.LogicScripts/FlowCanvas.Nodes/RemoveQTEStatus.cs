using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除拼刀状态", 0)]
[Category("Logic/Buff")]
[Description("统合节点，具体逻辑可看4040的转阶段拼刀状态相关，目前默认另一方是本地玩家")]
public class RemoveQTEStatus : FlowNode
{
	private readonly int m_InvincibleBuffID = 200003;

	private void EnableAnyMovable(int entityID)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			long baseValue = 0L;
			long plusValue = 0L;
			long tempPlusValue = 0L;
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2016, out baseValue, out plusValue, out tempPlusValue);
			baseValue--;
			baseValue = IntMath.Max(baseValue, 0L);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2016, baseValue, 0L, 0L);
			if (baseValue == 0L)
			{
				MovementProcessor.EnableMovement(entityWithEntityID, isActive: true);
			}
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2022, out baseValue, out plusValue, out tempPlusValue);
			baseValue--;
			baseValue = IntMath.Max(baseValue, 0L);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2022, baseValue, 0L, 0L);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2021, out baseValue, out plusValue, out tempPlusValue);
			baseValue--;
			baseValue = IntMath.Max(baseValue, 0L);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2021, baseValue, 0L, 0L);
		}
	}

	private void EnableCollisionByID(int simEntityID, bool isEnable)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityShape)
		{
			return;
		}
		entityWithEntityID.entityBlackboard.var.mHide = !isEnable;
		if (entityWithEntityID.hasEntityActionAbility)
		{
			int mLogicTime = entityWithEntityID.entityActionAbility.mLogicTime;
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
			for (int i = 0; i < config.ShapeInfoList.Count; i++)
			{
				ShapeInfo shapeInfo = config.ShapeInfoList.get_Item(i);
				if (mLogicTime >= shapeInfo.Start && mLogicTime < shapeInfo.Start + shapeInfo.Duration)
				{
					SimShapeProcessor.UpdateShapeWorldPositionByConfig(base.mSimContext, entityWithEntityID, shapeInfo);
				}
			}
		}
		else if (entityWithEntityID.hasEntityHitRecover)
		{
			int mHitRecoverTime = entityWithEntityID.entityHitRecover.mHitRecoverTime;
			Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityHitRecover.mHitRecoverActionID);
			for (int j = 0; j < config2.ShapeInfoList.Count; j++)
			{
				ShapeInfo shapeInfo2 = config2.ShapeInfoList.get_Item(j);
				int start = shapeInfo2.Start;
				int num = start + shapeInfo2.Duration;
				if (mHitRecoverTime >= start && mHitRecoverTime <= num)
				{
					SimShapeProcessor.UpdateShapeWorldPositionByConfig(base.mSimContext, entityWithEntityID, shapeInfo2);
					break;
				}
			}
		}
		else if (entityWithEntityID.hasEntityActionMoveDirection && entityWithEntityID.entityActionMoveDirection.mMoveID != 0)
		{
			int mLogicTime2 = entityWithEntityID.entityActionMoveDirection.mLogicTime;
			Timeline config3 = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionMoveDirection.mMoveID);
			for (int k = 0; k < config3.ShapeInfoList.Count; k++)
			{
				ShapeInfo shapeInfo3 = config3.ShapeInfoList.get_Item(k);
				int start2 = shapeInfo3.Start;
				int num2 = start2 + shapeInfo3.Duration;
				if (mLogicTime2 >= start2 && mLogicTime2 <= num2)
				{
					SimShapeProcessor.UpdateShapeWorldPositionByConfig(base.mSimContext, entityWithEntityID, shapeInfo3);
					break;
				}
			}
		}
		else
		{
			Timeline config4 = ConfigHelper.GetInstance().GetConfig<Timeline>((entityWithEntityID.entityConfig.mConfig as RoleConfig).Idle);
			for (int l = 0; l < config4.ShapeInfoList.Count; l++)
			{
				SimShapeProcessor.UpdateShapeWorldPositionByConfig(base.mSimContext, entityWithEntityID, config4.ShapeInfoList.get_Item(l));
			}
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("敌方拼刀实体ID", "作用对象");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BuffProcessor.RemoveBuffByConfigID(targetIDInput.value, m_InvincibleBuffID);
			int num = CommonProcessor.GetWorldState().mLocalPlayerID;
			if (num == 0)
			{
				Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
				RemoteMember value = null;
				if (mRoomMembers.TryGetValue(MemberPosition.First, out value))
				{
					num = value.mEntityID;
				}
			}
			BuffProcessor.RemoveBuffByConfigID(num, m_InvincibleBuffID);
			EnableAnyMovable(targetIDInput.value);
			EnableAnyMovable(num);
			EnableCollisionByID(targetIDInput.value, isEnable: true);
			EnableCollisionByID(num, isEnable: true);
			output.Call(f);
		});
	}
}
