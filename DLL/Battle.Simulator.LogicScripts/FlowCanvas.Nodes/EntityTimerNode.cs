using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体计数器", 0)]
[Category("Logic/Buff")]
[Description("用来给实体计时\n编号是指计数器的编号, 每一个实体可以有很多个计数器, 用编号来区分\n间隔是指计数器多久触发一次, 触发走true, 否则走false\n增量是指每次进来的时候加多少, 从0开始, 加到超过间隔的时候触发一次")]
public class EntityTimerNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> nameInput = AddValueInput<int>("编号");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> intervalInput = AddValueInput<int>("间隔");
		ValueInput<int> deltaInput = AddValueInput<int>("增量");
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddFlowInput("In", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = nameInput.value;
			int value3 = intervalInput.value;
			if (base.mSimContext.GetEntityWithEntityID(value) == null)
			{
				errorOut.Call(f);
			}
			else if (CommonNodeFunction.EntityCounterUpdate(base.mSimContext.GetEntityWithEntityID(value), value2, value3, deltaInput.value))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddFlowInput("Reset", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = nameInput.value;
			if (base.mSimContext.GetEntityWithEntityID(value) == null)
			{
				errorOut.Call(f);
			}
			else if (CommonProcessor.EntityHasEntityTimer(value, value2))
			{
				if (CommonProcessor.ResetEntityTimer(value, value2))
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
