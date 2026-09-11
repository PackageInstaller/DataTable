using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置AI参数-不加抗性千分比(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("设置AI参数-不加抗性千分比")]
public class SetENTITY_AI_PARAM_NO_RESISTANCE_PERCENT : FlowControlNode
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
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2218, value, 0L, 0L);
		}
	}
}
