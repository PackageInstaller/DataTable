using System.Collections.Generic;

public class AdventureActorReceiveDamageForEffectEvent : BaseAdventureEvent
{
	public LogicEntity from;

	public LogicEntity to;

	public AdventureWeapon weapon;

	public DamageType attackType;

	public long damage;

	public long damageToShieldAndHp;

	public long damageToHp;

	public bool isCrit;

	public bool isDodge;

	public HotfixEnum.elementType elementType;

	public bool damageShield;

	public bool isKill;

	public int hitDamageId;

	public IList<int> hitDamageTag;

	public int uniqueAttackId;

	public int onceAttackTargetCount;

	public HotfixEnum.skillSlotType skillSlotType;

	public long areaEffectId;

	public int skillId;

	public bool isEnterLostCtr;

	public LostControlType lostControlType;

	public long damageToughness;

	public HotfixEnum.damageType damageType;

	public static AdventureActorReceiveDamageForEffectEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveDamageForEffectEvent>("ACTOR_RECEIVE_DAMAGE_FOR_EFFECT");
	}

	public AdventureActorReceiveDamageForEffectEvent()
		: base("ACTOR_RECEIVE_DAMAGE_FOR_EFFECT")
	{
	}

	public override void Clear()
	{
		from = null;
		to = null;
		weapon = null;
		attackType = DamageType.None;
		damage = 0L;
		damageToShieldAndHp = 0L;
		damageToHp = 0L;
		isCrit = false;
		isDodge = false;
		damageShield = false;
		hitDamageId = 0;
		hitDamageTag = null;
		skillSlotType = HotfixEnum.skillSlotType.NONE;
		skillId = 0;
		isEnterLostCtr = false;
		lostControlType = LostControlType.None;
		damageToughness = 0L;
	}
}
