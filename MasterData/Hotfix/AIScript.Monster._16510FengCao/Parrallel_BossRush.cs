using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._16510FengCao;

public class Parrallel_BossRush : Parallel_BossRush
{
	private int hitTag = CommonHelper.StringToHash("CyclonesHitTag");

	private FP liveTime = 10;

	private int bulletTag_Cyclone = CommonHelper.StringToHash("CyclonesTag");

	private int skill_1 = 1651007;

	private int skill_2 = 1651027;

	private int skill_3 = 1651002;

	private int skill_4 = 1651022;

	private FP delayTime = 6;

	private string bossTagId = "100001";

	private int buff_rage = 631003001;

	private int interval = 10;

	private int buff_dmg = 631003002;

	private int accumulate = 10;

	private int maxCount = 10;

	private int interval_dmg = 2;

	private int once_dmg = 50;

	private FP cd = 2;

	private readonly string bossTagId_2 = "100012";

	private readonly int damageCount2_1 = 10;

	private readonly int buff_2_1 = 631012010;

	private readonly int damageCount2_2 = 1;

	private readonly int buff_2_2 = 631012020;

	private readonly string bossTagId_3 = "100019";

	private const int buff_3_1 = 631019010;

	private const int buff_3_2 = 631019020;

	private const int buff_3_3 = 631019030;

	private static readonly FP cd_3 = 0.5f;

	private readonly string bossTagId_4 = "100000";

	private readonly int buff_4_1;

	private readonly int buff_4_2;

	private int summonId;

	private Dictionary<long, FP> dicLiveTime = new Dictionary<long, FP>();

	private CoroutineNode corBuff;

	private Dictionary<int, List<FP>> dicSkillHit = new Dictionary<int, List<FP>>();

	private bool hasTag;

	private FP curTime;

	private bool hasTag_2;

	private bool hasTag_3;

	private bool hasTag_4;

	private int hitCount2_1;

	private int hitCount2_2;

	private FP curTime_3;

	private long uid;

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private Dictionary<long, bool> dicDmgState = new Dictionary<long, bool>();

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnAcorSummon);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeave);
		uid = 0L;
		curTime = 0;
		curTime_3 = 0;
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		summonId = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, 1);
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			dicSkillHit.Add(playerAdventureActor.dataID, new List<FP>());
		}
		hasTag = _actor.CheckTag(bossTagId);
		if (hasTag)
		{
			StartCoroutine(ref corBuff, DoAddBuff());
		}
		hitCount2_1 = 0;
		hitCount2_2 = 0;
		hasTag_2 = _actor.CheckTag(bossTagId_2);
		hasTag_3 = _actor.CheckTag(bossTagId_3);
		hasTag_4 = _actor.CheckTag(bossTagId_4);
		if (hasTag_3)
		{
			AddBuffToTeam(631019020, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnAcorSummon);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeave);
		StopCoroutine(ref corBuff);
		dicLiveTime.Clear();
		dicSkillHit.Clear();
		dicDmgState.Clear();
		if (hasTag_3)
		{
			RemoveBuffFromTeam(631019020);
			RemoveBuffFromTeam(631019030);
		}
		foreach (CoroutineNode cor in corList)
		{
			StopCoroutine(cor);
		}
		corList.Clear();
	}

	private long GetUid()
	{
		return ++uid;
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			int skillId = adventureActorCastSkillEvent.skillEventInfo.skillId;
			if (skillId == skill_1 || skillId == skill_2 || skillId == skill_3 || skillId == skill_4)
			{
				long key = GetUid();
				dicDmgState.Add(key, value: false);
				corList.Add(StartCoroutine(DoCheckHit(key)));
			}
		}
	}

	private IEnumerator DoCheckHit(long uid)
	{
		yield return _actor.WaitTime(delayTime);
		if (dicDmgState.TryGetValue(uid, out var value))
		{
			if (!value && _monster.CheckScoreBossBehaviour(11))
			{
				_monster.TriggerScoreBossBehaviour(11);
			}
			dicDmgState.Remove(uid);
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, hitTag) && damageEvent.to is PlayerAdventureActor && damageEvent.weapon != null && damageEvent.weapon is AdventureBullet adventureBullet && adventureBullet.BulletHashCode == bulletTag_Cyclone)
		{
			foreach (long item in dicDmgState.Keys.ToList())
			{
				dicDmgState.set_Item(item, true);
			}
		}
		if (!(damageEvent.to == _actor))
		{
			return;
		}
		PlayerAdventureActor summoner = damageEvent.from as PlayerAdventureActor;
		if ((object)summoner == null && (!(damageEvent.from is MonsterAdventureActor entity) || !entity.IsPlayerMinion(out summoner)))
		{
			return;
		}
		if (hasTag && (_actor.LogicTime - curTime > cd || curTime <= 0) && dicSkillHit.TryGetValue(summoner.dataID, out var value))
		{
			value.Add(_actor.LogicTime);
			_ = _actor.LogicTime;
			FP fP = _actor.LogicTime - interval_dmg;
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value.get_Item(num) < fP)
				{
					value.RemoveAt(num);
				}
			}
			if (value.Count >= accumulate)
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_rage);
				mainCtrActor.buffComponent.AddBuffNum(buff_dmg, maxCount, summoner);
				curTime = _actor.LogicTime;
				foreach (KeyValuePair<int, List<FP>> item2 in dicSkillHit)
				{
					item2.Value.Clear();
				}
			}
		}
		if (hasTag_2)
		{
			if (damageEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				hitCount2_1++;
				if (hitCount2_1 >= damageCount2_1)
				{
					hitCount2_1 = 0;
					_actor.buffComponent?.AddBuff(buff_2_1, _actor);
				}
			}
			else if (damageEvent.damageType == HotfixEnum.damageType.MARK)
			{
				hitCount2_2++;
				if (hitCount2_2 >= damageCount2_2)
				{
					hitCount2_2 = 0;
					_actor.buffComponent?.AddBuff(buff_2_2, _actor);
				}
			}
		}
		if (hasTag_3 && damageEvent.damageType == HotfixEnum.damageType.NORMAL && damageEvent.from == mainCtrActor && (_actor.LogicTime - curTime_3 >= cd_3 || curTime_3 <= 0))
		{
			_actor.buffComponent?.AddBuff(631019010, mainCtrActor);
			curTime_3 = _actor.LogicTime;
		}
		if (hasTag_4)
		{
			if (damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				_actor.buffComponent?.AddBuff(buff_4_1, _actor);
			}
			else if (damageEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				_actor.buffComponent?.AddBuff(buff_4_2, _actor);
			}
		}
	}

	protected override void OnReceiveBeforeHit(IEvent evt)
	{
		if (hasTag)
		{
			AdventureActorReceiveDamageBeforeHitEvent obj = evt as AdventureActorReceiveDamageBeforeHitEvent;
			PlayerAdventureActor playerAdventureActor = obj.from as PlayerAdventureActor;
			if (obj.to as MonsterAdventureActor == _actor && playerAdventureActor == mainCtrActor && mainCtrActor.buffComponent.CheckBuffByBuffID(buff_dmg))
			{
				mainCtrActor.buffComponent.RemoveBuffByBuffId(buff_dmg, 1);
				AdventureActor.AddFromAttr(once_dmg, mainCtrActor);
			}
		}
	}

	private void OnAcorSummon(IEvent evt)
	{
		AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = evt as AdventureMonsterSummonerSpawnedEvent;
		if (adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id && adventureMonsterSummonerSpawnedEvent.dataId == summonId)
		{
			dicLiveTime.Add(adventureMonsterSummonerSpawnedEvent.id, _actor.LogicTime);
		}
	}

	private void OnPlayerEnter(IEvent evt)
	{
		if (hasTag_3 && evt is AdventurePlayerEnterEvent)
		{
			RefreshEntry3AssistBuff();
		}
	}

	private void OnPlayerLeave(IEvent evt)
	{
		if (hasTag_3 && evt is AdventurePlayerLeaveEvent)
		{
			RefreshEntry3AssistBuff();
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		base.OnActorDied(e);
		if (e is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.dataID == summonId && dicLiveTime.TryGetValue(adventureActorDiedEvent.actor.Id, out var value) && _actor.LogicTime - value <= liveTime && _monster.CheckScoreBossBehaviour(12))
		{
			_monster.TriggerScoreBossBehaviour(12);
		}
	}

	private IEnumerator DoAddBuff()
	{
		_actor.buffComponent.AddBuff(buff_rage, _actor);
		while (true)
		{
			yield return _actor.WaitTime(interval);
			_actor.buffComponent.AddBuff(buff_rage, _actor);
		}
	}

	private bool HasResidentAssist()
	{
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = list.get_Item(i);
			if (playerAdventureActor != null && playerAdventureActor.isAssist && !playerAdventureActor.IsDead() && playerAdventureActor.isResident)
			{
				return true;
			}
		}
		return false;
	}

	private void RefreshEntry3AssistBuff()
	{
		if (HasResidentAssist())
		{
			AddBuffToTeam(631019030, _actor);
		}
		else
		{
			RemoveBuffFromTeam(631019030);
		}
	}

	private void AddBuffToTeam(int buffId, AdventureActor from)
	{
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = list.get_Item(i);
			if (!(playerAdventureActor == null) && !playerAdventureActor.IsDead() && !(playerAdventureActor.buffComponent == null) && !playerAdventureActor.buffComponent.CheckBuffByBuffID(buffId))
			{
				playerAdventureActor.buffComponent.AddBuff(buffId, from);
			}
		}
	}

	private void RemoveBuffFromTeam(int buffId)
	{
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = list.get_Item(i);
			if (!(playerAdventureActor?.buffComponent == null))
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(buffId);
			}
		}
	}
}
