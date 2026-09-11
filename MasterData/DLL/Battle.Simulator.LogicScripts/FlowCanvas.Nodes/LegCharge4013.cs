using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("4013腿上充能", 0)]
[Category("Logic/游戏具体功能")]
[Description("4013腿上充能, \nbuff参数1是当前能量值\nbuff参数2是脚板上的buffID\nbuff参数3是当前状态(0充能,1开火)\nbuff参数4是开火计时")]
public class LegCharge4013 : FlowNode
{
	public static bool TragetInAngleRegion(SimEntity baseEntity, SimEntity targetEntity, Int startAngle, Int deltaAngle)
	{
		if (baseEntity == null || targetEntity == null || !baseEntity.hasEntityPositon || !targetEntity.hasEntityPositon)
		{
			return false;
		}
		Int obj = IntMath.AngleOfVector(targetEntity.entityPositon.mPosition - baseEntity.entityPositon.mPosition);
		Int obj2 = startAngle + deltaAngle;
		bool flag = false;
		if ((obj2.i <= 360000) ? (obj >= startAngle && obj < obj2) : (obj >= startAngle || obj < obj2.i % 360000))
		{
			return true;
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> indexInput = AddValueInput<int>("buff数组下标");
		ValueInput<Dictionary<int, int>> startAngleInput = AddValueInput<Dictionary<int, int>>("起始角度");
		ValueInput<Int> deltaAngleInput = AddValueInput<Int>("区间大小");
		ValueInput<List<int>> listSpecialAbilityInput = AddValueInput<List<int>>("停止tick的技能列表(后三位)");
		ValueInput<List<RoleType>> listTargetRoleTypeListInput = AddValueInput<List<RoleType>>("目标的阵营列表");
		ValueInput<int> chargeMaxValueInput = AddValueInput<int>("充能时的上限");
		ValueInput<int> fireIntervalInput = AddValueInput<int>("开火间隔");
		ValueInput<int> aimTargetFlagInput = AddValueInput<int>("瞄准的标记变量名");
		ValueInput<int> fireCosumeInput = AddValueInput<int>("开火消耗");
		FlowOutput outputChangeToCharge = AddFlowOutput("切换为充能");
		FlowOutput output = AddFlowOutput("正常tick");
		FlowOutput outputChangeToFire = AddFlowOutput("切换为开火");
		FlowOutput errorOutput = AddFlowOutput("异常");
		FlowOutput fireOutput = AddFlowOutput("向目标开火");
		FlowOutput aimTargetOutput = AddFlowOutput("瞄准目标");
		FlowOutput loseTargetOutput = AddFlowOutput("丢失目标");
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		AddValueOutput("数组下标", () => indexInput.value);
		int configID = 0;
		AddValueOutput("配置ID", () => configID);
		AddValueOutput("参数1", (ValueHandler<int>)delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int value = indexInput.value;
			return entityWithEntityID.entityBuff.mBuffParamsArray[value].v1;
		}, "");
		AddValueOutput("参数2", (ValueHandler<int>)delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int value = indexInput.value;
			return entityWithEntityID.entityBuff.mBuffParamsArray[value].v2;
		}, "");
		AddValueOutput("参数3", (ValueHandler<int>)delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int value = indexInput.value;
			return entityWithEntityID.entityBuff.mBuffParamsArray[value].v3;
		}, "");
		AddValueOutput("参数4", (ValueHandler<int>)delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int value = indexInput.value;
			return entityWithEntityID.entityBuff.mBuffParamsArray[value].v4;
		}, "");
		int startAngle = 0;
		AddValueOutput("起始角度", () => startAngle);
		AddFlowInput("Tick", delegate(Flow f)
		{
			SimEntity entity = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entity == null || !CommonProcessor.IsAliveRole(entity))
			{
				errorOutput.Call(f);
			}
			else
			{
				int index = indexInput.value;
				configID = entity.entityBuff.mBuffConfigID[index];
				startAngle = startAngleInput.value[configID];
				List<RoleType> value = listTargetRoleTypeListInput.value;
				Int value2 = deltaAngleInput.value;
				int value3 = fireIntervalInput.value;
				int value4 = aimTargetFlagInput.value;
				int num = entity.entityBuff.mTickArray[index];
				uint num2 = 0u;
				for (int i = 0; i < value.Count; i++)
				{
					num2 |= (uint)value[i];
				}
				if (num2 == 0)
				{
					output.Call(f);
				}
				else
				{
					BuffParams buffParams = entity.entityBuff.mBuffParamsArray[index];
					if (CommonProcessor.IsInSourceSpaceState())
					{
						ChangeToChargeState();
					}
					else
					{
						List<int> value5 = listSpecialAbilityInput.value;
						bool flag = false;
						int num3 = 0;
						if (entity.hasEntityActionAbility)
						{
							num3 = entity.entityActionAbility.mAbilityID;
						}
						for (int j = 0; j < value5.Count; j++)
						{
							if (entity.entityConfig.mId * 1000 + value5[j] == num3)
							{
								flag = true;
								break;
							}
						}
						if (flag)
						{
							ChangeToChargeState();
						}
						else if (buffParams.v3 == 0)
						{
							SimEntity[] entities = base.mSimContext.GetEntities();
							bool flag2 = false;
							for (int k = 0; k < entities.Length; k++)
							{
								if (entities[k].hasEntityCamp && RoleCampProcessor.Is(num2, entities[k].entityCamp.mRoleTypeCamp) && entities[k].hasEntityRemotePlayer && TragetInAngleRegion(entity, entities[k], startAngle, value2))
								{
									flag2 = true;
									break;
								}
							}
							if (flag2)
							{
								ref SimVar v = ref buffParams.v1;
								v = (int)v + 1;
								if ((int)buffParams.v1 > chargeMaxValueInput.value)
								{
									ChangeToFireState();
								}
								else
								{
									entity.entityBuff.mBuffParamsArray[index] = buffParams;
									output.Call(f);
								}
							}
							else
							{
								ChangeToChargeState();
							}
						}
						else
						{
							SimEntity[] entities2 = base.mSimContext.GetEntities();
							bool flag3 = false;
							bool flag4 = false;
							for (int l = 0; l < entities2.Length; l++)
							{
								if (entities2[l].hasEntityCamp && RoleCampProcessor.Is(num2, entities2[l].entityCamp.mRoleTypeCamp) && CommonProcessor.IsAliveRole(entities2[l]) && entities2[l].hasEntityRemotePlayer)
								{
									targetID = entities2[l].creationIndex;
									AttributeProcessor.GetAttributeWithIntName(entities2[l].entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var _, out var _);
									if (baseValue <= 0)
									{
										AttributeProcessor.GetAttributeWithIntName(entities2[l].entityBlackboard.var.mAttributeID, value4, out var baseValue2, out var _, out var _);
										if (TragetInAngleRegion(entity, entities2[l], startAngle, value2))
										{
											flag3 = true;
											if (buffParams.v4 == 0)
											{
												AttributeProcessor.SetAttributeWithIntName(entities2[l].entityBlackboard.var.mAttributeID, value4, configID, 0L, 0L);
												aimTargetOutput.Call(f);
											}
											else if ((int)buffParams.v4 >= value3 - num && baseValue2 == configID)
											{
												AttributeProcessor.SetAttributeWithIntName(entities2[l].entityBlackboard.var.mAttributeID, value4, 0L, 0L, 0L);
												fireOutput.Call(f);
												flag4 = true;
											}
										}
										else if (baseValue2 == configID)
										{
											AttributeProcessor.SetAttributeWithIntName(entities2[l].entityBlackboard.var.mAttributeID, value4, 0L, 0L, 0L);
											loseTargetOutput.Call(f);
										}
									}
								}
							}
							ref SimVar v2 = ref buffParams.v4;
							v2 = (int)v2 + num;
							if ((int)buffParams.v4 >= value3)
							{
								buffParams.v4 = 0;
							}
							if (flag4 || !flag3)
							{
								ref SimVar v3 = ref buffParams.v1;
								v3 = (int)v3 - fireCosumeInput.value;
							}
							if ((int)buffParams.v1 <= 0)
							{
								ChangeToChargeState();
							}
							else
							{
								entity.entityBuff.mBuffParamsArray[index] = buffParams;
								output.Call(f);
							}
						}
					}
				}
			}
		});
		void ChangeToChargeState()
		{
			P_0.buffParams.v1 = 0;
			if (P_0.buffParams.v3 != 0)
			{
				P_0.buffParams.v3 = 0;
				P_0.entity.entityBuff.mBuffParamsArray[P_0.index] = P_0.buffParams;
				outputChangeToCharge.Call(P_0.f);
			}
			else
			{
				P_0.entity.entityBuff.mBuffParamsArray[P_0.index] = P_0.buffParams;
				output.Call(P_0.f);
			}
		}
		void ChangeToFireState()
		{
			P_0.buffParams.v1 = 100;
			if (P_0.buffParams.v3 == 0)
			{
				P_0.buffParams.v3 = 1;
				P_0.buffParams.v4 = 0;
				P_0.entity.entityBuff.mBuffParamsArray[P_0.index] = P_0.buffParams;
				outputChangeToFire.Call(P_0.f);
			}
			else
			{
				P_0.entity.entityBuff.mBuffParamsArray[P_0.index] = P_0.buffParams;
				output.Call(P_0.f);
			}
		}
	}
}
