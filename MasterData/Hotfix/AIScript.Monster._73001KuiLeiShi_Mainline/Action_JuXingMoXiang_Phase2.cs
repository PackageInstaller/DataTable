using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_JuXingMoXiang_Phase2 : MonsterActionBase
{
	private const int SEQ_P2 = 2;

	private const int SEQ_P2_PARALYSIS_RETRY = 4;

	private const int SEQ_P2_2 = 5;

	private const int consumeEnergyOnAttack = 20;

	private const int reduceBuffLayerOnAttack = 1;

	private int _seqBeforeParalyzeRetry;

	private int _seqPosBeforeParalyzeRetry;

	private int _summonLevel;

	private int _damageReductionBuffId;

	private int _vulnerableBuffId;

	private PlayFX _shieldDownFx;

	private void ConsumeEnergyAndReduceBuff(int consumedEnergy, int reduceBuffLayer)
	{
		if (consumedEnergy > 0)
		{
			ConsumeEnergy(consumedEnergy);
		}
		if (reduceBuffLayer > 0)
		{
			BuffCom buffCom = _actor?.buffComponent;
			if (buffCom != null && buffCom.GetBuffNumByID(_damageReductionBuffId) > 0)
			{
				buffCom.RemoveBuffByBuffId(_damageReductionBuffId, reduceBuffLayer);
				ILRuntimeAPI.PlayFX(ref _shieldDownFx, _actor, null, "fx_m72012_base_Shield_down", default, _actor.tsTransform.Position, TSVector2.zero);
			}
			else
			{
				ConsumeEnergy(10);
			}
		}
	}

	private void ConsumeEnergy(int amount)
	{
		FP fP = GetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag);
		fP -= (FP)amount;
		if (fP < 0)
		{
			fP = 0;
		}
		SetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag, fP);
		BossEnergyValueChage((int)(long)fP, _actor);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetSummonLevel();
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
		SetLogicTagFpValue(_actor, Config_JuXingMoXiang.PhaseTag, 2);
		SetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag, 100);
		CommonUtils_MonsterAPI.AddBuffNumToTarget(_actor, _damageReductionBuffId, _actor, 8);
		BossEnergyValueChage(100, _actor);
		EnergyHudShow(isShow: true, _actor.Id, 0, 0);
		Common_73001.SyncBossBuffChange(_actor, _damageReductionBuffId, _vulnerableBuffId);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ILRuntimeAPI.ClearPlayFX(_shieldDownFx);
		EnergyHudShow(isShow: false, _actor.Id, 0, 0);
		_seqBeforeParalyzeRetry = 0;
		_seqPosBeforeParalyzeRetry = 0;
	}

	protected void SetSummonLevel()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		Common_73001.SetSummonLevelByTag(_actor, monsterTagValue);
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = DoCast_P2_CoreLaser;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_JuXiangHuiJi;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_ZhuNengGuangXian;
		list.Add(new BaseBranchInfo(2003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_ShuFuXianJing;
		list.Add(new BaseBranchInfo(2004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_HeXinBaoFa;
		list.Add(new BaseBranchInfo(2005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_NengLiangQiu;
		list.Add(new BaseBranchInfo(2006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_JiGuangFangShe;
		list.Add(new BaseBranchInfo(2007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_LiPaoHongJi;
		list.Add(new BaseBranchInfo(2008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DoCast_P2_ParalyzeCharge;
		list.Add(new BaseBranchInfo(2009, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[2] = new List<int> { 2005, 2002, 2001, 2006, 2007, 2002, 2004, 2008 },
			[5] = new List<int> { 2005, 2001, 2002, 2004, 2006, 2008, 2007, 2001 },
			[4] = new List<int> { 2009 }
		};
		InitSequenceBranches(2, sequenceBranches, sequenceDict);
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		FP logicTagFpValue = GetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag);
		if (logicTagFpValue <= 0)
		{
			if (CurrentSeqIndex != 4)
			{
				_seqBeforeParalyzeRetry = CurrentSeqIndex;
				_seqPosBeforeParalyzeRetry = CurrentIndex;
			}
			SwitchSequence(4);
		}
		else if (CurrentSeqIndex == 4)
		{
			if (logicTagFpValue < 100)
			{
				SwitchSequence(CurrentSeqIndex);
				return;
			}
			SwitchSequence(_seqBeforeParalyzeRetry, initialIndex: false);
			SetCurrentSequenceIndex(_seqPosBeforeParalyzeRetry);
		}
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
		switch (curSeqIndex)
		{
		case 4:
			SwitchSequence(_seqBeforeParalyzeRetry, initialIndex: false);
			SetCurrentSequenceIndex(_seqPosBeforeParalyzeRetry);
			return;
		case 2:
		case 5:
			if (GetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag) <= 0)
			{
				_seqBeforeParalyzeRetry = curSeqIndex;
				_seqPosBeforeParalyzeRetry = CurrentIndex;
				SwitchSequence(4);
				return;
			}
			break;
		}
		if (isSeqEnd)
		{
			int index = ((curSeqIndex == 2) ? 5 : 2);
			SwitchSequence(index);
		}
	}

	private IEnumerator DoCast_P2_CoreLaser()
	{
		CastSkill(7201232);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(20, 1);
	}

	private IEnumerator DoCast_P2_JuXiangHuiJi()
	{
		CastSkill(7201231);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(20, 1);
	}

	private IEnumerator DoCast_P2_ZhuNengGuangXian()
	{
		CastSkill(7201237);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(0, 0);
	}

	private IEnumerator DoCast_P2_ShuFuXianJing()
	{
		CastSkill(7201235);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(20, 1);
	}

	private IEnumerator DoCast_P2_HeXinBaoFa()
	{
		CastSkill(7201236);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(20, 1);
	}

	private IEnumerator DoCast_P2_NengLiangQiu()
	{
		CastSkill(7201238);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(0, 0);
	}

	private IEnumerator DoCast_P2_JiGuangFangShe()
	{
		CastSkill(7201234);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(20, 1);
	}

	private IEnumerator DoCast_P2_LiPaoHongJi()
	{
		CastSkill(7201233);
		yield return WaitSkillFinish();
		ConsumeEnergyAndReduceBuff(20, 1);
	}

	private IEnumerator DoCast_P2_ParalyzeCharge()
	{
		CastSkill(7201239);
		yield return WaitSkillFinish();
	}
}
