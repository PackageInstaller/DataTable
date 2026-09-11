using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改黑板值(long)", 0)]
[Category("Logic/Attribute")]
[Description("给某个实体逻辑黑板添加属性")]
public class ModifyAttributeWithLong : FlowControlNode
{
	private ValueInput<int> mWantedVarName;

	private ValueInput<long> mWantedVarValue;

	private ValueInput<OperationMethod> mOperationInpuva;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => mEntityID.value);
		mWantedVarName = AddValueInput<int>("期望添加的变量名字", "wantedName");
		mOperationInpuva = AddValueInput<OperationMethod>("操作符", "operation");
		mWantedVarValue = AddValueInput<long>("期望添加的变化值", "wantedValue");
		FlowOutput o = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarName.value, mWantedVarValue.value);
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

	private void Invoke(int entityID, int name, long value)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, out var baseValue, out var _, out var _);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, OperatorValue(mOperationInpuva.value, baseValue, value), 0L, 0L);
		}
	}
}
