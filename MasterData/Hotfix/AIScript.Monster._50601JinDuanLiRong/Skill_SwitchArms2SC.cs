#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_SwitchArms2SC : JinDuanLiRongSkillBase
{
	private int aiType;

	private List<LogicEntity> teamMateList = new List<LogicEntity>();

	private CoroutineNode SCAreaAttackCor;

	private long weapondieFx;

	private long repelAreaFx;

	private List<long> fxList = new List<long>();

	private List<TSVector2> summonPOSList = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.切换武装.开始");
		teamMateList.AddRange(GetTargetByTeammateIndexes(new List<int> { 2, 3, 4, 5, 6 }));
		for (int i = 0; i < teamMateList.Count; i++)
		{
			SetLogicTagToggleValue(teamMateList.get_Item(i), "Stop", value: true);
		}
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, In_CheckBossScro_Tag1, value: false);
		if (fxList.Count > 0)
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
		fxList.Clear();
		StopAreaEffect(repelAreaFx);
		summonPOSList.Clear();
		StopCor(SCAreaAttackCor);
		teamMateList.Clear();
		NovaLogger.Debug("禁断丽容.切换武装.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		NovaLogger.Debug("禁断丽容.梳子吹风机连击.返回场中");
		PlayWwiseSound("mon_50601_transform");
		PlayWwiseSound("mon_50601_transform2");
		yield return StartCor(Return());
		NovaLogger.Debug("禁断丽容.梳子吹风机连击.变身");
		aiType = GetAiType();
		if (aiType < 2)
		{
			yield return WaitTime(0.5);
		}
		yield return StartCor(AttackSC());
		CancelAttack();
		PlayEffect("fx_common_base_Fire_YuJing_circular_8", 0.4f, default, GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return StartCor(SCFinalAttack());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator AttackSC()
	{
		BeginAttack(JinDuanLiRongSkillBase.JCATKIndex, JinDuanLiRongSkillBase.JCATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		int num = (int)(long)GetLogicTagFpValue(_actor, "CurrentPhase");
		switch (aiType)
		{
		case 0:
		case 1:
		case 2:
			switch ((int)(long)GetLogicTagFpValue(_actor, "AttractAreaType"))
			{
			case 0:
				repelAreaFx = PlayAreaEffect("AttractArea", GetPosition(), GetRotation());
				break;
			case 1:
				repelAreaFx = PlayAreaEffect("AttractArea_Weak", GetPosition(), GetRotation());
				break;
			default:
				repelAreaFx = PlayAreaEffect("AttractArea", GetPosition(), GetRotation());
				break;
			}
			break;
		case 3:
			if (num >= 2)
			{
				repelAreaFx = PlayAreaEffect("AttractArea", GetPosition(), GetRotation());
			}
			else
			{
				repelAreaFx = PlayAreaEffect("AttractArea_Weak", GetPosition(), GetRotation());
			}
			break;
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetLogicTagToggleValue(_actor, "IsLeftMove", value: false);
		if (aiType < 2)
		{
			SCAreaAttackCor = StartCor(SCAreaAttack());
		}
		else if (aiType > 1 && GetMonsterTagValue(_actor, 1) != "BossRush")
		{
			fxList.Add(PlayEffect("fx_common_base_Fire_YuJing_circular_5", 0.5f, default, TSVector2.zero));
			yield return WaitTime(2.2);
			SCAreaAttackCor = StartCor(SCAreaAttack());
		}
		int times = ((aiType != 3) ? 5 : 3);
		FP distance = 5;
		FP fP = 0.8;
		if (aiType < 2)
		{
			distance -= fP;
		}
		for (int i = 0; i < times; i++)
		{
			if (aiType > 1)
			{
				if (i == 0 || i % 2 == 0)
				{
					summonPOSList = new List<TSVector2>
					{
						new TSVector2(0, distance),
						new TSVector2(0, -distance),
						new TSVector2(distance, 0),
						new TSVector2(-distance, 0)
					};
					SetLogicTagToggleValue(_actor, "IsLeftMove", value: true);
				}
				else
				{
					summonPOSList = new List<TSVector2>
					{
						RotateTo(new TSVector2(0, distance), 45),
						RotateTo(new TSVector2(0, -distance), 45),
						RotateTo(new TSVector2(distance, 0), 45),
						RotateTo(new TSVector2(-distance, 0), 45)
					};
					SetLogicTagToggleValue(_actor, "IsLeftMove", value: false);
				}
			}
			else if (i == 0 || i % 2 == 0)
			{
				summonPOSList = new List<TSVector2>
				{
					new TSVector2(0, distance),
					RotateTo(new TSVector2(0, distance), 120),
					RotateTo(new TSVector2(0, distance), -120)
				};
				SetLogicTagToggleValue(_actor, "IsLeftMove", value: true);
			}
			else
			{
				summonPOSList = new List<TSVector2>
				{
					new TSVector2(0, -distance),
					RotateTo(new TSVector2(0, -distance), 120),
					RotateTo(new TSVector2(0, -distance), -120)
				};
				SetLogicTagToggleValue(_actor, "IsLeftMove", value: false);
			}
			StartCor(Summon());
			yield return WaitTime(2.2);
		}
		yield return WaitTime(2.4);
		if (SCAreaAttackCor != null)
		{
			StopCor(SCAreaAttackCor);
		}
		StopAreaEffect(repelAreaFx);
	}

	protected IEnumerator SCSwitch()
	{
		BeginAttack(JinDuanLiRongSkillBase.JCSwitchIndex, JinDuanLiRongSkillBase.JCSwitchKey, flushInputedKeys: true, forceInterruptAttack: true);
		weapondieFx = PlayEffect("fx_50601JinDuanLiRong_base_JC_weapondie", 1f, default, default, default, 1f, actorScale: true);
		fxList.Add(weapondieFx);
		yield return WaitTime(1);
		ModelNodeShow("clipper", isShow: false);
		yield return WaitTime(0.85);
		StopEffect(weapondieFx);
		ModelNodeShow("comb", isShow: true);
		ModelNodeShow("drier", isShow: true);
		yield return WaitTime(0.9);
		yield return null;
	}

	protected IEnumerator SCAreaAttack()
	{
		if (aiType < 2)
		{
			for (int i = 0; i < 3; i++)
			{
				PlayAreaEffect("AttractExplosiveRing_warningFx", TSVector2.zero, 0);
				yield return WaitTime(5);
			}
		}
		else if (GetMonsterTagValue(_actor, 1) != "BossRush")
		{
			for (int i = 0; i < 1000; i++)
			{
				PlayAreaEffect("AttractExplosiveRing", GetPosition(), GetRotation());
				yield return WaitTime(0.7);
			}
		}
	}

	protected IEnumerator Return()
	{
		BeginAttack(JinDuanLiRongSkillBase.SwitchArmsnIndex, JinDuanLiRongSkillBase.SwitchArmsKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetSearchedImmunityEnable();
		SetUnparalleledEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetHideModelEnable();
		SetCloseBlockEnable();
		yield return WaitTime(1);
		Teleport(TSVector2.zero);
		BeginLookAtByPos_NotWait(TSVector2.down, 0.1, 1800);
		SetHideModelDisable();
		SetCloseBlockDisable();
		CancelAttack();
		ModelNodeShow("clipper", isShow: false);
		ModelNodeShow("comb", isShow: true);
		ModelNodeShow("drier", isShow: true);
		yield return WaitTime(1.9);
		SetUnparalleledDisable();
		SetSearchedImmunityDisable();
		PlayEffect("fx_50601JinDuanLiRong_base_B_Switch_shuizi01", 1f, default, GetPosition(), GetRotation());
		PlayEffect("fx_50601JinDuanLiRong_base_B_Switch_shuizi02", 1f, default, GetPosition(), GetRotation());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Summon()
	{
		for (int i = 0; i < summonPOSList.Count; i++)
		{
			fxList.Add(PlayEffect("fx_common_base_Fire_YuJing_circular_2", 0.5f, default, summonPOSList.get_Item(i), GetTSVectToAngle(summonPOSList.get_Item(i) - TSVector2.zero, 0)));
		}
		yield return WaitTime(2.2);
		for (int j = 0; j < summonPOSList.Count; j++)
		{
			SummonTeammate(1, summonPOSList.get_Item(j), summonPOSList.get_Item(j) - TSVector2.zero);
		}
		if (aiType == 3)
		{
			StartCor(ScoreLogicTag1());
		}
	}

	protected IEnumerator SCFinalAttack()
	{
		BeginAttack(JinDuanLiRongSkillBase.GeneralIndex, JinDuanLiRongSkillBase.GeneralKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.3);
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		PlayEffect("fx_50601JinDuanLiRong_base_JC_Bullet_hit", 1f, default, GetPosition());
		int num = 1;
		int bulletCount = 36;
		FP angle = 360;
		for (int i = 0; i < num; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / num * i);
			FanMultipleShoot("50601JinDuanLiRong_DiffusionBubble", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 8);
			PlayWwiseSound("mon_50601_JC2_greencircle");
		}
		StartCor(Damage());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 1; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 8);
			Skill_SwitchArms2SC skill_SwitchArms2SC = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_SwitchArms2SC.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601091, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return WaitTime(0.1);
		}
		yield return null;
	}
}
