using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到全部Buff参数(配置ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("获取buff参数(ID), 下标从0开始")]
public class GetAllBuffParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("配置ID", "BuffID");
		SimVar[] simVar = new SimVar[4];
		for (int num = 0; num < 4; num++)
		{
			int index = num;
			AddValueOutput("参数" + num, () => simVar[index]);
		}
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				int buffConfigIDIndex = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(buffConfigIDInput.value);
				if (buffConfigIDIndex >= 0)
				{
					BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[buffConfigIDIndex];
					simVar[0] = buffParams.v1;
					simVar[1] = buffParams.v2;
					simVar[2] = buffParams.v3;
					simVar[3] = buffParams.v4;
					f.Call(trueOut);
				}
				else
				{
					f.Call(falseOut);
				}
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
