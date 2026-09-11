using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[统合]玩家AI获取目标(芯片)", 0)]
[Category("Logic/装备")]
[Description("整合玩家AI的四个芯片和【玩家AI获取目标】节点的逻辑")]
public class AIChipTryGetTarget : FlowNode
{
	private List<int> targets = new List<int>();

	private int[] chips = new int[4];

	private int _target;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> distanceInput = AddValueInput<int>("半径", "distance");
		ValueInput<int> attackLockIDInput = AddValueInput<int>("协击芯片ID", "coAttackID");
		ValueInput<int> attackLockAroundIDInput = AddValueInput<int>("掩护芯片ID", "coverID");
		ValueInput<int> searchRangeInput = AddValueInput<int>("搜索范围", "searchRange").SetDefaultAndSerializedValue(13000);
		ValueInput<int> attackBossIDInput = AddValueInput<int>("破雄芯片ID", "attackBossID");
		ValueInput<int> attackNormalEnemyIDInput = AddValueInput<int>("裁决芯片ID", "attackNormalEnemyID");
		FlowOutput trueOutput = AddFlowOutput("成功", "trueOut");
		FlowOutput tooFarOutput = AddFlowOutput("距离过大", "tooFarOutput");
		FlowOutput noEntityOutput = AddFlowOutput("无对象", "noEntityOutput");
		FlowOutput noTargetOutput = AddFlowOutput("无目标", "noTargetOutput");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("目标ID", () => _target);
		AddFlowInput("In", delegate(Flow f)
		{
			int num = 0;
			_target = 0;
			chips[0] = attackLockIDInput.value;
			chips[1] = attackLockAroundIDInput.value;
			chips[2] = attackBossIDInput.value;
			chips[3] = attackNormalEnemyIDInput.value;
			int varName = 2130;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int num2 = CommonProcessor.GetWorldState().mLocalPlayerID;
			if (num2 == 0)
			{
				Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
				RemoteMember value = null;
				if (mRoomMembers.TryGetValue(MemberPosition.First, out value))
				{
					num2 = value.mEntityID;
				}
			}
			SimEntity simEntity = base.mSimContext.GetEntityWithEntityID(num2);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2214, out var baseValue, out var _, out var _);
			if (baseValue > 0 && simEntity == null)
			{
				simEntity = entityWithEntityID;
			}
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || simEntity == null)
			{
				noEntityOutput.Call(f);
				return;
			}
			targets.Clear();
			if ((simEntity.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).sqrMagnitudeLong > distanceInput.value * distanceInput.value)
			{
				tooFarOutput.Call(f);
				return;
			}
			SimPhysics.Overlap(simEntity.entityPositon.mPosition, distanceInput.value, targets, RoleCampProcessor.GetInterestCampWithoutBunkerAndAvoidShadow(simEntity.entityCamp.mRoleTypeCamp));
			if (targets.Count <= 0)
			{
				noEntityOutput.Call(f);
				return;
			}
			long num3 = long.MaxValue;
			int num4 = int.MinValue;
			_target = 0;
			for (int i = 0; i < targets.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targets[i]);
				if (AIProcessor.CanLockOfEntity(simEntityByMultiColliders))
				{
					AttributeProcessor.GetAttributeWithIntName(simEntityByMultiColliders.entityBlackboard.var.mAttributeID, 2172, out var baseValue2, out var _, out var _);
					long sqrMagnitudeLong = (simEntityByMultiColliders.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).sqrMagnitudeLong;
					if (baseValue2 > num4)
					{
						num4 = (int)baseValue2;
						_target = simEntityByMultiColliders.creationIndex;
						num3 = sqrMagnitudeLong;
					}
					else if (baseValue2 == num4 && sqrMagnitudeLong < num3)
					{
						_target = simEntityByMultiColliders.creationIndex;
						num3 = sqrMagnitudeLong;
					}
				}
			}
			if (_target == 0)
			{
				noTargetOutput.Call(f);
				return;
			}
			AIProcessor.ChangeTarget(entityWithEntityID, _target);
			entityWithEntityID.entityBlackboard.var.hasManualLock = true;
			if (CommonProcessor.IsInSourceSpaceState())
			{
				AIProcessor.ChangeTarget(entityWithEntityID, base.mSimContext.entitySourceSpace.BreakEntityID);
				_target = base.mSimContext.entitySourceSpace.BreakEntityID;
				entityWithEntityID.entityBlackboard.var.hasManualLock = true;
				trueOutput.Call(f);
				return;
			}
			if (chips[0] != 0)
			{
				if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(chips[0], out var _))
				{
					Debug.LogError("《[整合]芯片里玩家AI获取目标》节点的协击芯片ID在ai_chip表里查询不到！！！");
					return;
				}
				if (TryGetAIChipEffect(entityWithEntityID, varName, chips[0]))
				{
					if (simEntity != null && simEntity.hasEntityBlackboard)
					{
						EntityBlackboard entityBlackboard = simEntity.entityBlackboard;
						if (entityBlackboard.var.hasManualLock)
						{
							num = entityBlackboard.var.mLastTarget;
						}
						if (num == 0)
						{
							num = entityBlackboard.var.mAimTarget;
						}
					}
					if (num != 0)
					{
						SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(num);
						if (simEntityByMultiColliders2 != null && simEntityByMultiColliders2.hasEntityBlackboard && simEntityByMultiColliders2.entityBlackboard.var.mHP > 0)
						{
							EntityVarName varName2 = EntityVarName.ENTITY_ATTR_CANT_BE_LOCKED;
							long num5 = 0L;
							if (simEntityByMultiColliders2 != null && simEntityByMultiColliders2.hasEntityBlackboard)
							{
								AttributeProcessor.GetAttributeWithIntName(simEntityByMultiColliders2.entityBlackboard.var.mAttributeID, (int)varName2, out var baseValue3, out var _, out var _);
								num5 = baseValue3;
							}
							if (num5 == 0L)
							{
								num = simEntityByMultiColliders2.creationIndex;
								AIProcessor.ChangeTarget(entityWithEntityID, num);
								_target = num;
								entityWithEntityID.entityBlackboard.var.hasManualLock = true;
								trueOutput.Call(f);
							}
							else
							{
								trueOutput.Call(f);
							}
							return;
						}
					}
					trueOutput.Call(f);
					return;
				}
			}
			SimEntity simEntityByMultiColliders3;
			int num6;
			if (chips[1] != 0)
			{
				if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(chips[1], out var _))
				{
					Debug.LogError("《[整合]芯片里玩家AI获取目标》节点的掩护芯片ID在ai_chip表里查询不到！！！");
					return;
				}
				if (TryGetAIChipEffect(entityWithEntityID, varName, chips[1]))
				{
					simEntityByMultiColliders3 = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
					num6 = 0;
					if (simEntityByMultiColliders3 == null)
					{
						trueOutput.Call(f);
						return;
					}
					num = simEntityByMultiColliders3.creationIndex;
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(num2);
					if (entityWithEntityID2 != null)
					{
						SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(num);
						if (entityWithEntityID3 != null && entityWithEntityID2.hasEntityPositon && entityWithEntityID3.hasEntityPositon)
						{
							num6 = (entityWithEntityID2.entityPositon.mPosition - entityWithEntityID3.entityPositon.mPosition).magnitude2D;
							goto IL_05b6;
						}
					}
					num6 = -1;
					goto IL_05b6;
				}
			}
			goto IL_08c9;
			IL_08c9:
			if (chips[2] != 0)
			{
				if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(chips[2], out var _))
				{
					Debug.LogError("《[整合]芯片里玩家AI获取目标》节点的破雄芯片ID在ai_chip表里查询不到！！！");
					return;
				}
				if (TryGetAIChipEffect(entityWithEntityID, varName, chips[2]))
				{
					SimEntity simEntityByMultiColliders4 = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
					if (simEntityByMultiColliders4 == null)
					{
						trueOutput.Call(f);
						return;
					}
					if (simEntityByMultiColliders4.entityBlackboard.var.enemyType == EnemyType.MonsterNormal || simEntityByMultiColliders4.entityBlackboard.var.enemyType == EnemyType.Other)
					{
						int num7 = 0;
						int num8 = 0;
						SimEntity[] entities = base.mSimContext.GetEntities();
						for (int j = 0; j < entities.Length; j++)
						{
							num7 = 0;
							SimEntity simEntity2 = entities[j];
							if (simEntity2.hasEntityCamp && RoleCampProcessor.Is(2u, simEntity2.entityCamp.mRoleTypeCamp) && simEntity2.entityBlackboard.var.mHP > 0 && simEntity2.hasEntityRemotePlayer)
							{
								num7 = simEntity2.creationIndex;
								SimEntity entityWithEntityID4 = base.mSimContext.GetEntityWithEntityID(num7);
								if (entityWithEntityID4.entityBlackboard.var.enemyType == EnemyType.MonsterBoss || entityWithEntityID4.entityBlackboard.var.enemyType == EnemyType.MonsterElitel)
								{
									EntityVarName varName3 = EntityVarName.ENTITY_ATTR_CANT_BE_LOCKED;
									long num9 = 0L;
									if (entityWithEntityID4 != null && entityWithEntityID4.hasEntityBlackboard)
									{
										AttributeProcessor.GetAttributeWithIntName(entityWithEntityID4.entityBlackboard.var.mAttributeID, (int)varName3, out var baseValue4, out var _, out var _);
										num9 = baseValue4;
									}
									if (num9 == 0L)
									{
										num8 = num7;
									}
								}
							}
						}
						SimEntity entityWithEntityID5 = base.mSimContext.GetEntityWithEntityID(num8);
						if (entityWithEntityID5 == null)
						{
							trueOutput.Call(f);
						}
						else if (entityWithEntityID5.entityBlackboard.var.mHP > 0)
						{
							AIProcessor.ChangeTarget(entityWithEntityID, num8);
							_target = num8;
							entityWithEntityID.entityBlackboard.var.hasManualLock = true;
							trueOutput.Call(f);
						}
						else
						{
							trueOutput.Call(f);
						}
						return;
					}
					if (simEntityByMultiColliders4.entityBlackboard.var.enemyType == EnemyType.MonsterBoss || simEntityByMultiColliders4.entityBlackboard.var.enemyType == EnemyType.MonsterElitel)
					{
						AIProcessor.ChangeTarget(entityWithEntityID, simEntityByMultiColliders4.creationIndex);
						_target = simEntityByMultiColliders4.creationIndex;
						entityWithEntityID.entityBlackboard.var.hasManualLock = true;
						trueOutput.Call(f);
						return;
					}
				}
			}
			if (chips[3] != 0)
			{
				if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(chips[3], out var _))
				{
					Debug.LogError("《[整合]芯片里玩家AI获取目标》节点的裁决芯片ID在ai_chip表里查询不到！！！");
					return;
				}
				if (TryGetAIChipEffect(entityWithEntityID, varName, chips[3]))
				{
					SimEntity simEntityByMultiColliders5 = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
					if (simEntityByMultiColliders5 == null)
					{
						trueOutput.Call(f);
						return;
					}
					if (simEntityByMultiColliders5.entityBlackboard.var.enemyType == EnemyType.MonsterBoss || simEntityByMultiColliders5.entityBlackboard.var.enemyType == EnemyType.MonsterElitel)
					{
						int num10 = 0;
						int num11 = 0;
						SimEntity[] entities2 = base.mSimContext.GetEntities();
						for (int k = 0; k < entities2.Length; k++)
						{
							num10 = 0;
							SimEntity simEntity3 = entities2[k];
							if (simEntity3.hasEntityCamp && RoleCampProcessor.Is(2u, simEntity3.entityCamp.mRoleTypeCamp) && simEntity3.entityBlackboard.var.mHP > 0 && simEntity3.hasEntityRemotePlayer)
							{
								num10 = simEntity3.creationIndex;
								SimEntity entityWithEntityID6 = base.mSimContext.GetEntityWithEntityID(num10);
								if (entityWithEntityID6.entityBlackboard.var.enemyType == EnemyType.MonsterNormal)
								{
									EntityVarName varName4 = EntityVarName.ENTITY_ATTR_CANT_BE_LOCKED;
									long num12 = 0L;
									if (entityWithEntityID6 != null && entityWithEntityID6.hasEntityBlackboard)
									{
										AttributeProcessor.GetAttributeWithIntName(entityWithEntityID6.entityBlackboard.var.mAttributeID, (int)varName4, out var baseValue5, out var _, out var _);
										num12 = baseValue5;
									}
									if (num12 == 0L)
									{
										num11 = num10;
									}
								}
							}
						}
						SimEntity entityWithEntityID7 = base.mSimContext.GetEntityWithEntityID(num11);
						if (entityWithEntityID7 == null)
						{
							trueOutput.Call(f);
						}
						else if (entityWithEntityID7.entityBlackboard.var.mHP > 0)
						{
							AIProcessor.ChangeTarget(entityWithEntityID, num11);
							_target = num11;
							entityWithEntityID.entityBlackboard.var.hasManualLock = true;
							trueOutput.Call(f);
						}
						else
						{
							trueOutput.Call(f);
						}
						return;
					}
					if (simEntityByMultiColliders5.entityBlackboard.var.enemyType == EnemyType.MonsterNormal || simEntityByMultiColliders5.entityBlackboard.var.enemyType == EnemyType.Other)
					{
						AIProcessor.ChangeTarget(entityWithEntityID, simEntityByMultiColliders5.creationIndex);
						_target = simEntityByMultiColliders5.creationIndex;
						trueOutput.Call(f);
						return;
					}
				}
			}
			trueOutput.Call(f);
			return;
			IL_05b6:
			if (num6 < 8000)
			{
				if (num6 == -1)
				{
					trueOutput.Call(f);
				}
				else if (simEntityByMultiColliders3 != null && !simEntityByMultiColliders3.hasEntityActionDeath && simEntityByMultiColliders3.hasEntityBlackboard)
				{
					_target = num;
					trueOutput.Call(f);
				}
				else
				{
					trueOutput.Call(f);
				}
				return;
			}
			Int3 entityPostion = AIProcessor.GetEntityPostion(num2);
			bool flag = false;
			int num13 = 0;
			SimEntity simEntity4 = null;
			List<int> list = FrameListPool<int>.Claim();
			if (CommonProcessor.TryGetCollisions(base.mSimContext, RangeType.Roundness, entityPostion, new Int3(0, 0, 1), new Int3(0, 0, 0), 8000, 0, new Int3(0, 0, 0), list, 2u))
			{
				List<int> list2 = FrameListPool<int>.Claim();
				if (CommonProcessor.TryFilterCollisions(base.mSimContext, entityPostion, list, TargetSelectType.Random, 1, list2) && list2.Count > 0)
				{
					simEntity4 = CommonProcessor.GetSimEntityByMultiColliders(list2[0]);
					if (simEntity4 != null)
					{
						num13 = simEntity4.creationIndex;
						flag = true;
					}
				}
				FrameListPool<int>.Release(list2);
			}
			FrameListPool<int>.Release(list);
			if (flag)
			{
				EntityVarName varName5 = EntityVarName.ENTITY_ATTR_CANT_BE_LOCKED;
				long num14 = 0L;
				if (simEntity4 != null && simEntity4.hasEntityBlackboard && !simEntity4.hasEntityActionDeath)
				{
					AttributeProcessor.GetAttributeWithIntName(simEntity4.entityBlackboard.var.mAttributeID, (int)varName5, out var baseValue6, out var _, out var _);
					num14 = baseValue6;
				}
				if (num14 == 0L)
				{
					AIProcessor.ChangeTarget(entityWithEntityID, num13);
					_target = num13;
					entityWithEntityID.entityBlackboard.var.hasManualLock = true;
					trueOutput.Call(f);
				}
				else
				{
					trueOutput.Call(f);
				}
				return;
			}
			if (num6 >= 13000)
			{
				List<int> list3 = FrameListPool<int>.Claim();
				if (CommonProcessor.TryGetCollisions(base.mSimContext, RangeType.Roundness, entityPostion, new Int3(0, 0, 1), new Int3(0, 0, 0), searchRangeInput.value, 0, new Int3(0, 0, 0), list3, 2u))
				{
					List<int> list4 = FrameListPool<int>.Claim();
					if (CommonProcessor.TryFilterCollisions(base.mSimContext, entityPostion, list3, TargetSelectType.Random, 1, list4) && list4.Count > 0)
					{
						simEntity4 = CommonProcessor.GetSimEntityByMultiColliders(list4[0]);
						if (simEntity4 != null)
						{
							num13 = simEntity4.creationIndex;
							flag = true;
						}
					}
					FrameListPool<int>.Release(list4);
				}
				FrameListPool<int>.Release(list3);
				if (flag)
				{
					EntityVarName varName6 = EntityVarName.ENTITY_ATTR_CANT_BE_LOCKED;
					long num15 = 0L;
					if (simEntity4 != null && simEntity4.hasEntityBlackboard && !simEntity4.hasEntityActionDeath)
					{
						AttributeProcessor.GetAttributeWithIntName(simEntity4.entityBlackboard.var.mAttributeID, (int)varName6, out var baseValue7, out var _, out var _);
						num15 = baseValue7;
					}
					if (num15 == 0L)
					{
						AIProcessor.ChangeTarget(entityWithEntityID, num13);
						_target = num13;
						entityWithEntityID.entityBlackboard.var.hasManualLock = true;
						trueOutput.Call(f);
					}
					else
					{
						trueOutput.Call(f);
					}
				}
				else
				{
					trueOutput.Call(f);
				}
				return;
			}
			if (simEntityByMultiColliders3 != null && !simEntityByMultiColliders3.hasEntityActionDeath && simEntityByMultiColliders3.hasEntityBlackboard)
			{
				_target = num;
				trueOutput.Call(f);
				return;
			}
			goto IL_08c9;
		});
	}

	private bool TryGetAIChipEffect(SimEntity entity, int varName, int idIn, int maxInput = 20)
	{
		bool result = false;
		for (int i = 0; i < maxInput; i++)
		{
			AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, varName + i, out var baseValue, out var _, out var _);
			if (baseValue == 0L)
			{
				break;
			}
			if (idIn == baseValue)
			{
				result = true;
				break;
			}
		}
		return result;
	}
}
