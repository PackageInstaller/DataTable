#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_FloorBreak_Strong : SkillSimpleBase
{
	private int FBIndex = 1;

	private string FBKey = "FloorBreak";

	private int RepulseIndex = 2;

	private string RepulseKey = "Repulse_Attack_02";

	private int cellSize = 8;

	private TSVector2 offset = new TSVector2(12, 12);

	private int border = 24;

	private Dictionary<int, TSVector2> allfloorPOS = new Dictionary<int, TSVector2>
	{
		{
			0,
			new TSVector2(-8, 8)
		},
		{
			1,
			new TSVector2(0, 8)
		},
		{
			2,
			new TSVector2(8, 8)
		},
		{
			3,
			new TSVector2(-8, 0)
		},
		{
			4,
			new TSVector2(0, 0)
		},
		{
			5,
			new TSVector2(8, 0)
		},
		{
			6,
			new TSVector2(-8, -8)
		},
		{
			7,
			new TSVector2(0, -8)
		},
		{
			8,
			new TSVector2(8, -8)
		}
	};

	private Dictionary<TSVector2, string> floorWarningFxList = new Dictionary<TSVector2, string>
	{
		{
			new TSVector2(-8, 8),
			"fx_m17510_loop_Skill07_Floor01g_Waring_red"
		},
		{
			new TSVector2(0, 8),
			"fx_m17510_loop_Skill07_Floor01h_Waring_red"
		},
		{
			new TSVector2(8, 8),
			"fx_m17510_loop_Skill07_Floor01i_Waring_red"
		},
		{
			new TSVector2(-8, 0),
			"fx_m17510_loop_Skill07_Floor01d_Waring_red"
		},
		{
			new TSVector2(0, 0),
			"fx_m17510_loop_Skill07_Floor01e_Waring_red"
		},
		{
			new TSVector2(8, 0),
			"fx_m17510_loop_Skill07_Floor01f_Waring_red"
		},
		{
			new TSVector2(-8, -8),
			"fx_m17510_loop_Skill07_Floor01a_Waring_red"
		},
		{
			new TSVector2(0, -8),
			"fx_m17510_loop_Skill07_Floor01b_Waring_red"
		},
		{
			new TSVector2(8, -8),
			"fx_m17510_loop_Skill07_Floor01c_Waring_red"
		}
	};

	private Dictionary<TSVector2, string> floorActive_FxList = new Dictionary<TSVector2, string>
	{
		{
			new TSVector2(-8, 8),
			"fx_m17510_loop_Skill07_Floor01g_Waring"
		},
		{
			new TSVector2(0, 8),
			"fx_m17510_loop_Skill07_Floor01h_Waring"
		},
		{
			new TSVector2(8, 8),
			"fx_m17510_loop_Skill07_Floor01i_Waring"
		},
		{
			new TSVector2(-8, 0),
			"fx_m17510_loop_Skill07_Floor01d_Waring"
		},
		{
			new TSVector2(0, 0),
			"fx_m17510_loop_Skill07_Floor01e_Waring"
		},
		{
			new TSVector2(8, 0),
			"fx_m17510_loop_Skill07_Floor01f_Waring"
		},
		{
			new TSVector2(-8, -8),
			"fx_m17510_loop_Skill07_Floor01a_Waring"
		},
		{
			new TSVector2(0, -8),
			"fx_m17510_loop_Skill07_Floor01b_Waring"
		},
		{
			new TSVector2(8, -8),
			"fx_m17510_loop_Skill07_Floor01c_Waring"
		}
	};

	private string effect_FloorStart = "fx_m17510_base_Skill07_Floor_start";

	private string effect_Warning = "fx_m17510_loop_Skill05_warning";

	private string effect_SelectWarn = "fx_m17510_loop_Skill07_SelectFloor_Waring";

	private TSVector2 nearestPos;

	private List<TSVector2> safePos = new List<TSVector2>();

	private List<long> warningFxList = new List<long>();

	private List<long> fxIDList = new List<long>();

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopFXList(fxIDList);
		StopFXList(warningFxList);
		safePos.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(FBIndex, FBKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		SetBattleOutEnable();
		SetHideModelEnable();
		TriggerOpLisener("DeActiveObstruct");
		yield return StartCor(FloorBreak());
		GetTagSafePos();
		StartCor(SideWarningFx());
		yield return WaitTime(1);
		CancelAttack();
		SetBattleOutDisable();
		SetHideModelDisable();
		TriggerOpLisener("ActiveObstruct");
		yield return WaitTime(0.75);
		BeginAttack(RepulseIndex, RepulseKey, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(SideAttack());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator FloorBreak()
	{
		ActivatedFloor();
		Dictionary<int, TSVector2> floorPos = GetTagSafePos();
		int num = GetLogicTagFpValue(_actor, "CastTime").AsInt();
		int indexX = ((num % 2 == 0) ? GetCurPos() : GetNearestPos());
		for (int i = 0; i < 3; i++)
		{
			int key = indexX + i * 3;
			if (floorPos.TryGetValue(key, out var value))
			{
				long item = PlayEffect(effect_SelectWarn, 0.5f, 0.7, value, 0);
				fxIDList.Add(item);
			}
		}
		yield return WaitTime(2);
		StopFXList(fxIDList);
		NovaLogger.Debug("咕噜海兔.最终距离玩家最近的坐标为 列:" + indexX);
		for (int j = 0; j < 3; j++)
		{
			int key2 = indexX + j * 3;
			if (floorPos.TryGetValue(key2, out var value2))
			{
				PlayWarningFx(value2);
			}
		}
		yield return WaitTime(1);
		SetLogicTagFpValue(_actor, "updateIndex", indexX);
		yield return WaitTime(0.1);
		StopFXList(fxIDList);
		InformClone();
		for (int k = 0; k < 3; k++)
		{
			int key3 = indexX + k * 3;
			if (floorPos.TryGetValue(key3, out var value3))
			{
				DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, value3, 8, 8);
				Skill_FloorBreak_Strong skill_FloorBreak_Strong = this;
				FP hitStrenth = 2;
				HitFeatureData hitFeatureData = skill_FloorBreak_Strong.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
				AreaHit_Simple(GetMonsterCloner(), shapeData, hitFeatureData, 17510071, 1, HitBox.HurtAnimType.Small, "fx_common_hit_water_strike");
			}
		}
	}

	private void ActivatedFloor()
	{
		Dictionary<int, TSVector2> tagSafePos = GetTagSafePos();
		if (tagSafePos != null && tagSafePos.Count > 0)
		{
			foreach (KeyValuePair<int, TSVector2> item in tagSafePos)
			{
				TSVector2 tSVector = new TSVector2(item.Value.x, item.Value.y);
				string fxAlias;
				if (floorActive_FxList.TryGetValue(tSVector, out var value))
				{
					fxAlias = value;
				}
				else
				{
					NovaLogger.Debug("咕噜海兔.破坏地板.地板激活特效异常");
					fxAlias = floorActive_FxList.get_Item(new TSVector2(-8, 8));
				}
				fxIDList.Add(PlayEffect(fxAlias, 1f, 0.7, tSVector));
			}
			PlayEffect(effect_FloorStart, 1f, 0.7, TSVector2.zero, 0);
		}
		else
		{
			NovaLogger.Debug("咕噜海兔.破坏地板.获取安全地板失败");
		}
	}

	private void PlayWarningFx(TSVector2 targetPos)
	{
		string fxAlias;
		if (floorWarningFxList.TryGetValue(targetPos, out var value))
		{
			fxAlias = value;
		}
		else
		{
			NovaLogger.Debug("咕噜海兔.破坏地板.红色预警特效筛选异常");
			fxAlias = "fx_m17510_loop_Skill07_Floor01g_Waring_red";
		}
		fxIDList.Add(PlayEffect(fxAlias, 1f, 0.7, targetPos));
	}

	private IEnumerator SideWarningFx()
	{
		PlayWwiseSound("mon_17510_warning_2period");
		Dictionary<int, TSVector2> dictionary = new Dictionary<int, TSVector2>();
		if (GetTagSafePos() != null && GetTagSafePos().Count > 0)
		{
			foreach (KeyValuePair<int, TSVector2> tagSafePo in GetTagSafePos())
			{
				dictionary.Add(tagSafePo.Key, new TSVector2(tagSafePo.Value.x, tagSafePo.Value.y));
			}
		}
		foreach (KeyValuePair<int, TSVector2> item in dictionary)
		{
			warningFxList.Add(PlayEffect(effect_Warning, 1f, 0.7, new TSVector2(item.Value.x, item.Value.y), GetTSVectToAngle(GetForward(), 0)));
		}
		NovaLogger.Debug("咕噜海兔推出击退特效");
		yield break;
	}

	private IEnumerator SideAttack()
	{
		for (int i = 0; i < warningFxList.Count; i++)
		{
			StopEffect(warningFxList.get_Item(i));
		}
		PlayFeedbackEffect("CameraShake_BanShenShu_Flap");
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TSVector2.zero, 25, 25);
		Skill_FloorBreak_Strong skill_FloorBreak_Strong = this;
		FP knockBackForce = 50;
		FP knockBackDistance = 11;
		FP hitStrenth = 5;
		HitFeatureData hitFeatureData = skill_FloorBreak_Strong.GetHitFeatureData(HitBox.FeatureFlag.KnockBack, knockBackForce, knockBackDistance, UseAtttackForward: true, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510021, 1, HitBox.HurtAnimType.Large);
		Dictionary<int, TSVector2> dictionary = new Dictionary<int, TSVector2>();
		if (GetTagSafePos() != null && GetTagSafePos().Count > 0)
		{
			foreach (KeyValuePair<int, TSVector2> tagSafePo in GetTagSafePos())
			{
				dictionary.Add(tagSafePo.Key, new TSVector2(tagSafePo.Value.x, tagSafePo.Value.y));
			}
		}
		foreach (KeyValuePair<int, TSVector2> item in dictionary)
		{
			warningFxList.Add(PlayEffect("fx_m17510_bullet_Skill5_wave", 1f, 0.7, item.Value, GetTSVectToAngle(GetForward(), 0)));
		}
		yield break;
	}

	private void InformClone()
	{
		SetLogicTagToggleValue(_actor, "IsCloneUpdatePos", value: true);
		NovaLogger.Debug("咕噜海兔.场景破坏.通知分身获取安全区");
	}

	protected Dictionary<int, TSVector2> GetTagSafePos()
	{
		return GetLogicTagDicIntTSVector2Value(_actor, "safeFloor");
	}

	protected int GetCurPos()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		entityPositionObsoleted.x = TSMath.Clamp(entityPositionObsoleted.x + offset.x, 0, border);
		entityPositionObsoleted.y = TSMath.Clamp(offset.y - entityPositionObsoleted.y, 0, border);
		return Mathf.Clamp(TSMath.FloorToInt(entityPositionObsoleted.x / cellSize), 0, 2);
	}

	protected int GetNearestPos()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		entityPositionObsoleted.x = TSMath.Clamp(entityPositionObsoleted.x + offset.x, 0, border);
		entityPositionObsoleted.y = TSMath.Clamp(offset.y - entityPositionObsoleted.y, 0, border);
		int num = TSMath.FloorToInt(entityPositionObsoleted.x / cellSize);
		if (entityPositionObsoleted.x - num * cellSize <= cellSize / 2)
		{
			return Mathf.Clamp(--num, 0, 2);
		}
		return Mathf.Clamp(++num, 0, 2);
	}

	private void StopFXList(List<long> fxList)
	{
		if ((fxList != null) & (fxList.Count > 0))
		{
			for (int i = 0; i < fxList.Count; i++)
			{
				StopEffect(fxList.get_Item(i));
			}
		}
		fxList.Clear();
	}
}
