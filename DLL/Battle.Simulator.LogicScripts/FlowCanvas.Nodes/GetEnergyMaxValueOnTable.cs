using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取最大机制值(表)", 0)]
[Category("Logic/Config")]
[Description("获取最大机制值")]
public class GetEnergyMaxValueOnTable : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("最大机制值", delegate
		{
			int result = 0;
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig)
			{
				result = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId).EnergyMaxValue;
			}
			return result;
		});
	}
}
