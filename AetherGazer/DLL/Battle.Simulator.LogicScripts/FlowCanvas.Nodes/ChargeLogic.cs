using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("蓄力", 0)]
[Category("Logic/PosAndRot")]
[Description("蓄力逻辑,所有技能ID都取后三位, 播完起手和循环走do, 开始播结束是走done, 执行的节能不是蓄力技能走default, 过程出错走error")]
public class ChargeLogic : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> maxCountInput = AddValueInput<int>("层数上限");
		ValueInput<int> enterAbilityIDInput = AddValueInput<int>("起手技能ID");
		ValueInput<int> enterFrameInput = AddValueInput<int>("起手帧数");
		ValueInput<int> loopAbilityIDInput = AddValueInput<int>("循环技能ID");
		ValueInput<int> loopFrameInput = AddValueInput<int>("循环帧数");
		ValueInput<int> outAbilityIDInput = AddValueInput<int>("释放技能ID");
		ValueInput<int> countNameInput = AddValueInput<int>("蓄力层数变量名");
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮类型");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int count = 0;
		AddValueOutput("蓄力层数", () => count);
		FlowOutput doOutput = AddFlowOutput("do");
		FlowOutput doneOutput = AddFlowOutput("done");
		FlowOutput defaultOutput = AddFlowOutput("default");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				errorOutput.Call(f);
			}
			else
			{
				int currentShortAbilityID = CommonNodeFunction.GetCurrentShortAbilityID(entityWithEntityID);
				int value = enterAbilityIDInput.value;
				int value2 = loopAbilityIDInput.value;
				if (currentShortAbilityID != value && currentShortAbilityID != value2)
				{
					defaultOutput.Call(f);
				}
				else
				{
					int num = entityWithEntityID.entityActionAbility.mLogicTime / CommonProcessor.GetConfigInterval();
					if (currentShortAbilityID == value && num == enterFrameInput.value)
					{
						if (entityWithEntityID.entityBlackboard.var.mOnPressDownBtnID == (int)buttonTypeInput.GetValue())
						{
							int abilityID = entityWithEntityID.entityConfig.mId * 1000 + value2;
							AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, abilityID, isForce: true);
							int value3 = countNameInput.value;
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value3, 0L, 0L, 0L);
							doOutput.Call(f);
						}
						else
						{
							int abilityID2 = entityWithEntityID.entityConfig.mId * 1000 + outAbilityIDInput.value;
							AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, abilityID2, isForce: true);
							doneOutput.Call(f);
						}
					}
					else if (currentShortAbilityID == value2)
					{
						if (entityWithEntityID.entityBlackboard.var.mOnPressDownBtnID != (int)buttonTypeInput.GetValue())
						{
							int abilityID3 = entityWithEntityID.entityConfig.mId * 1000 + outAbilityIDInput.value;
							AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, abilityID3, isForce: true);
							doneOutput.Call(f);
						}
						else if (num == loopFrameInput.value)
						{
							int value4 = countNameInput.value;
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value4, out var baseValue, out var _, out var _);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, value4, baseValue + 1, 0L, 0L);
							if (maxCountInput.value > baseValue + 1)
							{
								int abilityID4 = entityWithEntityID.entityConfig.mId * 1000 + value2;
								AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, abilityID4, isForce: true);
								doOutput.Call(f);
							}
							else
							{
								int abilityID5 = entityWithEntityID.entityConfig.mId * 1000 + outAbilityIDInput.value;
								AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, abilityID5, isForce: true);
								doneOutput.Call(f);
							}
						}
					}
					else if ((currentShortAbilityID == value2 || currentShortAbilityID == value) && num == 1)
					{
						int abilityID6 = entityWithEntityID.entityConfig.mId * 1000 + currentShortAbilityID;
						CDProcessor.RemoveCD(entityWithEntityID, abilityID6);
					}
				}
			}
		});
	}
}
