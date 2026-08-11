using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase.ECS;

public class CoolingComponent : BaseComponent
{
	private bool _isPause;

	private bool _isOverDraft;

	private float _overDraftTimer;

	private ObservableDictionary<int, HeroSkillData> _coolingDataDic;

	private List<HeroSkillData> _coolingDataCacheList;

	public bool OpenSkillRelease = true;

	public bool OpenEnergyConsume = true;

	public bool OpenSpRelease = true;

	private const string SpSkillTag = "Skill4";

	private ObservableDictionary<int, HeroSkillData> CoolingDataDic
	{
		set
		{
			_coolingDataDic = value;
			_coolingDataCacheList = _coolingDataDic.Values.ToList();
		}
	}

	public bool IsOverDraft => _isOverDraft;

	public override void Init(int index, BaseEntity entity, object data = null)
	{
		base.Init(index, entity, data);
		CoolingDataDic = new ObservableDictionary<int, HeroSkillData>();
		_overDraftTimer = 0f;
		_isOverDraft = false;
	}

	public override void OnPause()
	{
		_isPause = true;
	}

	public override void OnResume()
	{
		_isPause = false;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (_isPause)
		{
			return;
		}
		deltaTime = mBaseEntity?.GetWorld()?.IntervalTimer ?? deltaTime;
		foreach (HeroSkillData coolingDataCache in _coolingDataCacheList)
		{
			coolingDataCache.SkillCoolingData.OnFixedUpdate(deltaTime);
		}
		OverDraftState(deltaTime);
	}

	public bool CanRelease(int skillId)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		return value?.SkillCoolingData.CanRelease() ?? false;
	}

	public void AmendSkillChargeTime(int skillId, float time)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.AmendChargeTime(time);
	}

	public void AmendSkillCurrentChargeTime(int skillId, int number)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.AmendCurrentChargeCount(number);
	}

	public int GetSkillChargeNumber(int skillId)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		if (value == null)
		{
			return 0;
		}
		return value.SkillCoolingData?.CurrentChargeNumber ?? 0;
	}

	public float GetSkillRelease(int skillId, string propertyName)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		return value?.SkillCoolingData.GetSkillPropertyConsume(propertyName) ?? 0f;
	}

	public void ChangeSkillRelease(int skillId, string propertyName, float changeValue, bool isSetValue)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		if (value != null)
		{
			if (isSetValue)
			{
				value.SkillCoolingData.SetSkillPropertyConsume(propertyName, changeValue);
			}
			else
			{
				value.SkillCoolingData.ReviseSkillPropertyConsume(propertyName, changeValue);
			}
		}
	}

	public void ResetSkillRelease(int skillId, string propertyName)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.ResetSkillPropertyConsume(propertyName);
	}

	public float GetCoolingTime(int skillId)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		return value?.SkillCoolingData.CoolingTime ?? 0f;
	}

	public float GetCurCoolingTime(int skillId)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		return value?.SkillCoolingData.CurrentCoolingTime ?? 0f;
	}

	public void SetCoolingTime(int skillId, float changeValue)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.SetCoolingTime(changeValue);
	}

	public void SetCurCoolingTime(int skillId, float changeValue)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.SetCurCoolingTime(changeValue);
	}

	public void ReviseCoolingTime(int skillId, float changeValue)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.ReviseCoolingTime(changeValue);
	}

	public void ReviseCurrentCoolingTime(int skillId, float changeValue)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.ReviseCurrentCoolingTime(changeValue);
	}

	public void ResetCoolingTime(int skillId)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.ResetCoolingTime();
	}

	public void ResetCurCoolingTime(int skillId)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		value?.SkillCoolingData.ResetCurCoolingTime();
	}

	public void RefreshAllSkillCD()
	{
		foreach (HeroSkillData coolingDataCache in _coolingDataCacheList)
		{
			coolingDataCache.SkillCoolingData.SetCurCoolingTime(0f);
			coolingDataCache.SkillCoolingData.AmendCurrentChargeCountToMax();
		}
	}

	public bool ReleaseSkill(int skillId, bool isCd)
	{
		_coolingDataDic.TryGetValue(skillId, out var value);
		if (value == null)
		{
			return false;
		}
		if (CheckIgnoreSkillRelease(value))
		{
			return true;
		}
		return value.SkillCoolingData.Release(isCd, mBaseEntity.IsActorEntity);
	}

	private bool CheckIgnoreSkillRelease(HeroSkillData heroSkillData)
	{
		if (heroSkillData != null && heroSkillData.SKillConfig != null)
		{
			List<string> skillLabelList = heroSkillData.GetSkillLabelList();
			if (skillLabelList != null && skillLabelList.Contains("Skill4"))
			{
				return !OpenSpRelease;
			}
			return !OpenSkillRelease;
		}
		return false;
	}

	public void AccompanySkillCd(List<int> cdSkillList, int releaseSkillId)
	{
		if (cdSkillList == null)
		{
			return;
		}
		_coolingDataDic.TryGetValue(releaseSkillId, out var value);
		if (value == null)
		{
			return;
		}
		for (int i = 0; i < cdSkillList.Count; i++)
		{
			_coolingDataDic.TryGetValue(cdSkillList[i], out var value2);
			if (value2 == null)
			{
				break;
			}
			value2.SkillCoolingData.AccompanySkillCd(value.SkillCoolingData.CoolingTime);
		}
	}

	public void InitCoolingData(ObservableDictionary<int, HeroSkillData> skillDataDic)
	{
		if (skillDataDic != null)
		{
			CoolingDataDic = skillDataDic;
		}
	}

	private void OverDraftState(float deltaTime)
	{
		if (_isOverDraft)
		{
			_overDraftTimer -= deltaTime;
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"开启透支状态：{_isOverDraft} 透支时间  {_overDraftTimer}", mBaseEntity);
			}
			if (_overDraftTimer < 0f)
			{
				_overDraftTimer = 0f;
				_isOverDraft = false;
			}
		}
	}

	public void SetDraftState(float overDraftTimer)
	{
		_isOverDraft = true;
		_overDraftTimer = overDraftTimer;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"实体透支状态：{_isOverDraft}", mBaseEntity);
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		_coolingDataCacheList.Clear();
		_coolingDataCacheList = null;
		_coolingDataDic.Clear();
	}
}
