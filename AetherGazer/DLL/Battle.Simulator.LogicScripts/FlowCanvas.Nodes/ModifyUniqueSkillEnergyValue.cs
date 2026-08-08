using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改奥义能量(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("修改奥义能量值，没有考虑属性")]
public class ModifyUniqueSkillEnergyValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _AddValueInput;

	private ValueInput<bool> _ApplyUniqueSkillRateInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_AddValueInput = AddValueInput<int>("增量", "addValue");
		_ApplyUniqueSkillRateInput = AddValueInput<bool>("是否计算获得率", "applyUniqueSkillRateInput").SetDefaultAndSerializedValue(v: false);
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
				EntityUniqueSkillEnergy entityUniqueSkillEnergy = entityWithEntityID.entityUniqueSkillEnergy;
				int num = _AddValueInput.GetValue();
				if (_ApplyUniqueSkillRateInput.GetValue())
				{
					int num2 = (int)AttributeProcessor.GetFinalAttributeByAttributeID(AttributeProcessor.GetAttributeIDByEntityID(_EntityIDInput.GetValue()), 1101, AttributeCalcType.Add);
					num = num * (1000 + num2) / 1000;
				}
				entityUniqueSkillEnergy.mValue += num;
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
