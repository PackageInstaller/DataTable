using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化奥义能量(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("初始化奥义能量组件")]
public class InitUniqueSkillEnergy : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _ValueInput;

	private ValueInput<int> _UpperLimitInput;

	private ValueInput<int> _AddValueInput;

	private ValueInput<int> _TickInput;

	private ValueInput<int> _DelayInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_ValueInput = AddValueInput<int>("新值", "value");
		_UpperLimitInput = AddValueInput<int>("上限", "upperLimit");
		_AddValueInput = AddValueInput<int>("增量", "addValue");
		_TickInput = AddValueInput<int>("触发间隔时长(毫秒)", "tick");
		_DelayInput = AddValueInput<int>("延迟时长(毫秒)", "delay");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				_Error.Call(f);
			}
			else
			{
				if (!entityWithEntityID.hasEntityUniqueSkillEnergy)
				{
					entityWithEntityID.AddEntityUniqueSkillEnergy(EntityActionStatus.E_ACTIVE, _ValueInput.GetValue(), _UpperLimitInput.GetValue(), _AddValueInput.GetValue(), _TickInput.GetValue(), _DelayInput.GetValue());
				}
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
