using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置游戏结束", 0)]
[Category("Logic/Control")]
[Description("结束过程时间会受时间缩放影响")]
public class SetGameOver : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> timeInput = AddValueInput<int>("结束过程时间");
		ValueInput<int> timeScaleInput = AddValueInput<int>("过程时间缩放").SetDefaultAndSerializedValue(5);
		ValueInput<bool> isVectoryInput = AddValueInput<bool>("是否胜利");
		AddFlowInput("", delegate
		{
			_ = timeScaleInput.value;
			if (!base.mSimContext.hasSEntityGameOver)
			{
				base.mSimContext.SetSEntityGameOver(GameOverState.start, timeInput.value, timeScaleInput.value, isVectoryInput.value ? E_BattleResult.Win : E_BattleResult.Lose);
			}
		});
	}
}
