#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_FloorBreak : SkillSimpleBase
{
	private int FBIndex = 1;

	private string FBKey = "FloorBreak";

	private int RepulseIndex = 2;

	private string RepulseKey = "Repulse_Attack_02";

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
		NovaLogger.Debug("咕噜海兔.场景破坏.开始");
	}

	protected override void OnSkillDisable()
	{
		StopFXList(fxIDList);
		StopFXList(warningFxList);
		safePos.Clear();
		NovaLogger.Debug("咕噜海兔.场景破坏.结束");
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
		yield return StartCor(PlayerSelectionTipsCor());
		StopFXList(fxIDList);
		TSVector2 tSVector = nearestPos;
		NovaLogger.Debug("咕噜海兔.最终距离玩家最近的坐标为" + tSVector.ToString());
		PlayWarningFx(nearestPos);
		yield return WaitTime(1);
		int nearstPosIndex = GetNearstPosIndex(nearestPos);
		SetLogicTagFpValue(_actor, "updateIndex", nearstPosIndex);
		yield return WaitTime(0.1);
		StopFXList(fxIDList);
		InformClone();
		TSVector2 position = nearestPos;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, 8, 8);
		Skill_FloorBreak skill_FloorBreak = this;
		FP hitStrenth = 2;
		HitFeatureData hitFeatureData = skill_FloorBreak.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(GetMonsterCloner(), shapeData, hitFeatureData, 17510071, 1, HitBox.HurtAnimType.Small, "fx_common_hit_water_strike");
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
		Skill_FloorBreak skill_FloorBreak = this;
		FP knockBackForce = 50;
		FP knockBackDistance = 11;
		FP hitStrenth = 5;
		HitFeatureData hitFeatureData = skill_FloorBreak.GetHitFeatureData(HitBox.FeatureFlag.KnockBack, knockBackForce, knockBackDistance, UseAtttackForward: true, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
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

	private IEnumerator PlayerSelectionTipsCor()
	{
		TSVector2 position = GetNearestPos();
		long selectionFx = PlayEffect(effect_SelectWarn, 0.5f, 0.7, position, 0);
		fxIDList.Add(selectionFx);
		TSVector2 savePos = (nearestPos = position);
		for (int i = 0; i < 40; i++)
		{
			TSVector2 tSVector = GetNearestPos();
			if (tSVector != savePos)
			{
				savePos = tSVector;
				ModifyEffectPosition(selectionFx, savePos, 0);
				nearestPos = savePos;
			}
			yield return WaitTime(0.05);
		}
	}

	protected Dictionary<int, TSVector2> GetTagSafePos()
	{
		return GetLogicTagDicIntTSVector2Value(_actor, "safeFloor");
	}

	protected int GetNearstPosIndex(TSVector2 nearstPos)
	{
		int result = 0;
		foreach (KeyValuePair<int, TSVector2> allfloorPO in allfloorPOS)
		{
			if (nearstPos == new TSVector2(allfloorPO.Value.x, allfloorPO.Value.y))
			{
				result = allfloorPO.Key;
			}
		}
		return result;
	}

	protected TSVector2 GetNearestPos()
	{
		Dictionary<int, TSVector2> tagSafePos = GetTagSafePos();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		TSVector2 tSVector;
		if (tagSafePos != null && tagSafePos.Count > 0)
		{
			tSVector = tagSafePos.Values.First();
			foreach (KeyValuePair<int, TSVector2> item in tagSafePos)
			{
				tSVector = ((Distance(entityPositionObsoleted, item.Value) < Distance(entityPositionObsoleted, tSVector)) ? item.Value : tSVector);
			}
		}
		else
		{
			NovaLogger.Debug("咕噜海兔.破坏地板.获取最近地板异常默认为原点");
			tSVector = TSVector2.zero;
		}
		return tSVector;
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
