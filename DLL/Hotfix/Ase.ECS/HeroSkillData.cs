using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase.ECS;

public class HeroSkillData : ViewModelBase
{
	private const int AmendTrue = 2;

	private const int AmendFalse = 1;

	private int _id;

	private string _icon;

	private string _iconBattle;

	private string pcKey;

	private string name;

	private string desc;

	private string simpleDesc;

	private string staminaCost;

	private string _skillTag;

	private int _indicatorType;

	private float _skillRange;

	private float _skillWidth;

	private float _skillAngle;

	private float _largeCircleLockRadius;

	private bool _isStrengthen;

	private bool _isCharging;

	private float curChargeTime;

	private float _chargeUIFill;

	private int _cacheLayer;

	private int _maxCacheLayer;

	private int _propId;

	private bool _isAddLayerSkill;

	private bool _isTeachClick;

	private DRHeroSKillConfig _config;

	private SkillCoolingData _skillCoolingData;

	private SkillDeriveData _skillDeriveData;

	private SkillAdditionData _skillAdditionData;

	private List<int> _unlockDeriveSkillList;

	private List<string> _skillLabelList;

	private List<int> _skillExecuteCreatBuffList;

	private List<int> _skillExecuteBreakState;

	private List<int> _unlockSkillEffectList;

	private bool _isAccumulatSkill;

	private bool skillNormalShow = true;

	private BaseEntity _baseEntity;

	private bool _isXpSkill;

	private bool _cantClick;

	private ChangeIndicatorData _changeIndicatorData;

	public ChangeIndicatorData ChangeIndicatorSaveData => _changeIndicatorData;

	public int IndicatorType => _indicatorType;

	public float SkillRange => _skillRange;

	public float SkillWidth => _skillWidth;

	public float SkillAngle => _skillAngle;

	public string Icon
	{
		get
		{
			return _icon;
		}
		set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public string IconBattle
	{
		get
		{
			return _iconBattle;
		}
		set
		{
			Set(ref _iconBattle, value, "IconBattle");
		}
	}

	public string PcKey
	{
		get
		{
			return pcKey;
		}
		set
		{
			Set(ref pcKey, value, "PcKey");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string SimpleDesc
	{
		get
		{
			return simpleDesc;
		}
		private set
		{
			Set(ref simpleDesc, value, "SimpleDesc");
		}
	}

	public string StaminaCost
	{
		get
		{
			return staminaCost;
		}
		private set
		{
			Set(ref staminaCost, value, "StaminaCost");
		}
	}

	public string SkillTag
	{
		get
		{
			return _skillTag;
		}
		set
		{
			Set(ref _skillTag, value, "SkillTag");
		}
	}

	public int Id
	{
		get
		{
			return _id;
		}
		private set
		{
			Set(ref _id, value, "Id");
		}
	}

	public bool IsStrengthen
	{
		get
		{
			return _isStrengthen;
		}
		private set
		{
			Set(ref _isStrengthen, value, "IsStrengthen");
		}
	}

	public int CacheLayer
	{
		get
		{
			return _cacheLayer;
		}
		private set
		{
			Set(ref _cacheLayer, value, "CacheLayer");
		}
	}

	public int MaxCacheLayer
	{
		get
		{
			return _maxCacheLayer;
		}
		private set
		{
			Set(ref _maxCacheLayer, value, "MaxCacheLayer");
		}
	}

	public bool IsCharging
	{
		get
		{
			return _isCharging;
		}
		private set
		{
			Set(ref _isCharging, value, "IsCharging");
		}
	}

	public bool IsAddLayerSkill
	{
		get
		{
			return _isAddLayerSkill;
		}
		private set
		{
			Set(ref _isAddLayerSkill, value, "IsAddLayerSkill");
		}
	}

	public bool IsTeachClick
	{
		get
		{
			return _isTeachClick;
		}
		private set
		{
			Set(ref _isTeachClick, value, "IsTeachClick");
		}
	}

	public float ChargeUIFill
	{
		get
		{
			return _chargeUIFill;
		}
		set
		{
			Set(ref _chargeUIFill, value, "ChargeUIFill");
		}
	}

	public bool IsAccumulatSkill
	{
		get
		{
			return _isAccumulatSkill;
		}
		set
		{
			Set(ref _isAccumulatSkill, value, "IsAccumulatSkill");
		}
	}

	public bool IsXpSkill
	{
		get
		{
			return _isXpSkill;
		}
		set
		{
			Set(ref _isXpSkill, value, "IsXpSkill");
		}
	}

	public bool CantClick
	{
		get
		{
			return _cantClick;
		}
		set
		{
			Set(ref _cantClick, value, "cantClick");
		}
	}

	public bool SkillNormalShow
	{
		get
		{
			return skillNormalShow;
		}
		private set
		{
			Set(ref skillNormalShow, value, "SkillNormalShow");
		}
	}

	public DRHeroSKillConfig SKillConfig => _config;

	public SkillCoolingData SkillCoolingData
	{
		get
		{
			return _skillCoolingData;
		}
		set
		{
			Set(ref _skillCoolingData, value, "SkillCoolingData");
		}
	}

	public SkillDeriveData SkillDeriveData => _skillDeriveData;

	public SkillAdditionData SkillAdditionData => _skillAdditionData;

	public float LargeCircleLockRadius => _largeCircleLockRadius;

	public bool IsDeriveSkill => _skillDeriveData.IsDeriveSkill;

	public bool IsDerive => _skillDeriveData.IsDerive;

	public bool IsDeriving => _skillDeriveData.IsDeriving;

	public int OriginalSkillId => _skillDeriveData.OriginalSkillId;

	public int OriginalDeriveSkillOriginalId => _skillDeriveData.OriginalDeriveSkillOriginalId;

	public List<int> UnlockDeriveSkillList => _unlockDeriveSkillList;

	public int PropId => _propId;

	public List<int> SkillExecuteBreakState => _skillExecuteBreakState;

	public List<string> GetSkillLabelList()
	{
		return _skillLabelList;
	}

	public static HeroSkillData CreateEmpty()
	{
		return new HeroSkillData
		{
			_id = 0,
			SkillTag = string.Empty,
			Icon = string.Empty,
			IconBattle = string.Empty,
			_indicatorType = 0,
			_unlockDeriveSkillList = new List<int>(),
			_skillLabelList = new List<string>(),
			_skillExecuteCreatBuffList = new List<int>(),
			_skillExecuteBreakState = new List<int>(),
			SkillCoolingData = SkillCoolingData.CreateEmpty(),
			_changeIndicatorData = new ChangeIndicatorData()
		};
	}

	public static HeroSkillData Create(DRHeroSKillConfig sKillConfig, BaseEntity baseEntity, string skinSuffix, bool xpSkill)
	{
		HeroSkillData heroSkillData = new HeroSkillData();
		heroSkillData._baseEntity = baseEntity;
		heroSkillData._config = sKillConfig;
		heroSkillData._id = sKillConfig.Id;
		heroSkillData.SkillTag = sKillConfig.ButtonTag;
		heroSkillData.Icon = sKillConfig.Icon;
		heroSkillData.IconBattle = sKillConfig.Icon + skinSuffix;
		heroSkillData._indicatorType = sKillConfig.IndicatorType;
		heroSkillData._skillRange = sKillConfig.SkillRange;
		heroSkillData._skillWidth = sKillConfig.SkillWidth;
		heroSkillData._skillAngle = sKillConfig.SkillAngle;
		heroSkillData._largeCircleLockRadius = sKillConfig.LargeCircleLockRadius;
		heroSkillData._unlockDeriveSkillList = new List<int>();
		heroSkillData.IsAddLayerSkill = sKillConfig.IsCacheLayerSkill;
		heroSkillData.MaxCacheLayer = sKillConfig.MaxCacheLayerNumber;
		heroSkillData._changeIndicatorData = new ChangeIndicatorData(heroSkillData._config);
		heroSkillData._isXpSkill = xpSkill;
		for (int i = 0; i < sKillConfig.DefaultDeriveSkillId.Count; i++)
		{
			heroSkillData._unlockDeriveSkillList.Add(sKillConfig.DefaultDeriveSkillId[i]);
		}
		heroSkillData._skillLabelList = new List<string>();
		for (int j = 0; j < sKillConfig.SkillLabelTypeEnum.Count; j++)
		{
			heroSkillData._skillLabelList.Add(sKillConfig.SkillLabelTypeEnum[j]);
		}
		heroSkillData._skillExecuteCreatBuffList = new List<int>();
		for (int k = 0; k < sKillConfig.Buffs.Count; k++)
		{
			heroSkillData._skillExecuteCreatBuffList.Add(sKillConfig.Buffs[k]);
		}
		heroSkillData._skillExecuteBreakState = new List<int>();
		for (int l = 0; l < sKillConfig.BreakStates.Count; l++)
		{
			heroSkillData._skillExecuteBreakState.Add(sKillConfig.BreakStates[l]);
		}
		heroSkillData._unlockSkillEffectList = new List<int>();
		heroSkillData.IsAccumulatSkill = sKillConfig.SkillLabelTypeEnum.Contains("AccumulatesSkill");
		heroSkillData.SkillCoolingData = SkillCoolingData.Create(heroSkillData, baseEntity);
		heroSkillData._skillDeriveData = new SkillDeriveData(sKillConfig);
		heroSkillData._skillDeriveData.DeriveDataRegisterEntity(baseEntity);
		heroSkillData._skillAdditionData = ReferencePool.Acquire<SkillAdditionData>();
		heroSkillData.SkillLabelLog("技能初始化后");
		return heroSkillData;
	}

	public void CultivateSkillEffect(List<DRCultivateSkillEffect> cultivateSkillEffectList)
	{
		if (cultivateSkillEffectList == null)
		{
			return;
		}
		for (int i = 0; i < cultivateSkillEffectList.Count; i++)
		{
			DRCultivateSkillEffect dRCultivateSkillEffect = cultivateSkillEffectList[i];
			_skillRange += dRCultivateSkillEffect.SkillRange;
			_skillWidth += dRCultivateSkillEffect.SkillWidth;
			_skillAngle += dRCultivateSkillEffect.SkillAngle;
			_largeCircleLockRadius += dRCultivateSkillEffect.LargeCircleLockRadius;
			_skillCoolingData.CultivateSkillEffect(dRCultivateSkillEffect, _baseEntity);
			_skillDeriveData.CultivateSkillEffect(dRCultivateSkillEffect);
			if (dRCultivateSkillEffect.IsCacheLayerSkill == 2)
			{
				IsAddLayerSkill = true;
				MaxCacheLayer += dRCultivateSkillEffect.MaxCacheLayerNumber;
			}
			else if (dRCultivateSkillEffect.IsCacheLayerSkill == 1)
			{
				IsAddLayerSkill = false;
			}
			for (int j = 0; j < dRCultivateSkillEffect.DeriveSkillIdAdd.Count; j++)
			{
				if (!_unlockDeriveSkillList.Contains(dRCultivateSkillEffect.DeriveSkillIdAdd[j]))
				{
					_unlockDeriveSkillList.Add(dRCultivateSkillEffect.DeriveSkillIdAdd[j]);
				}
			}
			for (int k = 0; k < dRCultivateSkillEffect.DeriveSkillIdDec.Count; k++)
			{
				if (_unlockDeriveSkillList.Contains(dRCultivateSkillEffect.DeriveSkillIdDec[k]))
				{
					_unlockDeriveSkillList.Remove(dRCultivateSkillEffect.DeriveSkillIdDec[k]);
				}
			}
			for (int l = 0; l < dRCultivateSkillEffect.SkillLabelTypeAdd.Count; l++)
			{
				if (!_skillLabelList.Contains(dRCultivateSkillEffect.SkillLabelTypeAdd[l]))
				{
					_skillLabelList.Add(dRCultivateSkillEffect.SkillLabelTypeAdd[l]);
				}
			}
			for (int m = 0; m < dRCultivateSkillEffect.SkillLabelTypeDec.Count; m++)
			{
				if (_skillLabelList.Contains(dRCultivateSkillEffect.SkillLabelTypeDec[m]))
				{
					_skillLabelList.Remove(dRCultivateSkillEffect.SkillLabelTypeDec[m]);
				}
			}
			for (int n = 0; n < dRCultivateSkillEffect.BreakStatesAdd.Count; n++)
			{
				if (!_skillExecuteBreakState.Contains(dRCultivateSkillEffect.BreakStatesAdd[n]))
				{
					_skillExecuteBreakState.Add(dRCultivateSkillEffect.BreakStatesAdd[n]);
				}
			}
			for (int num = 0; num < dRCultivateSkillEffect.BreakStatesDec.Count; num++)
			{
				if (_skillExecuteBreakState.Contains(dRCultivateSkillEffect.BreakStatesDec[num]))
				{
					_skillExecuteBreakState.Remove(dRCultivateSkillEffect.BreakStatesDec[num]);
				}
			}
		}
		IsAccumulatSkill = _skillLabelList.Contains("AccumulatesSkill");
		SkillLabelLog("技能养成后");
	}

	private void SkillLabelLog(string log)
	{
	}

	public void CultivateSkillLevel(List<DRCultivateSkillLevel> cultivateSkillLevelList)
	{
		if (cultivateSkillLevelList != null)
		{
			for (int i = 0; i < cultivateSkillLevelList.Count; i++)
			{
				DRCultivateSkillLevel cultivateSkillLevel = cultivateSkillLevelList[i];
				_skillAdditionData.CultivateSkillLevel(cultivateSkillLevel);
			}
		}
	}

	public void CreateBuff()
	{
		for (int i = 0; i < _skillExecuteCreatBuffList.Count; i++)
		{
			_baseEntity.GetSystem<BuffSystem>().CreateBuff(_baseEntity, _baseEntity, _skillExecuteCreatBuffList[i]);
		}
	}

	public void RegisterPropSkillData(BattleProps bpData)
	{
		_skillCoolingData?.RegisterPropSkillData(bpData);
		_propId = bpData?.Id ?? 0;
	}

	public void FixedUpdate(float deltaTime)
	{
		_skillDeriveData?.FixedUpdate(deltaTime);
		if (_isCharging)
		{
			curChargeTime++;
			ChargeUIFill = curChargeTime / _config.PropSkillTime;
		}
	}

	public bool RegisterDeriveSkill(int deriveSkillId)
	{
		return _skillDeriveData.RegisterDeriveSkillId(deriveSkillId);
	}

	public void OpenDeriveWindow(float deriveTime, bool restoreDeriveTime, HeroSkillTypeEnum heroSkillTypeEnum, HeroSkillData originalSkillData, int deriveNumber, bool isStateDerive)
	{
		_skillDeriveData.OpenDeriveWindow(deriveTime, restoreDeriveTime, heroSkillTypeEnum, originalSkillData, deriveNumber, isStateDerive);
	}

	public void SetDeriveWindowExecuteState(bool isPause)
	{
		_skillDeriveData.SetDeriveWindowExecuteState(isPause);
	}

	public void HideSkillDeriveWindow()
	{
		_skillDeriveData.HideSkillDeriveWindow();
	}

	public void OnCreateDeriveSkillWindowEnd(int deriveSkillId)
	{
		_skillDeriveData.OnCreateDeriveSkillWindowEnd(deriveSkillId);
	}

	public int GetLatestDeriveSkillId()
	{
		return _skillDeriveData.GetLatestDeriveSkillId();
	}

	public void AmendSkillLayer(int layer)
	{
		CacheLayer = Mathf.Clamp(layer, 0, MaxCacheLayer);
	}

	public void AmendMaxSkillLayer(int layer)
	{
		MaxCacheLayer = ((layer >= 0) ? layer : 0);
	}

	public void ExpendSKillLayer(int expendLayer)
	{
		if (IsAddLayerSkill)
		{
			CacheLayer = Mathf.Clamp(CacheLayer - expendLayer, 0, CacheLayer);
		}
	}

	public void ExpendSkillDeriveNumber()
	{
		_skillDeriveData.ExpendDriveNumber();
	}

	public void SetSkillAddition(AdditionKind additionKind, float addition)
	{
		_skillAdditionData.SetSkillAddition(additionKind, addition);
	}

	public void SetSkillStrengthen(bool isStrengthen)
	{
		IsStrengthen = isStrengthen;
	}

	public void SetPropSkillChargeState(bool charge)
	{
		if (_config != null && _config.IsPropSkill)
		{
			IsCharging = charge;
			curChargeTime = 0f;
			ChargeUIFill = 0f;
		}
	}

	public void AddSkillLabelTypeEnum(string label)
	{
		if (!_skillLabelList.Contains(label))
		{
			_skillLabelList.Add(label);
			IsAccumulatSkill = _skillLabelList.Contains("AccumulatesSkill");
			SkillLabelLog("添加技能标签" + label);
		}
	}

	public void RemoveSkillLabelTypeEnum(string label)
	{
		if (_skillLabelList.Contains(label))
		{
			_skillLabelList.Remove(label);
			IsAccumulatSkill = _skillLabelList.Contains("AccumulatesSkill");
			SkillLabelLog("移除技能标签" + label);
		}
	}

	public bool ContainsSkillLabel(string label)
	{
		return _skillLabelList?.Contains(label) ?? false;
	}

	public void SetSkillShow(bool isShow)
	{
		SkillNormalShow = isShow;
	}

	public void RunTimeChangeIndicator(float range, float rangeTime, float width, float widthTime, float angle, float angleTime)
	{
		if (rangeTime != 0f)
		{
			float num = _changeIndicatorData.FinalSkillRange - _changeIndicatorData.SkillRangeIncreaseValue * _changeIndicatorData.ChangeRangeTime;
			_changeIndicatorData.SkillRangeIncreaseValue = (range - num) / rangeTime;
			_changeIndicatorData.ChangeRangeTime = rangeTime;
			_changeIndicatorData.FinalSkillRange = range;
		}
		if (widthTime != 0f)
		{
			float num2 = _changeIndicatorData.FinalSkillWidth - _changeIndicatorData.SkillWidthInCreaseValue * _changeIndicatorData.ChangeWidthTime;
			_changeIndicatorData.SkillWidthInCreaseValue = (width - num2) / widthTime;
			_changeIndicatorData.ChangeWidthTime = widthTime;
			_changeIndicatorData.FinalSkillWidth = width;
		}
		if (angleTime != 0f)
		{
			float num3 = _changeIndicatorData.FinalSkillAngle - _changeIndicatorData.SkillAngleIncreaseValue * _changeIndicatorData.ChangeAngleTime;
			_changeIndicatorData.SkillAngleIncreaseValue = (angle - num3) / angleTime;
			_changeIndicatorData.ChangeAngleTime = angleTime;
			_changeIndicatorData.FinalSkillAngle = angle;
		}
	}

	public void SetSkillBtnHide(HeroSkillTypeEnum skillTypeEnum, bool isHide)
	{
		_baseEntity.GetComponent<SkillComponent>().SetSkillBtnHide(skillTypeEnum, isHide);
	}

	public void SetSkillCanRelease(HeroSkillTypeEnum skillTypeEnum, bool canRelease)
	{
		_baseEntity.GetComponent<SkillComponent>().SetSkillBtnHide(skillTypeEnum, canRelease);
	}

	public void SetTeachSkillEffect(bool isShow)
	{
		IsTeachClick = isShow;
	}
}
