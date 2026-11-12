using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Dash_Back : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyStart = ComboInputBuffer.ActionKey.G;

	private readonly ComboInputBuffer.ActionKey _actionKeyEnd;

	private readonly FP backDistance = 8;

	private readonly FP dashSpeed = 30;

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
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		RequestComboAttack requestComboAttack = BeginAttack(_actionKeyStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		TSVector2 desPos = default;
		if (SearchValidPoint(ref desPos))
		{
			FP fP = backDistance / dashSpeed;
			_actor.Dodge((desPos - _actor.tsTransform.Position).normalized, backDistance, fP, null, null, comboWithAttack: true, canRotate: false);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(fP));
			BeginAttack(_actionKeyEnd, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, () =>
			{
				_skill?.Clear();
			});
		}
		else
		{
			_skill?.Clear();
		}
	}

	private bool SearchValidPoint(ref TSVector2 desPos)
	{
		desPos = _actor.tsTransform.Position - backDistance * _actor.tsTransform.Forward;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		FP angleBase = TSVector2.Angle(-_actor.tsTransform.Forward, TSVector2.up);
		desPos = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, backDistance, backDistance, angleBase, 120);
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, backDistance, backDistance, angleBase, 180);
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = _actor.tsTransform.Position + backDistance * _actor.tsTransform.Forward;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, backDistance, backDistance, 180, 360);
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = TrueSyncExtensions.RandomPointInsideFan(_actor.tsTransform.Position, 6, 10, 180, 360);
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		return false;
	}
}
