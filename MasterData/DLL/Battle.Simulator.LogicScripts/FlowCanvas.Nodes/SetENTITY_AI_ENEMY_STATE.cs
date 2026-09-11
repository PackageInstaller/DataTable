using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置小怪AI状态(0:未发现目标;1:观察;2:待攻击;3:攻击)(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("设置小怪AI状态(0:未发现目标;1:观察;2:待攻击;3:攻击)")]
public class SetENTITY_AI_ENEMY_STATE : FlowControlNode
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
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, value, 0L, 0L);
		}
	}
}
