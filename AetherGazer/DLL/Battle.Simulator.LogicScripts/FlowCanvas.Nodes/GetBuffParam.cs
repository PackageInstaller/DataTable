using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff参数(配置ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("获取buff参数(ID), 下标从0开始")]
public class GetBuffParam : FlowNode
{
	private int _index;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("配置ID", "BuffID");
		ValueInput<int> indexInput = AddValueInput<int>("Buff参数下标(0-3)", "下标");
		SimVar simVar = 0;
		AddValueOutput("结果", () => simVar);
		AddValueOutput("数组下标", "index", () => _index);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			_index = -1;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				int buffConfigIDIndex = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(buffConfigIDInput.value);
				if (buffConfigIDIndex >= 0)
				{
					BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[buffConfigIDIndex];
					switch (indexInput.value)
					{
					case 0:
						simVar = buffParams.v1;
						break;
					case 1:
						simVar = buffParams.v2;
						break;
					case 2:
						simVar = buffParams.v3;
						break;
					case 3:
						simVar = buffParams.v4;
						break;
					default:
						f.Call(falseOut);
						return;
					}
					_index = buffConfigIDIndex;
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
