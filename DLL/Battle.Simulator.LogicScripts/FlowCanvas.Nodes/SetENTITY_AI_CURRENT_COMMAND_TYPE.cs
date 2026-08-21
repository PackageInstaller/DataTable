using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置AI目前的指令类型(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("设置AI目前的指令类型")]
public class SetENTITY_AI_CURRENT_COMMAND_TYPE : FlowControlNode
{
	private ValueInput<long> mWantedVarValue;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => mEntityID.value);
		mWantedVarValue = AddValueInput<long>("期望添加的变量值");
		FlowOutput o = AddFlowOutput(" ");
		AddFlowInput(" ", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarValue.value);
			o.Call(f);
		});
	}

	private void Invoke(int entityID, long value)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, value, 0L, 0L);
		}
	}
}
