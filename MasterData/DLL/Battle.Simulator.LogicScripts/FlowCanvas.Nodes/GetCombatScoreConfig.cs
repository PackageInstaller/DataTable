using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到战斗评分配置", 0)]
[Category("Logic/Config")]
[Description("如题")]
public class GetCombatScoreConfig : FlowControlNode
{
	private ValueInput<EnCombatScoreRank> _EnLevelInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private CombatScore _ScoreInfo;

	protected override void RegisterPorts()
	{
		_EnLevelInput = AddValueInput<EnCombatScoreRank>("等级", "enLevel");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			_ScoreInfo = null;
			if (!ConfigHelper.GetInstance().TryGetConfig<CombatScore>((int)_EnLevelInput.GetValue(), out _ScoreInfo))
			{
				_Error.Call(f);
			}
			else
			{
				_Out.Call(f);
			}
		});
		AddValueOutput("评价下限", "floor_value", () => (_ScoreInfo != null) ? _ScoreInfo.FloorValue : 0);
		AddValueOutput("扣分", "score_reduction", () => (_ScoreInfo != null) ? _ScoreInfo.ScoreReduction : 0);
		AddValueOutput("打架势槽加成", "exposed_add", () => (_ScoreInfo != null) ? _ScoreInfo.ExposedAdd : 0);
		AddValueOutput("攻击力加成", "attack_add", () => (_ScoreInfo != null) ? _ScoreInfo.AttackAdd : 0);
		AddValueOutput("脱战时间", "combat_off", () => (_ScoreInfo != null) ? _ScoreInfo.CombatOff : 0);
	}
}
