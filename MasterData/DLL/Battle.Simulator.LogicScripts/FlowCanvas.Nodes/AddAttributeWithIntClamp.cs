using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑黑板增加属性(上下限)(int)", 0)]
[Category("Logic/Attribute")]
[Description("给某个实体逻辑黑板添加属性")]
public class AddAttributeWithIntClamp : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> mWantedVarName = AddValueInput<int>("期望添加的变量名字", "wantedVar");
		ValueInput<int> mWantedVarValue = AddValueInput<int>("期望添加的变量值", "wantedVarValue");
		ValueInput<int> maxInput = AddValueInput<int>("上限", "max").SetDefaultAndSerializedValue(int.MaxValue);
		ValueInput<int> minInput = AddValueInput<int>("下限", "min").SetDefaultAndSerializedValue(int.MinValue);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, out var baseValue, out var plusValue, out var tempPlusValue);
				baseValue += mWantedVarValue.value;
				baseValue = IntMath.Clamp(baseValue, minInput.value, maxInput.value);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName.value, baseValue, plusValue, tempPlusValue);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
