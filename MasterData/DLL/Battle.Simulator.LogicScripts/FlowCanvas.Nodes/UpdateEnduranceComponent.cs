using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新耐力组件", 0)]
[Category("Logic/Attribute")]
[Description("更新耐力组件")]
public class UpdateEnduranceComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("启用闪避");
		FlowOutput falseOut = AddFlowOutput("禁用闪避");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityEndurance)
			{
				Int resumeSpeed = entityWithEntityID.entityEndurance.resumeSpeed;
				int logicConstTick = CommonProcessor.GetLogicConstTick();
				Int obj = resumeSpeed * new VFactor(logicConstTick, 1000L);
				entityWithEntityID.entityEndurance.currentValue += obj;
				if (entityWithEntityID.entityEndurance.currentValue > entityWithEntityID.entityEndurance.maxValue)
				{
					entityWithEntityID.entityEndurance.currentValue = entityWithEntityID.entityEndurance.maxValue;
				}
				if (entityWithEntityID.entityEndurance.currentValue >= entityWithEntityID.entityEndurance.consumeValue)
				{
					if (!entityWithEntityID.entityEndurance.state)
					{
						entityWithEntityID.entityEndurance.state = true;
						f.Call(trueOut);
					}
				}
				else if (entityWithEntityID.entityEndurance.state)
				{
					entityWithEntityID.entityEndurance.state = false;
					f.Call(falseOut);
				}
			}
		});
	}
}
