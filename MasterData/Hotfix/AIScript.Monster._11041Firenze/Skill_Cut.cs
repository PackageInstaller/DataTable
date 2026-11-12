using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Cut : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyStart;

	private readonly FP loopTime = 0;

	private readonly ComboInputBuffer.ActionKey _DodgeStart = ComboInputBuffer.ActionKey.I;

	private CoroutineNode corMain;

	private CoroutineNode corSkill;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	private readonly AimTarget _aimTarget = new AimTarget();

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
		_aimTarget?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		FP fP = TSVector2.Distance(_actor.tsTransform.Position, activedPlayerActor.tsTransform.Position);
		bool rotateFinish = false;
		if (fP >= 2)
		{
			_actor.EnableImmuneControl();
			_actor.PauseMovementBlock();
			activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, 0, 3600, () =>
			{
				rotateFinish = true;
			});
			while (!rotateFinish)
			{
				yield return null;
			}
			RequestComboAttack requestComboAttack1 = BeginAttack(_DodgeStart, flushInputedKeys: true);
			while (!requestComboAttack1.isAnticipationEnd)
			{
				yield return null;
			}
			_actor.DisableImmuneControl();
			_actor.ResumeMovementBlock();
		}
		activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		RequestComboAttack requestComboAttack2 = BeginAttack(_actionKeyStart, flushInputedKeys: true);
		while (!requestComboAttack2.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(loopTime));
		requestComboAttack2 = BeginAttack(_actionKeyStart);
		while (!requestComboAttack2.isComboFinish)
		{
			yield return null;
		}
		_skill?.Clear();
	}
}
