using System;
using Nova.Hotfix;
using TrueSync;

public class ActorHealthInfo : LogicComponent
{
	public delegate void HpChangedHandle(long hp, long hpMax);

	public delegate void AliveChangedHandle(bool alive);

	private AttributeList attributeList;

	private SpecialAttributeList specialAttributeList;

	private bool _isAlive;

	public bool isAlive
	{
		get
		{
			return _isAlive;
		}
		set
		{
			if (_isAlive != value)
			{
				_isAlive = value;
				AliveChangedEvent?.Invoke(_isAlive);
			}
		}
	}

	public long hp
	{
		get
		{
			return specialAttributeList?.GetAttributeValue(HotfixEnum.specialAttributeType.HP).AsLong() ?? 0;
		}
		set
		{
			if (hp != value)
			{
				specialAttributeList?.SetAttributeValue(attributeList, HotfixEnum.specialAttributeType.HP, HotfixEnum.parameterType.BASE_VALUE, FDP.FromLong(value));
			}
		}
	}

	public long hpMax => attributeList?.GetAttributeValue(HotfixEnum.effectAttributeType.MAXHP).AsLong() ?? 0;

	public FDP hpPercentage
	{
		get
		{
			if (hpMax == 0L)
			{
				return FDP.Zero;
			}
			return FDP.FromLong(hp) / FDP.FromLong(hpMax);
		}
	}

	public event HpChangedHandle HpChangedEvent;

	public event AliveChangedHandle AliveChangedEvent;

	protected override void OnInit()
	{
		AdventureActor adventureActor = Entity as AdventureActor;
		if (adventureActor != null)
		{
			attributeList = adventureActor.attributeList;
			specialAttributeList = adventureActor.specialAttributeList;
			attributeList.ValueChangedEvent += OnAttributeValueChanged;
			specialAttributeList.ValueChangedEvent += OnSpecialValueChanged;
		}
	}

	protected override void OnShutdown()
	{
		base.OnShutdown();
		if (attributeList != null)
		{
			attributeList.ValueChangedEvent -= OnAttributeValueChanged;
		}
		if (specialAttributeList != null)
		{
			specialAttributeList.ValueChangedEvent -= OnSpecialValueChanged;
		}
		attributeList = null;
		specialAttributeList = null;
	}

	private void OnAttributeValueChanged(HotfixEnum.effectAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP diff)
	{
		if (attributeType == HotfixEnum.effectAttributeType.MAXHP)
		{
			ChangeHpByMaxHp(old.AsLong());
			HpChangedEvent?.Invoke(hp, hpMax);
		}
	}

	private void OnSpecialValueChanged(HotfixEnum.specialAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP current)
	{
		if (attributeType != HotfixEnum.specialAttributeType.HP)
		{
			return;
		}
		LogicEntity entity = Entity;
		if (!(entity is PlayerAdventureActor playerAdventureActor))
		{
			if (entity is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSS && hpPercentage >= (FDP)0.1f && current / FDP.FromLong(hpMax) < (FDP)0.1f)
			{
				MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(0, "encourage");
			}
		}
		else if (current < old)
		{
			if ((old - current) / FDP.FromLong(hpMax) > FDP.HALF)
			{
				MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(playerAdventureActor.dataID, "takedamage");
			}
			if (hpPercentage >= (FDP)0.3f && current / FDP.FromLong(hpMax) < (FDP)0.3f)
			{
				MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(playerAdventureActor.dataID, "injured");
			}
		}
		HpChangedEvent?.Invoke(hp, hpMax);
	}

	protected void ChangeHpByMaxHp(long oldHpMax)
	{
		long num = hpMax - oldHpMax;
		if (num > 0)
		{
			hp += num;
		}
		hp = Math.Min(hp, hpMax);
	}

	public void SetOwnerValue(ActorHealthInfo owner, FDP ratio)
	{
		attributeList?.SetOriginIntValue(HotfixEnum.effectAttributeType.MAXHP, (int)owner.hpMax, ratio);
		hp = hpMax;
	}

	private void SetOriginIntValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		attributeList?.SetOriginIntValue(type, val, ratio);
	}

	private void SetOriginLongValue(HotfixEnum.effectAttributeType type, long val, FDP ratio)
	{
		attributeList?.SetOriginLongValue(type, val, ratio);
	}

	private void SetOriginLongValueAdjust(HotfixEnum.effectAttributeType type, long val, FDP ratio, int adjustRatio, long adjustFix)
	{
		attributeList?.SetOriginLongValueAdjust(type, val, ratio, adjustRatio, adjustFix);
	}

	public void SetOriginAttributeData(Nova.Hotfix.Attribute attributeConfig, FDP ratio)
	{
		SetOriginIntValue(HotfixEnum.effectAttributeType.MAXHP, attributeConfig.Hp, ratio);
		hp = hpMax;
	}

	public void SetOriginAttributeData(MonsterValueTemplete attributeConfig, MonsterValueTempleteAdjust templeteAdjustInfo, FDP ratio)
	{
		if (templeteAdjustInfo != null)
		{
			SetOriginLongValueAdjust(HotfixEnum.effectAttributeType.MAXHP, attributeConfig.Hp, ratio, templeteAdjustInfo.HpRatio, templeteAdjustInfo.HpFix);
		}
		else
		{
			SetOriginLongValue(HotfixEnum.effectAttributeType.MAXHP, attributeConfig.Hp, ratio);
		}
		hp = hpMax;
	}

	public void SetOriginAttributeData(Lua2CSharpInfo_CharAttribute attributeConfig, FDP ratio)
	{
		SetOriginIntValue(HotfixEnum.effectAttributeType.MAXHP, attributeConfig.Hp, ratio);
		hp = hpMax;
	}
}
