#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_SwitchArms2JC : JinDuanLiRongSkillBase
{
	private bool tornadoATKState;

	private int aiType;

	private List<LogicEntity> teamMateList = new List<LogicEntity>();

	private CoroutineNode ChosePOSCor;

	private CoroutineNode SummonCor;

	private long repelAreaFx;

	private List<long> fxList = new List<long>();

	private List<TSVector2> summonPOSList1 = new List<TSVector2>();

	private List<TSVector2> summonPOSList2 = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.切换武装.开始");
		tornadoATKState = true;
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
		StopCor(ChosePOSCor);
		StopCor(SummonCor);
		teamMateList.Clear();
		summonPOSList1.Clear();
		summonPOSList2.Clear();
		NovaLogger.Debug("禁断丽容.切换武装.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayWwiseSound("mon_50601_transform");
		yield return StartCor(Return());
		aiType = GetAiType();
		if (aiType < 2)
		{
			yield return WaitTime(0.5);
		}
		yield return StartCor(AttackJC());
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopAreaEffect(repelAreaFx);
		if (aiType == 3)
		{
			while (tornadoATKState)
			{
				yield return WaitTime(0.2);
			}
		}
	}

	protected IEnumerator AttackJC()
	{
		int phaseTag = (int)(long)GetLogicTagFpValue(_actor, "CurrentPhase");
		BeginAttack(JinDuanLiRongSkillBase.JCATKIndex, JinDuanLiRongSkillBase.JCATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		ChosePOSCor = StartCor(TornadoAttack());
		switch (aiType)
		{
		case 0:
		case 1:
		case 2:
			switch ((int)(long)GetLogicTagFpValue(_actor, "RepelAreaType"))
			{
			case 0:
				repelAreaFx = PlayAreaEffect("RepelArea", GetPosition(), GetRotation());
				break;
			case 1:
				repelAreaFx = PlayAreaEffect("RepelArea_Weak", GetPosition(), GetRotation());
				break;
			default:
				repelAreaFx = PlayAreaEffect("RepelArea", GetPosition(), GetRotation());
				break;
			}
			break;
		case 3:
			if (phaseTag >= 2)
			{
				repelAreaFx = PlayAreaEffect("RepelArea", GetPosition(), GetRotation());
			}
			else
			{
				repelAreaFx = PlayAreaEffect("RepelArea_Weak", GetPosition(), GetRotation());
			}
			break;
		}
		int times = ((GetAiType() != 3) ? 4 : 3);
		if (aiType < 2)
		{
			for (int i = 0; i < times; i++)
			{
				if (i == 0 || i == times - 1)
				{
					yield return StartCor(AreaATK());
				}
				else
				{
					yield return WaitTime(2.5);
				}
			}
		}
		else if (aiType == 2)
		{
			for (int i = 0; i < times; i++)
			{
				yield return StartCor(AreaATK());
			}
		}
		else
		{
			if (aiType != 3)
			{
				yield break;
			}
			for (int i = 0; i < times; i++)
			{
				if (phaseTag == 1)
				{
					if (i == 0 || i == 2)
					{
						yield return StartCor(AreaATK());
					}
					else
					{
						yield return WaitTime(2.5);
					}
				}
				else
				{
					yield return StartCor(AreaATK());
				}
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
		SetSearchedImmunityDisable();
		SetCloseBlockDisable();
		SetUnparalleledDisable();
		CancelAttack();
		ModelNodeShow("comb", isShow: false);
		ModelNodeShow("clipper", isShow: true);
		ModelNodeShow("drier", isShow: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator TornadoAttack()
	{
		List<TSVector2> summonList = new List<TSVector2>();
		summonPOSList1 = new List<TSVector2>
		{
			new TSVector2(0, 5),
			new TSVector2(0, -5),
			new TSVector2(5, 0),
			new TSVector2(-5, 0)
		};
		summonPOSList2 = new List<TSVector2>
		{
			RotateTo(new TSVector2(0, 5), 45),
			RotateTo(new TSVector2(0, -5), 45),
			RotateTo(new TSVector2(5, 0), 45),
			RotateTo(new TSVector2(-5, 0), 45)
		};
		for (int i = 0; i < 2; i++)
		{
			if (i == 0)
			{
				summonList.AddRange(summonPOSList1);
				SetLogicTagToggleValue(_actor, "IsLeftMove", value: true);
			}
			else
			{
				summonList.AddRange(summonPOSList2);
				SetLogicTagToggleValue(_actor, "IsLeftMove", value: false);
			}
			for (int j = 0; j < summonList.Count; j++)
			{
				SummonTeammate(5, summonList.get_Item(j), summonList.get_Item(j) - TSVector2.zero);
			}
			if (aiType == 3)
			{
				yield return WaitTime(4);
				StartCor(ScoreLogicTag1());
				yield return WaitTime(2.2);
			}
			else
			{
				yield return WaitTime(3.5);
			}
			summonList.Clear();
		}
		tornadoATKState = false;
	}

	private IEnumerator AreaATK()
	{
		fxList.Add(PlayEffect("fx_common_base_Fire_YuJing_circular_8", 0.5f, default, TSVector2.zero));
		yield return WaitTime(2.2);
		PlayAreaEffect("RepelExplosiveRing", GetPosition(), GetRotation());
		int num = 1;
		int bulletCount = 36;
		FP angle = 360;
		for (int i = 0; i < num; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / num * i);
			FanMultipleShoot("50601JinDuanLiRong_DiffusionBubble", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 8);
			PlayWwiseSound("mon_50601_JC2_greencircle");
		}
	}
}
