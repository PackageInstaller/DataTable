using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改Buff存活时长(数组下标)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("修改buff时间(ID), 乘除操作不能用")]
public class ModifyBuffTime3 : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> buffListIndexInput = AddValueInput<int>("数组下标", "buffListIndex");
		ValueInput<OperationMethod> opInput = AddValueInput<OperationMethod>("操作", "operation");
		ValueInput<int> timeInput = AddValueInput<int>("毫秒数", "time");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				errorOut.Call(f);
			}
			else
			{
				ModifyBuffTimeWithConfigID(entityWithEntityID, buffListIndexInput.value, opInput.value, timeInput.value);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}

	public static bool ModifyBuffTimeWithConfigID(SimEntity simEntity, int index, OperationMethod operationMethod, int value)
	{
		if (simEntity == null || !simEntity.hasEntityBuff)
		{
			return false;
		}
		switch (operationMethod)
		{
		case OperationMethod.Add:
			simEntity.entityBuff.mDuringArray[index] += value;
			break;
		case OperationMethod.Divide:
			return false;
		case OperationMethod.Multiply:
			return false;
		case OperationMethod.Set:
			simEntity.entityBuff.mDuringArray[index] = value;
			break;
		case OperationMethod.Subtract:
			simEntity.entityBuff.mDuringArray[index] -= value;
			break;
		}
		return true;
	}
}
