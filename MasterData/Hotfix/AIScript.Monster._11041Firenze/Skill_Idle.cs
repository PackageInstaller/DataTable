using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Idle : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyA;

	private readonly FP loopTime = 2;

	private CoroutineNode corMain;

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
		TSVector2 desPos = default;
		if (SearchValidPoint(ref desPos))
		{
			rotateFinish = false;
			_lookAtTarget.BeginLookAtByPos(_actor, desPos, 0, 3600, () =>
			{
				rotateFinish = true;
			});
			while (!rotateFinish)
			{
				yield return null;
			}
			BeginAttack(_actionKeyA, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, target);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(loopTime));
		}
		_skill?.Clear();
	}

	private bool SearchValidPoint(ref TSVector2 desPos)
	{
		desPos = _actor.tsTransform.Position + TSRandom.Range(2.0, 4.0) * _actor.tsTransform.Left;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = _actor.tsTransform.Position + TSRandom.Range(2.0, 4.0) * _actor.tsTransform.Right;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		return false;
	}
}
