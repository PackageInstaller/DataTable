using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到速度因子(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class GetSpeedFactor : FlowNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _SpeedFactor;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
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
				_SpeedFactor = (int)IntMath.Divide(entityWithEntityID.entityBlackboard.var.mSpeedFactor.nom * 100, entityWithEntityID.entityBlackboard.var.mSpeedFactor.den);
				_Out.Call(f);
			}
		});
		AddValueOutput("速度因子(满值100)", "speedFactor", () => _SpeedFactor);
	}
}
