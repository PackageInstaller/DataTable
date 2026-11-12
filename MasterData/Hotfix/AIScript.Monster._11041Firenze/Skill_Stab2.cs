using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Stab2 : SkillAdvancedBase
{
	private enum DashStatus
	{
		Running,
		Complete,
		DashPlay,
		DashObstacle
	}

	private readonly ComboInputBuffer.ActionKey _StabStart = ComboInputBuffer.ActionKey.E;

	private readonly ComboInputBuffer.ActionKey _StabEnd;

	private readonly ComboInputBuffer.ActionKey _Stab2Start = ComboInputBuffer.ActionKey.F;

	private readonly ComboInputBuffer.ActionKey _Stab2End;

	private readonly FP StabloopTime = 0;

	private readonly FP Stab2loopTime = 0.4;

	private CoroutineNode corMain;

	private CoroutineNode corSkill;

	private LookAtTarget _lookAtTarget = new LookAtTarget();

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
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_aimTarget.Aim(_actor, target.GetComponent<AdventureActor>());
		requestComboAttack = BeginAttack(_StabStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(StabloopTime));
		_aimTarget.Cancel();
		requestComboAttack = BeginAttack(_StabEnd);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		requestComboAttack = BeginAttack(_Stab2Start, flushInputedKeys: true);
		_aimTarget.Aim(_actor, target.GetComponent<AdventureActor>());
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Stab2loopTime));
		_aimTarget.Cancel();
		requestComboAttack = BeginAttack(_Stab2End);
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
}
