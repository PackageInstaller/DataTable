using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI技能CD开始事件(过时)", 0)]
[Category("Render/UI")]
[Description("战斗UI技能CD开始事件")]
public class OnBattleButtonUIBeginCD : OnBattleButtonUICD
{
	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		AbilityButtonsUI component = base.graph.agent.gameObject.GetComponent<AbilityButtonsUI>();
		component.OnBeginCD = (Action<int>)Delegate.Combine(component.OnBeginCD, new Action<int>(base.Invoke));
	}
}
