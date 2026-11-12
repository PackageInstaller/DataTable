using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11401;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_MS2 = CommonHelper.StringToHash("114_Short_Bullet");

	private int buffId_S2 = 801140010;

	private int buffTag_S2 = CommonHelper.StringToHash("114_B1_Base");

	private int totleTime_S2 = 10;

	private FP interval_S2 = 2;

	private string areaEffect_S2 = "AreaEffect_114_Main_Skill_Hit_Lv1";

	private const int perkId_2 = 1140102;

	private int bulletCountThreshold = 12;

	private int bounceCount = 1;

	private int bombCount = 2;

	private FP searchRange = 7.5;

	private FP reboundRange = 5;

	private string bullet_First = "Bullet_114_Bomb";

	private string bullet_Bounce = "Bullet_114_Bomb_Bounce";

	private int normalBulletTag = CommonHelper.StringToHash("NormalAttack");

	private List<TSVector2> shootOffsets_XZ = new List<TSVector2>
	{
		new TSVector2(0.7, 1),
		new TSVector2(-0.7, 1)
	};

	private List<FP> shootOffsets_Y = new List<FP> { 1.5, 1.5 };

	private int curBulletCount;

	private string fxKey_DotShoot = "fx_11401_base_Skill_Main_2_td";

	private const int perkId_3 = 1140103;

	private int buffId_3_vuln = 801140020;

	private int once_3_base = 811140001;

	private int once_3_vuln = 811140002;

	private int buffId_S2_3_1 = 801140011;

	private int buffId_S2_3_2 = 801140012;

	private int buffId_S2_3_3 = 801140013;

	private string areaEffect_S2_3_1 = "AreaEffect_114_Main_Skill_Hit_Lv2";

	private string areaEffect_S2_3_2 = "AreaEffect_114_Main_Skill_Hit_Lv3";

	private string areaEffect_S2_3_3 = "AreaEffect_114_Main_Skill_Hit_Lv4";

	private const int perkId_4 = 1140104;

	private int buffId_P04 = 801140030;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1140107] = 25 };

	private List<LogicEntity> entities = new List<LogicEntity>();

	private List<ReflectWeapon> reflectWeapons = new List<ReflectWeapon>();

	private Dictionary<long, CoroutineNode> dicMonsterCor = new Dictionary<long, CoroutineNode>();

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private long uidGen;

	private PlayFX playFX_DotShoot = new PlayFX();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		curBulletCount = 0;
		uidGen = 0L;
	}

	public override void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		base.OnDisable();
		for (int i = 0; i < reflectWeapons.Count; i++)
		{
			if (!reflectWeapons.get_Item(i).isFinished)
			{
				reflectWeapons.get_Item(i).Finish();
			}
		}
		reflectWeapons.Clear();
		entities.Clear();
		foreach (CoroutineNode value in dicMonsterCor.Values)
		{
			StopCoroutine(value);
		}
		foreach (CoroutineNode cor in corList)
		{
			StopCoroutine(cor);
		}
		dicMonsterCor.Clear();
		corList.Clear();
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerk(1140104))
		{
			_actor.buffComponent.AddBuff(buffId_P04, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2))
		{
			return;
		}
		if (GetPerk(1140103))
		{
			if (monster.buffComponent.CheckBuffByBuffID(buffId_S2))
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_S2);
				monster.buffComponent.AddBuff(buffId_S2_3_1, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_3_1))
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_S2);
				monster.buffComponent.AddBuff(buffId_S2_3_2, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_3_2))
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_S2);
				monster.buffComponent.AddBuff(buffId_S2_3_3, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_3_3))
			{
				monster.buffComponent.AddBuff(buffId_S2_3_3, _actor);
			}
			else
			{
				monster.buffComponent.AddBuff(buffId_S2, _actor);
			}
			monster.buffComponent.AddBuff(buffId_3_vuln, _actor);
		}
		else
		{
			monster.buffComponent.AddBuff(buffId_S2, _actor);
		}
		if (dicMonsterCor.TryGetValue(monster.Id, out var value))
		{
			StopCoroutine(value);
			dicMonsterCor.Remove(monster.Id);
		}
		value = StartCoroutine(DotHit(monster));
		dicMonsterCor.Add(monster.Id, value);
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerk(1140103) && monster.buffComponent.CheckBuffByBuffTag(buffTag_S2))
		{
			if (once_3_base != 0)
			{
				AdventureActor.AddFromAttr(once_3_base, _actor);
			}
			int num = ((buffId_3_vuln != 0) ? monster.buffComponent.GetBuffNumByID(buffId_3_vuln) : 0);
			if (num > 1 && once_3_vuln != 0)
			{
				AdventureActor.AddFromAttr(once_3_vuln, _actor, num - 1);
			}
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (!actor.IsActive || !(evt is AdventureBulletBornEvent adventureBulletBornEvent) || adventureBulletBornEvent.owner != _actor || !GetPerk(1140102))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = adventureBulletBornEvent.sender as AdventureBulletBase;
		if (adventureBulletBase != null && adventureBulletBase.CheckBulletTag(normalBulletTag))
		{
			curBulletCount++;
			if (bulletCountThreshold > 0 && curBulletCount >= bulletCountThreshold)
			{
				curBulletCount = 0;
				CoroutineNode item = StartCoroutine(DotShoot());
				corList.Add(item);
			}
		}
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
	}

	private IEnumerator DotHit(MonsterAdventureActor monster)
	{
		FP time = totleTime_S2;
		long areaEffectId = DoHit(monster);
		for (; time > 0; time -= _actor.LogicDeltaTime)
		{
			if (!(monster != null))
			{
				break;
			}
			if (!monster.actorHealthInfo.isAlive)
			{
				break;
			}
			yield return null;
		}
		ILRuntimeAPI.StopAreaEffect(areaEffectId);
		if (monster != null)
		{
			monster.buffComponent.RemoveBuffByTag(buffTag_S2);
		}
	}

	private long DoHit(MonsterAdventureActor monster)
	{
		string fxAlias = areaEffect_S2;
		if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_3_1))
		{
			fxAlias = areaEffect_S2_3_1;
		}
		else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_3_2))
		{
			fxAlias = areaEffect_S2_3_2;
		}
		else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_3_3))
		{
			fxAlias = areaEffect_S2_3_3;
		}
		return ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, monster.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = areaEffect.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = monster;
			}
		});
	}

	private IEnumerator DotShoot()
	{
		CommonUtils.SearchNearTargetsByCircleInTD(actor, actor.tsTransform.Position, searchRange, entities, isConfront: true);
		if (entities.Count > 0)
		{
			if (_actor.attackTarget != null && entities.Contains(_actor.attackTarget))
			{
				entities.Remove(_actor.attackTarget);
				entities.Insert(0, _actor.attackTarget);
			}
			playFX_DotShoot.Play(_actor, null, fxKey_DotShoot, default, _actor.tsTransform.Position, TSVector2.zero);
			for (int i = 0; i < bombCount; i++)
			{
				int index = i % entities.Count;
				ReflectWeapon reflectWeapon = new ReflectWeapon();
				reflectWeapon.uid = GenUid();
				reflectWeapon.owner = _actor;
				reflectWeapon.reflectCount = bounceCount;
				reflectWeapon.reboundRange = reboundRange;
				reflectWeapon.firBullet = bullet_First;
				reflectWeapon.sedBullet = bullet_Bounce;
				TSVector2 shootPosXZ = _actor.tsTransform.Position + shootOffsets_XZ.get_Item(i);
				FP shootPosY = shootOffsets_Y.get_Item(i);
				reflectWeapon.Shoot(entities.get_Item(index), shootPosXZ, shootPosY);
				reflectWeapons.Add(reflectWeapon);
			}
		}
		yield break;
	}

	private long GenUid()
	{
		uidGen++;
		return uidGen;
	}
}
