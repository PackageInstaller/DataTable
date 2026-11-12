using AIScript.Monster.Template;

namespace AIScript.Monster._16510FengCao;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private static readonly string bullet_tag = "CyclonesHitTag";

	private const int beHitNum = 5;

	private const int beHitNum_Max = 0;

	private bool fengCao_001_finish;

	private bool fengCao_002_finish;

	private bool fengCao_003_finish;

	private bool fengCao_004_finish;

	private int num_hit_current;

	private bool beHit;

	private bool isToughnessBroken;

	public static bool inUltra;

	public override void OnStart()
	{
		base.OnStart();
		inUltra = false;
		if (AdventureGameContext.LevelLoadParam != null && AdventureGameContext.LevelLoadParam.regionBossLevel != null)
		{
			num_hit_current = 0;
			beHit = false;
			isToughnessBroken = false;
			fengCao_001_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengCao_001);
			fengCao_002_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengCao_002);
			fengCao_003_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengCao_003);
			fengCao_004_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengCao_004);
			if (!fengCao_002_finish)
			{
				ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
			}
			if (!fengCao_001_finish || !fengCao_003_finish || !fengCao_004_finish)
			{
				ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		if (!fengCao_002_finish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
		}
		if (!fengCao_001_finish || !fengCao_003_finish || !fengCao_004_finish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && adventureActorReceiveDamageEvent.to == _player)
		{
			if (!fengCao_001_finish && adventureActorReceiveDamageEvent.attackType == DamageType.Range && adventureActorReceiveDamageEvent.weapon != null && adventureActorReceiveDamageEvent.weapon.tag == bullet_tag)
			{
				beHit = true;
			}
			if (!fengCao_003_finish || !fengCao_004_finish)
			{
				num_hit_current++;
			}
		}
	}

	private void OnToughnessState(IEvent evt)
	{
		MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent = evt as MonsterToughnessStateChangeEvent;
		if (_actor != null && _actor.Id == monsterToughnessStateChangeEvent.actor.Id && _player != null && _player.Id == monsterToughnessStateChangeEvent.source.Id && monsterToughnessStateChangeEvent.isToughnessBroken && inUltra && !isToughnessBroken)
		{
			isToughnessBroken = true;
			ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengCao_002);
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		base.OnActorDied(e);
		if (e is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.Id == _actor.Id && !(adventureActorDiedEvent.killer == null) && adventureActorDiedEvent.killer.Id != _actor.Id)
		{
			if (!beHit && !fengCao_001_finish)
			{
				ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengCao_001);
			}
			if (num_hit_current <= 5 && !fengCao_003_finish)
			{
				ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengCao_003);
			}
			if (num_hit_current <= 0 && !fengCao_004_finish)
			{
				ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengCao_004);
			}
		}
	}
}
