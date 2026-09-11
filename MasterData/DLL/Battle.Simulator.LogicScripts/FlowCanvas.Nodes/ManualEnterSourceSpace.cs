using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[修正模式]手动进入(逻辑)", 0)]
[Category("Logic/修正模式")]
[Description("将实体标记为可进入间层,需要在手动模式下才能生效")]
public class ManualEnterSourceSpace : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput nonManualOut = AddFlowOutput("非手动模式", "nonManual");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID) || !entityWithEntityID.hasEntityExposedValue)
			{
				errorOut.Call(f);
			}
			else
			{
				EntitySourceSpace entitySourceSpace = base.graph.mSimContext.entitySourceSpace;
				if (entitySourceSpace == null)
				{
					errorOut.Call(f);
				}
				else if (!entitySourceSpace.ManualMode)
				{
					nonManualOut.Call(f);
				}
				else
				{
					entityWithEntityID.entityExposedValue.mManualEnter = true;
					output.Call(f);
				}
			}
		});
	}
}
