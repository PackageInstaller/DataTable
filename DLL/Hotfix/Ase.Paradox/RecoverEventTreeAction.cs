using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("注册黑板变量绑定事件--回复", 0)]
[Category("EventTree")]
[Description("行为树黑板可以根据战斗内事件改变")]
public class RecoverEventTreeAction : BaseEventTreeAction
{
	[Name("技能ID", 0)]
	public int skillId;

	[Name("恢复", 0)]
	public BBParameter<EventTreeConditionParams> recover;

	public override BattleObserverEventEnum EventEnum => BattleObserverEventEnum.InteractiveStart;

	protected override void OnExecute()
	{
		base.OnExecute();
		Condition.Add(6002, EventTreeConditionParams.Create(skillId));
		Condition.Add(8003, recover.value);
		EventTreeEndAction();
	}
}
