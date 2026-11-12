using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.MageGhost;

public class Skill2_Boom : SkillSimpleBase
{
	private const string ComboKeyP1 = "Boom";

	private const string ComboKeyP2 = "Boom_Plus";

	private const string BaseFxAlias = "fx_m70061_base_BoomGhost_Attack01_01";

	private const string EarlyWarningFxAlias = "fx_common_base_Dark_YuJing_circular_3";

	private static readonly FP FxStartDelay = 0.3;

	private static readonly FP LoopEndAdvanceStop = 0.2;

	private static readonly FP ChargeTime = 3;

	private static readonly FP FxRate = 0.75;

	private static readonly FP DeathHideWaitTime = 5;

	private bool _success;

	private long EarlyWarningFxId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_success = false;
		_actor.EnableImmuneControl();
		SetLogicTagToggleValue(_actor, "MageGhost_DeathWordStarted", value: true);
		SetBlockPriorityToStatic();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableImmuneControl();
		if (_success && _actor.actorHealthInfo.isAlive)
		{
			_actor.ClearMonsterSelf();
		}
		StopEffect(EarlyWarningFxId);
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = GetSummonerPhase();
		AdventureActor summoner = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (num < 2 && GetLogicTagToggleValue(summoner, "FastExplodeTagId"))
		{
			num = 2;
		}
		string actionKey = ((num >= 2) ? "Boom_Plus" : "Boom");
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(FxStartDelay);
		Skill2_Boom skill2_Boom = this;
		Skill2_Boom skill2_Boom2 = this;
		float duration = ChargeTime.AsFloat();
		TSVector2 position = GetPosition();
		float spawnSize = FxRate.AsFloat();
		skill2_Boom.EarlyWarningFxId = skill2_Boom2.PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_3", duration, default, position, default, spawnSize);
		yield return WaitTime(ChargeTime - LoopEndAdvanceStop);
		Skill2_Boom skill2_Boom3 = this;
		position = GetPosition();
		spawnSize = FxRate.AsFloat();
		skill2_Boom3.PlayEffect("fx_m70061_base_BoomGhost_Attack01_01", 1f, default, position, default, spawnSize);
		yield return WaitTime(LoopEndAdvanceStop);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_success = true;
		PerfumeHelper.AddPerfumeToSummoner(summoner, AIScript.Monster._70061WuYu.MageGhost.Action.PerfumeGain);
		SetLogicTagToggleValue(_actor, "PerfumeHasAddedTag", value: true);
		_actor.EnableHideModel();
		_actor.EnableCloseBlock();
		_actor.EnableUnparalleled();
		yield return WaitTime(DeathHideWaitTime);
		_actor.ClearMonsterSelf();
	}

	private int GetSummonerPhase()
	{
		AdventureActor adventureActor = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (adventureActor == null)
		{
			return 1;
		}
		int num = GetLogicTagFpValue(adventureActor, "Phase").AsInt();
		if (num < 1)
		{
			num = 1;
		}
		return num;
	}
}
