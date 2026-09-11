using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加或重置实体计时器(自动计时)", 0)]
[Category("Logic/Buff")]
[Description("添加或重置实体计时器(自动计时)")]
public class AddOrResetEntityTimer : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.value);
		ValueInput<int> nameInput = AddValueInput<int>("计时器编号");
		ValueInput<int> duringTimeInput = AddValueInput<int>("存在时间");
		ValueInput<int> delayTimeInput = AddValueInput<int>("延迟触发时间");
		ValueInput<int> intervalTimeInput = AddValueInput<int>("触发间隔");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				falseOut.Call(f);
			}
			else
			{
				if (!entityWithEntityID.hasEntityTimer)
				{
					entityWithEntityID.AddEntityTimer(FrameListPool<EntityTimerStruct>.Claim());
				}
				int num = -1;
				List<EntityTimerStruct> entityTimers = entityWithEntityID.entityTimer.entityTimers;
				for (int i = 0; i < entityTimers.Count; i++)
				{
					if (entityTimers[i].name == nameInput.GetValue())
					{
						num = i;
						break;
					}
				}
				if (num != -1)
				{
					EntityTimerStruct value = entityWithEntityID.entityTimer.entityTimers[num];
					value.duringTime = duringTimeInput.GetValue();
					value.intervalTime = intervalTimeInput.GetValue();
					value.runningTime = delayTimeInput.GetValue();
					entityWithEntityID.entityTimer.entityTimers[num] = value;
				}
				else
				{
					EntityTimerStruct timerStruct = default(EntityTimerStruct);
					timerStruct.duringTime = duringTimeInput.GetValue();
					timerStruct.id = BuffProcessor.IncreaseBuffID();
					timerStruct.intervalTime = intervalTimeInput.GetValue();
					timerStruct.name = nameInput.GetValue();
					timerStruct.runningTime = delayTimeInput.GetValue();
					entityWithEntityID.entityTimer.Add(timerStruct);
					base.mSimContext.PostEvent(EntityTimerEvent.Claim(timerStruct, EBuffLife.Bind, entityWithEntityID.creationIndex));
				}
				trueOut.Call(f);
			}
		});
	}
}
