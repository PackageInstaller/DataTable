using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改速度因子(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("增减命中率, 增量填负数就是减")]
public class ModifySpeedFactor : FlowNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _AddValueInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_AddValueInput = AddValueInput<int>("增量(满值100)", "addValue");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_Error.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mSpeedFactor += new VFactor(_AddValueInput.GetValue(), 100L);
				entityWithEntityID.entityBlackboard.var.mSpeedFactor = CommonProcessor.Normalize(entityWithEntityID.entityBlackboard.var.mSpeedFactor);
				_Out.Call(f);
			}
		});
	}
}
