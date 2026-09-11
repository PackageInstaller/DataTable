using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加拼刀状态", 0)]
[Category("Logic/Buff")]
[Description("统合节点，具体逻辑可看4040的转阶段拼刀状态相关，目前默认另一方是本地玩家")]
public class AddQTEStatus : FlowNode
{
	private readonly int m_InvincibleBuffID = 200003;

	private void DisableAnyMovable(SimEntity simEntity)
	{
		long baseValue = 0L;
		long plusValue = 0L;
		long tempPlusValue = 0L;
		AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2016, out baseValue, out plusValue, out tempPlusValue);
		baseValue++;
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2016, baseValue, 0L, 0L);
		MovementProcessor.EnableMovement(simEntity, isActive: false);
		AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2022, out baseValue, out plusValue, out tempPlusValue);
		baseValue++;
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2022, baseValue, 0L, 0L);
		AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2021, out baseValue, out plusValue, out tempPlusValue);
		baseValue++;
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2021, baseValue, 0L, 0L);
	}

	private void DisableCollisionByID(int simEntityID, bool isEnable)
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
		FlowOutput outputFalse = AddFlowOutput("没有添加");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID != null)
			{
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
				bool flag2 = true;
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(num);
				if (entityWithEntityID2 != null)
				{
					if (!entityWithEntityID.hasEntityBuff)
					{
						flag = true;
					}
					else
					{
						int buffClassId = ConfigHelper.GetInstance().GetConfig<public_buff>(m_InvincibleBuffID).BuffClassId;
						switch (BuffRelationShip.GetRelationShip(entityWithEntityID, buffClassId))
						{
						case BuffRelationShipType.None:
							flag = true;
							break;
						case BuffRelationShipType.OverWrite:
							flag = true;
							BuffRelationShip.RemoveOverWriteList(entityWithEntityID, buffClassId, -1);
							break;
						case BuffRelationShipType.RemoveTogether:
							flag = false;
							BuffRelationShip.RemoveTogetherList(entityWithEntityID, buffClassId, -1);
							break;
						case BuffRelationShipType.RemoveSelf:
							flag = false;
							break;
						}
					}
					if (flag)
					{
						if (AddBuff.AddBuffWithConfigID(base.mSimContext, targetIDInput.GetValue(), targetIDInput.GetValue(), m_InvincibleBuffID, 1, 0, 0, 0, 0))
						{
							if (!entityWithEntityID2.hasEntityBuff)
							{
								flag2 = true;
							}
							else
							{
								int buffClassId2 = ConfigHelper.GetInstance().GetConfig<public_buff>(m_InvincibleBuffID).BuffClassId;
								switch (BuffRelationShip.GetRelationShip(entityWithEntityID2, buffClassId2))
								{
								case BuffRelationShipType.None:
									flag2 = true;
									break;
								case BuffRelationShipType.OverWrite:
									flag2 = true;
									BuffRelationShip.RemoveOverWriteList(entityWithEntityID2, buffClassId2, -1);
									break;
								case BuffRelationShipType.RemoveTogether:
									flag2 = false;
									BuffRelationShip.RemoveTogetherList(entityWithEntityID2, buffClassId2, -1);
									break;
								case BuffRelationShipType.RemoveSelf:
									flag2 = false;
									break;
								}
							}
							if (flag2)
							{
								if (AddBuff.AddBuffWithConfigID(base.mSimContext, num, num, m_InvincibleBuffID, 1, 0, 0, 0, 0))
								{
									DisableAnyMovable(entityWithEntityID);
									DisableAnyMovable(entityWithEntityID2);
									DisableCollisionByID(entityWithEntityID.entityID.mID, isEnable: false);
									DisableCollisionByID(entityWithEntityID2.entityID.mID, isEnable: false);
									output.Call(f);
								}
								else
								{
									outputFalse.Call(f);
								}
							}
							else
							{
								outputFalse.Call(f);
							}
						}
						else
						{
							outputFalse.Call(f);
						}
					}
					else
					{
						outputFalse.Call(f);
					}
				}
			}
		});
	}
}
