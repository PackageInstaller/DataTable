#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using TrueSync;

namespace AIScript.Monster._70031Huochui;

public class Action_HuoChui : MonsterActionBase
{
	private static readonly int Skill_01 = 7003101;

	private static readonly int Skill_02 = 7003102;

	private static readonly int Skill_03 = 7003103;

	private static readonly int Skill_04 = 7003104;

	private static readonly int Skill_05 = 7003105;

	private static readonly int Skill_JQFC = 7003121;

	private static readonly int Skill_SWJZ = 7003122;

	private static readonly int Skill_JJYJ_01 = 7003123;

	private static readonly int Skill_JJYJ_02 = 7003124;

	private static readonly int Skill_HXZJ_01 = 7003125;

	private static readonly int Skill_HXZJ_02 = 7003126;

	private static readonly int Skill_TJ = 7003127;

	private static readonly int Skill_XLZJ = 7003128;

	private static readonly int Skill_FLS_01 = 7003129;

	private static readonly int Skill_FLS_02 = 7003130;

	private static readonly int Skill_41 = 7003141;

	private static readonly int Skill_42 = 7003142;

	private static readonly int Skill_43 = 7003143;

	private static readonly int Skill_44 = 7003144;

	private static readonly int Skill_45 = 7003145;

	private static readonly int Skill_61 = 7003161;

	private static readonly int Skill_62 = 7003162;

	private static readonly int Skill_63 = 7003163;

	private static readonly int Skill_65 = 7003165;

	private static readonly int Skill_66 = 7003166;

	private static readonly int Skill_67 = 7003167;

	private static readonly int Skill_68 = 7003168;

	private static readonly int Skill_69 = 7003169;

	private FP BossStage;

	private static readonly FP PlayerDistance = 5;

	private bool Skill_JJYJ_Tips;

	private bool SkipSkillSpawn;

	private bool Skill1stTo2nd;

	private bool SkillToHot;

	private int HotValue;

	private int HotValueAdd = 5;

	private int HotValueAdd2 = 10;

	private int HotValueMinus = 25;

	private int DamageHotValue1 = 5;

	private int DamageHotValue2 = 10;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		BossStage = 1;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(1001, 4, 360, 7, null, Attack_QingJianGongJi)
		};
		OperateDelegate operateIEnumerator = Skill_GuangRenTouZhi;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_HuiXuanGuangRen;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_GuangRenHuanQuan;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_GuangRenHongZha;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_JianQiFangChu;
		list.Add(new BaseBranchInfo(1101, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_SiWangJianZhen;
		list.Add(new BaseBranchInfo(1102, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_JuJianYueJi;
		list.Add(new BaseBranchInfo(1103, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_HuiXuanZhanJi;
		list.Add(new BaseBranchInfo(1105, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_TiJi;
		list.Add(new BaseBranchInfo(1107, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_XuLiZhanJi;
		list.Add(new BaseBranchInfo(1108, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_FeiLeiShen;
		list.Add(new BaseBranchInfo(1109, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_JianQiYueJi_01;
		list.Add(new BaseBranchInfo(1111, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_JianQiYueJi_02;
		list.Add(new BaseBranchInfo(1112, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_JianQiFangChu_Hot;
		list.Add(new BaseBranchInfo(1201, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_JuJianLianJi_Hot;
		list.Add(new BaseBranchInfo(1202, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_KuaiJianManJian_Hot;
		list.Add(new BaseBranchInfo(1203, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_ChaoJiuWuShenZhan_Hot;
		list.Add(new BaseBranchInfo(1204, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_HouCheGongJi_Hot;
		list.Add(new BaseBranchInfo(1205, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_1stTo2nd;
		list.Add(new BaseBranchInfo(1301, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_ToHot;
		list.Add(new BaseBranchInfo(1302, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_XiuFu;
		list.Add(new BaseBranchInfo(1305, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_Call;
		list.Add(new BaseBranchInfo(1306, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_ShunYi;
		list.Add(new BaseBranchInfo(1307, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_MovaFront;
		list.Add(new BaseBranchInfo(1308, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill_MovaBack;
		list.Add(new BaseBranchInfo(1309, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1306, 1001, 1002, 1205, 1003, 1004, 1005, 1001, 1002, 1003,
				1004, 1307, 1005
			},
			[2] = new List<int>
			{
				1301, 1105, 1109, 1108, 1102, 1111, 1107, 1109, 1105, 1112,
				1102, 1109
			},
			[3] = new List<int> { 1302, 1204, 1202, 1203, 1201 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, HpChange);
		InitListenEvent(MonsterEventType.DamageToOthers, active: true, HotValueChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, BrokenChange);
		InitListenEvent(MonsterEventType.SelfReceiveDamage, active: true, StageChange);
	}

	private void AddHotValue(int value)
	{
		HotValue += value;
		HotValue = ((HotValue >= 100) ? 100 : HotValue);
		FireHotValueChange(HotValue);
	}

	private void SubtractHotValue(int value)
	{
		HotValue -= value;
		HotValue = ((HotValue > 0) ? HotValue : 0);
		FireHotValueChange(HotValue);
	}

	protected override void OnActionDisable()
	{
	}

	protected override void OnActionEnable()
	{
		FireHudShow(isShow: true, _actor.Id, 0, 1);
		StartCor(HotCheckTools());
		if (GetLogicTagToggleValue(_actor, "SkillTag_HotHitExtra"))
		{
			HotValueAdd = 10;
			HotValueAdd2 = 15;
		}
		if (GetLogicTagToggleValue(_actor, "SkillTag_HotLoss"))
		{
			HotValueMinus = 20;
		}
		if (GetLogicTagToggleValue(_actor, "SkillTag_HotTimeUp"))
		{
			StartCor(AutoAddHotValue());
		}
	}

	private IEnumerator HotCheckTools()
	{
		int i = 1;
		while (i > 0)
		{
			if (HotValue >= 100 && GetLogicTagFpValue(_actor, "BattleStage") != 3)
			{
				SetLogicTagFpValue(_actor, "BattleStage", 3);
				SwitchSequence(3);
				FireStateValueChange(3);
				yield return WaitTime(5);
			}
			i++;
			yield return WaitFrame(3);
		}
	}

	private IEnumerator AutoAddHotValue()
	{
		for (int i = 1; i > 0; i++)
		{
			yield return WaitTime(5);
			if (GetLogicTagFpValue(_actor, "BattleStage") != 3)
			{
				AddHotValue(5);
			}
		}
	}

	private IEnumerator BrokeEnd()
	{
		yield return WaitTime(10);
		StartCor(HotCheckTools());
		if (GetLogicTagToggleValue(_actor, "SkillTag_HotTimeUp"))
		{
			StartCor(AutoAddHotValue());
		}
	}

	private void BrokenChange(IEvent custom)
	{
		if (GetLogicTagFpValue(_actor, "BattleStage") == 3)
		{
			HotValue = 0;
			FireHotValueChange(HotValue);
			NovaLogger.Debug("破韧 结束后 进入 2阶段 ");
			SwitchSequence(2, initialIndex: false);
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			FireStateValueChange(2);
		}
		if (GetLogicTagFpValue(_actor, "BattleStage") == 1)
		{
			if (HotValue >= 50)
			{
				HotValue = 50;
			}
			FireHotValueChange(HotValue);
			NovaLogger.Debug("破韧 结束后 进入 2阶段 ");
			SwitchSequence(2);
			FireStateValueChange(2);
		}
		if (GetLogicTagFpValue(_actor, "BattleStage") == 2)
		{
			if (HotValue >= 50)
			{
				HotValue = 50;
			}
			FireHotValueChange(HotValue);
		}
		StartCor(BrokeEnd());
	}

	private void HotValueChange(IEvent custom)
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "BattleStage");
		if (logicTagFpValue == 1)
		{
			AddHotValue(DamageHotValue1);
		}
		else if (logicTagFpValue == 2)
		{
			AddHotValue(DamageHotValue2);
		}
	}

	private void HpChange(IEvent custom)
	{
		if (_actor.actorHealthInfo.hpPercentage <= FDP.FromDouble(0.7) && HotValue < 100 && GetLogicTagFpValue(_actor, "BattleStage") == 1)
		{
			NovaLogger.Debug("1阶段 进入 2阶段 阶段");
			SwitchSequence(2);
			FireStateValueChange(2);
		}
	}

	private void StageChange(IEvent custom)
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "BattleStage");
		if (HotValue >= 100 && (logicTagFpValue == 1 || logicTagFpValue == 2))
		{
			NovaLogger.Debug($"{logicTagFpValue}阶段 进入 热力阶段 ");
			SwitchSequence(3);
			SetLogicTagFpValue(_actor, "BattleStage", 3);
			FireStateValueChange(3);
		}
	}

	private IEnumerator Skill_1stTo2nd()
	{
		if (GetLogicTagFpValue(_actor, "BattleStage") == 2)
		{
			SkillToHot = false;
			yield break;
		}
		SetLogicTagFpValue(_actor, "BattleStage", 2);
		CastSkill(Skill_61);
		yield return WaitSkillFinish();
		RemoveBuffFromTarget(_actor, 700310010);
		RemoveBuffFromTarget(_actor, 700310020);
	}

	private IEnumerator Skill_ToHot()
	{
		if (!SkillToHot)
		{
			SkillToHot = true;
			AddBuffToTarget(_actor, 700310060);
			if (GetTargetByTeammateIndex(1).Count > 0)
			{
				GetTargetByTeammateIndex(1).get_Item(0);
				KillActors(GetTargetByTeammateIndex(1));
				CastSkill(Skill_62);
				yield return WaitTime(1);
				RemoveBuffFromTarget(_actor, 700310010);
				RemoveBuffFromTarget(_actor, 700310020);
				yield return WaitSkillFinish();
			}
			else
			{
				CastSkill(Skill_62);
				yield return WaitTime(1);
				RemoveBuffFromTarget(_actor, 700310010);
				RemoveBuffFromTarget(_actor, 700310020);
				yield return WaitSkillFinish();
			}
			SkillToHot = true;
		}
	}

	private IEnumerator Attack_QingJianGongJi()
	{
		GotoCastskill(Skill_01);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd);
	}

	private IEnumerator Skill_GuangRenTouZhi()
	{
		GotoCastskill(Skill_02);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd);
	}

	private IEnumerator Skill_HuiXuanGuangRen()
	{
		GotoCastskill(Skill_03);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd);
	}

	private IEnumerator Skill_GuangRenHuanQuan()
	{
		GotoCastskill(Skill_04);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd);
	}

	private IEnumerator Skill_GuangRenHongZha()
	{
		GotoCastskill(Skill_05);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd);
	}

	private IEnumerator Skill_JianQiFangChu()
	{
		GotoCastskill(Skill_JQFC);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd2);
	}

	private IEnumerator Skill_SiWangJianZhen()
	{
		GotoCastskill(Skill_SWJZ);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd2);
	}

	private IEnumerator Skill_JuJianYueJi()
	{
		if (!GetLogicTagToggleValue(_actor, "SkillTag_HotCombo"))
		{
			GotoCastskill(Skill_JJYJ_01);
			yield return WaitSkillFinish();
			AddHotValue(HotValueAdd2);
		}
		else
		{
			GotoCastskill(Skill_JJYJ_02);
			yield return WaitSkillFinish();
			AddHotValue(HotValueAdd2);
		}
	}

	private IEnumerator Skill_HuiXuanZhanJi()
	{
		GotoCastskill(Skill_HXZJ_01);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd2);
	}

	private IEnumerator Skill_TiJi()
	{
		GotoCastskill(Skill_TJ);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd2);
	}

	private IEnumerator Skill_XuLiZhanJi()
	{
		GotoCastskill(Skill_XLZJ);
		yield return WaitSkillFinish();
		AddHotValue(HotValueAdd2);
	}

	private IEnumerator Skill_FeiLeiShen()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_HotCombo"))
		{
			GotoCastskill(Skill_FLS_01);
			yield return WaitSkillFinish();
			AddHotValue(HotValueAdd2);
		}
	}

	private IEnumerator Skill_JianQiYueJi_01()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 4)
		{
			GotoCastskill(Skill_JQFC);
			yield return WaitSkillFinish();
			AddHotValue(HotValueAdd2);
		}
		else
		{
			GotoCastskill(Skill_JJYJ_01);
			yield return WaitSkillFinish();
			Skill_JJYJ_Tips = true;
			AddHotValue(HotValueAdd2);
		}
	}

	private IEnumerator Skill_JianQiYueJi_02()
	{
		if (Skill_JJYJ_Tips)
		{
			GotoCastskill(Skill_JQFC);
			yield return WaitSkillFinish();
			Skill_JJYJ_Tips = false;
			AddHotValue(HotValueAdd2);
		}
		else
		{
			GotoCastskill(Skill_JJYJ_01);
			yield return WaitSkillFinish();
			AddHotValue(HotValueAdd2);
		}
	}

	private IEnumerator Skill_JianQiFangChu_Hot()
	{
		if (HotValue <= 0)
		{
			SkillToHot = false;
			GotoCastskill(Skill_63);
			RemoveBuffFromTarget(_actor, 700310060);
			yield return WaitSkillFinish();
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			SwitchSequence(2, initialIndex: false);
			Interlocked.Exchange(ref HotValue, 0);
			FireStateValueChange(2);
			SkillToHot = false;
		}
		else if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= PlayerDistance)
		{
			GotoCastskill(Skill_45);
			yield return WaitSkillFinish();
			GotoCastskill(Skill_41);
			yield return WaitSkillFinish();
			SubtractHotValue(HotValueMinus);
		}
		else
		{
			GotoCastskill(Skill_41);
			yield return WaitSkillFinish();
			SubtractHotValue(HotValueMinus);
		}
	}

	private IEnumerator Skill_JuJianLianJi_Hot()
	{
		if (HotValue <= 0)
		{
			GotoCastskill(Skill_63);
			RemoveBuffFromTarget(_actor, 700310060);
			yield return WaitSkillFinish();
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			SwitchSequence(2, initialIndex: false);
			Interlocked.Exchange(ref HotValue, 0);
			FireStateValueChange(2);
			SkillToHot = false;
		}
		else
		{
			GotoCastskill(Skill_42);
			yield return WaitSkillFinish();
			SubtractHotValue(HotValueMinus);
		}
	}

	private IEnumerator Skill_KuaiJianManJian_Hot()
	{
		if (HotValue <= 0)
		{
			GotoCastskill(Skill_63);
			RemoveBuffFromTarget(_actor, 700310060);
			yield return WaitSkillFinish();
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			SwitchSequence(2, initialIndex: false);
			Interlocked.Exchange(ref HotValue, 0);
			FireStateValueChange(2);
			SkillToHot = false;
		}
		else
		{
			GotoCastskill(Skill_43);
			yield return WaitSkillFinish();
			SubtractHotValue(HotValueMinus);
		}
	}

	private IEnumerator Skill_ChaoJiuWuShenZhan_Hot()
	{
		if (HotValue <= 0)
		{
			GotoCastskill(Skill_63);
			RemoveBuffFromTarget(_actor, 700310060);
			yield return WaitSkillFinish();
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			SwitchSequence(2, initialIndex: false);
			Interlocked.Exchange(ref HotValue, 0);
			FireStateValueChange(2);
			SkillToHot = false;
			NovaLogger.Debug("退出 热力阶段，进入 2 阶段  ");
		}
		else
		{
			GotoCastskill(Skill_44);
			yield return WaitSkillFinish();
			SubtractHotValue(HotValueMinus);
		}
	}

	private IEnumerator Skill_HouCheGongJi_Hot()
	{
		GotoCastskill(Skill_45);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_XiuFu()
	{
		GotoCastskill(Skill_65);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_Call()
	{
		if (!SkipSkillSpawn)
		{
			FireHudShow(isShow: true, _actor.Id, 0, 1);
			SkipSkillSpawn = true;
			CastSkill(Skill_66);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Skill_ShunYi()
	{
		GotoCastskill(Skill_67);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_MovaFront()
	{
		GotoCastskill(Skill_68);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_MovaBack()
	{
		GotoCastskill(Skill_69);
		yield return WaitSkillFinish();
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}
}
