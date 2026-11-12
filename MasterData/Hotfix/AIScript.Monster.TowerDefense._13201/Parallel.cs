using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13201;

public class Parallel : TowerCharacterParalletBase
{
	private const int buffId_Star = 801320030;

	private const int BuffMaxCount_ForMonster = 4;

	private string areaEffectKey_Explosion = "AreaEffect_132_Support_StarBurst";

	private string areaEffectKey_Explosion_Big = "AreaEffect_132_Support_StarBurst_P22_Big";

	private int damageTag_S2 = CommonHelper.StringToHash("132_Main_S2_Burst");

	private int damageTag_S3 = CommonHelper.StringToHash("132_Main_S3_Burst");

	private int damageTag_S3Extra_Add = CommonHelper.StringToHash("132_Main_S2Extra_Add");

	private int damageTag_S3Extra_Boom = CommonHelper.StringToHash("132_Main_S2Extra_Boom");

	private const int perkId_1 = 1320101;

	private const int addStarCount_P01 = 1;

	private const int perkId_2 = 1320102;

	private const int perkId_3 = 1320103;

	private const int perkId_4 = 1320104;

	private FP knockbackDistance_Small = 0.5;

	private FP knockbackDistance_Mid = 1.5;

	private FP knockbackSpeed = 20;

	private FP knockbackStrength = 0;

	private FP knockbackStrength_P2 = 3;

	private FP knockbackStrength_P4 = 3;

	private FP knockbackStrength_P2_P4 = 4;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>
	{
		[1320105] = 25,
		[1320106] = 25,
		[1320107] = 25
	};

	private Dictionary<long, StarBuffController> _starControllerDic = new Dictionary<long, StarBuffController>(10);

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		foreach (StarBuffController value in _starControllerDic.Values)
		{
			value?.Clear();
		}
		_starControllerDic.Clear();
	}

	public void OnUpdate()
	{
		if (_starControllerDic.Count <= 0)
		{
			return;
		}
		foreach (StarBuffController value in _starControllerDic.Values)
		{
			value?.Update(_actor.LogicDeltaTime);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf || monster == null)
		{
			return;
		}
		if (GetPerk(1320101))
		{
			bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_S2);
			bool flag2 = GetPerk(1320103) && CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_S3Extra_Add);
			if (flag | flag2)
			{
				AddStar(monster, 1);
			}
			bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_S3);
			bool flag4 = GetPerk(1320103) && CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_S3Extra_Boom);
			if (flag3 | flag4)
			{
				TriggerStarByMace(monster);
			}
		}
		if (GetPerk(1320102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_S2))
		{
			FP distance = (GetPerk(1320104) ? knockbackDistance_Mid : knockbackDistance_Small);
			ApplyKnockback(monster, distance);
		}
	}

	private void AddStar(MonsterAdventureActor monster, int count)
	{
		if (!_starControllerDic.ContainsKey(monster.Id))
		{
			StarBuffController starBuffController = new StarBuffController(_actor);
			starBuffController.Init(monster, 4, OnStarReduceCount);
			_starControllerDic.Add(monster.Id, starBuffController);
		}
		_starControllerDic.get_Item(monster.Id).AddBuff(count);
	}

	private void OnStarReduceCount(AdventureActor target)
	{
		if (!(target == null))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Explosion, target.tsTransform.Position);
		}
	}

	private void TriggerStarByMace(MonsterAdventureActor monster)
	{
		if (_starControllerDic.TryGetValue(monster.Id, out var value) && value.GetBuffCount() > 0)
		{
			int buffCount = value.GetBuffCount();
			for (int i = 0; i < buffCount; i++)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Explosion_Big, monster.tsTransform.Position);
			}
			monster.buffComponent.RemoveBuffByBuffId(801320030);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (GetPerk(1320101) && (evt as AdventureActorDiedEvent)?.actor is MonsterAdventureActor monsterAdventureActor && _starControllerDic.TryGetValue(monsterAdventureActor.Id, out var value))
		{
			int buffCount = value.GetBuffCount();
			for (int i = 0; i < buffCount; i++)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Explosion, monsterAdventureActor.tsTransform.Position);
			}
			value.Clear();
			_starControllerDic.Remove(monsterAdventureActor.Id);
		}
	}

	private void ApplyKnockback(MonsterAdventureActor monster, FP distance)
	{
		if (!(distance <= 0))
		{
			FP strength = knockbackStrength;
			if (GetPerk(1320102) && GetPerk(1320104))
			{
				strength = knockbackStrength_P2_P4;
			}
			else if (GetPerk(1320102))
			{
				strength = knockbackStrength_P2;
			}
			else if (GetPerk(1320104))
			{
				strength = knockbackStrength_P4;
			}
			TSVector2 normalized = (monster.tsTransform.Position - _actor.tsTransform.Position).normalized;
			ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, monster.tsTransform.Position + normalized * distance, new List<LogicEntity> { monster }, distance, knockbackSpeed, strength, 99, isPull: false, withRadius: false, isCoExist: true, isChangeForward: false);
		}
	}
}
