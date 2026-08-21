using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改buff时间和上限(配置ID)", 0)]
[Category("Logic/Buff")]
[Description("修改buff时间(ID)和上限, 乘除操作不能用\n修改上限为了处理一些时间百分比需求,避免超过上限超过百分之百")]
public class ModifyBuffTimeAndKeeptTime : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID", "BuffID");
		ValueInput<OperationMethod> opInput = AddValueInput<OperationMethod>("操作");
		ValueInput<int> timeInput = AddValueInput<int>("毫秒数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			ModifyBuffTimeWithConfigID(base.mSimContext.GetEntityWithEntityID(entityIDInput.value), configIDInput.GetValue(), opInput.GetValue(), timeInput.GetValue());
			output.Call(f);
		});
	}

	public static bool ModifyBuffTimeWithConfigID(SimEntity simEntity, int configID, OperationMethod operationMethod, int value)
	{
		if (simEntity == null || !simEntity.hasEntityBuff)
		{
			return false;
		}
		int buffConfigIDIndex = simEntity.entityBuff.GetBuffConfigIDIndex(configID);
		if (buffConfigIDIndex == -1)
		{
			return false;
		}
		switch (operationMethod)
		{
		case OperationMethod.Add:
			simEntity.entityBuff.mDuringArray[buffConfigIDIndex] += value;
			simEntity.entityBuff.mBuffKeepTimeArray[buffConfigIDIndex] += value;
			break;
		case OperationMethod.Divide:
			return false;
		case OperationMethod.Multiply:
			return false;
		case OperationMethod.Set:
			simEntity.entityBuff.mDuringArray[buffConfigIDIndex] = value;
			simEntity.entityBuff.mBuffKeepTimeArray[buffConfigIDIndex] = value;
			break;
		case OperationMethod.Subtract:
			simEntity.entityBuff.mDuringArray[buffConfigIDIndex] -= value;
			simEntity.entityBuff.mBuffKeepTimeArray[buffConfigIDIndex] -= value;
			break;
		}
		return true;
	}
}
