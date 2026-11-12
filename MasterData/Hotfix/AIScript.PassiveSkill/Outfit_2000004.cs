using AIScript.Utils;
using TrueSync;

namespace AIScript.PassiveSkill;

public class Outfit_2000004 : SkillAdvancedBase
{
	private readonly FP _duration = 1.5;

	private readonly int _hitDamageId = 23400022;

	private readonly FP _circleRadius = 1.5;

	private CoroutineNode _finishCoroutine;

	private PassiveSkill_ListenEvent_CircleDamage _circleDamage;

	protected override void OnSkillEnable()
	{
		_finishCoroutine = _actor.StartLogicCoroutine(Finish(_duration));
		if (_circleDamage == null)
		{
			_circleDamage = new PassiveSkill_ListenEvent_CircleDamage();
		}
		_circleDamage.OnEnable(_actor, _skill, _hitDamageId, _circleRadius);
	}

	protected override void OnSkillDisable()
	{
		_circleDamage.OnDisable();
		if (_finishCoroutine != null)
		{
			_actor.StopLogicCoroutine(_finishCoroutine);
			_finishCoroutine = null;
		}
	}
}
