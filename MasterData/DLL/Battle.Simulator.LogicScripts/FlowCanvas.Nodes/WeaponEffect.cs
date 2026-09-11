using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断钥从效果", 0)]
[Category("Logic/装备")]
[Description("钥从效果ID对应 equip_effect 表中的 id 列")]
public class WeaponEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> effectIDInput = AddValueInput<int>("钥从效果ID");
		long level = 0L;
		AddValueOutput("精炼等级", () => (int)level);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			level = 0L;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				falseOut.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2011, out var baseValue, out var plusValue, out var tempPlusValue);
				if (baseValue == effectIDInput.value)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2012, out level, out plusValue, out tempPlusValue);
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
