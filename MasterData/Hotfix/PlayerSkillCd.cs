using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class PlayerSkillCd : LogicComponent
{
	public delegate void SkillBindHandle(ActionKey actionKey, int skillId, int actorId);

	public delegate void SkillResidentHintHandle(int skillId, bool isShow);

	public delegate void SyncSkillBtnToLuaHandle(float[] SyncData, bool bLocking, bool bBeginResume, bool bCanUseAssitSkill);

	private readonly Dictionary<ActionKey, int> _skillIdBindDict = new Dictionary<ActionKey, int>();

	private int _actorId;

	private AdventureActor _actor;

	private bool _isFastResume;

	private readonly Dictionary<int, SkillEnergyInfo> dicSkillEnergy = new Dictionary<int, SkillEnergyInfo>();

	protected int _unableRecoverEnergyRC;

	private bool bNeedSyncToLua;

	private readonly float[] arrSyncData = new float[9];

	public List<SkillInfo> skillInfos { get; } = new List<SkillInfo>();

	public Dictionary<ActionKey, int> SkillSlotBaseLvBindDict { get; } = new Dictionary<ActionKey, int>();

	public Dictionary<ActionKey, int> SkillSlotAmendLvBindDict { get; } = new Dictionary<ActionKey, int>();

	public bool unableRecoverEnergy => _unableRecoverEnergyRC > 0;

	public event SkillBindHandle SkillBindEvent;

	public event SkillResidentHintHandle SkillResidentHintEvent;

	public event SyncSkillBtnToLuaHandle SyncSkillBtnToLua;

	protected override void OnInit()
	{
		_actor = Entity as AdventureActor;
		dicSkillEnergy.Clear();
	}

	public void SetActorId(int id)
	{
		_actorId = id;
	}

	public void SetFastResume(bool active)
	{
		_isFastResume = active;
	}

	public int GetSkillSection(int skillId)
	{
		int result = 0;
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null)
		{
			result = skillCD.currentSectionAmount;
		}
		return result;
	}

	public bool CanUseCD(int skillId)
	{
		if (GetSkillCD(skillId).currentUseInterval > 0)
		{
			return false;
		}
		return GetSkillSection(skillId) > 0;
	}

	public bool CheckCD(int skillId)
	{
		return GetSkillCD(skillId).currentResumeTime > 0;
	}

	public ActionKey GetCurrentActionKey(int skillId)
	{
		foreach (ActionKey key in _skillIdBindDict.Keys)
		{
			if (_skillIdBindDict.get_Item(key) == skillId)
			{
				return key;
			}
		}
		return ActionKey.None;
	}

	public SkillInfo GetSkillCD(ActionKey actionKey)
	{
		int currentBindSkillId = GetCurrentBindSkillId(actionKey);
		return GetSkillCD(currentBindSkillId);
	}

	public SkillInfo GetSkillCD(int skillId)
	{
		if (skillInfos == null)
		{
			return null;
		}
		SkillInfo result = null;
		for (int i = 0; i < skillInfos.Count; i++)
		{
			if (skillInfos.get_Item(i).skillId == skillId)
			{
				result = skillInfos.get_Item(i);
				break;
			}
		}
		return result;
	}

	public void SetSkillUseTimeHint(int skillId, FP useTimeHint, FP currentUseTimeHint)
	{
		for (int i = 0; i < skillInfos.Count; i++)
		{
			if (skillInfos.get_Item(i).skillId == skillId)
			{
				skillInfos.get_Item(i).useTimeHint = useTimeHint;
				skillInfos.get_Item(i).currentUseTimeHint = TSMath.Clamp(currentUseTimeHint, 0, useTimeHint);
				DoSyncSkillBtnToLua(skillInfos.get_Item(i));
				break;
			}
		}
	}

	public void CloseSkillUseTimeHint(int skillId)
	{
		for (int i = 0; i < skillInfos.Count; i++)
		{
			if (skillInfos.get_Item(i).skillId == skillId)
			{
				skillInfos.get_Item(i).currentUseTimeHint = 0;
				DoSyncSkillBtnToLua(skillInfos.get_Item(i));
				if (skillInfos.get_Item(i).useTimeHint < 0)
				{
					SkillResidentHintEvent?.Invoke(skillId, isShow: false);
				}
				break;
			}
		}
	}

	public FP GetSkillUseTimeHint(int skillId)
	{
		for (int i = 0; i < skillInfos.Count; i++)
		{
			if (skillInfos.get_Item(i).skillId == skillId)
			{
				return skillInfos.get_Item(i).useTimeHint;
			}
		}
		return 0;
	}

	public int GetSkillLevel(ActionKey actionKey)
	{
		SkillSlotBaseLvBindDict.TryGetValue(actionKey, out var value);
		SkillSlotAmendLvBindDict.TryGetValue(actionKey, out var value2);
		return value + value2;
	}

	public void AddSkillSlotLevel(ActionKey actionKey, int amend)
	{
		if (!SkillSlotAmendLvBindDict.TryAdd(actionKey, amend))
		{
			SkillSlotAmendLvBindDict.get_Item(actionKey) += amend;
			AdventureActorSkillSlotLevelInfoChangeEvent adventureActorSkillSlotLevelInfoChangeEvent = AdventureActorSkillSlotLevelInfoChangeEvent.Generate();
			adventureActorSkillSlotLevelInfoChangeEvent.sender = _actor;
			ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureActorSkillSlotLevelInfoChangeEvent);
		}
	}

	public (bool valid, int oldLevel) SetSkillSlotBaseLevel(ActionKey actionKey, int level)
	{
		bool item = false;
		SkillSlotBaseLvBindDict.TryGetValue(actionKey, out var value);
		if (value < level)
		{
			SkillSlotBaseLvBindDict.set_Item(actionKey, level);
			item = true;
			AdventureActorSkillSlotLevelInfoChangeEvent adventureActorSkillSlotLevelInfoChangeEvent = AdventureActorSkillSlotLevelInfoChangeEvent.Generate();
			adventureActorSkillSlotLevelInfoChangeEvent.sender = _actor;
			ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureActorSkillSlotLevelInfoChangeEvent);
		}
		return (valid: item, oldLevel: value);
	}

	public void SetSkillSlotBaseLevelForBootConfig(ActionKey actionKey, int level)
	{
		SkillSlotBaseLvBindDict.set_Item(actionKey, level);
		AdventureActorSkillSlotLevelInfoChangeEvent adventureActorSkillSlotLevelInfoChangeEvent = AdventureActorSkillSlotLevelInfoChangeEvent.Generate();
		adventureActorSkillSlotLevelInfoChangeEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureActorSkillSlotLevelInfoChangeEvent);
	}

	public void BindSkillIdToButton(ActionKey actionKey, int skillId, bool resetSection = false)
	{
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId);
		if (skill == null)
		{
			Debug.LogError($"bind skill id error, can not find skill config, skillId:{skillId}");
		}
		else
		{
			if (skillId == GetCurrentBindSkillId(actionKey))
			{
				return;
			}
			_skillIdBindDict.set_Item(actionKey, skillId);
			SkillInfo skillInfo = null;
			for (int i = 0; i < skillInfos.Count; i++)
			{
				if (skillInfos.get_Item(i).skillId == skillId)
				{
					skillInfo = skillInfos.get_Item(i);
					skillInfo.actionKey = actionKey;
					break;
				}
			}
			if (skillInfo == null)
			{
				skillInfo = new SkillInfo(_actor, actionKey, skillId, skill.UseInterval, skill.SectionAmount, skill.SkillCD, skill.UseTimeHint, skill.UltraEnergy);
				skillInfos.Add(skillInfo);
			}
			else
			{
				skillInfo.currentUseTimeHint = skillInfo.useTimeHint;
			}
			if (resetSection)
			{
				FP currentSectionResumeTime = GetCurrentSectionResumeTime(skillInfo);
				skillInfo.currentResumeTime = 0;
				skillInfo.sectionResumeTime = currentSectionResumeTime;
				skillInfo.currentSectionAmount = 0;
				skillInfo.beginResume = true;
			}
			SkillBindEvent?.Invoke(actionKey, skillId, _actorId);
			DoSyncSkillBtnToLua(skillInfo);
			if (skillInfo.actionKey == ActionKey.A)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("CanRush", skillInfo.currentSectionAmount <= 0);
			}
			if (!dicSkillEnergy.ContainsKey(skillId) && skill.GetEnergyLimit > 0)
			{
				FP fP = FP.FromMyriad(skill.GetEnergyLimit);
				SkillEnergyInfo value = new SkillEnergyInfo
				{
					curEnergy = 0,
					maxEnergy = 0,
					originalDeltaEnergy = fP,
					deltaEnergy = fP
				};
				dicSkillEnergy.Add(skillId, value);
			}
			if (skillInfo.useTimeHint < 0)
			{
				SkillResidentHintEvent?.Invoke(skillInfo.skillId, isShow: true);
			}
		}
	}

	public int GetCurrentBindSkillId(ActionKey actionKey)
	{
		_skillIdBindDict.TryGetValue(actionKey, out var value);
		return value;
	}

	public SkillEnergyInfo GetSkillEnergyInfo(int skillId)
	{
		return dicSkillEnergy.GetValueOrDefault(skillId);
	}

	public void ChangeSkillGetEnergyLimit(int skillId, FP getEnergyLimit)
	{
		SkillEnergyInfo skillEnergyInfo = GetSkillEnergyInfo(skillId);
		if (skillEnergyInfo != null)
		{
			skillEnergyInfo.deltaEnergy = getEnergyLimit;
		}
	}

	public void ResetSkillGetEnergyLimit(int skillId)
	{
		SkillEnergyInfo skillEnergyInfo = GetSkillEnergyInfo(skillId);
		if (skillEnergyInfo != null)
		{
			skillEnergyInfo.deltaEnergy = skillEnergyInfo.originalDeltaEnergy;
		}
	}

	public void AddSkillEnergyPool(int skillId)
	{
		SkillEnergyInfo skillEnergyInfo = GetSkillEnergyInfo(skillId);
		if (skillEnergyInfo != null)
		{
			skillEnergyInfo.maxEnergy += skillEnergyInfo.deltaEnergy;
			float energyReduceTime = AdventureModuleController.Config.EnergyReduceTime;
			skillEnergyInfo.removeList.Add(Entity.LogicTime + FP.FromConfigFloat(energyReduceTime));
		}
	}

	public void SetSkillEnergyMaxEnergy(int skillId, FP maxEnergy)
	{
		SkillEnergyInfo skillEnergyInfo = GetSkillEnergyInfo(skillId);
		if (skillEnergyInfo != null)
		{
			skillEnergyInfo.maxEnergy = maxEnergy;
			if (skillEnergyInfo.curEnergy > skillEnergyInfo.maxEnergy)
			{
				skillEnergyInfo.curEnergy = skillEnergyInfo.maxEnergy;
			}
		}
	}

	public void ReduceSkillSection(int skillId, bool beginResume = true)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null && skillCD.currentSectionAmount > 0)
		{
			skillCD.currentSectionAmount--;
			if (beginResume)
			{
				skillCD.beginResume = true;
			}
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void AddSkillSection(ActionKey actionKey, int amount = 1)
	{
		SkillInfo skillCD = GetSkillCD(actionKey);
		if (skillCD != null && skillCD.currentSectionAmount < skillCD.totalSectionAmount)
		{
			skillCD.currentSectionAmount += amount;
			if (skillCD.currentSectionAmount >= skillCD.totalSectionAmount)
			{
				skillCD.currentSectionAmount = skillCD.totalSectionAmount;
				skillCD.currentResumeTime = 0;
			}
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void SetSkillTotalSection(ActionKey actionKey, int totalAmount = 1, bool forceMaxSection = false)
	{
		SkillInfo skillCD = GetSkillCD(actionKey);
		if (skillCD != null && skillCD.totalSectionAmount != totalAmount)
		{
			skillCD.totalSectionAmount = totalAmount;
			if ((skillCD.currentSectionAmount >= skillCD.totalSectionAmount) | forceMaxSection)
			{
				skillCD.currentSectionAmount = skillCD.totalSectionAmount;
				skillCD.currentResumeTime = 0;
				skillCD.beginResume = false;
				skillCD.resuming = false;
			}
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void AddSkillTotalSection(ActionKey actionKey, int addAmount)
	{
		SkillInfo skillCD = GetSkillCD(actionKey);
		if (skillCD != null)
		{
			skillCD.totalSectionAmount += addAmount;
			skillCD.beginResume = true;
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void ResetSkillTotalSection(ActionKey actionKey)
	{
		SkillInfo skillCD = GetSkillCD(actionKey);
		if (skillCD != null && skillCD.totalSectionAmount != skillCD.originalTotalSectionAmount)
		{
			skillCD.totalSectionAmount = skillCD.originalTotalSectionAmount;
			if (skillCD.currentSectionAmount >= skillCD.totalSectionAmount)
			{
				skillCD.currentSectionAmount = skillCD.totalSectionAmount;
				skillCD.currentResumeTime = 0;
			}
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void SetSkillBeginResume(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null && !skillCD.resuming)
		{
			skillCD.beginResume = true;
			FP currentSectionResumeTime = GetCurrentSectionResumeTime(skillCD);
			skillCD.sectionResumeTime = currentSectionResumeTime;
		}
	}

	public void SetSkillStopResume(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null)
		{
			skillCD.beginResume = false;
		}
	}

	private FP GetCurrentSectionResumeTime(SkillInfo info)
	{
		FP fP = _actor.actorInfo.skillCDMaxPercentAmend;
		FP fP2 = _actor.actorInfo.skillCDMaxAmend;
		if (info.actionKey == ActionKey.A)
		{
			fP = _actor.actorInfo.dodgeCDMaxPercentAmend;
			fP2 = _actor.actorInfo.dodgeCDMaxAmend;
		}
		else if (info.actionKey == ActionKey.D)
		{
			fP = _actor.actorInfo.ultraCDMaxPercentAmend;
			fP2 = _actor.actorInfo.ultraCDMaxAmend;
		}
		FP fP3 = info.originalSectionResumeTime * (info.sectionResumeTimePercentAmend / 100f) + info.sectionResumeTimeAmend;
		FP fP4 = fP3 * fP + fP2;
		if (fP4 < fP3 / 2)
		{
			fP4 = fP3 / 2;
		}
		if (_isFastResume)
		{
			fP4 = ((fP4 > 1f) ? ((FP)1f) : fP4);
		}
		return fP4;
	}

	public void ReturnSkillResumeTime(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null && skillCD.actionKey == ActionKey.B && skillCD.currentSectionAmount < skillCD.totalSectionAmount)
		{
			skillCD.currentResumeTime += GetCurrentSectionResumeTime(skillCD) * AdventureModuleController.Config.Actor_ReturnCDRate;
		}
	}

	public void ResetUseInterval(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null)
		{
			skillCD.currentUseInterval = skillCD.totalUseInterval;
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void ModifyResumeTimePercent(int resumeTimePercent, ActionKey actionKey)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		resumeTimePercent = Math.Clamp(resumeTimePercent, 0, 100);
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			int currentBindSkillId = GetCurrentBindSkillId(actionKey);
			if (skillInfo.skillId == currentBindSkillId && skillInfo.currentSectionAmount != skillInfo.totalSectionAmount)
			{
				FP fP = (GetCurrentSectionResumeTime(skillInfo) - skillInfo.currentResumeTime) * (100 - resumeTimePercent) / 100f;
				skillInfo.currentResumeTime += fP;
			}
		}
	}

	public void ModifyResumeTimeAbs(FP resumeTimeAbs, ActionKey actionKey)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			int currentBindSkillId = GetCurrentBindSkillId(actionKey);
			if (skillInfo.skillId == currentBindSkillId && skillInfo.currentSectionAmount != skillInfo.totalSectionAmount)
			{
				skillInfo.currentResumeTime -= resumeTimeAbs;
			}
		}
	}

	public void ModifySectionResumeTimePercentAmend(int sectionResumeTimePercentAmend, ActionKey actionKey)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		sectionResumeTimePercentAmend = Math.Clamp(sectionResumeTimePercentAmend, 0, 100);
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			int currentBindSkillId = GetCurrentBindSkillId(actionKey);
			if (skillInfo.skillId == currentBindSkillId)
			{
				skillInfo.sectionResumeTimePercentAmend = sectionResumeTimePercentAmend;
				break;
			}
		}
	}

	public void ResetSectionResumeTimePercentAmend(ActionKey actionKey)
	{
		ModifySectionResumeTimePercentAmend(100, actionKey);
	}

	public void ModifySectionResumeTimeAmend(FP sectionResumeTimeAmend, ActionKey actionKey)
	{
		List<SkillInfo> list = skillInfos;
		if (list != null && list.Count > 0)
		{
			int currentBindSkillId = GetCurrentBindSkillId(actionKey);
			ModifySectionResumeTimeAmend(sectionResumeTimeAmend, currentBindSkillId);
		}
	}

	public void ModifySectionResumeTimeAmend(FP sectionResumeTimeAmend, int skillId)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (skillInfo.skillId == skillId)
			{
				skillInfo.sectionResumeTimeAmend = sectionResumeTimeAmend;
				break;
			}
		}
	}

	public void ResetSectionResumeTimeAmend(ActionKey actionKey)
	{
		ModifySectionResumeTimeAmend(0, actionKey);
	}

	public void ResetSectionResumeTimeAmend(int skillId)
	{
		ModifySectionResumeTimeAmend(0, skillId);
	}

	public void ModifyOriginalSectionResumeTime(ActionKey actionKey, FP originalResumeTimeAmend)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			int currentBindSkillId = GetCurrentBindSkillId(actionKey);
			if (skillInfo.skillId == currentBindSkillId)
			{
				skillInfo.originalSectionResumeTime = originalResumeTimeAmend;
				break;
			}
		}
	}

	public void ResetAllSkillCD()
	{
		List<SkillInfo> list = skillInfos;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < skillInfos.Count; i++)
			{
				SkillInfo skillInfo = skillInfos.get_Item(i);
				ResetSkillCD(skillInfo.skillId);
			}
		}
	}

	public void ResetSkillCD(ActionKey actionKey)
	{
		int currentBindSkillId = GetCurrentBindSkillId(actionKey);
		ResetSkillCD(currentBindSkillId);
	}

	public void ResetSkillCD(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null)
		{
			skillCD.currentUseInterval = 0;
			skillCD.currentResumeTime = 0;
			skillCD.currentSectionAmount = skillCD.totalSectionAmount;
			skillCD.beginResume = false;
			skillCD.resuming = false;
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public void ResetUseTimeHint(ActionKey actionKey)
	{
		int currentBindSkillId = GetCurrentBindSkillId(actionKey);
		ResetUseTimeHint(currentBindSkillId);
	}

	public void ResetUseTimeHint(int skillId)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (skillInfo.skillId == skillId)
			{
				skillInfo.currentUseTimeHint = skillInfo.useTimeHint;
			}
		}
	}

	public void ResetSkillInfo(int skillId, long cd, int sectionAmount, long sectionResumeTime, long useTimeHint, long energy)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (skillInfo.skillId == skillId)
			{
				FDP currentEnergy = skillInfo.currentEnergy;
				skillInfo.currentUseInterval = new FP(cd);
				skillInfo.currentSectionAmount = sectionAmount;
				skillInfo.currentResumeTime = new FP(sectionResumeTime);
				skillInfo.currentUseTimeHint = new FP(useTimeHint);
				skillInfo.currentEnergy = new FDP(energy);
				skillInfo.beginResume = true;
				if (currentEnergy != skillInfo.currentEnergy)
				{
					OnEnergyChange(skillInfo, isReset: true);
				}
				DoSyncSkillBtnToLua(skillInfo);
				break;
			}
		}
	}

	public bool ModifyResumeAbsByEffect(FP resumeTimeAbs, string actionKey, string skillId)
	{
		bool result = false;
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return result;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (checkSkillByActionkOrId(skillInfo, actionKey, skillId) && skillInfo.currentSectionAmount != skillInfo.totalSectionAmount)
			{
				skillInfo.currentResumeTime -= resumeTimeAbs;
				if (skillInfo.currentResumeTime < 0)
				{
					skillInfo.currentResumeTime = 0;
				}
				result = true;
			}
		}
		return result;
	}

	public bool ModifyResumeTimePercentByEffect(FP resumeTimePercent, string actionKey, string skillId)
	{
		bool result = false;
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return result;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (checkSkillByActionkOrId(skillInfo, actionKey, skillId) && skillInfo.currentSectionAmount != skillInfo.totalSectionAmount)
			{
				FP fP = GetCurrentSectionResumeTime(skillInfo) * resumeTimePercent;
				skillInfo.currentResumeTime -= fP;
				if (skillInfo.currentResumeTime < 0)
				{
					skillInfo.currentResumeTime = 0;
				}
				result = true;
			}
		}
		return result;
	}

	public void AddSectionAmountByEffect(int amount, string actionKey, string skillId)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (checkSkillByActionkOrId(skillInfo, actionKey, skillId) && skillInfo.currentSectionAmount < skillInfo.totalSectionAmount)
			{
				skillInfo.currentSectionAmount += amount;
				if (skillInfo.currentSectionAmount >= skillInfo.totalSectionAmount)
				{
					skillInfo.currentSectionAmount = skillInfo.totalSectionAmount;
					skillInfo.currentResumeTime = 0;
				}
				DoSyncSkillBtnToLua(skillInfo);
			}
		}
	}

	public void ResumeSectionAmountByEffect(string actionKey, string skillId)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (checkSkillByActionkOrId(skillInfo, actionKey, skillId) && skillInfo.currentSectionAmount < skillInfo.totalSectionAmount)
			{
				skillInfo.currentSectionAmount = skillInfo.totalSectionAmount;
				skillInfo.currentResumeTime = 0;
				DoSyncSkillBtnToLua(skillInfo);
			}
		}
	}

	private bool checkSkillByActionkOrId(SkillInfo skillInfo, string checkActionKey, string checkSkillId)
	{
		ActionKey actionKey = ActionKey.None;
		int num = 0;
		if (!string.IsNullOrEmpty(checkActionKey))
		{
			actionKey = (ActionKey)CommonHelper.ParseStringParamToInt(checkActionKey);
		}
		if (!string.IsNullOrEmpty(checkSkillId))
		{
			num = CommonHelper.ParseStringParamToInt(checkSkillId);
		}
		if (actionKey == ActionKey.None && num == 0)
		{
			return true;
		}
		if (skillInfo.skillId == num)
		{
			return true;
		}
		if (actionKey == ActionKey.None)
		{
			return false;
		}
		return skillInfo.actionKey == actionKey;
	}

	public void EnterUnableRecoverEnergyState()
	{
		_unableRecoverEnergyRC++;
	}

	public void ExitUnableRecoverEnergyState()
	{
		_unableRecoverEnergyRC--;
		if (_unableRecoverEnergyRC < 0)
		{
			_unableRecoverEnergyRC = 0;
			Debug.LogWarning("EnterUnableRecoverEnergyState与ExitUnableRecoverEnergyState使用不匹配，请成对使用");
		}
	}

	public void AddEnergy(FDP energy)
	{
		if (!(_actor == null) && _actor.actorHealthInfo.isAlive && (!unableRecoverEnergy || !(energy >= 0L)))
		{
			int currentBindSkillId = GetCurrentBindSkillId(ActionKey.D);
			SkillInfo skillCD = GetSkillCD(currentBindSkillId);
			if (skillCD != null)
			{
				FDP fDP = FDP.Clamp(skillCD.currentEnergy + energy, FDP.Zero, skillCD.totalEnergy) - skillCD.currentEnergy;
				skillCD.currentEnergy += fDP;
			}
		}
	}

	public void ClearEnergy()
	{
		int currentBindSkillId = GetCurrentBindSkillId(ActionKey.D);
		SkillInfo skillCD = GetSkillCD(currentBindSkillId);
		if (skillCD != null)
		{
			skillCD.currentEnergy = FDP.Zero;
		}
	}

	public void SetEnergy(FDP energy)
	{
		int currentBindSkillId = GetCurrentBindSkillId(ActionKey.D);
		SkillInfo skillCD = GetSkillCD(currentBindSkillId);
		if (skillCD != null)
		{
			skillCD.currentEnergy = energy;
		}
	}

	public void OnSetEnergy(FDP old_energy, FDP energy)
	{
		int currentBindSkillId = GetCurrentBindSkillId(ActionKey.D);
		SkillInfo skillCD = GetSkillCD(currentBindSkillId);
		if (skillCD != null)
		{
			if (old_energy != energy)
			{
				OnEnergyChange(skillCD);
			}
			DoSyncSkillBtnToLua(skillCD);
		}
	}

	public FDP GetEnergy()
	{
		FDP result = FDP.Zero;
		int currentBindSkillId = GetCurrentBindSkillId(ActionKey.D);
		SkillInfo skillCD = GetSkillCD(currentBindSkillId);
		if (skillCD != null)
		{
			result = skillCD.currentEnergy;
		}
		return result;
	}

	public int GetTotalEnergy()
	{
		int result = 0;
		int currentBindSkillId = GetCurrentBindSkillId(ActionKey.D);
		SkillInfo skillCD = GetSkillCD(currentBindSkillId);
		if (skillCD != null)
		{
			result = (int)(long)skillCD.totalEnergy;
		}
		return result;
	}

	public FDP GetEnergyPercent()
	{
		int totalEnergy = GetTotalEnergy();
		if (totalEnergy == 0)
		{
			return FDP.Zero;
		}
		return GetEnergy() / totalEnergy * 100;
	}

	private void OnEnergyChange(SkillInfo info, bool isReset = false)
	{
		if (info != null)
		{
			AdventureActorEnergyChangeEvent adventureActorEnergyChangeEvent = AdventureActorEnergyChangeEvent.Generate();
			adventureActorEnergyChangeEvent.actor = _actor;
			adventureActorEnergyChangeEvent.skillId = info.skillId;
			adventureActorEnergyChangeEvent.totalEnergy = info.totalEnergy;
			adventureActorEnergyChangeEvent.currentEnergy = info.currentEnergy;
			adventureActorEnergyChangeEvent.isReset = isReset;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEnergyChangeEvent);
		}
	}

	public void DoSyncSkillBtnToLua(SkillInfo info)
	{
		float num = 0f;
		if (info.totalUseInterval != 0)
		{
			num = (float)(info.currentUseInterval / info.totalUseInterval);
		}
		float num2 = 0f;
		if (info.sectionResumeTime != 0)
		{
			num2 = (float)(info.currentResumeTime / info.sectionResumeTime);
		}
		float num3 = 0f;
		if (info.useTimeHint > 0)
		{
			num3 = (float)(info.currentUseTimeHint / info.useTimeHint);
		}
		float num4 = 0f;
		if (info.totalEnergy != FDP.Zero)
		{
			num4 = (float)(info.currentEnergy / info.totalEnergy);
		}
		float num5 = (float)info.currentUseInterval;
		float num6 = (float)(info.sectionResumeTime - info.currentResumeTime);
		arrSyncData[0] = info.skillId;
		arrSyncData[1] = num;
		arrSyncData[2] = num2;
		arrSyncData[3] = num3;
		arrSyncData[4] = num4;
		arrSyncData[5] = num5;
		arrSyncData[6] = num6;
		arrSyncData[7] = info.currentSectionAmount;
		arrSyncData[8] = info.totalSectionAmount;
		SyncSkillBtnToLua?.Invoke(arrSyncData, info.locking, info.beginResume, info.canUseAssitSkill);
	}

	public void UpdateSkillCD(FP deltaTime)
	{
		List<SkillInfo> list = skillInfos;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < skillInfos.Count; i++)
		{
			bNeedSyncToLua = false;
			SkillInfo skillInfo = skillInfos.get_Item(i);
			if (skillInfo.currentUseInterval > 0)
			{
				skillInfo.currentUseInterval -= deltaTime;
				if (skillInfo.currentUseInterval <= 0)
				{
					skillInfo.currentUseInterval = 0;
				}
				bNeedSyncToLua = true;
			}
			if (!skillInfo.locking)
			{
				if (skillInfo.beginResume && skillInfo.currentSectionAmount < skillInfo.totalSectionAmount)
				{
					skillInfo.resuming = true;
					skillInfo.sectionResumeTime = GetCurrentSectionResumeTime(skillInfo);
					skillInfo.currentResumeTime += deltaTime;
					if (skillInfo.currentResumeTime >= skillInfo.sectionResumeTime)
					{
						skillInfo.currentSectionAmount++;
						skillInfo.currentResumeTime = 0;
					}
					bNeedSyncToLua = true;
				}
				if (skillInfo.currentSectionAmount >= skillInfo.totalSectionAmount)
				{
					skillInfo.beginResume = false;
					skillInfo.resuming = false;
				}
			}
			if (skillInfo.lockStateChange)
			{
				skillInfo.lockStateChange = false;
				bNeedSyncToLua = true;
				skillInfo.sectionResumeTime = GetCurrentSectionResumeTime(skillInfo);
			}
			if (skillInfo.currentUseTimeHint > 0)
			{
				skillInfo.currentUseTimeHint -= deltaTime;
				if (skillInfo.currentUseTimeHint <= 0)
				{
					skillInfo.currentUseTimeHint = 0;
					AdventureActorSkillUseHintFinishEvent adventureActorSkillUseHintFinishEvent = AdventureActorSkillUseHintFinishEvent.Generate();
					adventureActorSkillUseHintFinishEvent.sender = _actor;
					adventureActorSkillUseHintFinishEvent.skillId = skillInfo.skillId;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorSkillUseHintFinishEvent);
				}
				bNeedSyncToLua = true;
			}
			if (skillInfo.isAssistSkill)
			{
				bool isAssistAIFinish = ((PlayerAdventureActor)_actor).isAssistAIFinish;
				if (skillInfo.canUseAssitSkill != isAssistAIFinish)
				{
					skillInfo.canUseAssitSkill = isAssistAIFinish;
					bNeedSyncToLua = true;
				}
			}
			if (bNeedSyncToLua)
			{
				DoSyncSkillBtnToLua(skillInfo);
			}
		}
		foreach (KeyValuePair<int, SkillEnergyInfo> item in dicSkillEnergy)
		{
			SkillEnergyInfo value = item.Value;
			if (value.removeList.Count > 0 && _actor.LogicTime > value.removeList.get_Item(0))
			{
				item.Value.curEnergy = TSMath.Max(0, item.Value.curEnergy - item.Value.deltaEnergy);
				item.Value.maxEnergy = TSMath.Max(0, item.Value.maxEnergy - item.Value.deltaEnergy);
				value.removeList.RemoveAt(0);
			}
		}
	}

	public void LockSkillCD(ActionKey actionKey)
	{
		SkillInfo skillCD = GetSkillCD(actionKey);
		if (skillCD != null && !skillCD.locking)
		{
			skillCD.locking = true;
		}
	}

	public void LockSkillCD(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null && !skillCD.locking)
		{
			skillCD.locking = true;
		}
	}

	public void UnLockSkillCD(ActionKey actionKey)
	{
		SkillInfo skillCD = GetSkillCD(actionKey);
		if (skillCD != null && skillCD.locking)
		{
			skillCD.locking = false;
		}
	}

	public void UnLockSkillCD(int skillId)
	{
		SkillInfo skillCD = GetSkillCD(skillId);
		if (skillCD != null && skillCD.locking)
		{
			skillCD.locking = false;
		}
	}

	public bool CheckSkillIsLocking(int skillId)
	{
		return GetSkillCD(skillId)?.locking ?? false;
	}

	public void Clear()
	{
		foreach (SkillInfo skillInfo in skillInfos)
		{
			skillInfo.currentEnergy = FDP.Zero;
		}
		skillInfos.Clear();
		_skillIdBindDict.Clear();
		dicSkillEnergy.Clear();
	}
}
