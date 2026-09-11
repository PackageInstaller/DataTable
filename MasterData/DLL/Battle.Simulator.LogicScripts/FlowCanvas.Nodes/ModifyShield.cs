using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改护盾值", 0)]
[Category("Logic/Attribute")]
[Description("找到实体身上的护盾Buff并修改记录在其上的护盾值，修改后的值=修改前的值*千分比/1000+固定值，若修改后护盾值<=0则会移除护盾Buff并返回0\n实体没有护盾时会走Error")]
[ExposeAsDefinition]
public class ModifyShield : FlowNode
{
	private int modifyValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> percentInput = AddValueInput<int>("千分比").SetDefaultAndSerializedValue(1000);
		ValueInput<int> fixValueInput = AddValueInput<int>("固定值");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("修改后的值", "ModifyValue", () => modifyValue);
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				errorOut.Call(f);
			}
			else
			{
				modifyValue = 0;
				int num = -1;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == 102 || entityWithEntityID.entityBuff.mBuffClassIDArray[i] == 108))
					{
						BuffParams value = entityWithEntityID.entityBuff.mBuffParamsArray[i];
						if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == 108 && !value.v3.boolVar)
						{
							SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBuff.mBuffCasterArray[i]);
							public_buff config2;
							if (value.v1.boolVar && entityWithEntityID2 != null)
							{
								if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(entityWithEntityID.entityBuff.mBuffConfigID[i], out var config))
								{
									entityWithEntityID.entityBuff.mBuffParamsArray[i] = new BuffParams
									{
										v1 = config.BuffparamBase.get_Item(0),
										v2 = entityWithEntityID2.entityBlackboard.var.mMaxHP * (config.BuffparamBase.get_Item(1) + config.BuffparamFactor.get_Item(1) * (entityWithEntityID.entityBuff.mBuffFloor[i] - 1)) / 1000,
										v3 = true,
										v4 = entityWithEntityID2.entityBlackboard.var.mMaxHP * (config.BuffparamBase.get_Item(1) + config.BuffparamFactor.get_Item(1) * (entityWithEntityID.entityBuff.mBuffFloor[i] - 1)) / 1000
									};
								}
								else
								{
									entityWithEntityID.entityBuff.mBuffParamsArray[i] = new BuffParams
									{
										v1 = value.v1,
										v2 = entityWithEntityID.entityBlackboard.var.mMaxHP * value.v2.intVar / 1000,
										v3 = true,
										v4 = entityWithEntityID.entityBlackboard.var.mMaxHP * value.v2.intVar / 1000
									};
								}
							}
							else if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(entityWithEntityID.entityBuff.mBuffConfigID[i], out config2))
							{
								entityWithEntityID.entityBuff.mBuffParamsArray[i] = new BuffParams
								{
									v1 = config2.BuffparamBase.get_Item(0),
									v2 = entityWithEntityID.entityBlackboard.var.mMaxHP * (config2.BuffparamBase.get_Item(1) + config2.BuffparamFactor.get_Item(1) * (entityWithEntityID.entityBuff.mBuffFloor[i] - 1)) / 1000,
									v3 = true,
									v4 = entityWithEntityID.entityBlackboard.var.mMaxHP * (config2.BuffparamBase.get_Item(1) + config2.BuffparamFactor.get_Item(1) * (entityWithEntityID.entityBuff.mBuffFloor[i] - 1)) / 1000
								};
							}
							else
							{
								entityWithEntityID.entityBuff.mBuffParamsArray[i] = new BuffParams
								{
									v1 = value.v1,
									v2 = entityWithEntityID.entityBlackboard.var.mMaxHP * value.v2.intVar / 1000,
									v3 = true,
									v4 = entityWithEntityID.entityBlackboard.var.mMaxHP * value.v2.intVar / 1000
								};
							}
							value = entityWithEntityID.entityBuff.mBuffParamsArray[i];
						}
						if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == 102 && !value.v3.boolVar)
						{
							if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(entityWithEntityID.entityBuff.mBuffConfigID[i], out var config3))
							{
								entityWithEntityID.entityBuff.mBuffParamsArray[i] = new BuffParams
								{
									v1 = config3.BuffparamBase.get_Item(0),
									v2 = config3.BuffparamBase.get_Item(1) + config3.BuffparamFactor.get_Item(1) * (entityWithEntityID.entityBuff.mBuffFloor[i] - 1),
									v3 = true,
									v4 = config3.BuffparamBase.get_Item(1) + config3.BuffparamFactor.get_Item(1) * (entityWithEntityID.entityBuff.mBuffFloor[i] - 1)
								};
							}
							else
							{
								entityWithEntityID.entityBuff.mBuffParamsArray[i] = new BuffParams
								{
									v1 = value.v1,
									v2 = value.v2.intVar,
									v3 = true,
									v4 = value.v2.intVar
								};
							}
							value = entityWithEntityID.entityBuff.mBuffParamsArray[i];
						}
						modifyValue = value.v2;
						modifyValue = modifyValue * percentInput.value / 1000 + fixValueInput.value;
						value.v2 = modifyValue;
						value.v4 = (((int)value.v4 < (int)value.v2) ? value.v2 : value.v4);
						entityWithEntityID.entityBuff.mBuffParamsArray[i] = value;
						num = i;
						break;
					}
				}
				if (num != -1)
				{
					if ((int)entityWithEntityID.entityBuff.mBuffParamsArray[num].v2 <= 0)
					{
						modifyValue = 0;
						BuffProcessor.RemoveBuffID(0, entityWithEntityID.creationIndex, entityWithEntityID.entityBuff.mBuffID[num]);
					}
					output.Call(f);
				}
				else
				{
					errorOut.Call(f);
				}
			}
		});
	}
}
