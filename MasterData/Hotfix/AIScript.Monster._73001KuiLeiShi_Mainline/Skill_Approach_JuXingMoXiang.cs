using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Approach_JuXingMoXiang : Skill_NengLiangQiuBase
{
	private const string combo_Approach = "JuXingApproach";

	private const string combo_NLQPhase2 = "NLQPhase2";

	private static readonly string[] fromPositionHolders = new string[3] { "JuXingApproach_From_Left", "JuXingApproach_From_Right", "JuXingApproach_From_Up" };

	private static readonly string[] toPositionHolders = new string[3] { "JuXingApproach_To_Left", "JuXingApproach_To_Right", "JuXingApproach_To_Up" };

	private FP approachMoveSpeed = 36;

	private FP pullDelay = 10;

	private FP pullDuration = 5;

	private string fx_pull = "fx_m72012_loop_skill05_gravitational_field_30x30";

	private long playfx_pull;

	private long pullarea;

	private bool finished;

	private CoroutineNode orbCor;

	private CoroutineNode phantomCor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (playfx_pull >= 0)
		{
			StopEffect(playfx_pull);
		}
		playfx_pull = -1L;
		StopSpawnCoroutines();
		if (!finished)
		{
			StopAreaEffect(pullarea);
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_orbId));
			ClearActors(GetTargetByDataID(_phantomId));
			AddBuffToTarget(_actor, 720130108);
			RemoveBuffFromTarget(_actor, 720130107);
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		if (playfx_pull >= 0)
		{
			StopEffect(playfx_pull);
		}
		playfx_pull = -1L;
		StopAreaEffect(pullarea);
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
		StopSpawnCoroutines();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_orbId));
		ClearActors(GetTargetByDataID(_phantomId));
	}

	private void StopSpawnCoroutines()
	{
		if (orbCor != null)
		{
			StopCoroutine(orbCor);
			orbCor = null;
		}
		if (phantomCor != null)
		{
			StopCoroutine(phantomCor);
			phantomCor = null;
		}
	}

	protected override AdventureActor GetBossActor()
	{
		return GetPartnerActor();
	}

	protected override AdventureActor GetEnergyTarget()
	{
		return _actor;
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = (int)(long)GetRandomValue(0, fromPositionHolders.Length, isInt: true);
		TSVector2 fromPos = GetPlaceHolderPosition(fromPositionHolders[num]);
		TSVector2 toPos = GetPlaceHolderPosition(toPositionHolders[num]);
		Teleport(fromPos, checkPositionReachable: false);
		BeginLookAtByPos(new TSVector2(0, 0), default, 1000);
		yield return WaitTime(0.1);
		AddBuffToTarget(_actor, 720130109);
		AddBuffToTarget(_actor, 720130107);
		FP origSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(toPos, 0.2f);
		PlayWwiseSound("mon_72012_move");
		yield return WaitMoveStatus();
		_actor.actorInfo.runSpeed = origSpeed;
		_actor.actorInfo.walkSpeed = origSpeed;
		BeginAttack(1, "NLQPhase2", flushInputedKeys: true);
		orbCor = StartCoroutine(OrbSpawnLoop());
		phantomCor = StartCoroutine(PhantomSpawnLoop());
		yield return WaitTime(pullDelay);
		AdventureActor partnerActor = GetPartnerActor();
		if (partnerActor != null)
		{
			SetLogicTagToggleValue(partnerActor, Config_XiaoMoXiang.NLQ_PullStartTag, value: true);
		}
		playfx_pull = PlayEffect(fx_pull, 1f, default, new TSVector2(0, 0), 180 + GetRotation());
		pullarea = PlayAreaEffect("AreaEffect_72012_Skill5_QianYin", GetPosition(), GetEntityAngle(_actor));
		DispatchCustomEvent("StartPulling", isSelfEvent: false);
		FP pullElapsed = FP.Zero;
		while (GetMonsterSummonNum(_actor, _orbId) != 0)
		{
			yield return WaitTime(0.1);
			pullElapsed += (FP)0.1;
			if (!(pullElapsed >= pullDuration))
			{
				continue;
			}
			foreach (LogicEntity item in GetTargetByDataID(_orbId))
			{
				if (item is AdventureActor adventureActor)
				{
					adventureActor.DestroySelf();
				}
			}
			break;
		}
		yield return WaitTime(0.8f);
		StopEffect(playfx_pull);
		StopAreaEffect(pullarea);
		StopSpawnCoroutines();
		CancelAttack();
		InitNLQState();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtPosition(TSVector2.zero, 1000);
		FP retSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(fromPos, 0.2f);
		yield return WaitMoveStatus();
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
		_actor.actorInfo.runSpeed = retSpeed;
		_actor.actorInfo.walkSpeed = retSpeed;
		CancelAim();
	}

	private AdventureActor GetPartnerActor()
	{
		int dataID = (int)(long)GetLogicTagFpValue(_actor, Config_JuXingMoXiang.PartnerDataIdTag);
		List<LogicEntity> targetByDataID = GetTargetByDataID(dataID);
		if (targetByDataID.Count <= 0)
		{
			return null;
		}
		return targetByDataID.get_Item(0) as AdventureActor;
	}

	protected override void PlayDamageReductionAddedFx(AdventureActor boss)
	{
		if (!(boss == null))
		{
			new PlayFX().Play(boss, boss, "fx_m72011_base_Shield", GetEntityPosition(boss), default, default);
		}
	}
}
