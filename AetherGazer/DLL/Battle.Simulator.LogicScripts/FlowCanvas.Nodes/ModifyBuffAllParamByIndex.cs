using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置所有Buff参数(数组下标)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("修改buff参数(索引), 下标从0开始, 乘法操作的参数是百分比")]
public class ModifyBuffAllParamByIndex : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("数组下标", "索引");
		ValueInput<SimVar> valueInput0 = AddValueInput<SimVar>("值0");
		ValueInput<SimVar> valueInput1 = AddValueInput<SimVar>("值1");
		ValueInput<SimVar> valueInput2 = AddValueInput<SimVar>("值2");
		ValueInput<SimVar> valueInput3 = AddValueInput<SimVar>("值3");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				int value = buffConfigIDInput.value;
				if (value >= 0)
				{
					BuffParams value2 = entityWithEntityID.entityBuff.mBuffParamsArray[value];
					value2.v1 = valueInput0.value;
					value2.v2 = valueInput1.value;
					value2.v3 = valueInput2.value;
					value2.v4 = valueInput3.value;
					entityWithEntityID.entityBuff.mBuffParamsArray[value] = value2;
				}
			}
			f.Call(output);
		});
	}
}
