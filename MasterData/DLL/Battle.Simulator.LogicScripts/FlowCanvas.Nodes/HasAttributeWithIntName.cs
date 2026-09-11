using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断实体逻辑黑板是否存在某个属性(int)", 0)]
[Category("Logic/Attribute")]
[Description("判断实体逻辑黑板是否存在某个属性")]
public class HasAttributeWithIntName : FlowControlNode
{
	private ValueInput<int> mWantedVarName;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		mWantedVarName = AddValueInput<int>("期望判断的变量名字");
		FlowOutput t = AddFlowOutput("true");
		FlowOutput fls = AddFlowOutput("false");
		AddFlowInput(" ", delegate(Flow f)
		{
			if (Invoke(mEntityID.value, mWantedVarName.value))
			{
				t.Call(f);
			}
			else
			{
				fls.Call(f);
			}
		});
		AddValueOutput("值: ", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				long baseValue = 0L;
				long plusValue = 0L;
				long tempPlusValue = 0L;
				if (AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, out baseValue, out plusValue, out tempPlusValue))
				{
					return baseValue;
				}
			}
			return 0L;
		});
	}

	private bool Invoke(int entityID, int name)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		long baseValue;
		long plusValue;
		long tempPlusValue;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			return AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, out baseValue, out plusValue, out tempPlusValue);
		}
		return false;
	}
}
