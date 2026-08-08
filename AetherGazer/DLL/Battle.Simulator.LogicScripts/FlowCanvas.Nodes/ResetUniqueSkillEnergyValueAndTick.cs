using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置奥义能量和计时(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("重置奥义能量和计时;\n如果延迟为-1,则使用初始配置的间隔作为延迟")]
public class ResetUniqueSkillEnergyValueAndTick : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _NewValueInput;

	private ValueInput<int> _DelayInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_NewValueInput = AddValueInput<int>("新值", "newValue");
		_DelayInput = AddValueInput<int>("延迟时长(毫秒)", "delay").SetDefaultAndSerializedValue(-1);
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
				entityUniqueSkillEnergy.mValue = _NewValueInput.GetValue();
				if (_DelayInput.GetValue() != -1)
				{
					entityUniqueSkillEnergy.mRuntime = _DelayInput.GetValue();
				}
				else
				{
					entityUniqueSkillEnergy.mRuntime = entityUniqueSkillEnergy.mTick;
				}
				entityUniqueSkillEnergy.mState = EntityActionStatus.E_ACTIVE;
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
