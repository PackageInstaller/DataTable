#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_PointRepulse : SkillSimpleBase
{
	private List<long> fxIDList = new List<long>();

	private List<TSVector2> fxPOSList = new List<TSVector2>();

	private readonly List<TSVector2> atkPOSList = new List<TSVector2>
	{
		TSVector2.up,
		TSVector2.right,
		TSVector2.down,
		TSVector2.left
	};

	private readonly int start01Index;

	private readonly string start01Key = "FRepulse_Start";

	private readonly int start02Index = 1;

	private readonly string start02Key = "Wave";

	private readonly string[,] warningFx = new string[3, 3]
	{
		{ "fx_m17510_loop_Skill05_warning", "fx_m17510_loop_Skill06_warning_center", "fx_m17510_loop_Skill05_warning" },
		{ "fx_m17510_loop_Skill06_warning_30", "fx_m17510_loop_Skill05_warning", "fx_m17510_loop_Skill06_warning_30" },
		{ "fx_m17510_loop_Skill06_warning_45", "fx_m17510_loop_Skill05_warning", "fx_m17510_loop_Skill06_warning_45" }
	};

	private readonly string[,] attackFx = new string[3, 3]
	{
		{ "fx_m17510_bullet_Skill5_wave", "fx_m17510_base_Skill06_attack", "fx_m17510_bullet_Skill5_wave" },
		{ "fx_m17510_bullet_Skill6_wave_30", "fx_m17510_bullet_Skill5_wave", "fx_m17510_bullet_Skill6_wave_30" },
		{ "fx_m17510_bullet_Skill6_wave_45", "fx_m17510_bullet_Skill5_wave", "fx_m17510_bullet_Skill6_wave_45" }
	};

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.定点击退.开始");
	}

	protected override void OnSkillDisable()
	{
		for (int i = 0; i < fxIDList.Count; i++)
		{
			StopEffect(fxIDList.get_Item(i));
		}
		fxPOSList.Clear();
		fxIDList.Clear();
		NovaLogger.Debug("咕噜海兔.定点击退.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(start01Index, start01Key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		TSVector2 atkForward = atkPOSList.get_Item((int)(long)GetRandomValue(0, 3.5, isInt: true));
		TSVector2 atkPOS = new TSVector2(atkForward.x * 8, atkForward.y * 8);
		TSVector2 tSVector = atkPOS;
		NovaLogger.Debug("咕噜海兔选择的攻击坐标点为" + tSVector.ToString());
		WarningFx(atkPOS, atkForward, warningFx);
		TriggerOpLisener("DeActiveObstruct");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(start02Index, start02Key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		for (int i = 0; i < fxIDList.Count; i++)
		{
			StopEffect(fxIDList.get_Item(i));
		}
		fxIDList.Clear();
		WarningFx(atkPOS, atkForward, attackFx);
		PlayAreaEffect("POSRepulse", atkPOS);
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, atkPOS, 8, 8);
		Skill_PointRepulse skill_PointRepulse = this;
		FP hitStrenth = 5;
		HitFeatureData hitFeatureData = skill_PointRepulse.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510041, 1, HitBox.HurtAnimType.Large, "fx_common_hit_water_strike");
		yield return WaitTime(3);
		TriggerOpLisener("ActiveObstruct");
	}

	protected void WarningFx(TSVector2 beginPOS, TSVector2 forward, string[,] fxArray)
	{
		PlayWwiseSound("mon_17510_warning_3period");
		fxPOSList.Add(TransLocalPosToWorldPos(beginPOS, forward, new TSVector2(-8, 0)));
		fxPOSList.Add(TransLocalPosToWorldPos(beginPOS, forward, TSVector2.zero));
		fxPOSList.Add(TransLocalPosToWorldPos(beginPOS, forward, new TSVector2(8, 0)));
		for (int i = 0; i < 6; i++)
		{
			fxPOSList.Add(TransLocalPosToWorldPos(fxPOSList.get_Item(i), forward, new TSVector2(0, -8)));
		}
		int j = 0;
		int num = 0;
		for (; j < 3; j++)
		{
			int num2 = 0;
			while (num2 < 3)
			{
				if (j == 0)
				{
					fxIDList.Add(PlayEffect(fxArray[j, num2], 1f, 0.7, fxPOSList.get_Item(num), GetTSVectToAngle(forward, 90 + 90 * num2)));
				}
				else
				{
					fxIDList.Add(PlayEffect(fxArray[j, num2], 1f, 0.7, fxPOSList.get_Item(num), GetTSVectToAngle(forward, Mathf.Clamp(90 + 90 * num2, 90, 180))));
				}
				num2++;
				num++;
			}
		}
	}
}
