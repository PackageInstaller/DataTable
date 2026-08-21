using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("注册黑板变量绑定事件--受击", 0)]
[Category("EventTree")]
[Description("行为树黑板可以根据战斗内事件改变")]
public class HitEventTreeAction : BaseEventTreeAction
{
	[Name("伤害是否来自技能", 0)]
	public bool isDamageFromSkill;

	[Name("技能ID", 0)]
	[ShowIf("isDamageFromSkill", true)]
	public int skillId;

	[Name("伤害数值有条件", 0)]
	public bool isOverDamage;

	[Name("伤害数值", 0)]
	[ShowIf("isOverDamage", true)]
	public BBParameter<EventTreeConditionParams> overDamage;

	[Name("弱点等级有条件", 0)]
	public bool isWeaknessLevel;

	[Name("弱点等级", 0)]
	[ShowIf("isWeaknessLevel", true)]
	public int weaknessLevel;

	[Name("子弹标签筛选", 0)]
	public bool bulletLabelFilter;

	[Name("子弹标签", 0)]
	[ShowIf("bulletLabelFilter", true)]
	public string bulletLabel;

	public override BattleObserverEventEnum EventEnum => BattleObserverEventEnum.Hit;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (isDamageFromSkill)
		{
			Condition.Add(6002, EventTreeConditionParams.Create(skillId));
		}
		if (isOverDamage)
		{
			Condition.Add(8002, overDamage.value);
		}
		if (isWeaknessLevel)
		{
			Condition.Add(6006, EventTreeConditionParams.Create(weaknessLevel));
		}
		if (bulletLabelFilter && !string.IsNullOrEmpty(bulletLabel))
		{
			Condition.Add(6015, EventTreeConditionParamsString.Create(bulletLabel));
		}
		EventTreeEndAction();
	}
}
