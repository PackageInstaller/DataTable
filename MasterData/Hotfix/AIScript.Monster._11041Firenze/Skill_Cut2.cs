using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Cut2 : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _cutStart;

	private readonly ComboInputBuffer.ActionKey _cutEnd;

	private readonly ComboInputBuffer.ActionKey _cut2Start = ComboInputBuffer.ActionKey.B;

	private readonly ComboInputBuffer.ActionKey _cut2End;

	private readonly ComboInputBuffer.ActionKey _DodgeStart = ComboInputBuffer.ActionKey.I;

	private FP cutloopTime = 0;

	private FP cut2loopTime = 0.1;

	private CoroutineNode corMain;

	private CoroutineNode corSkill;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	private readonly AimTarget _aimTarget = new AimTarget();

	private bool isLoop;

	private RequestComboAttack requestComboAttack;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		StopCoroutine(ref corSkill);
		_aimTarget?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		isLoop = false;
		StartCoroutine(ref corSkill, SkillAction(_cutStart, _cutEnd, 0, ComboAttackType.isAnticipationEnd));
		while (!isLoop)
		{
			yield return null;
		}
		isLoop = false;
		StartCoroutine(ref corSkill, SkillAction(_cut2Start, _cut2End, 0, ComboAttackType.isComboFinish));
		while (!isLoop)
		{
			yield return null;
		}
		_skill?.Clear();
	}

	private IEnumerator SkillAction(ComboInputBuffer.ActionKey keyStart, ComboInputBuffer.ActionKey keyEnd, FP loopTime, ComboAttackType comboAttackType)
	{
		bool rotateFinish = false;
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) > 3 && TSRandom.Range(0, 100) > 30)
		{
			_actor.EnableImmuneControl();
			_actor.PauseMovementBlock();
			target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
			{
				rotateFinish = true;
			});
			while (!rotateFinish)
			{
				yield return null;
			}
			requestComboAttack = BeginAttack(_DodgeStart, flushInputedKeys: true);
			while (!requestComboAttack.isComboFinish)
			{
				yield return null;
			}
			_actor.DisableImmuneControl();
			_actor.ResumeMovementBlock();
		}
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(keyStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(loopTime));
		requestComboAttack = BeginAttack(keyEnd);
		if (comboAttackType != ComboAttackType.isAnticipationEnd)
		{
			if (comboAttackType == ComboAttackType.isRecoveryBegin)
			{
				while (!requestComboAttack.isRecoveryBegin)
				{
					yield return null;
				}
			}
			else
			{
				while (!requestComboAttack.isComboFinish)
				{
					yield return null;
				}
			}
		}
		else
		{
			while (!requestComboAttack.isAnticipationEnd)
			{
				yield return null;
			}
		}
		isLoop = true;
	}
}
