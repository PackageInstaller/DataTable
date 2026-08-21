using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("(统合)修改黑板值(带下限)", 0)]
[Category("Logic/Attribute")]
[Description("给某个实体逻辑黑板添加属性\n结果低于输入的下限值时会被强制改成下限值\n达到下限：修改前的值>下限且修改后的值<=上限")]
public class ModifyAttributeWithIntCeil2 : FlowNode
{
	private ValueInput<int> mWantedVarName;

	private ValueInput<int> mWantedVarValue;

	private ValueInput<int> mWantedCeilValue;

	private ValueInput<OperationMethod> mOperationInpuva;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => mEntityID.value);
		mWantedVarName = AddValueInput<int>("期望添加的变量名字");
		mOperationInpuva = AddValueInput<OperationMethod>("操作符");
		mWantedVarValue = AddValueInput<int>("期望添加的变化值");
		mWantedCeilValue = AddValueInput<int>("黑板值下限");
		FlowOutput o = AddFlowOutput("高于下限");
		FlowOutput equaled = AddFlowOutput("等于下限");
		FlowOutput fExceeded = AddFlowOutput("低于下限");
		FlowOutput reached = AddFlowOutput("达到下限");
		FlowOutput error = AddFlowOutput("error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, out var baseValue, out var _, out var _);
				long num = OperatorValue(mOperationInpuva.value, baseValue, mWantedVarValue.value);
				bool flag = num < mWantedCeilValue.value;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, flag ? mWantedCeilValue.value : num, 0L, 0L);
				if (baseValue > mWantedCeilValue.value && num <= mWantedCeilValue.value)
				{
					reached.Call(f);
				}
				if (num == mWantedCeilValue.value)
				{
					equaled.Call(f);
				}
				if (flag)
				{
					f.Call(fExceeded);
				}
				if (num > mWantedCeilValue.value)
				{
					o.Call(f);
				}
			}
			else
			{
				error.Call(f);
			}
		});
	}

	private long OperatorValue(OperationMethod op, long origin, long opValue)
	{
		return op switch
		{
			OperationMethod.Set => opValue, 
			OperationMethod.Add => origin + opValue, 
			OperationMethod.Subtract => origin - opValue, 
			OperationMethod.Multiply => origin * opValue, 
			OperationMethod.Divide => origin / opValue, 
			_ => origin, 
		};
	}
}
