using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化奥义能量(复合)(逻辑)", 0)]
[Category("Logic/奥义/复合")]
[Description("初始化奥义能量组件")]
public class InitUniqueSkillEnergyWithConfigAndAttribute : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _ValueInput;

	private ValueInput<int> _DelayInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_ValueInput = AddValueInput<int>("新值", "value");
		_DelayInput = AddValueInput<int>("延迟时长(毫秒)", "delay").SetDefaultAndSerializedValue(-1);
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig || !ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
			{
				_Error.Call(f);
			}
			else
			{
				int newMAddValue = CalcUniqueSkillEnergyAddtionalValueWithAttribute.CalcNewAddValue(entityWithEntityID.entityBlackboard.var.mAttributeID, config.BaseAddValue);
				int newMRuntime = ((_DelayInput.GetValue() != -1) ? _DelayInput.GetValue() : config.Tick);
				if (!entityWithEntityID.hasEntityUniqueSkillEnergy)
				{
					entityWithEntityID.AddEntityUniqueSkillEnergy(EntityActionStatus.E_ACTIVE, _ValueInput.GetValue(), config.UpperLimit, newMAddValue, config.Tick, newMRuntime);
				}
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
