using System.Collections;
using System.Collections.Generic;
using AIScript.Character._14901;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._14901001TieChuNv;

public class Action : AIBase
{
	private readonly Dictionary<MonsterAdventureActor, PlayFX> monsterLinks = new Dictionary<MonsterAdventureActor, PlayFX>();

	private readonly Dictionary<PlayFX, FP> hitLinks = new Dictionary<PlayFX, FP>();

	private readonly List<PlayFX> removeValues = new List<PlayFX>();

	private PlayerAdventureActor _mainActor;

	private readonly List<MonsterAdventureActor> targetList = new List<MonsterAdventureActor>();

	private readonly List<MonsterAdventureActor> targetList2 = new List<MonsterAdventureActor>();

	private readonly Dictionary<long, FP> _perkTriggerTimeDic = new Dictionary<long, FP>(5);

	private bool iPerk1;

	private bool iPerk7;

	private bool iPerk8;

	private FP sc_Cd;

	private CoroutineNode corHit;

	private PlayFX _playFx;

	private PlayFX _playFx_1;

	private FP hitTime;

	public void OnEnable()
	{
		hitTime = 0;
		targetList?.Clear();
		targetList2?.Clear();
		_mainActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (_mainActor != null)
		{
			_mainActor.logicVariable.SetLogicTagValue("summonId", _actor.Id);
		}
		_actor.EnablePenetrate();
		_actor.EnableSearchedImmunity();
		if (GetPerk(514904))
		{
			sc_Cd = CommonUtils.GetScriptValue(_mainActor, 14904011);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDie);
	}

	public void OnStop()
	{
		if (monsterLinks.Count > 0)
		{
			foreach (PlayFX value in monsterLinks.Values)
			{
				value.Stop();
			}
		}
		if (hitLinks.Count > 0)
		{
			foreach (PlayFX key in hitLinks.Keys)
			{
				key.Stop();
			}
		}
		StopCoroutine(ref corHit);
		_playFx?.Stop();
		_playFx_1?.Stop();
	}

	public void OnDisable()
	{
		_actor.DisablePenetrate();
		monsterLinks.Clear();
		targetList2.Clear();
		targetList.Clear();
		hitLinks.Clear();
		removeValues.Clear();
		_perkTriggerTimeDic.Clear();
		if (iPerk7 && Config_MainControl.mainConcTime > 0)
		{
			Config_MainControl.mainConcTime = Config_MainControl.time_07;
		}
		else
		{
			Config_MainControl.mainConcTime = 0;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDie);
	}

	public void OnStart()
	{
		iPerk1 = GetPerk(514901);
		iPerk7 = GetPerk(514907);
		iPerk8 = GetPerk(514908);
	}

	private void OnBattleReady(IEvent evt)
	{
		if (_actor != null)
		{
			_actor.DestroySelf();
		}
	}

	private void OnActorDie(IEvent evt)
	{
		if (!((evt as AdventureActorDiedEvent).actor is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		Dictionary<MonsterAdventureActor, PlayFX> dictionary = monsterLinks;
		if (dictionary != null && dictionary.Count <= 0)
		{
			return;
		}
		foreach (MonsterAdventureActor key in monsterLinks.Keys)
		{
			if (key.Id == monsterAdventureActor.Id)
			{
				UnLink(key);
				break;
			}
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor == null) && !(adventureActorReceiveDamageBeforeHitEvent.to == null) && adventureActorReceiveDamageBeforeHitEvent.hitDamageTag != null && !(adventureActorReceiveDamageBeforeHitEvent.from == null) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config_MainControl.damageTag_IronMaiden))
		{
			if (GetPerk(514910))
			{
				AdventureActor.AddFromAttr(14910001, _mainActor);
			}
			if (GetPerk(514912))
			{
				AdventureActor.AddFromAttr(14912001, _mainActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from == _mainActor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor key) || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_NormalAtk) || !monsterLinks.ContainsKey(key) || !GetPerk(514904, sc_Cd))
		{
			return;
		}
		StartCoroutine(ref corHit, DoHitLogic());
		foreach (MonsterAdventureActor key2 in monsterLinks.Keys)
		{
			HitLinkFx(key2);
		}
	}

	private IEnumerator DoHitLogic()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.delay_hit));
		targetList2.Clear();
		foreach (MonsterAdventureActor key in monsterLinks.Keys)
		{
			targetList2.Add(key);
		}
		for (int i = 0; i < targetList2.Count; i++)
		{
			MonsterAdventureActor target = targetList2.get_Item(i);
			ILRuntimeAPI.HitActor(_actor, target, 149310401);
		}
	}

	private bool InSpecialState(AdventureActor target)
	{
		if (target != null)
		{
			if (target.IsSearchedImmunity())
			{
				return true;
			}
			if (target.IsDead())
			{
				return true;
			}
		}
		return false;
	}

	private void CheckLinkTarget()
	{
		if (monsterLinks.Count < 1)
		{
			return;
		}
		bool flag = false;
		targetList.Clear();
		foreach (MonsterAdventureActor key in monsterLinks.Keys)
		{
			targetList.Add(key);
		}
		for (int i = 0; i < targetList.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = targetList.get_Item(i);
			if (InSpecialState(monsterAdventureActor) || _actor.DistanceWithRadius(monsterAdventureActor) > Config_MainControl.linkRange + 0.1)
			{
				UnLink(monsterAdventureActor);
				continue;
			}
			if (HitTarget(monsterAdventureActor))
			{
				flag = true;
			}
			if (iPerk8 && !monsterAdventureActor.buffComponent.CheckBuffByBuffID(14908011))
			{
				monsterAdventureActor.buffComponent.AddBuff(14908011, _actor);
			}
		}
		if (flag)
		{
			hitTime = Config_MainControl.linkHit_cd;
			ILRuntimeAPI.PlayFX(ref _playFx, _actor, null, "fx_14901_base_Skill_IronMaiden_hearts", default, _actor.tsTransform.Position, default);
		}
	}

	private void SearchTargetToLink()
	{
		if (monsterLinks.Count >= Config_MainControl.linkNum)
		{
			return;
		}
		ILRuntimeAPI.SearchByRange(_actor, Config_MainControl.linkRange, (List<LogicEntity> enemys) =>
		{
			if (enemys != null && enemys.Count >= 1)
			{
				enemys.Sort((LogicEntity a, LogicEntity b) => TSVector2.Distance(_actor.tsTransform.Position, a.tsTransform.Position).CompareTo(TSVector2.Distance(_actor.tsTransform.Position, b.tsTransform.Position)));
				for (int num = 0; num < enemys.Count; num++)
				{
					if (monsterLinks.Count >= Config_MainControl.linkNum)
					{
						break;
					}
					MonsterAdventureActor monsterAdventureActor = enemys.get_Item(num) as MonsterAdventureActor;
					if (monsterAdventureActor != null && !monsterAdventureActor.IsDead() && !monsterLinks.ContainsKey(monsterAdventureActor))
					{
						Link(monsterAdventureActor);
					}
				}
			}
		}, isConfront: true);
	}

	private void HitLinkFx(MonsterAdventureActor monster)
	{
		if (!((_actor as MonsterAdventureActor).monsterSummonInfo.LeftTime < Config_MainControl.delay_hit))
		{
			ILRuntimeAPI.PlayFX(ref _playFx_1, _actor, monster, "fx_14901_base_P4_chain_hit", monster.tsTransform.Position, default, default);
			ILRuntimeAPI.PlayFX(ref _playFx, _actor, null, "fx_14901_base_B1_P4_Skill_IronMaiden_trigger", default, _actor.tsTransform.Position, default);
			string fxAlias = "fx_14901_base_B1_P4_Skill_IronMaiden_chain_trigger";
			TSVector sourcePosition = new TSVector(_actor.tsTransform.Position.x, 0, _actor.tsTransform.Position.y);
			TSVector targetPosition = new TSVector(monster.tsTransform.Position.x, 0, monster.tsTransform.Position.y);
			PlayFX playFX = new PlayFX();
			playFX.PlayLinFx(_actor, fxAlias, 1f, useCustSource: false, _actor.gameObject, sourcePosition, _actor.tsTransform.PositionY, monster.gameObject, targetPosition, monster.tsTransform.PositionY);
			hitLinks.Add(playFX, _actor.LogicTime);
		}
	}

	private void Link(MonsterAdventureActor monster)
	{
		string fxAlias = "fx_14901_loop_B1_Skill_IronMaiden_chain";
		TSVector sourcePosition = new TSVector(_actor.tsTransform.Position.x, 0, _actor.tsTransform.Position.y);
		TSVector targetPosition = new TSVector(monster.tsTransform.Position.x, 0, monster.tsTransform.Position.y);
		PlayFX playFX = new PlayFX();
		playFX.PlayLinFx(_actor, fxAlias, 1f, useCustSource: false, _actor.gameObject, sourcePosition, _actor.tsTransform.PositionY, monster.gameObject, targetPosition, monster.tsTransform.PositionY);
		monsterLinks.Add(monster, playFX);
		if (iPerk8)
		{
			monster.buffComponent.AddBuff(14908011, _actor);
		}
	}

	private void UnLink(MonsterAdventureActor monster)
	{
		if (!(monster == null) && monsterLinks.ContainsKey(monster))
		{
			monsterLinks.get_Item(monster).Stop();
			monsterLinks.Remove(monster);
			_perkTriggerTimeDic.Remove(monster.Id);
		}
	}

	private bool HitTarget(MonsterAdventureActor monster)
	{
		if (monster == null)
		{
			return false;
		}
		if (hitTime > 0)
		{
			return false;
		}
		ILRuntimeAPI.HitActor(_actor, monster, 149310002, "fx_14901_hit_ironMaiden_1");
		return true;
	}

	private void CheckConcState()
	{
		if (iPerk1)
		{
			Config_MainControl.mainConcTime = 999;
		}
		else if (TSVector2.Distance(_mainActor.tsTransform.Position, _actor.tsTransform.Position) <= Config_MainControl.link_range * 1.25f)
		{
			Config_MainControl.mainConcTime = 999;
		}
		else
		{
			Config_MainControl.mainConcTime = 0;
		}
	}

	public void OnUpdate()
	{
		hitTime -= _actor.LogicDeltaTime;
		CheckLinkTarget();
		SearchTargetToLink();
		CheckConcState();
		if (hitLinks.Count <= 0)
		{
			return;
		}
		removeValues.Clear();
		foreach (PlayFX key in hitLinks.Keys)
		{
			if (_actor.LogicTime - hitLinks.get_Item(key) > 0.5)
			{
				removeValues.Add(key);
				key.Stop();
			}
		}
		if (removeValues.Count > 0)
		{
			for (int i = 0; i < removeValues.Count; i++)
			{
				hitLinks.Remove(removeValues.get_Item(i));
			}
		}
	}

	protected override bool CheckPerkCd(long perkId, FP Cd)
	{
		if (Cd <= 0 || Cd == default(FP))
		{
			return true;
		}
		if (_perkTriggerTimeDic.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				_perkTriggerTimeDic.set_Item(perkId, _actor.LogicTime);
				return true;
			}
			return false;
		}
		_perkTriggerTimeDic.Add(perkId, _actor.LogicTime);
		return true;
	}
}
