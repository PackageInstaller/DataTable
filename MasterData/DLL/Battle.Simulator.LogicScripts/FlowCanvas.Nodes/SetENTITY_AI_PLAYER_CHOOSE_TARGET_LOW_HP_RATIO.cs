using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置玩家方选目标低血量系数(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("设置玩家方选目标低血量系数")]
public class SetENTITY_AI_PLAYER_CHOOSE_TARGET_LOW_HP_RATIO : FlowControlNode
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
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2210, value, 0L, 0L);
		}
	}
}
