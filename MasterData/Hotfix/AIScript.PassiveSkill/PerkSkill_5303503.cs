using AdventureBehaviour;
using TrueSync;

namespace AIScript.PassiveSkill;

public class PerkSkill_5303503 : SkillAdvancedBase
{
	private readonly int _hitDamageId = 5303501;

	private readonly FP _circleRadius = 3;

	protected override void OnSkillEnable()
	{
		CommomAreaHitConfig commomAreaHitConfig = new CommomAreaHitConfig();
		commomAreaHitConfig.hitDamageId = _hitDamageId;
		commomAreaHitConfig.position = _actor.tsTransform.Position;
		ILRuntimeAPI.CircleAreaHit(_actor, commomAreaHitConfig, _circleRadius, 0);
		_skill.Clear();
	}
}
