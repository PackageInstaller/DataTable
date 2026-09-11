using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改黑板值(位操作)", 0)]
[Category("Logic/Attribute")]
[Description("修改黑板值对应位的值，用于后续其他操作")]
public class ModifyAttributeByBitwise : FlowControlNode
{
	private ValueInput<int> mEntityID;

	private ValueInput<int> mWantedVarName;

	private ValueInput<int> mIndexInput;

	private ValueInput<bool> mWantedVarValue;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID", "entityID");
		AddValueOutput("实体ID", "entityID", () => mEntityID.value);
		mWantedVarName = AddValueInput<int>("期望添加的变量名字", "wantedName");
		mIndexInput = AddValueInput<int>("标志位(0-31)", "index");
		mWantedVarValue = AddValueInput<bool>("值(0或1)", "wantedValue");
		FlowOutput o = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarName.value, mIndexInput.value, mWantedVarValue.value);
			o.Call(f);
		});
		AddFlowInput("快速取反", "xor", delegate(Flow f)
		{
			XORInvoke(mEntityID.value, mWantedVarName.value, mIndexInput.value);
			o.Call(f);
		});
	}

	private void Invoke(int entityID, int name, int index, bool value)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, out var baseValue, out var _, out var _);
			uint num = (uint)baseValue;
			num = ((!value) ? ((uint)(~(1 << index)) & num) : ((uint)(1 << index) | num));
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, num, 0L, 0L);
		}
	}

	private void XORInvoke(int entityID, int name, int index)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, out var baseValue, out var _, out var _);
			uint num = (uint)baseValue;
			num ^= (uint)(1 << index);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, name, num, 0L, 0L);
		}
	}
}
