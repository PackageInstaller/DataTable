using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体类型(角色)种族(渲染)", 0)]
[Category("Render/Agent")]
[Description("获取角色种族")]
public class SwitchEnumOfRaceRender : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		FlowOutput _None = AddFlowOutput("None", "none");
		FlowOutput _RaceGreece = AddFlowOutput("希腊", "raceGreece");
		FlowOutput _RaceEgypt = AddFlowOutput("埃及", "raceEgypt");
		FlowOutput _RaceJapan = AddFlowOutput("日本", "raceJapan");
		FlowOutput _RaceNorthernEurope = AddFlowOutput("北欧", "raceNorthernEurope");
		FlowOutput _RaceChina = AddFlowOutput("中国");
		FlowOutput _Other = AddFlowOutput("众星", "other");
		FlowOutput _RaceHuman = AddFlowOutput("人形怪", "raceHuman");
		FlowOutput _RaceBug = AddFlowOutput("视骸怪", "raceBug");
		FlowOutput _RaceMachine = AddFlowOutput("机械怪", "raceMachine");
		FlowOutput _RaceOtherEnemy = AddFlowOutput("其他类型敌人");
		AddFlowInput("", delegate(Flow f)
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(roleIDInput.value, out var config))
			{
				_None.Call(f);
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
				}
			}
		});
	}
}
