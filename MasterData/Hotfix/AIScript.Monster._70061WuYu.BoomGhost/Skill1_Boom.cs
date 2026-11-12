using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BoomGhost;

public class Skill1_Boom : SkillSimpleBase
{
	private const string ComboKeyP1 = "Skill1_Boom";

	private const string ComboKeyP2 = "Skill1_Boom_Plus";

	private const string BaseFxAlias = "fx_m70061_base_BoomGhost_Attack01_01";

	private const string EarlyWarningFxAlias = "fx_common_base_Dark_YuJing_circular_3";

	private const string ChargeFxAlias = "fx_common_base_charge_monster_2";

	private static readonly FP ChargeFxRate = 0.75;

	private static readonly FP FxStartDelay = 0.3;

	private static readonly FP LoopEndAdvanceStop = 0.2;

	private static readonly FP ChargeTime = 3;

	private static readonly FP DeathHideWaitTime = 2;

	private static readonly FP FxRateP1 = 0.75;

	private static readonly FP FxRateP2 = 1;

	private bool _success;

	private long EarlyWarningFxId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_success = false;
		_actor.EnableImmuneControl();
		SetLogicTagToggleValue(_actor, "BoomGhost_DeathWordStarted", value: true);
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
		AdventureActor entity = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (num < 2 && GetLogicTagToggleValue(entity, "FastExplodeTagId"))
		{
			num = 2;
		}
		string actionKey = ((num >= 2) ? "Skill1_Boom_Plus" : "Skill1_Boom");
		float scale = ((num >= 2) ? FxRateP2 : FxRateP1).AsFloat();
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(FxStartDelay);
		Skill1_Boom skill1_Boom = this;
		Skill1_Boom skill1_Boom2 = this;
		float duration = ChargeTime.AsFloat();
		TSVector2 position = GetPosition();
		skill1_Boom.EarlyWarningFxId = skill1_Boom2.PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_3", duration, default, position, default, scale);
		yield return WaitTime(ChargeTime - LoopEndAdvanceStop);
		Skill1_Boom skill1_Boom3 = this;
		float spawnSize = scale;
		position = GetPosition();
		skill1_Boom3.PlayEffect("fx_m70061_base_BoomGhost_Attack01_01", 1f, default, position, default, spawnSize);
		Skill1_Boom skill1_Boom4 = this;
		spawnSize = ChargeFxRate.AsFloat();
		position = GetPosition();
		skill1_Boom4.PlayEffect("fx_common_base_charge_monster_2", 1f, default, position, default, spawnSize);
		yield return WaitTime(LoopEndAdvanceStop);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_success = true;
		PerfumeHelper.AddPerfumeToSummoner(GetSummoner(), AIScript.Monster._70061WuYu.BoomGhost.Action.PerfumeGain);
		SetLogicTagToggleValue(_actor, "PerfumeHasAddedTag", value: true);
		_actor.EnableHideModel();
		_actor.EnableCloseBlock();
		_actor.EnableUnparalleled();
		yield return WaitTime(DeathHideWaitTime);
		_actor.ClearMonsterSelf();
	}

	private int GetSummonerPhase()
	{
		LogicEntity summoner = GetSummoner();
		if (summoner == null)
		{
			return 1;
		}
		int num = GetLogicTagFpValue(summoner, "Phase").AsInt();
		if (num < 1)
		{
			num = 1;
		}
		return num;
	}

	private LogicEntity GetSummoner()
	{
		return _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
	}
}
