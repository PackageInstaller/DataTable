using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取Buff剩余Tick次数", 0)]
[Category("Logic/Buff/通用")]
[Description("根据传入的数组下标获取实体身上对应Buff的剩余触发次数")]
public class GetBuffTickNum : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput errorOutput = AddFlowOutput("Error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> buffListIndex = AddValueInput<int>("数组下标", "数组下标");
		int buffTickNum = 0;
		int casterEntityID = 0;
		int index = 0;
		int during = 0;
		int tick = 0;
		int delay = 0;
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("释放者实体ID", () => casterEntityID);
		AddValueOutput("Buff剩余触发次数", () => buffTickNum);
		AddFlowInput("In", delegate(Flow f)
		{
			index = buffListIndex.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				errorOutput.Call(f);
			}
			else if (index < 0 || index >= entityWithEntityID.entityBuff.mDuringArray.Count)
			{
				Debug.LogError("获取Buff剩余Tick次数里的index越界");
				errorOutput.Call(f);
			}
			else
			{
				casterEntityID = entityWithEntityID.entityBuff.mBuffCasterArray[index];
				during = entityWithEntityID.entityBuff.mDuringArray[index];
				tick = entityWithEntityID.entityBuff.mTickArray[index];
				delay = entityWithEntityID.entityBuff.mBuffRuntime[index];
				int logicConstTick = CommonProcessor.GetLogicConstTick();
				if (during <= 0)
				{
					buffTickNum = 0;
					output.Call(f);
				}
				else
				{
					if (during % logicConstTick == 0)
					{
						during -= logicConstTick;
					}
					during = during / 33 * 33;
					if (tick <= logicConstTick)
					{
						tick = logicConstTick;
					}
					if (during < delay)
					{
						buffTickNum = 0;
						output.Call(f);
					}
					else
					{
						delay = IntMath.Max(delay, 1 - logicConstTick);
						int num = during - delay;
						buffTickNum = num / tick + 1;
						output.Call(f);
					}
				}
			}
		});
	}
}
