#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_FA : JinDuanLiRongSkillBase
{
	private string diffusionBubble = "50601JinDuanLiRong_DiffusionBubble";

	private string sound = "mon_50601_JC2_greencircle";

	private string areaEffect = "RepelExplosiveRing";

	private string fbxFire = "fx_common_base_Fire_YuJing_circular_8";

	private List<LogicEntity> teamMateList = new List<LogicEntity>();

	private List<long> fxList = new List<long>();

	private long weapondieFx;

	private CoroutineNode RingCor;

	private CoroutineNode ScoreCor;

	private int aiType;

	private bool interrupt;

	private readonly string decorativeRib = "fx_50601JinDuanLiRong_loop_FA_shuizi_Area";

	private long ribFxID;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.FA.开始");
		aiType = GetAiType();
		interrupt = true;
	}

	protected override void OnSkillDisable()
	{
		if (interrupt)
		{
			StopCor(ScoreCor);
			SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag2, value: false);
		}
		if (fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
		StopCor(RingCor);
		teamMateList.Clear();
		fxList.Clear();
		teamMateList.AddRange(GetTargetByTeammateIndexes(new List<int> { 2, 3, 4 }));
		if (teamMateList.Count > 0 && teamMateList != null)
		{
			for (int j = 0; j < teamMateList.Count; j++)
			{
				SetLogicTagToggleValue(teamMateList.get_Item(j), "Stop", value: true);
			}
		}
		StopEffect(ribFxID);
		ModelNodeShow("comb", isShow: true);
		ModelNodeShow("clipper", isShow: true);
		ModelNodeShow("drier", isShow: true);
		NovaLogger.Debug("禁断丽容.FA.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayWwiseSound("mon_50601_transform2");
		yield return StartCor(Switch());
		yield return StartCor(Return());
		BeginAttack(JinDuanLiRongSkillBase.FAIndex, JinDuanLiRongSkillBase.FAKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_common_warning_square_3side_2x17.5_start", 1f, default, TSVector2.zero, GetTSVectToAngle(TSVector2.left, 0));
		PlayEffect("fx_common_warning_square_3side_2x17.5_start", 1f, default, TSVector2.zero, GetTSVectToAngle(TSVector2.right, 0));
		ribFxID = PlayEffect(decorativeRib, 1f, default, TSVector2.zero);
		yield return WaitTime(0.5);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		FASummonMate();
		if (aiType == 3)
		{
			ScoreCor = StartCor(ScoreCheck());
		}
		for (int i = 0; i < fxList.Count; i++)
		{
			StopEffect(fxList.get_Item(i));
		}
		yield return WaitTime(2);
		RingCor = StartCor(ExplosiveRing());
		yield return WaitTime(10);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		teamMateList.AddRange(GetTargetByTeammateIndexes(new List<int> { 2, 3, 4 }));
		for (int j = 0; j < teamMateList.Count; j++)
		{
			SetLogicTagToggleValue(teamMateList.get_Item(j), "Stop", value: true);
		}
		StopCor(ScoreCor);
		interrupt = false;
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag2, value: false);
		StopEffect(ribFxID);
	}

	private void FASummonMate()
	{
		NovaLogger.Debug("禁断丽容.FA技能.召唤梳子");
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag2, value: true);
		SummonTeammate(2, new TSVector2(-2, 0), new TSVector2(1, 0));
		SummonTeammate(2, new TSVector2(2, 0), new TSVector2(-1, 0));
		SummonTeammate(3, new TSVector2(-8, 0), new TSVector2(7, 0));
		SummonTeammate(3, new TSVector2(8, 0), new TSVector2(-7, 0));
		SummonTeammate(4, new TSVector2(-13.5, 0), new TSVector2(12.5, 0));
		SummonTeammate(4, new TSVector2(13.5, 0), new TSVector2(-12.5, 0));
	}

	private IEnumerator Switch()
	{
		BeginAttack(JinDuanLiRongSkillBase.SwitchIndex, JinDuanLiRongSkillBase.SwitchKey, flushInputedKeys: true, forceInterruptAttack: true);
		weapondieFx = PlayEffect("fx_50601JinDuanLiRong_base_JC_weapondie");
		yield return WaitTime(0.5);
		ModelNodeShow("comb", isShow: false);
		ModelNodeShow("clipper", isShow: false);
		ModelNodeShow("drier", isShow: false);
	}

	private IEnumerator Return()
	{
		BeginAttack(JinDuanLiRongSkillBase.ReturnIndex, JinDuanLiRongSkillBase.ReturnKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetHideModelEnable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		yield return WaitTime(1);
		Teleport(TSVector2.zero);
		SetHideModelDisable();
		SetSearchedImmunityDisable();
		SetCloseBlockDisable();
		SetUnparalleledDisable();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (GetAiType() == 1)
		{
			yield return WaitTime(0.5);
		}
	}

	private IEnumerator ExplosiveRing()
	{
		for (int i = 0; i < 3; i++)
		{
			fxList.Add(PlayEffect(fbxFire, 0.3f, default, TSVector2.zero));
			yield return WaitTime(3.6);
			PlayAreaEffect(areaEffect, GetPosition(), GetRotation());
			int num = 1;
			int bulletCount = 36;
			FP angle = 360;
			for (int j = 0; j < num; j++)
			{
				TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / num * j);
				FanMultipleShoot(diffusionBubble, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 8);
				PlayWwiseSound(sound);
			}
			yield return WaitTime(0.5);
		}
	}

	private IEnumerator ScoreCheck()
	{
		yield return WaitTime(2);
		while (true)
		{
			yield return StartCor(ScoreLogicTag2());
			yield return WaitTime(0.4);
		}
	}
}
