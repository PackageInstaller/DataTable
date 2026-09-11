using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD以及充能检查消耗", 0)]
[Category("Logic/新多维")]
[Description("CD以及充能检查消耗, 不能用在ai玩法里面")]
public class NewMatrixSkillCheck : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> enttiyIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> cdBuffLogicIDInput = AddValueInput<int>("CD的buff处理逻辑ID");
		ValueInput<int> maxCDInput = AddValueInput<int>("最大CD");
		ValueInput<int> energyBuffLogicIDInput = AddValueInput<int>("充能的buff处理逻辑ID");
		FlowOutput outputTrue = AddFlowOutput("释放成功");
		FlowOutput outputFalse = AddFlowOutput("无法释放");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enttiyIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				outputFalse.Call(f);
			}
			else
			{
				int num = -1;
				int num2 = -1;
				List<int> mBuffClassIDArray = entityWithEntityID.entityBuff.mBuffClassIDArray;
				int value = cdBuffLogicIDInput.value;
				int value2 = energyBuffLogicIDInput.value;
				for (int i = 0; i < mBuffClassIDArray.Count; i++)
				{
					if (mBuffClassIDArray[i] == value)
					{
						num = i;
					}
					else if (mBuffClassIDArray[i] == value2)
					{
						num2 = i;
					}
				}
				if (num == -1 && num2 != -1)
				{
					BuffParams value3 = entityWithEntityID.entityBuff.mBuffParamsArray[num2];
					if ((int)value3.v1 >= (int)value3.v2)
					{
						ref SimVar v = ref value3.v1;
						v = (int)v - (int)value3.v2;
						entityWithEntityID.entityBuff.mBuffParamsArray[num2] = value3;
						BuffProcessor.AddBuffClassID(entityWithEntityID.creationIndex, entityWithEntityID.creationIndex, value, 0, maxCDInput.value, 0, isOnce: false, isLoop: false, default(BuffParams), 0, 1);
						outputTrue.Call(f);
						return;
					}
				}
				outputFalse.Call(f);
			}
		});
	}
}
