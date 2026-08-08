using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化机制值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("初始化机制值,并根据机制值初始化技能可用性;\n不会抛出事件")]
public class InitEnergyAndSkillEnable : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _CurEnergyInput;

	private ValueInput<int> _MaxValueInput;

	private FlowOutput _Out;

	private FlowOutput _Undefined;

	private FlowOutput _Error;

	private int _EnergyTypeValue;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_CurEnergyInput = AddValueInput<int>("当前值", "curEnergyValue");
		_MaxValueInput = AddValueInput<int>("最大值");
		_Out = AddFlowOutput("Out", "output");
		_Undefined = AddFlowOutput("未定义类型", "undefined");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				_Error.Call(f);
			}
			else if (ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId) == null)
			{
				_Error.Call(f);
			}
			else if (ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId) == null)
			{
				_Error.Call(f);
			}
			else
			{
				AttributeProcessor.AddPowerValue(entityWithEntityID.creationIndex, _MaxValueInput.GetValue(), _CurEnergyInput.GetValue(), out var _, out var _);
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("机制值类型", "energyType", () => _EnergyTypeValue);
		AddValueOutput("当前值", "curEnergyValue", () => _CurEnergyInput.GetValue());
	}
}
