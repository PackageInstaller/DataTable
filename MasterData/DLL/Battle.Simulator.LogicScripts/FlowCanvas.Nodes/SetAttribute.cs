using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("给某个实体逻辑黑板设置属性", 0)]
[Category("Logic/Attribute")]
[Description("给某个实体逻辑黑板添加属性")]
public class SetAttribute : FlowControlNode
{
	private ValueInput<EntityVarName> mWantedVarName;

	private ValueInput<int> mWantedVarValue;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		mWantedVarName = AddValueInput<EntityVarName>("期望添加的变量名字");
		mWantedVarValue = AddValueInput<int>("期望添加的变量值");
		FlowOutput o = AddFlowOutput(" ");
		AddFlowInput(" ", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarName.value, mWantedVarValue.value);
			o.Call(f);
		});
	}

	private void Invoke(int entityID, EntityVarName name, int value)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)name, value, 0L, 0L);
		}
	}
}
