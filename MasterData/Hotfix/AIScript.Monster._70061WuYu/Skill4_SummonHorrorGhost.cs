using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill4_SummonHorrorGhost : SkillSimpleBase
{
	private const string ComboKey = "Skill4_SummonHorrorGhost";

	private const string TeleportPlace = "SummonHorroGhostPosition";

	private const string FinalExplosionEvent = "SummonStart";

	private const string CloseExplosionAlias = "AreaEffect_70061WuYu_Skill4_Blast_Center";

	private const string OuterRingAlias = "AreaEffect_70061WuYu_Skill4_Blast_Ring_L";

	private const string MiddleRingAlias = "AreaEffect_70061WuYu_Skill4_Blast_Ring_M";

	private const string InnerRingAlias = "AreaEffect_70061WuYu_Skill4_Blast_Ring_S";

	private const string LoopStartFxAlias = "fx_70061_Loop_Attack04_Start";

	private static readonly FP LoopStartDelay = 0.15;

	private static readonly FP LoopStartSpawnSize = 1.6;

	private static readonly FP PerfumeStartDelay = 0.5;

	private const string PerfumeStartFxAlias = "fx_70061_base_Attack04_Start";

	private const string PerfumeLoopFxAlias = "fx_70061_Loop_Attack04_perfume";

	private static readonly FP PerfumeLoopDelay = 0.85;

	private static readonly FP DetonateDelay = 0.25;

	private const string MagicCircleFxAlias = "fx_70061_loop_Attack04_MagicCircle_big";

	private static readonly FP MagicCircleDelay = 2;

	private static readonly FP MagicCircleWait = 1;

	private static readonly FP CloseExplosionWarningDelay = 1.5;

	private static readonly FP LookAtDuration = 0.5;

	private static readonly FP LookAtRotateSpeed = 360;

	private static readonly FP ExplosionInterval = 2;

	private static readonly FP CloseToRingDelay = 0.8;

	private static readonly string[] _ringAliases = new string[3] { "AreaEffect_70061WuYu_Skill4_Blast_Ring_L", "AreaEffect_70061WuYu_Skill4_Blast_Ring_M", "AreaEffect_70061WuYu_Skill4_Blast_Ring_S" };

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: false);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: false);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: true);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("SummonHorroGhostPosition");
		TSVector2 centerPos = GetPlaceHolderPosition("CenterPoint");
		SetHideModelEnable();
		Teleport(placeHolderPosition);
		Skill4_SummonHorrorGhost skill4_SummonHorrorGhost = this;
		TSVector2 position = placeHolderPosition;
		skill4_SummonHorrorGhost.PlayEffect("fx_70061WuYu_base_dodge_born", 1f, default, position);
		yield return WaitTime(Skill11_BroomDodge.Delay);
		SetHideModelDisable();
		BeginLookAtByDir_NotWait(TSVector2.down, LookAtDuration, LookAtRotateSpeed);
		BeginAttack(99, "Dodge", flushInputedKeys: true, forceInterruptAttack: true);
		DispatchBossBottleClearEvent();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(0, "Skill4_SummonHorrorGhost", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(LoopStartDelay);
		Skill4_SummonHorrorGhost skill4_SummonHorrorGhost2 = this;
		float spawnSize = LoopStartSpawnSize.AsFloat();
		position = GetPosition();
		long loopStartFxId = skill4_SummonHorrorGhost2.PlayEffect("fx_70061_Loop_Attack04_Start", 1f, default, position, default, spawnSize);
		yield return WaitTime(PerfumeStartDelay);
		PlayEffect("fx_70061_base_Attack04_Start", 1f, default, centerPos);
		yield return WaitTime(PerfumeLoopDelay);
		long perfumeLoopFxId = PlayEffect("fx_70061_Loop_Attack04_perfume", 1f, default, centerPos);
		yield return WaitTime(DetonateDelay);
		int count = _ringAliases.Length;
		for (int i = 0; i < count; i++)
		{
			StartCor(ExplodeRound(i, centerPos));
			if (i < count - 1)
			{
				yield return WaitTime(ExplosionInterval);
			}
		}
		yield return WaitTime(MagicCircleDelay);
		long magicCircleFxId = PlayEffect("fx_70061_loop_Attack04_MagicCircle_big", 1f, default, centerPos);
		yield return WaitTime(MagicCircleWait);
		CancelAttack();
		yield return WaitCustomEvent("SummonStart");
		PlayAreaEffect("AreaEffect_70061WuYu_Skill4_Blast_Center", centerPos, FP.Zero);
		yield return WaitTime(CloseExplosionWarningDelay);
		StopEffect(perfumeLoopFxId);
		StopEffect(loopStartFxId);
		StopEffect(magicCircleFxId);
		int num = GetLogicTagFpValue(_actor, "FullSkillPhase").AsInt();
		bool logicTagToggleValue = GetLogicTagToggleValue(_actor, "DoubleHorrorTagId");
		bool WaitLongTime = false;
		if ((num > 1) | logicTagToggleValue)
		{
			SummonTeammate(4, centerPos, TSVector2.down, 2);
			WaitLongTime = true;
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (WaitLongTime)
		{
			yield return WaitTime(2.5);
		}
		else
		{
			yield return WaitTime(1.5);
		}
	}

	private void DispatchBossBottleClearEvent()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventName = "WuYu_BossBottleClear";
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private IEnumerator ExplodeRound(int roundIndex, TSVector2 center)
	{
		PlayAreaEffect("AreaEffect_70061WuYu_Skill4_Blast_Center", center, FP.Zero);
		yield return WaitTime(CloseToRingDelay);
		PlayAreaEffect(_ringAliases[roundIndex], center, FP.Zero);
	}
}
