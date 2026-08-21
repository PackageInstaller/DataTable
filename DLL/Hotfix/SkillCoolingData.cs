#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Text;
using Ase;
using Ase.ECS;
using Ase.Paradox;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

public class SkillCoolingData : ViewModelBase
{
	private const int AmendTrue = 2;

	private const int AmendFalse = 1;

	private bool _stateCanReleaseSkill = true;

	private bool _abnormalStateCanReleaseSkill = true;

	private bool _resourceAmpleReleaseSkill;

	private bool _propNumberAmpleRelSkill = true;

	private List<CoolingBase> _consumeCondition;

	private float _coolingTime;

	private CoolingBase _uitimateSkillXp;

	private float _currentCoolingTime;

	private float _initCoolingTime;

	private float _coolingProgress;

	private bool _accompanySkillCd;

	private bool _isChargeSkill;

	private bool isChargeVisible;

	private int _maxChargeNumber;

	private int _currentChargeNumber;

	private float _initChargeTime;

	private float _chargeTime;

	private float _currentChargeTime;

	private bool isCacheLayerVisible;

	private int _propNumber;

	private bool _isPropSkill;

	private bool isConsumePropToServer;

	private BattleProps _bpData;

	private List<CoolingBase> _necessaryCondition;

	private StringBuilder resourceUnEnoughtTips;

	private int skillLayerTextCount;

	private int bufferLayerTextCount;

	private List<string> resourceUnEnoughtStr;

	private DRHeroSKillConfig SKillConfig;

	private Action<IndicatorDisPlayEnum> indicatorRingAction;

	private bool enableMask;

	private Vector3 canReleEffect;

	private Vector3 abnormalCanReleEffectPos;

	private Vector3 abnormalRedShapPos;

	private Vector3 progressPos;

	private float cdFillAmount;

	private Vector3 cdBGPos;

	private float cdTextValue;

	public BattleProps BpData => _bpData;

	public bool IsPropSkill => _isPropSkill;

	public int PropNumber
	{
		get
		{
			return _propNumber;
		}
		private set
		{
			Set(ref _propNumber, value, "PropNumber");
			PropNumberAmpleRelSkill = value > 0;
		}
	}

	public float CurrentCoolingTime
	{
		get
		{
			return _currentCoolingTime;
		}
		set
		{
			Set(ref _currentCoolingTime, value, "CurrentCoolingTime");
			UpdateCanReleEffect();
			UpdateCDInfo();
		}
	}

	public float CoolingTime
	{
		get
		{
			return _coolingTime;
		}
		private set
		{
			Set(ref _coolingTime, value, "CoolingTime");
			UpdateCDInfo();
		}
	}

	public float InitCoolingTime
	{
		get
		{
			return _initCoolingTime;
		}
		private set
		{
			Set(ref _initCoolingTime, value, "InitCoolingTime");
		}
	}

	public float ChargeTime
	{
		get
		{
			return _chargeTime;
		}
		set
		{
			Set(ref _chargeTime, value, "ChargeTime");
			UpdateCDInfo();
		}
	}

	public float CurrentChargeTime
	{
		get
		{
			return _currentChargeTime;
		}
		set
		{
			Set(ref _currentChargeTime, value, "CurrentChargeTime");
			UpdateCDInfo();
		}
	}

	public int CurrentChargeNumber
	{
		get
		{
			return _currentChargeNumber;
		}
		set
		{
			Set(ref _currentChargeNumber, value, "CurrentChargeNumber");
			UpdateCanReleEffect();
			UpdateCDInfo();
		}
	}

	public int MaxChargeNumber
	{
		get
		{
			return _maxChargeNumber;
		}
		set
		{
			Set(ref _maxChargeNumber, value, "MaxChargeNumber");
		}
	}

	public bool IsChargeSkill
	{
		get
		{
			return _isChargeSkill;
		}
		set
		{
			Set(ref _isChargeSkill, value, "IsChargeSkill");
			UpdateCanReleEffect();
			UpdateCDInfo();
		}
	}

	public bool IsChargeVisible
	{
		get
		{
			return isChargeVisible;
		}
		set
		{
			Set(ref isChargeVisible, value, "IsChargeVisible");
		}
	}

	public bool IsCacheLayerVisible
	{
		get
		{
			return isCacheLayerVisible;
		}
		set
		{
			Set(ref isCacheLayerVisible, value, "IsCacheLayerVisible");
		}
	}

	public bool ResourceAmpleReleaseSkill
	{
		get
		{
			return _resourceAmpleReleaseSkill;
		}
		private set
		{
			Set(ref _resourceAmpleReleaseSkill, value, "ResourceAmpleReleaseSkill");
			UpdateCanReleEffect();
			UpdateAbnormalStateRedShape();
		}
	}

	public bool PropNumberAmpleRelSkill
	{
		get
		{
			return _propNumberAmpleRelSkill;
		}
		private set
		{
			Set(ref _propNumberAmpleRelSkill, value, "PropNumberAmpleRelSkill");
			UpdateCanReleEffect();
			UpdateAbnormalStateRedShape();
		}
	}

	public bool StateCanReleaseSkill
	{
		get
		{
			return _stateCanReleaseSkill;
		}
		private set
		{
			Set(ref _stateCanReleaseSkill, value, "StateCanReleaseSkill");
		}
	}

	public bool AbnormalStateCanReleaseSkill
	{
		get
		{
			return _abnormalStateCanReleaseSkill;
		}
		private set
		{
			Set(ref _abnormalStateCanReleaseSkill, value, "AbnormalStateCanReleaseSkill");
			UpdateCanReleEffect();
			UpdateAbnormStateCanRele();
			UpdateAbnormalStateRedShape();
		}
	}

	public CoolingBase UItimateSkillXp
	{
		get
		{
			return _uitimateSkillXp;
		}
		private set
		{
			Set(ref _uitimateSkillXp, value, "UItimateSkillXp");
		}
	}

	public Vector3 CanReleEffect
	{
		get
		{
			return canReleEffect;
		}
		set
		{
			Set(ref canReleEffect, value, "CanReleEffect");
		}
	}

	public Vector3 AbnormalCanReleEffectPos
	{
		get
		{
			return abnormalCanReleEffectPos;
		}
		set
		{
			Set(ref abnormalCanReleEffectPos, value, "AbnormalCanReleEffectPos");
		}
	}

	public Vector3 AbnormalRedShapPos
	{
		get
		{
			return abnormalRedShapPos;
		}
		set
		{
			Set(ref abnormalRedShapPos, value, "AbnormalRedShapPos");
		}
	}

	public Vector3 ProgressPos
	{
		get
		{
			return progressPos;
		}
		set
		{
			Set(ref progressPos, value, "ProgressPos");
		}
	}

	public float CDFillAmount
	{
		get
		{
			return cdFillAmount;
		}
		set
		{
			Set(ref cdFillAmount, value, "CDFillAmount");
		}
	}

	public Vector3 CDBGPos
	{
		get
		{
			return cdBGPos;
		}
		set
		{
			Set(ref cdBGPos, value, "CDBGPos");
		}
	}

	public float CDTextValue
	{
		get
		{
			return cdTextValue;
		}
		set
		{
			Set(ref cdTextValue, value, "CDTextValue");
		}
	}

	public static SkillCoolingData Create(HeroSkillData heroSkillData, BaseEntity baseEntity)
	{
		SkillCoolingData skillCoolingData = new SkillCoolingData();
		skillCoolingData.InitData(heroSkillData, baseEntity);
		return skillCoolingData;
	}

	public static SkillCoolingData CreateEmpty()
	{
		return new SkillCoolingData();
	}

	private void ShowXpIndicatorRing(bool showEffect)
	{
		if (indicatorRingAction != null)
		{
			indicatorRingAction(showEffect ? IndicatorDisPlayEnum.XpSkillCanRelease : IndicatorDisPlayEnum.XpSkillNoRelease);
		}
	}

	private void InitData(HeroSkillData skillData, BaseEntity baseEntity)
	{
		SKillConfig = skillData.SKillConfig;
		StateCanReleaseSkill = true;
		isConsumePropToServer = true;
		IsChargeSkill = skillData.SKillConfig.IsChargeSkill;
		IsChargeVisible = skillData.SKillConfig.IsChargeVisible;
		IsCacheLayerVisible = skillData.SKillConfig.IsCacheLayerVisible;
		_initChargeTime = skillData.SKillConfig.ChargeTime;
		MaxChargeNumber = skillData.SKillConfig.MaxChargeNumber;
		CurrentChargeNumber = (skillData.SKillConfig.IsInitChargeSuccess ? MaxChargeNumber : 0);
		CurrentChargeTime = (skillData.SKillConfig.IsInitChargeSuccess ? 0f : _initChargeTime);
		ChargeTime = _initChargeTime;
		_coolingTime = skillData.SKillConfig.CoolingTime;
		_initCoolingTime = skillData.SKillConfig.CoolingTime;
		_currentCoolingTime = 0f;
		_consumeCondition = CreateCoolingCondition(skillData.SKillConfig.ConsumeCondition, isConsumeCondition: true, baseEntity);
		if (_consumeCondition != null && _consumeCondition.Count > 0)
		{
			_uitimateSkillXp = _consumeCondition[0];
		}
		_necessaryCondition = CreateCoolingCondition(skillData.SKillConfig.NecessaryCondition, isConsumeCondition: false, baseEntity);
		_isPropSkill = skillData.SKillConfig.IsPropSkill;
		InitUIData();
		if (skillData.IsXpSkill && baseEntity != null)
		{
			HeroIndicatorRingComponent component = baseEntity.GetComponent<HeroIndicatorRingComponent>();
			if (component != null)
			{
				indicatorRingAction = (Action<IndicatorDisPlayEnum>)Delegate.Combine(indicatorRingAction, new Action<IndicatorDisPlayEnum>(component.PlayIndicatorRing));
			}
		}
	}

	public void InitResourceData()
	{
		ResourceAmpleReleaseSkill = true;
		SetResourceEnough();
	}

	public void RegisterPropSkillData(BattleProps bpData)
	{
		_bpData = bpData;
		PropNumber = bpData?.CarryPropNumber ?? 0;
	}

	public void ResetPropNumber()
	{
		PropNumber = _bpData?.CarryPropNumber ?? 0;
	}

	public void SetPropNumberToSpeicalMode()
	{
		isConsumePropToServer = false;
		PropNumber = 999;
	}

	private void ReleaseProp(bool isActorEntity)
	{
		PropNumber = Mathf.Max(_propNumber - 1, 0);
		if (isConsumePropToServer && isActorEntity)
		{
			_bpData.Release();
		}
	}

	public void CultivateSkillEffect(DRCultivateSkillEffect cultivateSkillEffect, BaseEntity baseEntity)
	{
		CoolingTime = Mathf.Clamp(CoolingTime + cultivateSkillEffect.CoolingTime, 0f, 9999f);
		_initCoolingTime = CoolingTime;
		if (cultivateSkillEffect.IsChargeSkill == 2)
		{
			IsChargeSkill = true;
		}
		else if (cultivateSkillEffect.IsChargeSkill == 1)
		{
			IsChargeSkill = false;
		}
		if (cultivateSkillEffect.IsChargeVisible == 1 && IsChargeVisible)
		{
			IsChargeVisible = false;
		}
		else if (cultivateSkillEffect.IsChargeVisible == 2 && !IsChargeVisible)
		{
			IsChargeVisible = true;
		}
		if (cultivateSkillEffect.IsCacheLayerVisible == 1 && IsCacheLayerVisible)
		{
			IsCacheLayerVisible = false;
		}
		else if (cultivateSkillEffect.IsCacheLayerVisible == 2 && !IsCacheLayerVisible)
		{
			IsCacheLayerVisible = true;
		}
		if (IsChargeSkill)
		{
			MaxChargeNumber += cultivateSkillEffect.MaxChargeNumber;
			_initChargeTime += cultivateSkillEffect.ChargeTime;
			ChargeTime = _initChargeTime;
			if (cultivateSkillEffect.IsInitChargeSuccess == 2)
			{
				CurrentChargeNumber = MaxChargeNumber;
				CurrentChargeTime = 0f;
			}
			else if (cultivateSkillEffect.IsInitChargeSuccess == 1)
			{
				CurrentChargeNumber = 0;
				CurrentChargeTime = ChargeTime;
			}
		}
		CultivateSkillCondition(cultivateSkillEffect.ConsumeCondition, isConsumeCondition: true, baseEntity, _consumeCondition);
		CultivateSkillCondition(cultivateSkillEffect.NecessaryCondition, isConsumeCondition: false, baseEntity, _necessaryCondition);
	}

	private void CultivateSkillCondition(string skillCultivateCondition, bool isConsumeCondition, BaseEntity baseEntity, List<CoolingBase> skillCondition)
	{
		List<CoolingBase> list = CreateCoolingCondition(skillCultivateCondition, isConsumeCondition, baseEntity);
		for (int i = 0; i < list.Count; i++)
		{
			for (int j = 0; j < skillCondition.Count; j++)
			{
				skillCondition[i].Cultivate(list[i]);
			}
		}
	}

	public void SetStateIsCanReleaseSkill(bool isCan)
	{
		StateCanReleaseSkill = isCan;
	}

	public void SetAbnormalStateIsCanReleaseSkill(bool isCan)
	{
		if (AbnormalStateCanReleaseSkill != isCan)
		{
			AbnormalStateCanReleaseSkill = isCan;
		}
	}

	public void OnFixedUpdate(float deltaTime)
	{
		if (_currentCoolingTime > 0f)
		{
			CurrentCoolingTime = Mathf.Clamp(_currentCoolingTime - deltaTime, 0f, _coolingTime);
		}
		if (CurrentCoolingTime <= 0f)
		{
			OnSkillCoolingEnd();
		}
		if (_isChargeSkill)
		{
			if (_currentChargeNumber < _maxChargeNumber)
			{
				CurrentChargeTime = Mathf.Clamp(_currentChargeTime - deltaTime, 0f, _chargeTime);
			}
			if (CurrentChargeTime == 0f)
			{
				OnSkillChargeEnd();
			}
		}
		foreach (CoolingBase item in _consumeCondition)
		{
			item.Update();
		}
		foreach (CoolingBase item2 in _necessaryCondition)
		{
			item2.Update();
		}
		SetResourceEnough();
	}

	private void SetResourceEnough()
	{
		bool flag = true;
		foreach (CoolingBase item in _consumeCondition)
		{
			if (!item.Check())
			{
				flag = false;
			}
		}
		foreach (CoolingBase item2 in _necessaryCondition)
		{
			if (!item2.Check())
			{
				flag = false;
			}
		}
		if (flag != _resourceAmpleReleaseSkill)
		{
			ResourceAmpleReleaseSkill = flag;
		}
	}

	private void OnSkillCoolingEnd()
	{
		if (_accompanySkillCd)
		{
			CoolingTime = _initCoolingTime;
			_accompanySkillCd = false;
		}
	}

	private void OnSkillChargeEnd()
	{
		CurrentChargeNumber = Mathf.Clamp(_currentChargeNumber + 1, 0, _maxChargeNumber);
		ChargeTime = _initChargeTime;
		CurrentChargeTime = _chargeTime;
	}

	public bool CanRelease()
	{
		if (_isPropSkill && PropNumber <= 0)
		{
			return false;
		}
		if (!_stateCanReleaseSkill)
		{
			return false;
		}
		if (!_abnormalStateCanReleaseSkill)
		{
			return false;
		}
		if (_isChargeSkill && _currentChargeNumber == 0)
		{
			return false;
		}
		if (_currentCoolingTime > 0f)
		{
			return false;
		}
		foreach (CoolingBase item in _consumeCondition)
		{
			if (!item.Check())
			{
				return false;
			}
		}
		foreach (CoolingBase item2 in _necessaryCondition)
		{
			if (!item2.Check())
			{
				return false;
			}
		}
		return true;
	}

	public bool Release(bool isCd, bool isActorEntity)
	{
		if (_currentCoolingTime > 0f)
		{
			return false;
		}
		if (_isPropSkill && PropNumber <= 0)
		{
			return false;
		}
		if (_isChargeSkill && _currentChargeNumber == 0)
		{
			return false;
		}
		if (isCd)
		{
			CurrentCoolingTime = _coolingTime;
		}
		if (_isChargeSkill)
		{
			CurrentChargeNumber = Mathf.Clamp(_currentChargeNumber - 1, 0, MaxChargeNumber);
		}
		if (_isPropSkill)
		{
			ReleaseProp(isActorEntity);
		}
		foreach (CoolingBase item in _consumeCondition)
		{
			item.Release();
		}
		return true;
	}

	public void AccompanySkillCd(float coolingTime)
	{
		if (!_isChargeSkill)
		{
			CoolingTime = coolingTime;
			CurrentCoolingTime = coolingTime;
			_accompanySkillCd = true;
		}
	}

	public void AmendChargeTime(float time)
	{
		_initChargeTime = time;
		ChargeTime = _initChargeTime;
	}

	public void AmendCurrentChargeCount(int number)
	{
		CurrentChargeNumber = Mathf.Clamp(number, 0, MaxChargeNumber);
		if (CurrentChargeNumber >= MaxChargeNumber)
		{
			ChargeTime = _initChargeTime;
			CurrentChargeTime = _chargeTime;
		}
	}

	public void AmendCurrentChargeCountToMax()
	{
		CurrentChargeNumber = MaxChargeNumber;
		ChargeTime = _initChargeTime;
		CurrentChargeTime = _chargeTime;
	}

	public void AmendMaxChargeCount(int number)
	{
		MaxChargeNumber = ((number >= 0) ? number : 0);
		CurrentChargeNumber = Mathf.Clamp(CurrentChargeNumber, CurrentChargeNumber, MaxChargeNumber);
		if (CurrentChargeNumber == MaxChargeNumber)
		{
			CurrentChargeTime = ChargeTime;
		}
	}

	public void AmendCurrentChargeTime(float number)
	{
		if (CurrentChargeNumber < MaxChargeNumber)
		{
			CurrentChargeTime = number;
		}
	}

	public float GetSkillPropertyConsume(string propertyName)
	{
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is PropertyCooling propertyCooling && string.Equals(propertyCooling.propertyName, propertyName))
			{
				return propertyCooling.ReleaseParamValue;
			}
		}
		return 0f;
	}

	public void SetSkillPropertyConsume(string propertyName, float changeValue)
	{
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is PropertyCooling propertyCooling && string.Equals(propertyCooling.propertyName, propertyName))
			{
				propertyCooling.SetPropertyValue(changeValue);
				break;
			}
		}
	}

	public void ReviseSkillPropertyConsume(string propertyName, float changeValue)
	{
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is PropertyCooling propertyCooling && string.Equals(propertyCooling.propertyName, propertyName))
			{
				propertyCooling.RevisePropertyValue(changeValue);
				break;
			}
		}
	}

	public void ResetSkillPropertyConsume(string propertyName)
	{
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is PropertyCooling propertyCooling && string.Equals(propertyCooling.propertyName, propertyName))
			{
				propertyCooling.ResetPropertyValue();
				break;
			}
		}
	}

	public List<CoolingBase> GetSkillConsumeConditionList()
	{
		return _consumeCondition;
	}

	public void SetCoolingTime(float changeValue)
	{
		CoolingTime = changeValue;
	}

	public void SetCurCoolingTime(float changeValue)
	{
		CurrentCoolingTime = changeValue;
	}

	public void ReviseCoolingTime(float changeValue)
	{
		CoolingTime = _coolingTime + changeValue;
	}

	public void ReviseCurrentCoolingTime(float changeValue)
	{
		CurrentCoolingTime = Mathf.Clamp(_currentCoolingTime + changeValue, 0f, CoolingTime);
	}

	public void ResetCoolingTime()
	{
		CoolingTime = _initCoolingTime;
	}

	public void ResetCurCoolingTime()
	{
		CurrentCoolingTime = CoolingTime;
	}

	private List<CoolingBase> CreateCoolingCondition(string condition, bool isConsumeCondition, BaseEntity baseEntity)
	{
		if (string.IsNullOrWhiteSpace(condition))
		{
			return new List<CoolingBase>();
		}
		string[][]? array = JsonConvert.DeserializeObject<string[][]>(condition);
		List<CoolingBase> list = new List<CoolingBase>();
		string[][] array2 = array;
		foreach (string[] param in array2)
		{
			list.Add(CreateCoolingCondition(param, isConsumeCondition, baseEntity));
		}
		return list;
	}

	private CoolingBase CreateCoolingCondition(string[] param, bool isConsumeCondition, BaseEntity baseEntity)
	{
		if (param.Length != 4)
		{
			Log.Error("冷却参数长度错误...");
			return null;
		}
		int num = int.Parse(param[0]);
		switch (num)
		{
		case 1:
			return new PropertyCooling(param, isConsumeCondition, baseEntity);
		case 2:
			return new BuffCooling(param, isConsumeCondition, baseEntity);
		case 3:
			return new SkillLayerCooling(param, isConsumeCondition, baseEntity);
		default:
			Log.Error($"无效的条件类型：{num}");
			return null;
		}
	}

	public string GetNoResourceAmpleText(ref bool energyUnenough)
	{
		if (_resourceAmpleReleaseSkill)
		{
			return string.Empty;
		}
		if (resourceUnEnoughtTips == null)
		{
			resourceUnEnoughtTips = new StringBuilder(15);
		}
		else
		{
			resourceUnEnoughtTips.Clear();
		}
		resourceUnEnoughtStr = ((resourceUnEnoughtStr == null) ? new List<string>(4) : resourceUnEnoughtStr);
		resourceUnEnoughtStr.Clear();
		skillLayerTextCount = 0;
		bufferLayerTextCount = 0;
		GetConditionUnEnoughText(_consumeCondition, ref energyUnenough);
		GetConditionUnEnoughText(_necessaryCondition, ref energyUnenough);
		if (resourceUnEnoughtTips.Length > 0 && resourceUnEnoughtTips[0] == '、')
		{
			resourceUnEnoughtTips.Remove(0, 1);
		}
		if (resourceUnEnoughtTips.Length > 0 && resourceUnEnoughtTips[resourceUnEnoughtTips.Length - 1] == '、')
		{
			resourceUnEnoughtTips.Remove(resourceUnEnoughtTips.Length - 1, 1);
		}
		resourceUnEnoughtTips.Append("不足");
		return resourceUnEnoughtTips.ToString();
	}

	private void GetConditionUnEnoughText(List<CoolingBase> conditions, ref bool energyUnenough)
	{
		if (conditions == null)
		{
			return;
		}
		foreach (CoolingBase condition in conditions)
		{
			if (condition is SkillLayerCooling)
			{
				if (skillLayerTextCount == 0)
				{
					string text = condition.NotEnoughConditionText(resourceUnEnoughtStr);
					if (!string.IsNullOrEmpty(text))
					{
						resourceUnEnoughtTips.Insert(0, text);
						resourceUnEnoughtTips.Insert(skillLayerTextCount, '、');
						skillLayerTextCount = text.Length;
						skillLayerTextCount++;
					}
				}
			}
			else if (condition is BuffCooling)
			{
				string text2 = condition.NotEnoughConditionText(resourceUnEnoughtStr);
				if (!string.IsNullOrEmpty(text2))
				{
					resourceUnEnoughtTips.Insert(skillLayerTextCount, text2);
					resourceUnEnoughtTips.Insert(skillLayerTextCount, '、');
					bufferLayerTextCount++;
					bufferLayerTextCount += text2.Length;
				}
			}
			else
			{
				if (!(condition is PropertyCooling))
				{
					continue;
				}
				if ((condition as PropertyCooling).propertyName == "Energy")
				{
					string value = condition.NotEnoughConditionText(resourceUnEnoughtStr);
					if (!string.IsNullOrEmpty(value))
					{
						if (resourceUnEnoughtTips.Length > 0)
						{
							resourceUnEnoughtTips.Append('、');
						}
						resourceUnEnoughtTips.Append(value);
						energyUnenough = true;
					}
				}
				else
				{
					string value2 = condition.NotEnoughConditionText(resourceUnEnoughtStr);
					if (!string.IsNullOrEmpty(value2))
					{
						resourceUnEnoughtTips.Insert(skillLayerTextCount + bufferLayerTextCount, value2);
						resourceUnEnoughtTips.Insert(skillLayerTextCount + bufferLayerTextCount, '、');
					}
				}
			}
		}
	}

	public void ExcutePropertyConsume(SkillCostEnum costEnum, List<string> certainPropertys)
	{
		if (!ExcuteSkillConsume(costEnum, certainPropertys))
		{
			return;
		}
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is PropertyCooling propertyCooling && (costEnum == SkillCostEnum.All || (costEnum == SkillCostEnum.Certain && certainPropertys.Contains(propertyCooling.propertyName))))
			{
				item.Release();
			}
		}
	}

	public void ExcuteBuffConsume(SkillCostEnum costEnum, List<int> certainBuffs)
	{
		if (!ExcuteSkillConsume(costEnum, certainBuffs))
		{
			return;
		}
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is BuffCooling buffCooling && (costEnum == SkillCostEnum.All || (costEnum == SkillCostEnum.Certain && certainBuffs.Contains(buffCooling.BuffId))))
			{
				item.Release();
			}
		}
	}

	public void ExcuteSkillLayerConsume(SkillCostEnum costEnum, List<int> certainSkillLayers)
	{
		if (!ExcuteSkillConsume(costEnum, certainSkillLayers))
		{
			return;
		}
		foreach (CoolingBase item in _consumeCondition)
		{
			if (item is SkillLayerCooling skillLayerCooling && (costEnum == SkillCostEnum.All || (costEnum == SkillCostEnum.Certain && certainSkillLayers.Contains(skillLayerCooling.Id))))
			{
				item.Release();
			}
		}
	}

	private bool ExcuteSkillConsume<T>(SkillCostEnum costEnum, List<T> costList)
	{
		switch (costEnum)
		{
		case SkillCostEnum.None:
			return false;
		case SkillCostEnum.Certain:
			if (costList == null || costList.Count <= 0)
			{
				return false;
			}
			break;
		}
		return true;
	}

	private void InitUIData()
	{
		enableMask = false;
		cdBGPos = VectorExtensions.ScreenOutPos;
		progressPos = VectorExtensions.ScreenOutPos;
		abnormalRedShapPos = VectorExtensions.ScreenOutPos;
		abnormalCanReleEffectPos = VectorExtensions.ScreenOutPos;
		canReleEffect = VectorExtensions.ScreenOutPos;
	}

	private void UpdateCanReleEffect()
	{
		if (ResourceAmpleReleaseSkill && PropNumberAmpleRelSkill && AbnormalStateCanReleaseSkill && CurrentCoolingTime <= 0f && ((IsChargeSkill && CurrentChargeNumber > 0) || !IsChargeSkill))
		{
			if (canReleEffect != VectorExtensions.OriginPos)
			{
				CanReleEffect = VectorExtensions.OriginPos;
				ShowXpIndicatorRing(showEffect: true);
			}
		}
		else if (canReleEffect != VectorExtensions.ScreenOutPos)
		{
			CanReleEffect = VectorExtensions.ScreenOutPos;
			ShowXpIndicatorRing(showEffect: false);
		}
	}

	private void UpdateAbnormStateCanRele()
	{
		if (!AbnormalStateCanReleaseSkill)
		{
			if (abnormalCanReleEffectPos != VectorExtensions.OriginPos)
			{
				AbnormalCanReleEffectPos = VectorExtensions.OriginPos;
			}
		}
		else if (abnormalCanReleEffectPos != VectorExtensions.ScreenOutPos)
		{
			AbnormalCanReleEffectPos = VectorExtensions.ScreenOutPos;
		}
	}

	private void UpdateAbnormalStateRedShape()
	{
		if (!AbnormalStateCanReleaseSkill || !ResourceAmpleReleaseSkill || !PropNumberAmpleRelSkill)
		{
			if (abnormalRedShapPos != VectorExtensions.OriginPos)
			{
				AbnormalRedShapPos = VectorExtensions.OriginPos;
			}
		}
		else if (abnormalRedShapPos != VectorExtensions.ScreenOutPos)
		{
			AbnormalRedShapPos = VectorExtensions.ScreenOutPos;
		}
	}

	private void UpdateCDInfo()
	{
		UpdateCDMask();
		UpdateCDFillAmount();
		UpdateCDBgShow();
		UpdateCDText();
	}

	private void UpdateCDMask()
	{
		if (IsChargeSkill && CurrentChargeNumber == 0 && ChargeTime > CoolingTime)
		{
			if (CurrentChargeTime > 0f)
			{
				if (progressPos != VectorExtensions.OriginPos)
				{
					ProgressPos = VectorExtensions.OriginPos;
				}
			}
			else if (progressPos != VectorExtensions.ScreenOutPos)
			{
				ProgressPos = VectorExtensions.ScreenOutPos;
			}
		}
		else if (CurrentCoolingTime > 0f)
		{
			if (progressPos != VectorExtensions.OriginPos)
			{
				ProgressPos = VectorExtensions.OriginPos;
			}
		}
		else if (progressPos != VectorExtensions.ScreenOutPos)
		{
			ProgressPos = VectorExtensions.ScreenOutPos;
		}
	}

	private void UpdateCDFillAmount()
	{
		if (IsChargeSkill && CurrentChargeNumber == 0 && ChargeTime > CoolingTime)
		{
			if (ChargeTime == 0f)
			{
				CDFillAmount = 0f;
			}
			else
			{
				CDFillAmount = 1f - CurrentChargeTime / ChargeTime;
			}
		}
		else if (CoolingTime == 0f)
		{
			CDFillAmount = 0f;
		}
		else
		{
			CDFillAmount = 1f - CurrentCoolingTime / CoolingTime;
		}
	}

	private void UpdateCDBgShow()
	{
		if (IsChargeSkill && CurrentChargeNumber == 0 && ChargeTime > CoolingTime)
		{
			if (CurrentChargeTime > 0f)
			{
				if (cdBGPos != VectorExtensions.OriginPos)
				{
					CDBGPos = VectorExtensions.OriginPos;
				}
			}
			else if (cdBGPos != VectorExtensions.ScreenOutPos)
			{
				CDBGPos = VectorExtensions.ScreenOutPos;
			}
		}
		else if (CurrentCoolingTime > 0f)
		{
			if (cdBGPos != VectorExtensions.OriginPos)
			{
				CDBGPos = VectorExtensions.OriginPos;
			}
		}
		else if (cdBGPos != VectorExtensions.ScreenOutPos)
		{
			CDBGPos = VectorExtensions.ScreenOutPos;
		}
	}

	private void UpdateCDText()
	{
		if (IsChargeSkill && CurrentChargeNumber == 0 && ChargeTime > CoolingTime)
		{
			CDTextValue = CurrentChargeTime;
		}
		else if (CoolingTime == 0f)
		{
			CDTextValue = 0f;
		}
		else
		{
			CDTextValue = CurrentCoolingTime;
		}
	}
}
