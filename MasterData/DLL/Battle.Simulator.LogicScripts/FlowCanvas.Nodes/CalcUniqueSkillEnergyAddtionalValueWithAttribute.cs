using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算奥义值增量(属性影响)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("传入基础值,计算得到增量值")]
public class CalcUniqueSkillEnergyAddtionalValueWithAttribute : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _BaseAddValueInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _NewAddValue;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_BaseAddValueInput = AddValueInput<int>("增量", "addValue");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_NewAddValue = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_Error.Call(f);
			}
			else
			{
				_NewAddValue = CalcNewAddValue(entityWithEntityID.entityBlackboard.var.mAttributeID, _BaseAddValueInput.GetValue());
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("新增量", "length", () => _NewAddValue);
	}

	public static int CalcNewAddValue(int attributeID, int pBaseAddValue)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 1101, AttributeCalcType.Add);
		return (pBaseAddValue * new VFactor(finalAttributeByAttributeID + 1000, 1000L)).floorInt;
	}
}
