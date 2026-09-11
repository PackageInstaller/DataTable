using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改黑板值(带上限)", 0)]
[Category("Logic/Attribute")]
[Description("给某个实体逻辑黑板添加属性\n结果不会超过输入的上限值\n超出上限：当本次运算结果大于（不含）上限值时。大于上限的值不会写入黑板不超过上限时走Out，超过上限时只走超出上限")]
public class ModifyAttributeWithIntCeil : FlowControlNode
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
		mWantedCeilValue = AddValueInput<int>("黑板值上限");
		FlowOutput o = AddFlowOutput("Out");
		FlowOutput fExceeded = AddFlowOutput("超出上限");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, out var baseValue, out var _, out var _);
				long num = OperatorValue(mOperationInpuva.value, baseValue, mWantedVarValue.value);
				bool flag = num > mWantedCeilValue.value;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, flag ? mWantedCeilValue.value : num, 0L, 0L);
				if (flag)
				{
					f.Call(fExceeded);
					return;
				}
			}
			o.Call(f);
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
