using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改Buff参数(数组下标)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("修改buff参数(索引), 下标从0开始, 乘法操作的参数是百分比")]
public class ModifyBuffParamByIndex : FlowNode
{
	public SimVar ModifyParam(SimVar simVar, OperationMethod operationMethod, SimVar value)
	{
		switch (operationMethod)
		{
		case OperationMethod.Add:
			simVar = (int)simVar + (int)value;
			break;
		case OperationMethod.Divide:
			simVar = (int)simVar / (int)value;
			break;
		case OperationMethod.Multiply:
			simVar = (int)simVar * (int)value;
			simVar = (int)simVar / 100;
			break;
		case OperationMethod.Set:
			simVar = value;
			break;
		case OperationMethod.Subtract:
			simVar = (int)simVar - (int)value;
			break;
		}
		return simVar;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("数组下标", "索引");
		AddValueOutput("数组下标", () => buffConfigIDInput.value);
		ValueInput<OperationMethod> opInput = AddValueInput<OperationMethod>("操作", "操作");
		ValueInput<SimVar> valueInput = AddValueInput<SimVar>("值");
		ValueInput<int> indexInput = AddValueInput<int>("Buff参数下标(0-3)", "下标");
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
					switch (indexInput.value)
					{
					case 0:
						value2.v1 = ModifyParam(value2.v1, opInput.value, valueInput.value);
						break;
					case 1:
						value2.v2 = ModifyParam(value2.v2, opInput.value, valueInput.value);
						break;
					case 2:
						value2.v3 = ModifyParam(value2.v3, opInput.value, valueInput.value);
						break;
					case 3:
						value2.v4 = ModifyParam(value2.v4, opInput.value, valueInput.value);
						break;
					}
					entityWithEntityID.entityBuff.mBuffParamsArray[value] = value2;
				}
			}
			f.Call(output);
		});
	}
}
