using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到奥义能量值(逻辑)", 0)]
[Category("Logic/QTE")]
[Description("如题")]
public class GetUniqueValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _UniqueValue;

	private int _uniqueMaxValue;

	private int _uniqueValuePermill;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUniqueSkillEnergy)
			{
				_Error.Call(f);
			}
			else
			{
				_UniqueValue = entityWithEntityID.entityUniqueSkillEnergy.mValue;
				if (_UniqueValue > entityWithEntityID.entityUniqueSkillEnergy.mMaxValue)
				{
					_UniqueValue = entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
				}
				_uniqueMaxValue = entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
				_uniqueValuePermill = IntMath.Divide(_UniqueValue * 1000, _uniqueMaxValue);
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("奥义值", "uniqueValue", () => _UniqueValue);
		AddValueOutput("奥义最大值", "uniqueMaxValue", () => _uniqueMaxValue);
		AddValueOutput("奥义值(千分之)", "uniqueValuePermill", () => _uniqueValuePermill);
	}
}
