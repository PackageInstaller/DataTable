using UnityEngine;

namespace BilliardGame.Runtime;

public class EntityMechanism : BilliardGameEntityBase
{
	private const int CRYSTAL_ID = 40310;

	private const int POT_ID = 40311;

	private const int CHEST_ID = 40312;

	private const int BOLT_ID = 40313;

	private const int PORTAL_ID = 40314;

	private const int SPEED_BUMP_ID = 50101;

	private const int TIME_PORTAL_ID = 50102;

	private const int BAG_ID = 50103;

	public bool Dead;

	public IMechanismTrigger mechModule;

	public BilliardGameMechanism logic { get; protected set; }

	public MechanismType mechanismType { get; protected set; }

	public EntityMechanism(int entityID, GameObject go, BilliardEntityConfig cfg)
		: base(entityID, go)
	{
		logic = go.GetComponent<BilliardGameMechanism>();
		switch (cfg.id)
		{
		case 40310:
			mechanismType = MechanismType.Crystal;
			mechModule = new CrystalModule(cfg.skillId, this, logic.maxCol);
			break;
		case 40311:
			mechanismType = MechanismType.Pot;
			mechModule = new PotModule(cfg.skillId, this, logic.waitTurn, logic.effectTurn, logic.hp);
			break;
		case 40312:
			mechanismType = MechanismType.Chest;
			mechModule = new ChestModule(cfg.skillId, this, logic.chestType, logic.chestCol);
			break;
		case 40313:
			mechanismType = MechanismType.Bolt;
			mechModule = new BoltModule(cfg.skillId, this, logic.colX, logic.colY, logic.dir);
			break;
		case 40314:
			mechanismType = MechanismType.Portal;
			mechModule = new PortalModule(this);
			break;
		case 50102:
			mechanismType = MechanismType.TimePortal;
			mechModule = new TimePortalModule(this);
			break;
		case 50103:
			mechanismType = MechanismType.Bag;
			mechModule = new BagModule(cfg.skillId, this);
			break;
		case 50101:
			mechanismType = MechanismType.SpeedBump;
			mechModule = new SpeedBumpModule(cfg.skillId, this, logic.totalInvokeNum, logic.maxRound);
			break;
		default:
			mechanismType = MechanismType.Crystal;
			mechModule = new CrystalModule(cfg.skillId, this, logic.maxCol);
			break;
		}
	}

	public EntityMechanism(int entityID, GameObject go)
		: base(entityID, go)
	{
		mechanismType = MechanismType.Wall;
		logic = go.GetComponent<BilliardGameMechanism>();
		mechModule = null;
		Dead = false;
	}

	public bool CheckCanBeAttack()
	{
		return mechanismType == MechanismType.Pot;
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		mechModule?.BeCollision(other);
	}

	public void OnRoundBegin()
	{
		mechModule?.OnRoundStart();
	}

	public override void Dispose()
	{
		Object.DestroyImmediate(base.go);
	}

	public void TakeDamage(int damage)
	{
		if (mechanismType == MechanismType.Pot)
		{
			(mechModule as PotModule).TakeDamage(damage);
		}
	}

	public void TakeRegeneration(int hp, float hpRatio)
	{
		if (mechanismType == MechanismType.Pot)
		{
			(mechModule as PotModule).TakeRegeneration(hp, hpRatio);
		}
	}
}
