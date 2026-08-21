using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取buff等级", 0)]
[Category("Logic/Buff")]
[Description("获取buff等级")]
public class GetBuffLevel : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("配置ID", "BuffID");
		int simVar = 0;
		AddValueOutput("等级", () => simVar);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			simVar = 0;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				int buffConfigIDIndex = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(buffConfigIDInput.value);
				if (buffConfigIDIndex >= 0)
				{
					simVar = entityWithEntityID.entityBuff.mBuffFloor[buffConfigIDIndex];
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
