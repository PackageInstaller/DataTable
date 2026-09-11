using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑黑板增加属性(int)", 0)]
[Category("Logic/Attribute")]
[Description("给某个实体逻辑黑板添加属性")]
public class AddAttributeWithInt : FlowControlNode
{
	private ValueInput<int> mWantedVarName;

	private ValueInput<int> mWantedVarValue;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => mEntityID.value);
		mWantedVarName = AddValueInput<int>("期望添加的变量名字");
		mWantedVarValue = AddValueInput<int>("期望添加的变量值");
		FlowOutput o = AddFlowOutput(" ");
		AddFlowInput(" ", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarName.value, mWantedVarValue.value);
			o.Call(f);
		});
	}

	private void Invoke(int entityID, int name, int value)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, out var baseValue, out var plusValue, out var tempPlusValue);
			baseValue += value;
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, baseValue, plusValue, tempPlusValue);
		}
	}
}
