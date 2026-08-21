using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("加能量", 0)]
[Category("Logic/新多维")]
[Description("不能用在ai玩法里面")]
public class NewMatrixSkillAddEnergy : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput outputTrue = AddFlowOutput("成功");
		FlowOutput outputFalse = AddFlowOutput("失败");
		ValueInput<int> enttiyIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> valueInput = AddValueInput<int>("变化量");
		ValueInput<int> energyBuffLogicIDInput = AddValueInput<int>("充能的buff处理逻辑ID");
		ValueInput<int> exEnergyCountInput = AddValueInput<int>("额外充能次数黑板的变量名");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enttiyIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff || !entityWithEntityID.hasEntityBlackboard)
			{
				outputFalse.Call(f);
			}
			else
			{
				int num = -1;
				List<int> mBuffClassIDArray = entityWithEntityID.entityBuff.mBuffClassIDArray;
				int value = energyBuffLogicIDInput.value;
				for (int i = 0; i < mBuffClassIDArray.Count; i++)
				{
					if (mBuffClassIDArray[i] == value)
					{
						num = i;
						break;
					}
				}
				if (num != -1)
				{
					BuffParams value2 = entityWithEntityID.entityBuff.mBuffParamsArray[num];
					ref SimVar v = ref value2.v1;
					v = (int)v + valueInput.value;
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, exEnergyCountInput.value, out var baseValue, out var _, out var _);
					if ((long)value2.v1 > (long)value2.v2 * (baseValue + 1))
					{
						value2.v1 = (long)value2.v2 * (baseValue + 1);
					}
					entityWithEntityID.entityBuff.mBuffParamsArray[num] = value2;
					outputTrue.Call(f);
				}
				else
				{
					outputFalse.Call(f);
				}
			}
		});
	}
}
