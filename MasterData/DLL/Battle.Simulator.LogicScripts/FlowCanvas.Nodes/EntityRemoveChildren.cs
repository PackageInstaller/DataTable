using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体脱离实体(逻辑)", 0)]
[Category("Logic/Entity")]
[Description("A从B上脱离")]
public class EntityRemoveChildren : FlowControlNode
{
	private ValueInput<int> _EntityIDAInput;

	private ValueInput<Int3> _OffsetInput;

	private ValueInput<int> _EntityIDBInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDAInput = AddValueInput<int>("挂件实体ID", "entityIDA");
		_EntityIDBInput = AddValueInput<int>("基座实体ID", "entityIDB");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity simEntity2;
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _EntityIDAInput.GetValue(), out var simEntity))
			{
				_Error.Call(f);
			}
			else if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _EntityIDBInput.GetValue(), out simEntity2))
			{
				_Error.Call(f);
			}
			else
			{
				simEntity2.RemoveChild(simEntity, destroyChild: false);
				simEntity.mTag = SimEntity.Tag.None;
				simEntity.entityBlackboard.var.LocalPositionOfCombination = Int3.zero;
				base.mSimContext.PostEvent(EntityCombinedEvent.Claim(CombinedStep.Out, simEntity.creationIndex, simEntity2.creationIndex));
				_Out.Call(f);
			}
		});
		AddValueOutput("挂件实体ID", "entityIDA", () => _EntityIDAInput.GetValue());
		AddValueOutput("基座实体ID", "entityIDB", () => _EntityIDBInput.GetValue());
	}
}
