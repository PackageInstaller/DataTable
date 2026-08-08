using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化技能可用性(机制值)(逻辑)(已过时)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class InitSkillEnableStateByEnergy : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _CurEnergyInput;

	private FlowOutput _Out;

	private FlowOutput _Undefined;

	private FlowOutput _Error;

	private int _EnergyTypeValue;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_CurEnergyInput = AddValueInput<int>("当前值", "curEnergyValue");
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
			else
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId);
				if (config == null)
				{
					_Error.Call(f);
				}
				else
				{
					charactor_param config2 = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
					if (config2 == null)
					{
						_Error.Call(f);
					}
					else
					{
						_EnergyTypeValue = config2.EnergyType;
						switch ((EnergyType)_EnergyTypeValue)
						{
						case EnergyType.None:
							_Undefined.Call(f);
							break;
						default:
							_Undefined.Call(f);
							break;
						case EnergyType.Rage:
						case EnergyType.Power:
						case EnergyType.Mark:
						case EnergyType.Unique:
						case EnergyType.Tune:
						{
							for (int i = 0; i < config.AllSkills.Count; i++)
							{
								int num = config.AllSkills.get_Item(i);
								if (AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, num, out var energyChangeValue, out var _))
								{
									bool flag = _CurEnergyInput.GetValue() + energyChangeValue >= 0;
									if (!flag)
									{
										entityWithEntityID.entityBlackboard.var.EnableAbility(num, flag);
									}
								}
							}
							_Out.Call(f);
							break;
						}
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("机制值类型", "energyType", () => _EnergyTypeValue);
		AddValueOutput("当前值", "curEnergyValue", () => _CurEnergyInput.GetValue());
	}
}
