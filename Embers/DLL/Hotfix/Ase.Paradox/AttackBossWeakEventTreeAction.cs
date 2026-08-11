using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("注册黑板变量绑定事件--弱点", 0)]
[Category("EventTree")]
[Description("行为树黑板可以根据战斗内事件改变")]
public class AttackBossWeakEventTreeAction : BaseEventTreeAction
{
	[Name("弱点等级", 0)]
	public int weaknessLevel;

	public override BattleObserverEventEnum EventEnum => BattleObserverEventEnum.AttackBossWeak;

	protected override void OnExecute()
	{
		base.OnExecute();
		Condition.Add(6006, EventTreeConditionParams.Create(weaknessLevel));
		EventTreeEndAction();
	}
}
