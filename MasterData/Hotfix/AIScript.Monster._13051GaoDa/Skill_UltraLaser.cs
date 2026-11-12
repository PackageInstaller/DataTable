using System.Collections;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_UltraLaser : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Ultra_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private static readonly string FlashBeforeShoot = "UltraSkill_FlashBeforeShoot";

	private static readonly string Warning1 = "UltraSkill_Warning1";

	private static readonly string Warning2 = "UltraSkill_Warning2";

	private static readonly string Attack = "UltraSkill_Attack";

	private static readonly string ChargeStart = "UltraSKill_ChargeStart";

	private static readonly string Warning_Charging = "UltraSkill_Warning_Charging";

	private static readonly FP shootDuration = 4;

	private CoroutineNode hitCoroutineNode;

	private long Warning1_LoopFX;

	private long ChargeFX;

	private FP Difficulty;

	private FP UltraSkillTimes;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref hitCoroutineNode);
		StopEffect(Warning1_LoopFX);
		StopEffect(ChargeFX);
		if (Difficulty == 3)
		{
			SetLogicTagStringValue(GetTargetByTeammateIndex(4).get_Item(0), "AttackMessage", "");
			SetLogicTagStringValue(GetTargetByTeammateIndex(5).get_Item(0), "AttackMessage", "");
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		UltraSkillTimes = GetLogicTagFpValue(_actor, "UltraSkillTimes");
		BeginAttack(1, Ultra_Combo, flushInputedKeys: true);
		PlayEffect(Warning2);
		TSVector2 Warning_FXPos = new TSVector2(0, -32.2);
		if (GetMonsterTagValue(_actor, 1) == "ChenShaAct")
		{
			Warning_FXPos = GetPlaceHolderPosition("UltraWarningLoopFXPos");
		}
		PlayEffect(Warning1, 1f, default, Warning_FXPos);
		yield return WaitTime(1);
		Warning1_LoopFX = PlayEffect(Warning_Charging, 1f, default, Warning_FXPos);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		ChargeFX = PlayEffect(ChargeStart);
		StartCor(SendMessageToPhantom(4, "LeftPhantomAttack"));
		yield return WaitTime(3.35);
		BeginAttack(2, Ultra_Combo);
		yield return WaitTime(0.5);
		StopEffect(ChargeFX);
		PlayEffect(FlashBeforeShoot);
		StopEffect(Warning1_LoopFX);
		yield return WaitTime(0.35);
		long attackFX = PlayEffect(Attack);
		StartCoroutine(ref hitCoroutineNode, ContinueHit());
		StartCor(SendMessageToPhantom(5, "RightPhantomAttack"));
		yield return WaitTime(shootDuration);
		StopEffect(attackFX);
		StopCoroutine(ref hitCoroutineNode);
		BeginAttack(3, Ultra_Combo);
		if (Difficulty == 3 && UltraSkillTimes % 2 == 0)
		{
			SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.right, 4);
			SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.left, 4);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SendSkillFinishMessage();
		SetLogicTagFpValue(_actor, "UltraSkillTimes", UltraSkillTimes + 1);
	}

	private void SendSkillFinishMessage()
	{
		AdventureMonsterGundamMessage adventureMonsterGundamMessage = AdventureMonsterGundamMessage.Generate();
		adventureMonsterGundamMessage.monsterId = _actor.Id;
		adventureMonsterGundamMessage.operationType = "masterAOELaserSkillFinish";
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterGundamMessage);
	}

	private IEnumerator ContinueHit()
	{
		while (true)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, GetPosition(), 11, 100);
			Skill_UltraLaser skill_UltraLaser = this;
			FP knockBackForce = 10;
			FP knockBackDistance = 2;
			FP stiffDuration = 0.3;
			FP hitStrenth = 4;
			HitFeatureData hitFeatureData = skill_UltraLaser.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: true, default, null, null, stiffDuration, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 13051041, 0.5, HitBox.HurtAnimType.Small, "HitByLaser");
			yield return null;
		}
	}

	private IEnumerator SendMessageToPhantom(int index, string message)
	{
		if (GetTargetByTeammateIndex(4).Count * GetTargetByTeammateIndex(5).Count != 0)
		{
			SetLogicTagStringValue(GetTargetByTeammateIndex(index).get_Item(0), "AttackMessage", message);
			yield return WaitTime(0.2);
			SetLogicTagStringValue(GetTargetByTeammateIndex(index).get_Item(0), "AttackMessage", "");
		}
	}
}
