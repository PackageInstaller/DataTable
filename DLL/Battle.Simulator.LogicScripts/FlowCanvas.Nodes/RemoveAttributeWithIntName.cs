using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除逻辑黑板属性", 0)]
[Category("Logic/Attribute")]
[Description("移除某个实体逻辑黑板属性")]
public class RemoveAttributeWithIntName : FlowControlNode
{
	private ValueInput<int> mWantedVarName;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		mWantedVarName = AddValueInput<int>("变量名字");
		FlowOutput o = AddFlowOutput(" ");
		AddFlowInput(" ", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarName.value);
			o.Call(f);
		});
	}

	private void Invoke(int entityID, int name)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, out var _, out var _, out var _))
		{
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, 0L, 0L, 0L);
		}
	}
}
