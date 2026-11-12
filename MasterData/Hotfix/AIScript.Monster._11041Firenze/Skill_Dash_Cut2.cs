using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Dash_Cut2 : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyStart = ComboInputBuffer.ActionKey.H;

	private readonly ComboInputBuffer.ActionKey _actionKeyA;

	private readonly ComboInputBuffer.ActionKey _cutStart;

	private readonly ComboInputBuffer.ActionKey _cutEnd;

	private readonly ComboInputBuffer.ActionKey _cut2Start = ComboInputBuffer.ActionKey.B;

	private readonly ComboInputBuffer.ActionKey _cut2End;

	private readonly ComboInputBuffer.ActionKey _DodgeStart = ComboInputBuffer.ActionKey.I;

	private readonly FP distance = 1;

	private readonly FP cutloopTime = 0;

	private readonly FP cut2loopTime = 0.1;

	private CoroutineNode corMain;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	private readonly AimTarget _aimTarget = new AimTarget();

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
		_aimTarget?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		bool rotateFinish = false;
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		while (!rotateFinish)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_actionKeyStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_actionKeyA);
		TSVector2 desPos = default;
		SearchValidPoint(ref desPos);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_actor.Teleport(desPos);
		rotateFinish = false;
		target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_cutStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(cutloopTime));
		requestComboAttack = BeginAttack(_cutEnd);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		if (TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) >= 2 && TSRandom.Range(0, 100) > 30)
		{
			_actor.EnableImmuneControl();
			_actor.PauseMovementBlock();
			rotateFinish = false;
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
		target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_cut2Start, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(cut2loopTime));
		requestComboAttack = BeginAttack(_cut2End);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_skill?.Clear();
	}

	private bool SearchValidPoint(ref TSVector2 desPos)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		desPos = activedPlayerActor.tsTransform.Position - distance * activedPlayerActor.tsTransform.Forward;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = TrueSyncExtensions.RandomPointInsideFan(activedPlayerActor.tsTransform.Position, 0.25, 0.5, 180, 360);
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = activedPlayerActor.tsTransform.Position;
		return true;
	}
}
