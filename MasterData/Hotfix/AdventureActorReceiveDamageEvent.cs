using System.Collections.Generic;
using TrueSync;

public class AdventureActorReceiveDamageEvent : BaseAdventureEvent
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

	public int damageToughness;

	public HotfixEnum.damageType damageType;

	public FP addEnergyForMainControl;

	public readonly Dictionary<int, int> fromOnceAttrIds = new Dictionary<int, int>();

	public readonly Dictionary<int, int> toOnceAttrIds = new Dictionary<int, int>();

	public static AdventureActorReceiveDamageEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveDamageEvent>("ADVENTURE_ACTOR_RECEIVE_DAMAGE");
	}

	public AdventureActorReceiveDamageEvent()
		: base("ADVENTURE_ACTOR_RECEIVE_DAMAGE")
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
		damageToughness = 0;
		addEnergyForMainControl = 0;
		fromOnceAttrIds.Clear();
		toOnceAttrIds.Clear();
	}
}
