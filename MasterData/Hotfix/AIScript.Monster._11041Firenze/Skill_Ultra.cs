using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Ultra : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyA = ComboInputBuffer.ActionKey.J;

	private ComboInputBuffer.ActionKey _actionKeyB = ComboInputBuffer.ActionKey.Z;

	private readonly ComboInputBuffer.ActionKey _actionKeyC = ComboInputBuffer.ActionKey.Z;

	private readonly ComboInputBuffer.ActionKey _actionKeyD;

	private FP loopTime = 1;

	private readonly TSVector2 desPos = new TSVector2(0, 0);

	protected LogicVariable _logicVariable;

	private CoroutineNode corMain;

	private CoroutineNode corSkill;

	private LookAtTarget _lookAtTarget = new LookAtTarget();

	private readonly AimTarget _aimTarget = new AimTarget();

	private readonly PlayFX playFX = new PlayFX();

	private readonly PlayFX playFX_fog = new PlayFX();

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
		playFX.Stop();
		playFX_fog.Stop();
		StopCoroutine(ref corSkill);
		StopCoroutine(ref corMain);
		_aimTarget?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		_logicVariable = ActorHelper.GetFlowLogicVariable(_actor.gameObject);
		_actor.EnableImmuneControl();
		_actor.PauseMovementBlock();
		_actor.Teleport(desPos);
		RequestComboAttack requestComboAttack = BeginAttack(_actionKeyA, flushInputedKeys: true);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		new PlayMonsterTimeline().Play(_actor);
		requestComboAttack = BeginAttack(_actionKeyC, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		playFX.Play(_actor, _skill, "fx_screen_dark", 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		playFX_fog.Play(_actor, _skill, "fx_m11041_change_fog", 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		StartCoroutine(ref corSkill, DoSkillLogic());
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(5));
		playFX.Stop();
		playFX_fog.Stop();
		requestComboAttack = BeginAttack(_actionKeyD);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_actor.DisableImmuneControl();
		_actor.ResumeMovementBlock();
		_skill?.Clear();
	}

	private IEnumerator DoSkillLogic()
	{
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		FP angleBase = TSVector2.Angle(-target.tsTransform.Forward, TSVector2.up);
		FP distance = 3;
		int time = ((_actor.actorHealthInfo.hp < 40) ? 20 : 10);
		FP interval = 0.5;
		for (int i = 0; i < time; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideFan(target.tsTransform.Position, distance, distance, angleBase, 270);
			TSVector2 normalized = (tSVector - target.tsTransform.Position).normalized;
			ILRuntimeAPI.SummonMonster(_actor, 0, 1100404, tSVector, normalized);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval));
		}
	}
}
