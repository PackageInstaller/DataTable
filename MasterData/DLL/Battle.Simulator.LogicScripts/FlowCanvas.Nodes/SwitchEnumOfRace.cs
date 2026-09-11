using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断实体种族(逻辑)", 0)]
[Category("Logic/Config")]
[Description("传入实体ID,根据得到的 CharactorParam 表中种族(RaceType) 走不同的分支流出")]
public class SwitchEnumOfRace : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Error;

	private FlowOutput _None;

	private FlowOutput _RaceGreece;

	private FlowOutput _RaceEgypt;

	private FlowOutput _RaceJapan;

	private FlowOutput _RaceNorthernEurope;

	private FlowOutput _RaceChina;

	private FlowOutput _Other;

	private FlowOutput _RaceHuman;

	private FlowOutput _RaceBug;

	private FlowOutput _RaceMachine;

	private FlowOutput _RaceOtherEnemy;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_Error = AddFlowOutput("Error", "error");
		_None = AddFlowOutput("None", "none");
		_RaceGreece = AddFlowOutput("希腊", "raceGreece");
		_RaceEgypt = AddFlowOutput("埃及", "raceEgypt");
		_RaceJapan = AddFlowOutput("日本", "raceJapan");
		_RaceNorthernEurope = AddFlowOutput("北欧", "raceNorthernEurope");
		_RaceChina = AddFlowOutput("中国");
		_Other = AddFlowOutput("众星", "other");
		_RaceHuman = AddFlowOutput("人形怪", "raceHuman");
		_RaceBug = AddFlowOutput("视骸怪", "raceBug");
		_RaceMachine = AddFlowOutput("机械怪", "raceMachine");
		_RaceOtherEnemy = AddFlowOutput("其他类型敌人");
		AddFlowInput("in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			charactor_param config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				_Error.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out config))
			{
				_Error.Call(f);
			}
			else
			{
				switch ((RaceType)config.RaceID)
				{
				case RaceType.None:
					_None.Call(f);
					break;
				case RaceType.RaceGreece:
					_RaceGreece.Call(f);
					break;
				case RaceType.RaceEgypt:
					_RaceEgypt.Call(f);
					break;
				case RaceType.RaceJapan:
					_RaceJapan.Call(f);
					break;
				case RaceType.RaceNorthernEurope:
					_RaceNorthernEurope.Call(f);
					break;
				case RaceType.RaceChina:
					_RaceChina.Call(f);
					break;
				case RaceType.Other:
					_Other.Call(f);
					break;
				case RaceType.RaceHuman:
					_RaceHuman.Call(f);
					break;
				case RaceType.RaceBug:
					_RaceBug.Call(f);
					break;
				case RaceType.RaceMachine:
					_RaceMachine.Call(f);
					break;
				case RaceType.RaceOtherEnemy:
					_RaceOtherEnemy.Call(f);
					break;
				default:
					_Error.Call(f);
					break;
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
