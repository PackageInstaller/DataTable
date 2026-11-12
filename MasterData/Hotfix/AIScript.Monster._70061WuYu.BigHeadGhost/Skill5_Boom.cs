using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Skill5_Boom : SkillSimpleBase
{
	private const string ComboKey = "Skill5_Boom";

	private const string AreaEvent = "areaEvent";

	private const string FieldAreaAliasP1 = "AreaEffect_70061WuYu_BigHeadGhost_BoomArea";

	private const string FieldAreaAliasP2 = "AreaEffect_70061WuYu_BigHeadGhost_BoomArea_Plus";

	private const string BaseFxAlias = "fx_m70061_base_BoomGhost_Attack01_01";

	private const string ChargeFxAlias = "fx_common_base_charge_monster_2";

	private const string EarlyWarningFxAlias = "fx_common_base_Dark_YuJing_circular_3";

	private static readonly FP ChargeTime = 2;

	private static readonly FP LoopEndAdvanceStop = 0.2;

	private static readonly FP BaseFxSpawnSizeP1 = 0.75;

	private static readonly FP BaseFxSpawnSizeP2 = 1.25;

	private static readonly FP ChargeFxRateP1 = 0.75;

	private static readonly FP ChargeFxRateP2 = 1.25;

	private static readonly FP ChargeFxPositionY = 1;

	private static readonly FP FieldInterval = 5;

	private const int FieldCount = 6;

	private static readonly FP FieldStartAdvance = 2;

	private static readonly FP FieldSpawnInterval = 0;

	private static readonly FP DeathHideWaitTime = 5;

	private bool _success;

	private long EarlyWarningFxId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_success = false;
		_actor.EnableImmuneControl();
		SetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted", value: true);
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
		AdventureActor summoner = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		int num = ((!(summoner != null)) ? 1 : GetLogicTagFpValue(summoner, "Phase").AsInt());
		if (num < 2 && GetLogicTagToggleValue(summoner, "FastExplodeTagId"))
		{
			num = 2;
		}
		string FieldAreaAlias = "AreaEffect_70061WuYu_BigHeadGhost_BoomArea";
		FP BaseFxSpawnSize = BaseFxSpawnSizeP1;
		FP ChargeFxRate = ChargeFxRateP1;
		if (num >= 2)
		{
			FieldAreaAlias = "AreaEffect_70061WuYu_BigHeadGhost_BoomArea_Plus";
			BaseFxSpawnSize = BaseFxSpawnSizeP2;
			ChargeFxRate = ChargeFxRateP2;
		}
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		BeginAttack(0, "Skill5_Boom", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Skill5_Boom skill5_Boom = this;
		Skill5_Boom skill5_Boom2 = this;
		float duration = ChargeTime.AsFloat();
		TSVector2 position = GetPosition();
		float spawnSize = BaseFxSpawnSize.AsFloat();
		skill5_Boom.EarlyWarningFxId = skill5_Boom2.PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_3", duration, default, position, default, spawnSize);
		yield return WaitTime(ChargeTime - LoopEndAdvanceStop);
		Skill5_Boom skill5_Boom3 = this;
		spawnSize = BaseFxSpawnSize.AsFloat();
		position = GetPosition();
		skill5_Boom3.PlayEffect("fx_m70061_base_BoomGhost_Attack01_01", 1f, default, position, default, spawnSize);
		PlayEffect("fx_common_base_charge_monster_2", 1f, spawnSize: ChargeFxRate.AsFloat(), fxPositionY: ChargeFxPositionY, position: GetPosition());
		yield return WaitTime(LoopEndAdvanceStop);
		CancelAttack();
		yield return WaitCustomEvent("areaEvent");
		PlayAreaEffect(FieldAreaAlias, GetPosition(), FP.Zero);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_success = true;
		PerfumeHelper.AddPerfumeToSummoner(summoner, AIScript.Monster._70061WuYu.BigHeadGhost.Action.PerfumeGain);
		SetLogicTagToggleValue(_actor, "PerfumeHasAddedTag", value: true);
		_actor.EnableHideModel();
		_actor.EnableCloseBlock();
		_actor.EnableUnparalleled();
		yield return WaitTime(DeathHideWaitTime);
		_actor.ClearMonsterSelf();
	}
}
