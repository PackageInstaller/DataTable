using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class SkillComponent : BaseComponent
{
	private HeroEntity _heroEntity;

	private Dictionary<int, bool> _recodeSkillDrag;

	private AIParadoxComponent _aiParadoxComponent;

	private List<HeroSkillTypeEnum> skillBtnHide = new List<HeroSkillTypeEnum>(7);

	private List<HeroSkillTypeEnum> skillCantRelease = new List<HeroSkillTypeEnum>(7);

	private SummonedComponent _summonedComponent;

	private bool isSkillDeriving;

	private float dragSkillJudge;

	public bool IsSkillDeriving => isSkillDeriving;

	public void GlobalAddition(AdditionKind additionKind, float addition)
	{
		SkillAdditionGlobal(additionKind, addition);
	}

	public void SkillAddition(int skillId, HeroSkillTypeEnum heroSkillTypeEnum, AdditionKind additionKind, float addition, SkillAdditionType skillAdditionType)
	{
		if (skillAdditionType == SkillAdditionType.SkillId)
		{
			GetSkillData(skillId)?.SetSkillAddition(additionKind, addition);
			return;
		}
		List<HeroSkillData> skillGroup = GetSkillGroup(heroSkillTypeEnum);
		if (skillGroup != null)
		{
			for (int i = 0; i < skillGroup.Count; i++)
			{
				skillGroup[i].SetSkillAddition(additionKind, addition);
			}
		}
	}

	public void SkillAdditionGlobal(AdditionKind additionKind, float addition, bool isBuffAddition = false)
	{
		if (isBuffAddition)
		{
			switch (additionKind)
			{
			case AdditionKind.Damage:
				mBaseEntity.ChangePropertyBuff("DamageAddition", addition);
				break;
			case AdditionKind.Tenacity:
				mBaseEntity.ChangePropertyBuff("TenacityAddition", addition);
				break;
			case AdditionKind.Cure:
				mBaseEntity.ChangePropertyBuff("CureAddition", addition);
				break;
			}
		}
		else
		{
			switch (additionKind)
			{
			case AdditionKind.Damage:
				mBaseEntity.ChangeProperty("DamageAddition", addition);
				break;
			case AdditionKind.Tenacity:
				mBaseEntity.ChangeProperty("TenacityAddition", addition);
				break;
			case AdditionKind.Cure:
				mBaseEntity.ChangeProperty("CureAddition", addition);
				break;
			}
		}
	}

	public PropertyData GetSkillAddtionGlobal(AdditionKind additionKind)
	{
		return additionKind switch
		{
			AdditionKind.Damage => mBaseEntity.GetPropertyData("DamageAddition"), 
			AdditionKind.Tenacity => mBaseEntity.GetPropertyData("TenacityAddition"), 
			AdditionKind.Cure => mBaseEntity.GetPropertyData("CureAddition"), 
			_ => null, 
		};
	}

	public void SkillAddition(HeroSkillTypeEnum skillTypeEnum, AdditionKind additionKind, float addition, bool isGlobalAddition)
	{
		if (isGlobalAddition)
		{
			SkillAdditionGlobal(additionKind, addition);
		}
		else
		{
			GetSkillData(skillTypeEnum)?.SetSkillAddition(additionKind, addition);
		}
	}

	public SkillAdditionData GetSkillAddition(int skillId)
	{
		return GetSkillData(skillId)?.SkillAdditionData;
	}

	private void RefreshCacheTime(HeroSkillTypeEnum heroSkillTypeEnum, int skillState)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		value?.RefreshTime(skillState);
	}

	public void AmendCommandCacheTime(HeroSkillTypeEnum heroSkillTypeEnum, float cacheTime)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		value?.AmendCommandCacheTime(cacheTime);
	}

	public void RestoreCacheTime(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		value?.RestoreCacheTime();
	}

	public bool CommandIsCache(HeroSkillTypeEnum heroSkillTypeEnum, int skillState)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		if (value == null)
		{
			return false;
		}
		return skillState switch
		{
			1 => value.IsDown, 
			3 => value.IsUp, 
			_ => false, 
		};
	}

	public void OpenCommandReceiveWindow(List<HeroSkillTypeEnum> heroSkillTypeEnumList, bool open)
	{
		if (heroSkillTypeEnumList == null || heroSkillTypeEnumList.Count == 0)
		{
			return;
		}
		for (int i = 0; i < heroSkillTypeEnumList.Count; i++)
		{
			GetCommandCacheData().TryGetValue(heroSkillTypeEnumList[i], out var value);
			if (value == null)
			{
				break;
			}
			value.OpenCommandReceiveWindow(open);
		}
	}

	public bool IsReceiveCommand(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		return value?.IsReceive ?? false;
	}

	public void ClearCommandCache(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		value?.ClearCommandCache();
	}

	public void SetCommandBreak(HeroSkillTypeEnum heroSkillTypeEnum, List<HeroSkillTypeEnum> breakHeroSkillTypeEnumList, bool openBreak)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		value?.SetCommandBreak(breakHeroSkillTypeEnumList, openBreak);
	}

	public bool CommandBreakWindowIsOpen(HeroSkillTypeEnum heroSkillTypeEnum, HeroSkillTypeEnum breakHeroSkillTypeEnum)
	{
		GetCommandCacheData().TryGetValue(heroSkillTypeEnum, out var value);
		return value?.CommandBreakWindowIsOpen(breakHeroSkillTypeEnum) ?? false;
	}

	private Dictionary<HeroSkillTypeEnum, CommandCacheData> GetCommandCacheData()
	{
		BattleHeroData battleHeroData = ((HeroEntity)mBaseEntity)?.BattleHeroData;
		if (battleHeroData == null)
		{
			return null;
		}
		_ = battleHeroData.CommandCacheDataDic;
		return battleHeroData.CommandCacheDataDic;
	}

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_heroEntity = (HeroEntity)mBaseEntity;
		if (_heroEntity != null)
		{
			_recodeSkillDrag = new Dictionary<int, bool>();
			dragSkillJudge = _heroEntity.GetWorld().BattleConfig.dragSkillJudge;
		}
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if (mBaseEntity.IsActorEntity)
		{
			mBaseEntity.GetSystem<TouchSystem>().BindTargetEntity((HeroEntity)mBaseEntity);
		}
		_aiParadoxComponent = mBaseEntity.GetComponent<AIParadoxComponent>();
		_summonedComponent = mBaseEntity.GetComponent<SummonedComponent>();
	}

	public bool CheckUnlockSkillEffect(int skillEffectId)
	{
		ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> heroSkillData = GetHeroSkillData();
		if (heroSkillData == null)
		{
			return false;
		}
		foreach (HeroSkillData value in heroSkillData.Values)
		{
			if (value.UnlockDeriveSkillList.Contains(skillEffectId))
			{
				return true;
			}
		}
		return false;
	}

	public int GetSkillReleaseType(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		return GetSkillData(heroSkillTypeEnum)?.SKillConfig.SkillReleaseType ?? 0;
	}

	public float GetSkillPoisedTime(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		return GetSkillData(heroSkillTypeEnum)?.SKillConfig.PropSkillTime ?? 0f;
	}

	private ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> GetHeroSkillData()
	{
		return (((HeroEntity)mBaseEntity)?.BattleHeroData)?.CommandType2HeroData;
	}

	public ObservableDictionary<int, HeroSkillData> GetHeroAllSkillData()
	{
		return (((HeroEntity)mBaseEntity)?.BattleHeroData)?.HeroSKillData;
	}

	public HeroSkillData GetSkillData(int skillId)
	{
		ObservableDictionary<int, HeroSkillData> heroAllSkillData = GetHeroAllSkillData();
		if (heroAllSkillData == null)
		{
			return null;
		}
		heroAllSkillData.TryGetValue(skillId, out var value);
		return value;
	}

	public List<HeroSkillData> GetSkillDataListByLabel(string label)
	{
		ObservableDictionary<int, HeroSkillData> heroAllSkillData = GetHeroAllSkillData();
		if (heroAllSkillData == null)
		{
			return null;
		}
		List<HeroSkillData> list = CollectionPool<List<HeroSkillData>, HeroSkillData>.Get();
		foreach (HeroSkillData value in heroAllSkillData.Values)
		{
			if (value.ContainsSkillLabel(label))
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<HeroSkillData> GetSkillDataListByLabel(ObserverConditionParams[] paramArr)
	{
		if (paramArr.IsNullOrEmpty())
		{
			return null;
		}
		ObservableDictionary<int, HeroSkillData> heroAllSkillData = GetHeroAllSkillData();
		if (heroAllSkillData == null)
		{
			return null;
		}
		List<HeroSkillData> list = CollectionPool<List<HeroSkillData>, HeroSkillData>.Get();
		foreach (HeroSkillData value in heroAllSkillData.Values)
		{
			bool flag = true;
			foreach (ObserverConditionParams observerConditionParams in paramArr)
			{
				if (value.ContainsSkillLabel(observerConditionParams.ParamString) != observerConditionParams.Compare)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<HeroSkillData> GetSkillGroup(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		BattleHeroData battleHeroData = ((HeroEntity)mBaseEntity)?.BattleHeroData;
		if (battleHeroData == null)
		{
			return null;
		}
		if (battleHeroData.CommandBindSkillGroup.TryGetValue(heroSkillTypeEnum, out var value))
		{
			return value;
		}
		return null;
	}

	public HeroSkillData GetSkillData(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		if (heroSkillTypeEnum == HeroSkillTypeEnum.None)
		{
			return null;
		}
		ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> heroSkillData = GetHeroSkillData();
		if (heroSkillData == null)
		{
			return null;
		}
		heroSkillData.TryGetValue(heroSkillTypeEnum, out var value);
		return value;
	}

	public HeroSkillTypeEnum GetSkillBindCommand(int skillId)
	{
		ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> heroSkillData = GetHeroSkillData();
		if (heroSkillData == null)
		{
			return HeroSkillTypeEnum.None;
		}
		foreach (KeyValuePair<HeroSkillTypeEnum, HeroSkillData> item in heroSkillData)
		{
			if (item.Value.Id == skillId)
			{
				return item.Key;
			}
		}
		return HeroSkillTypeEnum.None;
	}

	public void ExecuteCommand(MsgPlayerInput playerInput)
	{
		_aiParadoxComponent?.SetVariableValues("UnSync_moveJoystickInput", playerInput.inputUV);
		_aiParadoxComponent?.SetVariableValues("SkillInputJoystick", playerInput.skillJoyUv);
		_summonedComponent?.UpdateSummonedEntityUv("UnSync_moveJoystickInput", playerInput.inputUV);
		_summonedComponent?.UpdateSummonedEntityUv("SkillInputJoystick", playerInput.skillJoyUv);
		if (playerInput.optionCode != HeroSkillTypeEnum.None && IsReceiveCommand(playerInput.optionCode))
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"执行技能指令 optionCode : {playerInput.optionCode} inputUV : {playerInput.inputUV}" + $" skillJoyUv : {playerInput.skillJoyUv}  SkillState : {playerInput.SkillState}", mBaseEntity);
			}
			_aiParadoxComponent?.SetVariableValues("s_inputCommand", playerInput.optionCode);
			_aiParadoxComponent?.SetVariableValues("s_inputCommandState", playerInput.SkillState);
			_summonedComponent?.UpdateSummonedEntityUv("s_inputCommand", playerInput.optionCode);
			_summonedComponent?.UpdateSummonedEntityUv("s_inputCommandState", playerInput.SkillState);
			if (playerInput.SkillState == 3 || playerInput.SkillState == 1)
			{
				RefreshCacheTime(playerInput.optionCode, playerInput.SkillState);
			}
			if (playerInput.SkillState == 2 || playerInput.SkillState == 3)
			{
				RecodeIsDragSkill(playerInput.optionCode, playerInput.skillJoyUv);
			}
			if (playerInput.SkillState == 4)
			{
				RefreshSkillData();
				SkillCanel(playerInput.optionCode);
			}
			if (playerInput.SkillState == 4 || playerInput.SkillState == 3)
			{
				SetDragSkillJudge(mBaseEntity.GetWorld().BattleConfig.dragSkillJudge);
			}
		}
	}

	private void ReleaseSkill(int releaseSkillId, bool isCd, string skillLabel, Vector3 skillPosition, List<int> cdSkillList, SkillExecuteState skillExecuteState)
	{
		HeroSkillTypeEnum skillBindCommand = GetSkillBindCommand(releaseSkillId);
		RefreshSkillData();
		HeroSkillData skillData = GetSkillData(releaseSkillId);
		if (skillData != null)
		{
			mBaseEntity.GetComponent<CoolingComponent>().ReleaseSkill(releaseSkillId, isCd);
			mBaseEntity.GetComponent<CoolingComponent>().AccompanySkillCd(cdSkillList, releaseSkillId);
			skillData.CreateBuff();
			if (skillBindCommand == HeroSkillTypeEnum.PropSkill || skillBindCommand == HeroSkillTypeEnum.DeputyPropSkill)
			{
				SetPropTreeSkillData(skillData, skillBindCommand, skillPosition);
			}
		}
	}

	private void SetPropTreeSkillData(HeroSkillData heroSkillData, HeroSkillTypeEnum heroSkillTypeEnum, Vector3 skillPosition)
	{
		if (heroSkillData != null)
		{
			mBaseEntity.GetComponent<AIParadoxComponent>().SetPropSkillVariableValues(heroSkillData.PropId, (heroSkillData.SkillCoolingData?.BpData?.Level).GetValueOrDefault(), skillPosition, heroSkillTypeEnum);
		}
	}

	public bool IsCanReleaseCommand(HeroSkillTypeEnum commandType)
	{
		if (GetHeroSkillData().TryGetValue(commandType, out var value) && value != null)
		{
			return IsCanReleaseSkill(value.Id);
		}
		return false;
	}

	public bool IsCanReleaseSkill(int skillId)
	{
		if (!SkillCantRelease(skillId))
		{
			return false;
		}
		if (GetSkillData(skillId) == null)
		{
			return false;
		}
		if (!mBaseEntity.GetComponent<CoolingComponent>().CanRelease(skillId))
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"冷却无法释放技能 ： {skillId}", mBaseEntity);
			}
			return false;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"可以释放技能 ： {skillId}", mBaseEntity);
		}
		return true;
	}

	private bool SkillCantRelease(int skillId)
	{
		for (int i = 0; i < skillBtnHide.Count; i++)
		{
			HeroSkillData skillData = GetSkillData(skillBtnHide[i]);
			if (skillData != null && skillData.Id == skillId)
			{
				return false;
			}
		}
		for (int j = 0; j < skillCantRelease.Count; j++)
		{
			HeroSkillData skillData2 = GetSkillData(skillCantRelease[j]);
			if (skillData2 != null && skillData2.Id == skillId)
			{
				return false;
			}
		}
		return true;
	}

	public void SetStateIsCanReleaseSkill(bool isCan)
	{
		ObservableDictionary<int, HeroSkillData> heroAllSkillData = GetHeroAllSkillData();
		if (heroAllSkillData == null)
		{
			return;
		}
		foreach (HeroSkillData value in heroAllSkillData.Values)
		{
			value.SkillCoolingData.SetStateIsCanReleaseSkill(isCan);
		}
	}

	public void SetAbStateIsCanReleaseSkill(List<string> notReleaseLabel)
	{
		ObservableDictionary<int, HeroSkillData> heroAllSkillData = GetHeroAllSkillData();
		if (heroAllSkillData == null)
		{
			return;
		}
		foreach (HeroSkillData value in heroAllSkillData.Values)
		{
			bool abnormalStateIsCanReleaseSkill = true;
			foreach (string item in notReleaseLabel)
			{
				if (value.GetSkillLabelList().Contains(item))
				{
					abnormalStateIsCanReleaseSkill = false;
					break;
				}
			}
			value.SkillCoolingData.SetAbnormalStateIsCanReleaseSkill(abnormalStateIsCanReleaseSkill);
		}
	}

	public void SetStateIsCanReleaseSkill(bool isCan, List<HeroSkillTypeEnum> heroSkillTypeEnumList)
	{
		for (int i = 0; i < heroSkillTypeEnumList.Count; i++)
		{
			SetStateIsCanReleaseSkill(isCan, heroSkillTypeEnumList[i]);
		}
	}

	public void SetStateIsCanReleaseSkill(bool isCan, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		GetSkillData(heroSkillTypeEnum)?.SkillCoolingData.SetStateIsCanReleaseSkill(isCan);
	}

	public void ReleaseAiSkill(int aiIndex)
	{
		List<int> teamEntityId = mBaseEntity.GetSystem<EntitySystem>().GetTeamEntityId(mBaseEntity.Id, isIncludeEntity: false);
		if (teamEntityId.Count >= aiIndex + 1)
		{
			BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(teamEntityId[aiIndex]);
			if (entity != null && entity.IsSurvival)
			{
				entity.GetSystem<CommandSystem>().CollectAiSkill(teamEntityId[aiIndex], "AiButtonReleaseSkill", 1);
			}
		}
		CollectionPool<List<int>, int>.Release(teamEntityId);
	}

	public void SetSkillStrengthen(int skillId, bool isStrength)
	{
		GetSkillData(skillId)?.SetSkillStrengthen(isStrength);
	}

	public bool GetPropSkillCanBreakState(HeroSkillTypeEnum heroSkillTypeEnum, int stateId)
	{
		HeroSkillData skillData = GetSkillData(heroSkillTypeEnum);
		if (skillData != null && skillData.SkillExecuteBreakState.Contains(stateId))
		{
			return true;
		}
		return false;
	}

	public void SetSkillStateCanRelease(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		GetSkillData(heroSkillTypeEnum).SkillCoolingData.SetStateIsCanReleaseSkill(isCan: true);
	}

	public void SetAbnormalStateCanRelease(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		GetSkillData(heroSkillTypeEnum)?.SkillCoolingData?.SetAbnormalStateIsCanReleaseSkill(isCan: true);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_recodeSkillDrag.Clear();
		_recodeSkillDrag = null;
		_aiParadoxComponent = null;
		_summonedComponent = null;
	}

	public void SetSkillBtnHide(HeroSkillTypeEnum skillTypeEnum, bool isHide)
	{
		if (isHide)
		{
			if (!skillBtnHide.Contains(skillTypeEnum))
			{
				skillBtnHide.Add(skillTypeEnum);
			}
		}
		else if (skillBtnHide.Contains(skillTypeEnum))
		{
			skillBtnHide.Remove(skillTypeEnum);
		}
	}

	public void SetSkillCanRelease(HeroSkillTypeEnum skillTypeEnum, bool canRelease)
	{
		if (!canRelease)
		{
			if (!skillCantRelease.Contains(skillTypeEnum))
			{
				skillCantRelease.Add(skillTypeEnum);
			}
		}
		else if (skillCantRelease.Contains(skillTypeEnum))
		{
			skillCantRelease.Remove(skillTypeEnum);
		}
	}

	public void ResetPropSkillNumber()
	{
		foreach (HeroSkillData value in GetHeroAllSkillData().Values)
		{
			if (value.SkillCoolingData.IsPropSkill)
			{
				value.SkillCoolingData.ResetPropNumber();
			}
		}
	}

	public void SetPropNumberToSpeicalMode()
	{
		foreach (HeroSkillData value in GetHeroAllSkillData().Values)
		{
			SkillCoolingData skillCoolingData = value.SkillCoolingData;
			if (skillCoolingData != null && skillCoolingData.IsPropSkill)
			{
				skillCoolingData.SetPropNumberToSpeicalMode();
			}
		}
	}

	private void SkillCanel(HeroSkillTypeEnum skillTypeEnum)
	{
		HeroSkillData skillData = GetSkillData(skillTypeEnum);
		if (skillData != null)
		{
			ObserverSkillCanelParams observerSkillCanelParams = ReferencePool.Acquire<ObserverSkillCanelParams>();
			observerSkillCanelParams.Init(skillData.Id, mBaseEntity);
			mBaseEntity.GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.SkillCancel, observerSkillCanelParams);
			ReferencePool.Release(observerSkillCanelParams);
		}
	}

	public void SetSkillNormalShow(int skillId, bool isShow)
	{
		GetSkillData(skillId)?.SetSkillShow(isShow);
	}

	public void SwitchSkillBind(HeroSkillTypeEnum heroSkillTypeEnum, int skillId)
	{
		HeroSkillData heroSkillData = GetSkillData(skillId);
		if (heroSkillData == null)
		{
			DRHeroSKillConfig dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig data) => data.Id == skillId);
			if (dataRow != null)
			{
				heroSkillData = HeroSkillData.Create(dataRow, mBaseEntity, "", xpSkill: false);
				GetHeroAllSkillData().Add(skillId, heroSkillData);
				GetHeroSkillData()[heroSkillTypeEnum] = heroSkillData;
			}
			else if (GetHeroSkillData().ContainsKey(heroSkillTypeEnum))
			{
				GetHeroSkillData().Remove(heroSkillTypeEnum);
			}
		}
		mBaseEntity.GetSystem<TouchSystem>().OnSkillDerive((HeroEntity)mBaseEntity, heroSkillTypeEnum, heroSkillData);
	}

	public void OpenSkillDeriveWindow(HeroSkillTypeEnum heroSkillTypeEnum, int skillId, int deriveSKillId, float deriveTime, bool restoreDeriveTime, int deriveNumber, bool isStateDerive)
	{
		HeroSkillData skillData = GetSkillData(deriveSKillId);
		if (skillData == null || !skillData.IsDeriveSkill || skillData.IsDerive)
		{
			return;
		}
		HeroSkillData skillData2 = GetSkillData(skillId);
		if (skillData2 == null || (skillData2.IsDeriveSkill && !skillData2.IsDeriving))
		{
			return;
		}
		bool isDerive = skillData2.IsDerive;
		if (skillData2.RegisterDeriveSkill(deriveSKillId))
		{
			skillData.OpenDeriveWindow(deriveTime, restoreDeriveTime, heroSkillTypeEnum, skillData2, deriveNumber, isStateDerive);
			if (!isDerive)
			{
				GetHeroSkillData()[heroSkillTypeEnum] = skillData;
				mBaseEntity.GetSystem<TouchSystem>().OnSkillDerive((HeroEntity)mBaseEntity, heroSkillTypeEnum, skillData);
				isSkillDeriving = true;
				ObserverSkillDeriveWindowParams observerSkillDeriveWindowParams = ReferencePool.Acquire<ObserverSkillDeriveWindowParams>();
				observerSkillDeriveWindowParams.Init(mBaseEntity, heroSkillTypeEnum, skillData2, skillData, isDerive: true);
				mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.SkillDeriveWindow, observerSkillDeriveWindowParams);
				ReferencePool.Release(observerSkillDeriveWindowParams);
			}
		}
	}

	public void HideSkillDeriveWindow(int deriveSkillId)
	{
		HeroSkillData skillData = GetSkillData(deriveSkillId);
		if (skillData != null && skillData.IsDeriving)
		{
			skillData.HideSkillDeriveWindow();
		}
	}

	public void OnDeriveWindowEnd(int originalSkillId, int skillId, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		HeroSkillData skillData = GetSkillData(skillId);
		if (skillData == null || !skillData.IsDeriving)
		{
			return;
		}
		HeroSkillData skillData2 = GetSkillData(originalSkillId);
		if (skillData2 == null)
		{
			return;
		}
		skillData2.OnCreateDeriveSkillWindowEnd(skillId);
		if (skillData.IsDeriveSkill && skillData.IsDerive)
		{
			return;
		}
		HeroSkillData heroSkillData = ReverseGetSkill(originalSkillId, skillId);
		if (heroSkillData != null)
		{
			GetHeroSkillData()[heroSkillTypeEnum] = heroSkillData;
			mBaseEntity.GetSystem<TouchSystem>().OnSkillDerive((HeroEntity)mBaseEntity, heroSkillTypeEnum, heroSkillData);
			if (!skillData.GetSkillLabelList().Contains("DeriveEndDonotAutoCancel"))
			{
				mBaseEntity.GetSystem<TouchSystem>().SkillDeriveEnd((HeroEntity)mBaseEntity, heroSkillTypeEnum, skillId);
			}
			isSkillDeriving = false;
			ObserverSkillDeriveWindowParams observerSkillDeriveWindowParams = ReferencePool.Acquire<ObserverSkillDeriveWindowParams>();
			observerSkillDeriveWindowParams.Init(mBaseEntity, heroSkillTypeEnum, skillData2, skillData, isDerive: false);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.SkillDeriveWindow, observerSkillDeriveWindowParams);
			ReferencePool.Release(observerSkillDeriveWindowParams);
		}
	}

	private HeroSkillData ReverseGetSkill(int originalSkillId, int deriveSKillId)
	{
		HeroSkillData skillData = GetSkillData(originalSkillId);
		if (skillData == null)
		{
			return null;
		}
		if (!skillData.IsDeriveSkill && !skillData.IsDerive)
		{
			return skillData;
		}
		if (!skillData.IsDeriveSkill && skillData.IsDerive)
		{
			int latestDeriveSkillId = skillData.GetLatestDeriveSkillId();
			return ForwardGetSkill(skillData.Id, latestDeriveSkillId);
		}
		if (skillData.IsDeriveSkill && skillData.IsDeriving && !skillData.IsDerive)
		{
			return skillData;
		}
		if (skillData.IsDeriveSkill && skillData.IsDeriving && skillData.IsDerive)
		{
			int latestDeriveSkillId2 = skillData.GetLatestDeriveSkillId();
			return ForwardGetSkill(originalSkillId, latestDeriveSkillId2);
		}
		if (skillData.IsDeriveSkill && !skillData.IsDeriving && skillData.IsDerive)
		{
			int latestDeriveSkillId3 = skillData.GetLatestDeriveSkillId();
			return ForwardGetSkill(originalSkillId, latestDeriveSkillId3);
		}
		if (skillData.IsDeriveSkill && !skillData.IsDeriving && !skillData.IsDerive)
		{
			HeroSkillData skillData2 = GetSkillData(deriveSKillId);
			if (skillData2 == null)
			{
				return null;
			}
			return ReverseGetSkill(skillData2.OriginalDeriveSkillOriginalId, originalSkillId);
		}
		return null;
	}

	private HeroSkillData ForwardGetSkill(int originalSkillId, int deriveSKillId)
	{
		HeroSkillData skillData = GetSkillData(deriveSKillId);
		if (skillData == null)
		{
			return null;
		}
		if (!skillData.IsDeriveSkill)
		{
			return null;
		}
		if (skillData.IsDeriveSkill && !skillData.IsDeriving && !skillData.IsDerive)
		{
			return null;
		}
		if (skillData.IsDeriveSkill && skillData.IsDeriving && !skillData.IsDerive)
		{
			return skillData;
		}
		if (skillData.IsDeriveSkill && !skillData.IsDeriving && skillData.IsDerive)
		{
			int latestDeriveSkillId = skillData.GetLatestDeriveSkillId();
			return ForwardGetSkill(skillData.Id, latestDeriveSkillId);
		}
		if (skillData.IsDeriveSkill && skillData.IsDeriving && skillData.IsDerive)
		{
			int latestDeriveSkillId2 = skillData.GetLatestDeriveSkillId();
			return ForwardGetSkill(skillData.Id, latestDeriveSkillId2);
		}
		return null;
	}

	public void AmendSkillLayer(int skillId, int skillLayer)
	{
		GetSkillData(skillId)?.AmendSkillLayer(skillLayer);
	}

	public int GetSkillLayer(int skillId)
	{
		return GetSkillData(skillId)?.CacheLayer ?? 0;
	}

	private bool IsDragSkill(Vector2 skillUv)
	{
		return skillUv.SqrMagnitude() > dragSkillJudge * dragSkillJudge;
	}

	public void SetDragSkillJudge(float dragValue)
	{
		dragSkillJudge = dragValue;
	}

	public bool GetSkillDegAndPosition(int skillId, Vector2 skillUv, Vector2 moveUv, ref float deg, ref Vector3 position, ref int monsterId, string boneKey)
	{
		HeroSkillData skillData = GetSkillData(skillId);
		if (skillData == null)
		{
			return false;
		}
		bool isDragSkill = IsDragSkill(skillId);
		return AffirmSkillAngle(skillUv, moveUv, isDragSkill, skillData, ref deg, ref position, ref monsterId, boneKey);
	}

	public bool GetInteractiveSkillDegAndPosition(int skillId, Vector2 skillUv, Vector2 moveUv, ref float deg, ref Vector3 position, string boneKey)
	{
		HeroSkillData skillData = GetSkillData(skillId);
		if (skillData == null)
		{
			return false;
		}
		bool isDragSkill = IsDragSkill(skillId);
		return InteractiveAffirmSkillAngle(skillUv, moveUv, isDragSkill, skillData, ref deg, ref position, boneKey);
	}

	public void GetDragSkillDegAndPosition(int skillId, Vector2 skillUv, Vector2 moveUv, ref float deg, ref Vector3 position)
	{
		HeroSkillData skillData = GetSkillData(skillId);
		if (skillData != null)
		{
			ComputeSkillAngleAndPosition(new Vector3(skillUv.x, 0f, skillUv.y), skillData.SkillRange, ref deg, ref position);
		}
	}

	private void RecodeIsDragSkill(HeroSkillTypeEnum heroSkillTypeEnum, Vector2 skillUv)
	{
		bool flag = IsDragSkill(skillUv);
		HeroSkillData skillData = GetSkillData(heroSkillTypeEnum);
		if (skillData != null && flag)
		{
			_recodeSkillDrag.TryAdd(skillData.Id, value: true);
		}
	}

	public void RecodeIsDragSkill(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		HeroSkillData skillData = GetSkillData(heroSkillTypeEnum);
		if (skillData != null)
		{
			_recodeSkillDrag.TryAdd(skillData.Id, value: true);
		}
	}

	public void RefreshSkillData()
	{
		_recodeSkillDrag.Clear();
	}

	private bool IsDragSkill(int skillId)
	{
		_recodeSkillDrag.TryGetValue(skillId, out var value);
		return value;
	}

	private bool AffirmSkillAngle(Vector2 skillUv, Vector2 moveUv, bool isDragSkill, HeroSkillData sKillInfo, ref float deg, ref Vector3 position, ref int monsterId, string boneKey)
	{
		if (isDragSkill)
		{
			ComputeSkillAngleAndPosition(new Vector3(skillUv.x, 0f, skillUv.y), sKillInfo.SkillRange, ref deg, ref position);
			return false;
		}
		List<BaseEntity> hostileList = mBaseEntity.GetSystem<EntitySystem>().FindTargetEntities(mBaseEntity);
		return ReleaseSkillPostionAndDeg(hostileList, skillUv, moveUv, sKillInfo, ref deg, ref position, ref monsterId, boneKey);
	}

	private bool InteractiveAffirmSkillAngle(Vector2 skillUv, Vector2 moveUv, bool isDragSkill, HeroSkillData sKillInfo, ref float deg, ref Vector3 position, string boneKey)
	{
		if (isDragSkill)
		{
			ComputeSkillAngleAndPosition(new Vector3(skillUv.x, 0f, skillUv.y), sKillInfo.SkillRange, ref deg, ref position);
			return false;
		}
		List<BaseEntity> hostileList = mBaseEntity.GetSystem<EntitySystem>().FindInteractiveEntity();
		int monsterId = 0;
		return ReleaseSkillPostionAndDeg(hostileList, skillUv, moveUv, sKillInfo, ref deg, ref position, ref monsterId, boneKey);
	}

	private bool ReleaseSkillPostionAndDeg(List<BaseEntity> hostileList, Vector2 skillUv, Vector2 moveUv, HeroSkillData sKillInfo, ref float deg, ref Vector3 position, ref int monsterId, string boneKey)
	{
		float num = float.MaxValue;
		float largeCircleLockRadius = sKillInfo.LargeCircleLockRadius;
		largeCircleLockRadius *= largeCircleLockRadius;
		bool flag = false;
		if (string.IsNullOrEmpty(boneKey))
		{
			foreach (BaseEntity hostile in hostileList)
			{
				HitVolume hitVolume = (hostile?.GetComponent<HitColliderComponent>())?.GetClosestVolume(mBaseEntity.transform.position);
				Vector3 position2 = hostile.transform.position;
				Vector3 vector = position2 - mBaseEntity.transform.position;
				if (hitVolume != null)
				{
					position2 += hostile.transform.rotation * hitVolume.VolumeData.offset;
					vector = ((!(hitVolume.VolumeData.offset.sqrMagnitude < 4f)) ? (position2 - mBaseEntity.transform.position) : (hostile.transform.position - mBaseEntity.transform.position));
				}
				position2.y = hostile.transform.position.y;
				float num2 = Vector3.SqrMagnitude(vector);
				if (!(num2 > largeCircleLockRadius))
				{
					flag = true;
					if (num2 < num)
					{
						num = num2;
						deg = Quaternion.LookRotation(vector).eulerAngles.y;
						position = position2;
						monsterId = hostile.Id;
					}
				}
			}
			if (flag)
			{
				CollectionPool<List<BaseEntity>, BaseEntity>.Release(hostileList);
				return true;
			}
			if (moveUv == Vector2.zero)
			{
				deg = mBaseEntity.transform.eulerAngles.y;
				position = mBaseEntity.transform.position + mBaseEntity.transform.rotation * Vector3.forward * sKillInfo.SkillRange / 2f;
			}
			else
			{
				deg = TSUtil.Vector2Angle(moveUv);
				position = mBaseEntity.transform.position + new Vector3(moveUv.x, 0f, moveUv.y) * sKillInfo.SkillRange / 2f;
			}
		}
		else
		{
			VolumeSystem system = mBaseEntity.GetSystem<VolumeSystem>();
			if (system == null)
			{
				CollectionPool<List<BaseEntity>, BaseEntity>.Release(hostileList);
				return false;
			}
			foreach (BaseEntity hostile2 in hostileList)
			{
				HitVolume entityVolume = system.GetEntityVolume(hostile2.Id, boneKey);
				Vector3 position3 = hostile2.transform.position;
				if (entityVolume != null)
				{
					position3 += hostile2.transform.rotation * entityVolume.VolumeData.offset;
				}
				position3.y = hostile2.transform.position.y;
				Vector3 vector2 = position3 - mBaseEntity.transform.position;
				float num3 = Vector3.SqrMagnitude(vector2);
				if (!(num3 > largeCircleLockRadius))
				{
					flag = true;
					if (num3 < num)
					{
						num = num3;
						deg = Quaternion.LookRotation(vector2).eulerAngles.y;
						position = position3;
						monsterId = hostile2.Id;
					}
				}
			}
			if (flag)
			{
				CollectionPool<List<BaseEntity>, BaseEntity>.Release(hostileList);
				return true;
			}
			if (moveUv == Vector2.zero)
			{
				deg = mBaseEntity.transform.eulerAngles.y;
				position = mBaseEntity.transform.position + mBaseEntity.transform.rotation * Vector3.forward * sKillInfo.SkillRange / 2f;
			}
			else
			{
				deg = TSUtil.Vector2Angle(moveUv);
				position = mBaseEntity.transform.position + new Vector3(moveUv.x, 0f, moveUv.y) * sKillInfo.SkillRange / 2f;
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(hostileList);
		return false;
	}

	private void ComputeSkillAngleAndPosition(Vector3 uv, float range, ref float deg, ref Vector3 skillPosition)
	{
		Vector3 vector = uv;
		float num = TSUtil.Vector2Angle(new Vector2(uv.x, uv.z).normalized);
		float num2 = range / 2f;
		Vector3 vector2 = mBaseEntity.transform.position + vector * num2;
		deg = num;
		skillPosition = vector2;
	}

	private void ConfirmSkillDirect(bool isDragSkill, int monsterId, ref float deg)
	{
		MonsterEntity monsterEntity = (MonsterEntity)mBaseEntity.GetSystem<EntitySystem>().GetEntity(monsterId);
		if (!isDragSkill && monsterEntity != null && !monsterEntity.GetData<DRMonster>("MonsterConfig").IsEffectRadius)
		{
			float deg2 = 0f;
			HitColliderComponent component = monsterEntity.GetComponent<HitColliderComponent>();
			if (component != null && component.ConfirmSkillDirect(mBaseEntity.transform.position, mBaseEntity.transform.rotation, ref deg2))
			{
				deg = mBaseEntity.transform.eulerAngles.y + deg2;
			}
		}
	}

	public void ExecuteSkillTiming(SkillExecuteState skillExecuteState, int skillId, string skillLabel, Vector3 skillPosition, bool isCd, List<int> cdSkillList)
	{
		HeroSkillData skillData = GetSkillData(skillId);
		if (skillData == null)
		{
			return;
		}
		HeroSkillTypeEnum skillBindCommand = GetSkillBindCommand(skillId);
		switch (skillExecuteState)
		{
		case SkillExecuteState.SkillStart:
			OnSkillStart(skillId);
			break;
		case SkillExecuteState.SkillStartCharge:
			OnSkillStartCharge(skillId);
			skillData?.SetPropSkillChargeState(charge: true);
			if (skillData.GetSkillLabelList().Contains("DynamicRangeSkill"))
			{
				mBaseEntity.GetSystem<TouchSystem>().ShowSkillIndicator(mBaseEntity, skillData, skillBindCommand);
			}
			break;
		case SkillExecuteState.SkillRelease:
			OnSkillRelease(skillId, isCd, skillLabel, skillPosition, cdSkillList, skillExecuteState);
			skillData?.SetPropSkillChargeState(charge: false);
			SkillOverDeleteIndicator(skillData, skillBindCommand, skillId);
			break;
		case SkillExecuteState.SkillEnd:
			OnSkillEnd(skillId);
			skillData?.SetPropSkillChargeState(charge: false);
			SkillOverDeleteIndicator(skillData, skillBindCommand, skillId);
			break;
		case SkillExecuteState.ChargeFail:
			skillData?.SetPropSkillChargeState(charge: false);
			SkillOverDeleteIndicator(skillData, skillBindCommand, skillId);
			break;
		case SkillExecuteState.HammerChargeRelease:
			OnHammerSkillChargeRelease(skillId);
			SkillOverDeleteIndicator(skillData, skillBindCommand, skillId);
			break;
		}
		ObserverReleaseSkillParams observerReleaseSkillParams = ReferencePool.Acquire<ObserverReleaseSkillParams>();
		observerReleaseSkillParams.Init(mBaseEntity, skillExecuteState, skillData, skillBindCommand);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.ReleaseSkill, observerReleaseSkillParams);
		ReferencePool.Release(observerReleaseSkillParams);
	}

	private void SkillOverDeleteIndicator(HeroSkillData skillData, HeroSkillTypeEnum heroSkillTypeEnum, int skillId)
	{
		if (mBaseEntity.IsActorEntity)
		{
			if (skillData.GetSkillLabelList().Contains("DynamicRangeSkill"))
			{
				mBaseEntity.GetSystem<TouchSystem>().DeleteSkillIndicator(heroSkillTypeEnum, skillId);
			}
			else if (skillData.GetSkillLabelList().Contains("DraggablePropSkill"))
			{
				mBaseEntity.GetSystem<TouchSystem>().DeleteSkillIndicator(heroSkillTypeEnum, skillId);
			}
		}
	}

	private void OnSkillStart(int skillId)
	{
		mBaseEntity.GetWeaponMechanism().OnSkillStart(skillId);
		HeroSkillData skillData = GetSkillData(skillId);
		if (skillData != null)
		{
			skillData.ExpendSkillDeriveNumber();
			HeroSkillTypeEnum skillBindCommand = GetSkillBindCommand(skillId);
			if (_heroEntity.IsAi && skillBindCommand == HeroSkillTypeEnum.Skill4)
			{
				_heroEntity.BattleHeroData.AIReleaseSkill4();
			}
		}
	}

	private void OnSkillRelease(int skillId, bool isCd, string skillLabel, Vector3 skillPosition, List<int> cdSkillList, SkillExecuteState skillExecuteState)
	{
		ReleaseSkill(skillId, isCd, skillLabel, skillPosition, cdSkillList, skillExecuteState);
	}

	private void OnSkillEnd(int skillId)
	{
		mBaseEntity.GetWeaponMechanism().OnSkillEnd(skillId);
	}

	private void OnSkillStartCharge(int skillId)
	{
		mBaseEntity.GetWeaponMechanism().OnSkillCharge(skillId);
	}

	private void OnHammerSkillChargeRelease(int skillId)
	{
		mBaseEntity.GetWeaponMechanism().OnHammerSkillChargeRelease(skillId);
	}
}
