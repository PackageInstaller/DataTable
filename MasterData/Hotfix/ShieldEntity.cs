using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using Unity.Mathematics;
using UnityEngine;

public class ShieldEntity
{
	public List<long> sheildValue;

	private long currentValue;

	private readonly FP configTime;

	public FP leftTime;

	public Shield shieldConfig;

	public ShieldValue shieldValueConfig;

	private ActorShield _actorShield;

	private AdventureActor FromActor;

	private List<AdventureBuffFXHandler> specialAdventureBuffFxs;

	private int updataFrequency;

	public long value_Current;

	public long value_Max;

	private bool iRemoveEvent;

	private List<int> Tags { get; } = new List<int>();

	public bool iEnd
	{
		get
		{
			if (!(leftTime <= 0) || !(configTime > 0))
			{
				return sheildValue.Count == 0;
			}
			return true;
		}
	}

	public ShieldEntity(int shieldID, ActorShield acS, AdventureActor fromActor)
	{
		iRemoveEvent = false;
		shieldConfig = Singleton<HotfixDataController>.Instance.GetShield(shieldID);
		if (shieldConfig == null)
		{
			Debug.LogError("shield config not exist, id:" + shieldID);
			return;
		}
		int valueConfigIdByLevelType = CommonHelper.GetValueConfigIdByLevelType(fromActor, shieldConfig.Id, (HotfixEnum.levelTypeData)shieldConfig.LevelTypeData, shieldConfig.LevelData);
		shieldValueConfig = Singleton<HotfixDataController>.Instance.GetShieldValue(valueConfigIdByLevelType);
		if (shieldValueConfig == null)
		{
			Debug.LogError("shield value config not exist, id:" + valueConfigIdByLevelType);
			return;
		}
		if (shieldConfig.ShieldTag1 != 0)
		{
			Tags.Add(shieldConfig.ShieldTag1);
		}
		if (shieldConfig.ShieldTag2 != 0)
		{
			Tags.Add(shieldConfig.ShieldTag2);
		}
		if (shieldConfig.ShieldTag3 != 0)
		{
			Tags.Add(shieldConfig.ShieldTag3);
		}
		configTime = FP.FromMyriad(shieldValueConfig.Time);
		_actorShield = acS;
		FromActor = fromActor;
		InitTime();
		if (sheildValue == null)
		{
			sheildValue = new List<long>();
		}
		OnEventAdd();
	}

	public ShieldEntity(int shieldID, ActorShield acS, FP _leftTime, long[] _sheildValue, long _currentValue, int shieldValueConfigId)
	{
		iRemoveEvent = false;
		shieldConfig = Singleton<HotfixDataController>.Instance.GetShield(shieldID);
		if (shieldConfig == null)
		{
			Debug.LogError("shield config not exist, id:" + shieldID);
			return;
		}
		shieldValueConfig = Singleton<HotfixDataController>.Instance.GetShieldValue(shieldValueConfigId);
		if (shieldValueConfig == null)
		{
			Debug.LogError("shield value config not exist, id:" + shieldValueConfigId);
			return;
		}
		configTime = FP.FromMyriad(shieldValueConfig.Time);
		_actorShield = acS;
		currentValue = _currentValue;
		value_Current = _currentValue;
		if (sheildValue == null)
		{
			sheildValue = new List<long>();
		}
		for (int i = 0; i < _sheildValue.Length; i++)
		{
			value_Max += _sheildValue[i];
			sheildValue.Add(_sheildValue[i]);
			if (i < _sheildValue.Length - 1)
			{
				value_Current += _sheildValue[i];
			}
			OnFx();
		}
		leftTime = _leftTime;
		OnEventAdd();
	}

	private void InitTime(bool addNum = false)
	{
		if (!addNum)
		{
			leftTime = configTime;
			return;
		}
		switch (shieldValueConfig.TimeSuperposition)
		{
		case 2:
			leftTime = configTime;
			break;
		case 3:
			leftTime += configTime;
			break;
		case 1:
			break;
		}
	}

	public void AddNum(AdventureActor fromActor)
	{
		if (sheildValue.Count >= shieldValueConfig.ShieldLaminatedNum)
		{
			ReduceNum();
		}
		FromActor = fromActor;
		ShieldEffectStart();
		InitTime(addNum: true);
		OnEventAdd();
	}

	public void AjustShieldTime_Value(FP addTime)
	{
		leftTime += addTime;
	}

	public void ReduceNum()
	{
		if (sheildValue.Count > 0)
		{
			value_Current -= currentValue;
			currentValue = 0L;
			value_Max -= sheildValue.get_Item(0);
			sheildValue.RemoveAt(0);
			if (sheildValue.Count > 0)
			{
				currentValue = sheildValue.get_Item(0);
			}
			if (specialAdventureBuffFxs != null && specialAdventureBuffFxs.Count > 0)
			{
				specialAdventureBuffFxs.get_Item(0).StopFX(interrupt: true);
				specialAdventureBuffFxs.RemoveAt(0);
			}
			if (string.IsNullOrEmpty(shieldConfig.BindEffect))
			{
				_actorShield.OnNormalFx(iAdd: false);
			}
		}
	}

	private void InitShieldValue()
	{
		long absorptionBase = shieldValueConfig.AbsorptionBase;
		long num = 0L;
		if (shieldValueConfig.ReferenceTarget == 1)
		{
			num = (long)(GetRefValue(FromActor) * FDP.FromMyriad(shieldValueConfig.ReferenceScale));
		}
		else if (shieldValueConfig.ReferenceTarget == 2)
		{
			num = (long)(GetRefValue(_actorShield.OwnerActor) * FDP.FromMyriad(shieldValueConfig.ReferenceScale));
		}
		if (shieldValueConfig.ReferenceLimit > 0)
		{
			num = ((num > shieldValueConfig.ReferenceLimit) ? shieldValueConfig.ReferenceLimit : num);
		}
		absorptionBase += num;
		FDP fDP = FDP.One;
		if (FromActor != null)
		{
			fDP = FromActor.actorInfo.addShieldStrengthenRatio;
		}
		fDP = ((fDP < FDP.Zero) ? FDP.Zero : fDP);
		FDP fDP2 = FDP.One;
		if (_actorShield != null && _actorShield.OwnerActor != null)
		{
			fDP2 = _actorShield.OwnerActor.actorInfo.beAddShieldStrengthenRatio;
		}
		fDP2 = ((fDP2 < FDP.Zero) ? FDP.Zero : fDP2);
		absorptionBase = (long)math.ceil((double)absorptionBase * (double)fDP * (double)fDP2);
		sheildValue.Add(absorptionBase);
		value_Max += absorptionBase;
		value_Current += absorptionBase;
		if (currentValue <= 0)
		{
			currentValue = sheildValue.get_Item(0);
		}
	}

	private FDP GetRefValue(AdventureActor _actor)
	{
		if (_actor == null)
		{
			return FDP.Zero;
		}
		return shieldValueConfig.ReferenceAttrib switch
		{
			2 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.ATK), 
			3 => _actor.attributeList.GetBaseValue(HotfixEnum.effectAttributeType.ATK), 
			1 => FDP.FromLong(_actor.actorHealthInfo.hpMax), 
			4 => _actor.attributeList.GetBaseValue(HotfixEnum.effectAttributeType.MAXHP), 
			5 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.DEF), 
			6 => _actor.attributeList.GetBaseValue(HotfixEnum.effectAttributeType.DEF), 
			7 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.CRITRATE), 
			8 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.CRITPOWER_P), 
			9 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.PENETRATE), 
			10 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.WEE), 
			11 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.FEE), 
			12 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.SEE), 
			13 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.AEE), 
			14 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.LEE), 
			15 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.DEE), 
			16 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.WEP), 
			17 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.FEP), 
			18 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.SEP), 
			19 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.AEP), 
			20 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.LEP), 
			21 => _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.DEP), 
			22 => FDP.FromLong(_actor.actorHealthInfo.hp), 
			_ => FDP.Zero, 
		};
	}

	public long GetCurrentNumShieldValue()
	{
		return currentValue;
	}

	public bool CheckTag(int _tag)
	{
		if (iEnd)
		{
			return false;
		}
		if (_tag != 0)
		{
			return Tags.Contains(_tag);
		}
		return false;
	}

	public void ShieldEffectStart()
	{
		InitShieldValue();
		OnFx();
	}

	private void OnFx()
	{
		if (!string.IsNullOrEmpty(shieldConfig.BindEffect))
		{
			if (specialAdventureBuffFxs == null)
			{
				specialAdventureBuffFxs = new List<AdventureBuffFXHandler>(shieldValueConfig.ShieldLaminatedNum);
			}
			List<AdventureBuffFXHandler> list = specialAdventureBuffFxs;
			string bindEffect = shieldConfig.BindEffect;
			GameObject gameObject = _actorShield.gameObject;
			AdventureActor ownerActor = _actorShield.OwnerActor;
			list.Add(AdventureFXManager.PlayBuffFX(bindEffect, gameObject, AdventureBuffFXHandler.FXPlayMode.Default, default, default, 1f, ownerActor));
		}
		else
		{
			_actorShield.OnNormalFx(iAdd: true);
		}
	}

	private void OnEventAdd()
	{
		AdventureActorAddShield adventureActorAddShield = AdventureActorAddShield.Generate();
		adventureActorAddShield.sender = _actorShield?.OwnerActor;
		adventureActorAddShield.from = FromActor;
		adventureActorAddShield.shieldId = shieldConfig.Id;
		adventureActorAddShield.shieldTags.AddRange(Tags);
		adventureActorAddShield.to = _actorShield?.OwnerActor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAddShield);
	}

	private void OnEventRemove(bool iDamageBreak = false, LogicEntity damageFrom = null)
	{
		if (!iRemoveEvent)
		{
			iRemoveEvent = true;
			AdventureActorRemoveShield adventureActorRemoveShield = AdventureActorRemoveShield.Generate();
			adventureActorRemoveShield.sender = _actorShield?.OwnerActor;
			adventureActorRemoveShield.from = FromActor;
			adventureActorRemoveShield.shieldId = shieldConfig.Id;
			adventureActorRemoveShield.shieldTags = Tags;
			if (iDamageBreak)
			{
				adventureActorRemoveShield.removeType = ShiledRemoveType.DamageBreak;
				adventureActorRemoveShield.damageFrom = damageFrom;
			}
			else if (leftTime <= 0 && configTime > 0)
			{
				adventureActorRemoveShield.removeType = ShiledRemoveType.TimeFinish;
			}
			else
			{
				adventureActorRemoveShield.removeType = ShiledRemoveType.None;
			}
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorRemoveShield);
		}
	}

	public void OnEnd(bool interrupt = false)
	{
		if (specialAdventureBuffFxs != null)
		{
			for (int i = 0; i < specialAdventureBuffFxs.Count; i++)
			{
				specialAdventureBuffFxs.get_Item(i).StopFX(interrupt);
			}
			specialAdventureBuffFxs.Clear();
		}
		if (string.IsNullOrEmpty(shieldConfig.BindEffect))
		{
			_actorShield.OnNormalFx(iAdd: false, sheildValue.Count);
		}
		_actorShield.FireShieldUiEvent(shieldConfig.Id, 0L, 0, shieldConfig.Name);
		OnEventRemove();
		OnClearData();
	}

	private void OnClearData()
	{
		sheildValue.Clear();
		currentValue = 0L;
		value_Current = 0L;
		value_Max = 0L;
		shieldConfig = null;
		_actorShield = null;
		specialAdventureBuffFxs = null;
	}

	public void CalcShieldValue(ref long _value, LogicEntity from)
	{
		if (sheildValue.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < sheildValue.Count; i++)
		{
			if (_value < currentValue)
			{
				currentValue -= _value;
				value_Current -= _value;
				_value = 0L;
				break;
			}
			_value -= currentValue;
			ReduceNum();
		}
		AdventureShieldBeHit adventureShieldBeHit = AdventureShieldBeHit.Generate();
		adventureShieldBeHit.sender = _actorShield?.OwnerActor;
		adventureShieldBeHit.damageFrom = from;
		adventureShieldBeHit.from = FromActor;
		adventureShieldBeHit.shieldId = shieldConfig.Id;
		adventureShieldBeHit.shieldTags.AddRange(Tags);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureShieldBeHit);
		if (sheildValue.Count == 0)
		{
			_actorShield.damageFrom = from as AdventureActor;
			OnEventRemove(iDamageBreak: true, from);
		}
	}

	public void OnUpdate(FP deltaTime)
	{
		leftTime -= deltaTime;
		if (iEnd)
		{
			_actorShield.RemoveShield(this);
			return;
		}
		if (updataFrequency < 10)
		{
			updataFrequency++;
			return;
		}
		_actorShield.FireShieldUiEvent(shieldConfig.Id, value_Current, leftTime, shieldConfig.Name);
		updataFrequency = 0;
	}
}
