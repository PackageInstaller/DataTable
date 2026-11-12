using System.Collections.Generic;
using TrueSync;
using Unity.Mathematics;

public class ActorShieldOld : LogicMonoComponent
{
	public delegate void ShieldChangedHandle(int oneValueC, int oneValueM);

	private AdventureActor _actor;

	private bool iInit;

	private AttributeList attributeList;

	private SpecialAttributeList specialAttributeList;

	public long shiledValue
	{
		get
		{
			return specialAttributeList?.GetAttributeValue(HotfixEnum.specialAttributeType.SHIELD_V).AsLong() ?? 0;
		}
		set
		{
			long value2 = math.clamp(value, 0L, maxShieldValue);
			specialAttributeList?.SetAttributeValue(attributeList, HotfixEnum.specialAttributeType.SHIELD_V, HotfixEnum.parameterType.BASE_VALUE, FDP.FromLong(value2));
		}
	}

	public long maxShieldValue => attributeList?.GetAttributeValue(HotfixEnum.effectAttributeType.SHIELD_MAX).AsLong() ?? 0;

	public event ShieldChangedHandle shieldChangedEvent;

	protected override void OnInit()
	{
		base.OnInit();
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
		if (attributeType == HotfixEnum.effectAttributeType.SHIELD_MAX && shiledValue > maxShieldValue)
		{
			shiledValue = maxShieldValue;
		}
	}

	private void OnSpecialValueChanged(HotfixEnum.specialAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP current)
	{
		if (attributeType == HotfixEnum.specialAttributeType.SHIELD_V)
		{
			if (current == FDP.Zero && old > FDP.Zero)
			{
				AdventureActorBreakShield adventureActorBreakShield = AdventureActorBreakShield.Generate();
				adventureActorBreakShield.sender = _actor;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorBreakShield);
			}
			UpdateShieldValue();
		}
	}

	public override void OnActive()
	{
		_actor = (AdventureActor)Entity;
		resetUIshieldValues();
		iInit = true;
	}

	private void resetUIshieldValues()
	{
		shiledValue = 0L;
	}

	public int DamageToShield(int damageValue, HotfixEnum.elementType elementType = HotfixEnum.elementType.NONE, LogicEntity from = null, IList<int> attackTag = null)
	{
		int result = 0;
		if (damageValue > shiledValue)
		{
			result = damageValue - (int)shiledValue;
		}
		shiledValue -= damageValue;
		return result;
	}

	public void UpdateShieldValue()
	{
		if (iInit)
		{
			shieldChangedEvent?.Invoke((int)shiledValue, (int)maxShieldValue);
		}
	}

	public void RemoveAllShield()
	{
		shiledValue = 0L;
	}

	public override void OnDeactive()
	{
		resetUIshieldValues();
		iInit = false;
	}

	private void SetOriginIntValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		attributeList?.SetOriginIntValue(type, val, ratio);
	}

	public void SetOwnerValue(ActorShield owner, FDP ratio)
	{
		if (!(owner == null))
		{
			SetOriginIntValue(HotfixEnum.effectAttributeType.SHIELD_MAX, (int)owner.maxShieldValue, ratio);
		}
	}
}
