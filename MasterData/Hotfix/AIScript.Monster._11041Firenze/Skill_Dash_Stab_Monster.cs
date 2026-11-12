using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Dash_Stab_Monster : SkillAdvancedBase
{
	private enum DashStatus
	{
		Running,
		Complete,
		DashPlay,
		DashObstacle
	}

	private readonly ComboInputBuffer.ActionKey _actionKeyA = ComboInputBuffer.ActionKey.F;

	private readonly ComboInputBuffer.ActionKey _actionKeyB = ComboInputBuffer.ActionKey.B;

	private readonly FP Stab2loopTime = 0.3;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	private CoroutineNode corMain;

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
		requestComboAttack = BeginAttack(_actionKeyA, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Stab2loopTime));
		requestComboAttack = BeginAttack(_actionKeyB);
		FP fP = TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) + 3;
		_ = (target.tsTransform.Position - _actor.tsTransform.Position).normalized;
		FP speed = fP / 0.07f;
		Dash dash = new Dash();
		DashStatus dashStatus = DashStatus.Running;
		dash.BeginDash(_actor, _actor.tsTransform.Forward, speed, fP, 1, () =>
		{
			dashStatus = DashStatus.Complete;
		}, () =>
		{
			dashStatus = DashStatus.DashPlay;
		}, () =>
		{
			dashStatus = DashStatus.DashObstacle;
		}, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_skill?.Clear();
	}

	private void Finish()
	{
		_skill?.Clear();
	}
}
