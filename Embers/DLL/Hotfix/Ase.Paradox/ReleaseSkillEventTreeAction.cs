using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("注册黑板变量绑定事件--释放技能", 0)]
[Category("EventTree")]
[Description("行为树黑板可以根据战斗内事件改变")]
public class ReleaseSkillEventTreeAction : BaseEventTreeAction
{
	[Name("技能ID", 0)]
	public int skillId;

	[Name("技能类型有限制", 0)]
	public bool isLimitSkillType;

	[Name("技能类型", 0)]
	[ShowIf("isLimitSkillType", true)]
	public HeroSkillTypeEnum skillType;

	public override BattleObserverEventEnum EventEnum => BattleObserverEventEnum.ReleaseSkill;

	protected override void OnExecute()
	{
		base.OnExecute();
		Condition.Add(6002, EventTreeConditionParams.Create(skillId));
		if (isLimitSkillType)
		{
			Condition.Add(6004, EventTreeConditionParams.Create((float)skillType));
		}
		EventTreeEndAction();
	}
}
