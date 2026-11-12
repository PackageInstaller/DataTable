using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._10701;

public class Parallel : TowerCharacterParalletBase
{
	private int shieldTag_hit = CommonHelper.StringToHash("107ShieldHit");

	public const string shieldKey_monster = "Bullet_107_Shield_ToMonster";

	private readonly string shieldKey_player = "Bullet_107_Shield_ToPlayer";

	private int buffId_player = 801070010;

	public const int perkId_1 = 1070101;

	public static readonly FP time_1 = 8;

	private const int perkId_2 = 1070102;

	private const int buff_2 = 801070020;

	public const int perkId_3 = 1070103;

	public const string aoe_3 = "AreaEffect_107_BuffArea";

	public const int perkId_4 = 1070104;

	public const int count_5 = 5;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1070107] = 30 };

	public static List<long> bulletIds = new List<long>();

	private List<LogicEntity> targets = new List<LogicEntity>();

	public static FP norPlus_t;

	public List<long> bulletIds_toPlayer = new List<long>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		bulletIds.Clear();
		bulletIds_toPlayer.Clear();
		targets.Clear();
		norPlus_t = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnReceiveAttack(AdventureActorReceiveAttackEvent evt)
	{
		base.OnReceiveAttack(evt);
		if (evt.from?.Id != _actor.Id || !(evt.weapon is AdventureBullet adventureBullet))
		{
			return;
		}
		if (evt.to is MonsterAdventureActor monsterAdventureActor && bulletIds.Contains(adventureBullet.Id))
		{
			bulletIds.Remove(adventureBullet.Id);
			CommonUtils.SearchNearTargetsByCircleInTD(_actor, monsterAdventureActor.tsTransform.Position, Action.searchRange, targets);
			AdventureActor adventureActor = _actor;
			if (targets.Count >= 1)
			{
				for (int i = 0; i < targets.Count; i++)
				{
					if (targets.get_Item(i) is DynamicActor)
					{
						adventureActor = targets.get_Item(i) as AdventureActor;
						break;
					}
				}
			}
			TSVector2 position = monsterAdventureActor.tsTransform.Position;
			string bulletAlias = shieldKey_player;
			AdventureActor adventureActor2 = _actor;
			FP range = 0;
			FP positionY = 1.8;
			LogicEntity target = adventureActor;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bulletAlias, adventureActor2, range, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null)
			{
				bulletIds_toPlayer.Add(adventureBulletBase.Id);
			}
		}
		else if (evt.to is DynamicActor dynamicActor && bulletIds_toPlayer.Contains(adventureBullet.Id))
		{
			bulletIds_toPlayer.Remove(adventureBullet.Id);
			dynamicActor.buffComponent?.AddBuff(buffId_player, _actor);
			adventureBullet.Finish();
			CommonUtils.SearchNearTargetsByCircleInTD(_actor, dynamicActor.tsTransform.Position, Action.searchRange, targets, isConfront: true);
			if (targets.Count >= 1)
			{
				TSVector2 position2 = dynamicActor.tsTransform.Position;
				AdventureActor adventureActor3 = _actor;
				FP range2 = 0;
				FP positionY2 = 1.8;
				LogicEntity target = targets.get_Item(0);
				ILRuntimeAPI.Shoot("Bullet_107_Shield_ToMonster", adventureActor3, range2, position2, positionY2, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, shieldTag_hit) && GetPerk(1070102))
		{
			monster.buffComponent?.AddBuff(801070020, _actor);
		}
	}

	public override void OnBulletFinish(AdventureBulletFinishEvent evt)
	{
		base.OnBulletFinish(evt);
		if (bulletIds.Contains(evt.id))
		{
			bulletIds.Remove(evt.id);
		}
	}
}
