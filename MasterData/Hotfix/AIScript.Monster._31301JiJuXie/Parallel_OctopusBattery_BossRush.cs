using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Parallel_OctopusBattery_BossRush : Parallel_OctopusBattery
{
	private class WaveAgg
	{
		public int expected;

		public bool hit;

		public readonly HashSet<long> reported = new HashSet<long>();
	}

	private class BulletWave
	{
		public FP startTime;

		public int alive;

		public bool hit;
	}

	private readonly HotfixEnum.scoreBossBehavior entryEnum_DodgeAttack = HotfixEnum.scoreBossBehavior.TriggerCommon2;

	private static readonly int[] sprayScoreSkillIds = new int[2] { 3130139, 3130149 };

	private static readonly FP bulletWaveTolerance = 1;

	private MonsterAdventureActor _scoreBoss;

	private Dictionary<long, FP> _bulletShot = new Dictionary<long, FP>();

	private bool _isSpraying;

	private bool _sprayHit;

	private FP _sprayWaveId;

	private FP _sprayWaveIdPending;

	private static readonly Dictionary<FP, WaveAgg> s_waves = new Dictionary<FP, WaveAgg>();

	private static readonly Dictionary<FP, BulletWave> s_bulletWaves = new Dictionary<FP, BulletWave>();

	private static readonly List<FP> s_bulletSweepBuffer = new List<FP>();

	public override void OnStart()
	{
		base.OnStart();
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		_actor.logicVariable.SetLogicTagValue("isOctopusBattery", FP.One);
		_bulletShot.Clear();
		s_bulletWaves.Clear();
		_isSpraying = false;
		_sprayHit = false;
		_sprayWaveIdPending = FP.Zero;
		s_waves.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnActorCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnActorCustomEvent);
	}

	public override void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnActorCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnActorCustomEvent);
		base.OnDisable();
	}

	private void OpenWindow(FP waveId)
	{
		if (!s_waves.ContainsKey(waveId))
		{
			s_waves.set_Item(waveId, new WaveAgg
			{
				expected = CountActiveBatteries()
			});
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (!(evt is AdventureBulletBornEvent adventureBulletBornEvent) || adventureBulletBornEvent.owner != _actor)
		{
			return;
		}
		FP time = LockStepManager.time;
		SweepSettleClosedEmpty(time);
		FP fP = time;
		BulletWave bulletWave = null;
		foreach (KeyValuePair<FP, BulletWave> s_bulletWave in s_bulletWaves)
		{
			if (time - s_bulletWave.Value.startTime <= bulletWaveTolerance)
			{
				bulletWave = s_bulletWave.Value;
				fP = s_bulletWave.Key;
				break;
			}
		}
		if (bulletWave == null)
		{
			bulletWave = new BulletWave
			{
				startTime = time
			};
			fP = time;
			s_bulletWaves.set_Item(fP, bulletWave);
		}
		bulletWave.alive++;
		_bulletShot.set_Item(adventureBulletBornEvent.id, fP);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent) || adventureBulletFinishEvent.owner != _actor || !_bulletShot.TryGetValue(adventureBulletFinishEvent.id, out var value))
		{
			return;
		}
		_bulletShot.Remove(adventureBulletFinishEvent.id);
		SweepSettleClosedEmpty(LockStepManager.time);
		if (s_bulletWaves.TryGetValue(value, out var value2))
		{
			value2.alive--;
			if (value2.alive <= 0 && LockStepManager.time - value2.startTime > bulletWaveTolerance)
			{
				SettleBulletWave(value2);
				s_bulletWaves.Remove(value);
			}
		}
	}

	private void OnActorCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent && !(adventureActorCastSkillEndEvent.sender as AdventureActor != _actor) && IsSprayScoreSkill(adventureActorCastSkillEndEvent.skillEventInfo.skillId) && _isSpraying)
		{
			_isSpraying = false;
			TryAddDodgeScore(_sprayWaveId, _sprayHit);
		}
	}

	private void OnActorCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventHashCode: var eventHashCode } adventureActorCustomEvent)
		{
			if (eventHashCode == Config.evt_SprayWaterBattery || eventHashCode == Config.evt_SprayWaterBatteryUltra)
			{
				_sprayWaveIdPending = LockStepManager.time;
			}
			else if (!(adventureActorCustomEvent.sender as AdventureActor != _actor) && eventHashCode == Config.evt_SprayEnterLoop)
			{
				_sprayHit = false;
				_isSpraying = true;
				_sprayWaveId = _sprayWaveIdPending;
				OpenWindow(_sprayWaveId);
			}
		}
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || adventureActorReceiveDamageEvent.from != _actor)
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor == null || adventureActorReceiveDamageEvent.to != playerAdventureActor)
		{
			return;
		}
		if (adventureActorReceiveDamageEvent.weapon is AdventureBulletBase adventureBulletBase)
		{
			if (_bulletShot.TryGetValue(adventureBulletBase.Id, out var value) && s_bulletWaves.TryGetValue(value, out var value2))
			{
				value2.hit = true;
			}
		}
		else if (_isSpraying && IsSprayScoreSkill(adventureActorReceiveDamageEvent.skillId))
		{
			_sprayHit = true;
		}
	}

	private bool IsSprayScoreSkill(int skillId)
	{
		return Array.IndexOf(sprayScoreSkillIds, skillId) >= 0;
	}

	private void TryAddDodgeScore(FP waveId, bool isHit)
	{
		if (_scoreBoss == null)
		{
			_scoreBoss = FindBoss();
		}
		if (_scoreBoss == null || !_scoreBoss.CheckScoreBossBehaviour((int)entryEnum_DodgeAttack) || !s_waves.TryGetValue(waveId, out var value))
		{
			return;
		}
		value.reported.Add(_actor.Id);
		if (isHit)
		{
			value.hit = true;
		}
		if (value.reported.Count >= value.expected)
		{
			bool hit = value.hit;
			s_waves.Remove(waveId);
			if (!hit)
			{
				_scoreBoss.TriggerScoreBossBehaviour((int)entryEnum_DodgeAttack);
			}
		}
	}

	private void SettleBulletWave(BulletWave w)
	{
		if (_scoreBoss == null)
		{
			_scoreBoss = FindBoss();
		}
		if (!(_scoreBoss == null) && _scoreBoss.CheckScoreBossBehaviour((int)entryEnum_DodgeAttack) && !w.hit)
		{
			_scoreBoss.TriggerScoreBossBehaviour((int)entryEnum_DodgeAttack);
		}
	}

	private void SweepSettleClosedEmpty(FP now)
	{
		s_bulletSweepBuffer.Clear();
		foreach (KeyValuePair<FP, BulletWave> s_bulletWave in s_bulletWaves)
		{
			if (s_bulletWave.Value.alive == 0 && now - s_bulletWave.Value.startTime > bulletWaveTolerance)
			{
				s_bulletSweepBuffer.Add(s_bulletWave.Key);
			}
		}
		for (int i = 0; i < s_bulletSweepBuffer.Count; i++)
		{
			if (s_bulletWaves.TryGetValue(s_bulletSweepBuffer.get_Item(i), out var value))
			{
				SettleBulletWave(value);
				s_bulletWaves.Remove(s_bulletSweepBuffer.get_Item(i));
			}
		}
	}

	private int CountActiveBatteries()
	{
		int num = 0;
		List<LogicEntity> entities = ModuleController<AdventureModuleController>.Instance.entities;
		for (int num2 = entities.Count - 1; num2 >= 0; num2--)
		{
			if (entities.get_Item(num2) is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.logicVariable.GetLogicTagValue("isOctopusBattery") != FP.Zero && monsterAdventureActor.logicVariable.GetLogicTagToggle("isActive"))
			{
				num++;
			}
		}
		if (num <= 0)
		{
			return 1;
		}
		return num;
	}

	private MonsterAdventureActor FindBoss()
	{
		List<LogicEntity> entities = ModuleController<AdventureModuleController>.Instance.entities;
		for (int num = entities.Count - 1; num >= 0; num--)
		{
			if (entities.get_Item(num) is MonsterAdventureActor monsterAdventureActor && CommonUtils_MonsterAPI.GetLogicTagStringValue(monsterAdventureActor, "MonsterTag") == Config.bossTag)
			{
				return monsterAdventureActor;
			}
		}
		return null;
	}
}
