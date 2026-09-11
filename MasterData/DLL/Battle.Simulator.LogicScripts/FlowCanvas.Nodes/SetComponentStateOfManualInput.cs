using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置组件状态(逻辑输入)(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("设置本次逻辑输入的状态并可选销毁,默认销毁;\n用于接在输入【逻辑输入事件】后面进行处理;\n如果找不到实体或者实体无输入,则走error流")]
public class SetComponentStateOfManualInput : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<EntityActionStatus> _StateInput;

	private ValueInput<bool> _DestroyInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_StateInput = AddValueInput<EntityActionStatus>("状态", "state");
		_DestroyInput = AddValueInput<bool>("销毁输入", "destroy").SetDefaultAndSerializedValue(v: true);
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionManualInput)
			{
				_Error.Call(f);
			}
			else
			{
				entityWithEntityID.entityActionManualInput.mStatus = _StateInput.GetValue();
				entityWithEntityID.entityActionManualInput.mCanDestroy = _DestroyInput.GetValue();
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
