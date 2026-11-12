using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_ParabolaShoot_Artillery : SkillSimpleBase
{
	private string areaEffectName = "AreaEffect_72004_MortarHit";

	private bool isRed;

	private int lv;

	private int phase;

	private AdventureActor summoner;

	private string Color;

	private string BulletName;

	private string Charge01FX;

	private string Charge02FX;

	private string ShootFX;

	private string AreaEffectName;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		ChessInitialize();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity player = GetCurrentPlayer();
		BeginLookAt_NotWait(player, 999, 50);
		BeginAttack(1, "Skill_ParabolaShoot", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Charge01");
		PlayEffect(Charge01FX);
		yield return WaitCustomEvent("Charge02");
		PlayEffect(Charge02FX);
		yield return WaitCustomEvent("Shoot");
		StopWaitLookAt();
		TSVector2 curIndexByPos = Config.GetCurIndexByPos(player.tsTransform.Position);
		TSVector2 cellPosByIndex = Config.GetCellPosByIndex(curIndexByPos.x.AsInt(), curIndexByPos.y.AsInt());
		PlayEffect(ShootFX);
		ILRuntimeAPI.Shoot(BulletName, _actor, default, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5)), 2.7, cellPosByIndex, null, AimType.Position, BulletDirectionType.BulletToTarget);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
		_actor.DestroySelf();
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		BulletName = "Weapon_72004QiZiPao_Parabola_" + Color;
		Charge01FX = "fx_m72004_base_atk2_charge_01_" + Color;
		Charge02FX = "fx_m72004_base_atk2_charge_02_" + Color;
		ShootFX = "fx_m72004_base_atk_shoot_" + Color;
	}
}
