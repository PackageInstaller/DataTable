using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI技能CD结束事件(过时)", 0)]
[Category("Render/UI")]
[Description("战斗UI技能CD结束事件")]
public class OnBattleButtonUICompleteCD : OnBattleButtonUICD
{
	public override void OnGraphStarted()
	{
		base.OnGraphStoped();
		AbilityButtonsUI component = base.graph.agent.gameObject.GetComponent<AbilityButtonsUI>();
		component.OnCompleteCD = (Action<int>)Delegate.Combine(component.OnCompleteCD, new Action<int>(base.Invoke));
	}
}
