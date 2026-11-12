using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Common;

public class Skill_Wait : SkillAdvancedBase
{
	protected readonly FP minRotateAngle = 10;

	protected readonly FP minRotateTime = 0.5f;

	protected CoroutineNode _lookAtTargetCoroutine;

	protected LookAtTarget _lookAtTarget;

	public void OnStart()
	{
		LogicEntity monsterTarget = _actor.monsterTarget;
		if (monsterTarget != null)
		{
			TSVector2 normalized = (monsterTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			if (TSVector2.Angle(_actor.tsTransform.Forward, normalized) >= minRotateAngle)
			{
				_lookAtTargetCoroutine = _actor.StartLogicCoroutine(LookAtTarget());
			}
			else
			{
				_skill.Clear();
			}
		}
		else
		{
			_skill.Clear();
		}
	}

	private IEnumerator LookAtTarget()
	{
		FP lookAtTime = 0;
		while (true)
		{
			LogicEntity monsterTarget = _actor.monsterTarget;
			if (monsterTarget != null)
			{
				if (_lookAtTarget == null)
				{
					_lookAtTarget = new LookAtTarget();
				}
				_lookAtTarget.BeginLookAt(_actor, monsterTarget, 0, _actor.actorInfo.moveRotationSpeed, null);
				lookAtTime += _actor.LogicDeltaTime;
				TSVector2 normalized = (monsterTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				if (TSVector2.Angle(_actor.tsTransform.Forward, normalized) < minRotateAngle && lookAtTime >= minRotateTime)
				{
					_skill.Clear();
					break;
				}
				yield return null;
				continue;
			}
			_skill.Clear();
			break;
		}
		_lookAtTarget?.StopLookAt();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_lookAtTargetCoroutine != null)
		{
			_actor.StopLogicCoroutine(_lookAtTargetCoroutine);
			_lookAtTargetCoroutine = null;
		}
		_lookAtTarget?.StopLookAt();
		_lookAtTarget?.Clear();
	}
}
