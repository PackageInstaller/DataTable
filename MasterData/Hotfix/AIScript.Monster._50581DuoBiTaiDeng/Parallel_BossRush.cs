using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Parallel_BossRush : AIScript.Monster.Template.Parallel_BossRush
{
	private readonly HotfixEnum.scoreBossBehavior entryEnum_ScoreEntry_1 = HotfixEnum.scoreBossBehavior.TriggerTaiDengMissPlayer;

	private readonly int checkSkillId_ScoreEntry_1 = 5058182;

	private readonly int checkHitDamageTag_ScoreEntry_1 = CommonHelper.StringToHash("BulbDamage");

	private readonly HotfixEnum.scoreBossBehavior entryEnum_ScoreEntry_3 = HotfixEnum.scoreBossBehavior.TriggerTaiDengKill;

	private readonly string checkMonsterTag_ScoreEntry_3 = "BulbTag";

	private readonly string strengthenEntryId = "100006";

	private readonly FP triggerThunderInterval_StrengthenEntry = 3;

	private readonly string areaEffectKey_Thunder_StrengthenEntry = "AreaEffect_50581_BossRush_100006";

	private readonly int generateCount_Thunder_StrengthenEntry = 4;

	private readonly FP generateInterval_Thunder_StrengthenEntry = 0.5f;

	private readonly FP generateDistance_Thunder_StrengthenEntry = 4;

	private readonly int receiveAssitDamageTimes_LiftThunder_StrengthenEntry = 20;

	private readonly int unitTime_LiftThunder_StrengthenEntry = 5;

	private readonly int buffId_HaveThunder_StrengthenEntry = 631007001;

	private readonly int buffId_LiftThunder_StrengthenEntry = 631007002;

	private readonly string strengthenEntryId_2 = "100013";

	private readonly FP triggerThunderInterval_StrengthenEntry_2 = 3;

	private readonly string areaEffectKey_Thunder_StrengthenEntry_2 = "AreaEffect_50581_BossRush_100006";

	private readonly int generateCount_Thunder_StrengthenEntry_2 = 4;

	private readonly FP generateInterval_Thunder_StrengthenEntry_2 = 0.5f;

	private readonly FP generateDistance_Thunder_StrengthenEntry_2 = 4;

	private readonly int receiveMarkTriggerTimes_LiftThunder_StrengthenEntry_2 = 3;

	private readonly int unitTime_LiftThunder_StrengthenEntry_2 = 5;

	private readonly int buffId_HaveThunder_StrengthenEntry_2 = 631013001;

	private readonly int buffId_LiftThunder_StrengthenEntry_2 = 631013002;

	private bool _succeed_ScoreEntry_1;

	private bool _hasStrengthenEntry;

	private CoroutineNode _thunderCor_StrengthenEntry;

	private List<CoroutineNode> _singleThunderCorList_StrengthenEntry;

	private List<FP> _receiveDamageTimeList_StrengthenEntry;

	private bool _hasStrengthenEntry_2;

	private CoroutineNode _thunderCor_StrengthenEntry_2;

	private List<CoroutineNode> _singleThunderCorList_StrengthenEntry_2;

	private List<FP> _markTriggerTimeList_StrengthenEntry_2;

	public override void OnStart()
	{
		base.OnStart();
		_succeed_ScoreEntry_1 = false;
		_hasStrengthenEntry = _monster.CheckTag(strengthenEntryId);
		if (_hasStrengthenEntry)
		{
			ChangeThunderState(haveThunderState: true);
		}
		_hasStrengthenEntry_2 = _monster.CheckTag(strengthenEntryId_2);
		if (_hasStrengthenEntry_2)
		{
			ChangeThunderState_2(haveThunderState: true);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (evt is AdventurActorSpawned { sender: MonsterAdventureActor sender } && _monster.IsFriendlyWith(sender))
		{
			if (_monster.buffComponent.CheckBuffByBuffID(buffId_HaveThunder_StrengthenEntry))
			{
				sender.buffComponent.AddBuff(buffId_HaveThunder_StrengthenEntry, _monster);
			}
			else if (_monster.buffComponent.CheckBuffByBuffID(buffId_LiftThunder_StrengthenEntry))
			{
				sender.buffComponent.AddBuff(buffId_LiftThunder_StrengthenEntry, _monster);
			}
			if (_monster.buffComponent.CheckBuffByBuffID(buffId_HaveThunder_StrengthenEntry_2))
			{
				sender.buffComponent.AddBuff(buffId_HaveThunder_StrengthenEntry_2, _monster);
			}
			else if (_monster.buffComponent.CheckBuffByBuffID(buffId_LiftThunder_StrengthenEntry_2))
			{
				sender.buffComponent.AddBuff(buffId_LiftThunder_StrengthenEntry_2, _monster);
			}
		}
	}

	private void ChangeThunderState(bool haveThunderState)
	{
		if (!_hasStrengthenEntry)
		{
			return;
		}
		if (haveThunderState)
		{
			_monster.buffComponent.AddBuff(buffId_HaveThunder_StrengthenEntry, _monster);
			_monster.buffComponent.RemoveBuffByBuffId(buffId_LiftThunder_StrengthenEntry);
			foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor))
			{
				if (item is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.buffComponent.AddBuff(buffId_HaveThunder_StrengthenEntry, _monster);
					monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_LiftThunder_StrengthenEntry);
				}
			}
			if (_thunderCor_StrengthenEntry != null)
			{
				_monster.StopLogicCoroutine(_thunderCor_StrengthenEntry);
			}
			_thunderCor_StrengthenEntry = _monster.StartLogicCoroutine(ThunderLogic(), runImmediately: true);
			return;
		}
		_monster.buffComponent.RemoveBuffByBuffId(buffId_HaveThunder_StrengthenEntry);
		_monster.buffComponent.AddBuff(buffId_LiftThunder_StrengthenEntry, _monster);
		foreach (LogicEntity item2 in ILRuntimeAPI.SearchAllFriendActors(_actor))
		{
			if (item2 is MonsterAdventureActor monsterAdventureActor2)
			{
				monsterAdventureActor2.buffComponent.RemoveBuffByBuffId(buffId_HaveThunder_StrengthenEntry);
				monsterAdventureActor2.buffComponent.AddBuff(buffId_LiftThunder_StrengthenEntry, _monster);
			}
		}
		ClearThunder();
	}

	private void ChangeThunderState_2(bool haveThunderState)
	{
		if (!_hasStrengthenEntry_2)
		{
			return;
		}
		if (haveThunderState)
		{
			_monster.buffComponent.AddBuff(buffId_HaveThunder_StrengthenEntry_2, _monster);
			_monster.buffComponent.RemoveBuffByBuffId(buffId_LiftThunder_StrengthenEntry_2);
			foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor))
			{
				if (item is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.buffComponent.AddBuff(buffId_HaveThunder_StrengthenEntry_2, _monster);
					monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_LiftThunder_StrengthenEntry_2);
				}
			}
			if (_thunderCor_StrengthenEntry_2 != null)
			{
				_monster.StopLogicCoroutine(_thunderCor_StrengthenEntry_2);
			}
			_thunderCor_StrengthenEntry_2 = _monster.StartLogicCoroutine(ThunderLogic_2(), runImmediately: true);
			return;
		}
		_monster.buffComponent.RemoveBuffByBuffId(buffId_HaveThunder_StrengthenEntry_2);
		_monster.buffComponent.AddBuff(buffId_LiftThunder_StrengthenEntry_2, _monster);
		foreach (LogicEntity item2 in ILRuntimeAPI.SearchAllFriendActors(_actor))
		{
			if (item2 is MonsterAdventureActor monsterAdventureActor2)
			{
				monsterAdventureActor2.buffComponent.RemoveBuffByBuffId(buffId_HaveThunder_StrengthenEntry_2);
				monsterAdventureActor2.buffComponent.AddBuff(buffId_LiftThunder_StrengthenEntry_2, _monster);
			}
		}
		ClearThunder_2();
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnActorCastSkill(castSkillEvent);
		if (castSkillEvent.sender is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor == _monster && _monster.CheckScoreBossBehaviour((int)entryEnum_ScoreEntry_1) && castSkillEvent.skillEventInfo.skillId == checkSkillId_ScoreEntry_1)
		{
			_succeed_ScoreEntry_1 = true;
		}
	}

	private IEnumerator ThunderLogic()
	{
		FP interval = triggerThunderInterval_StrengthenEntry;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				if (_singleThunderCorList_StrengthenEntry == null)
				{
					_singleThunderCorList_StrengthenEntry = new List<CoroutineNode>();
				}
				_singleThunderCorList_StrengthenEntry.Add(_actor.StartLogicCoroutine(SingleThunderLogic(), runImmediately: true));
				interval += triggerThunderInterval_StrengthenEntry;
			}
			yield return null;
		}
	}

	private IEnumerator SingleThunderLogic()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		TSVector2 direction = (activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).normalized;
		TSVector2 position = _monster.tsTransform.Position;
		int lastCount = generateCount_Thunder_StrengthenEntry;
		FP generateInterval = 0;
		while (lastCount > 0)
		{
			if (generateInterval > 0)
			{
				generateInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				position += direction * generateDistance_Thunder_StrengthenEntry;
				ILRuntimeAPI.PlayAreaEffect(_monster, areaEffectKey_Thunder_StrengthenEntry, position);
				generateInterval += generateInterval_Thunder_StrengthenEntry;
				lastCount--;
			}
			yield return null;
		}
	}

	private IEnumerator ThunderLogic_2()
	{
		FP interval = triggerThunderInterval_StrengthenEntry_2;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				if (_singleThunderCorList_StrengthenEntry_2 == null)
				{
					_singleThunderCorList_StrengthenEntry_2 = new List<CoroutineNode>();
				}
				_singleThunderCorList_StrengthenEntry_2.Add(_actor.StartLogicCoroutine(SingleThunderLogic_2(), runImmediately: true));
				interval += triggerThunderInterval_StrengthenEntry_2;
			}
			yield return null;
		}
	}

	private IEnumerator SingleThunderLogic_2()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		TSVector2 direction = (activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).normalized;
		TSVector2 position = _monster.tsTransform.Position;
		int lastCount = generateCount_Thunder_StrengthenEntry_2;
		FP generateInterval = 0;
		while (lastCount > 0)
		{
			if (generateInterval > 0)
			{
				generateInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				position += direction * generateDistance_Thunder_StrengthenEntry_2;
				ILRuntimeAPI.PlayAreaEffect(_monster, areaEffectKey_Thunder_StrengthenEntry_2, position);
				generateInterval += generateInterval_Thunder_StrengthenEntry_2;
				lastCount--;
			}
			yield return null;
		}
	}

	private void OnBuffRemove(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff { sender: MonsterAdventureActor sender } adventureActorRemoveBuff && sender == _monster)
		{
			if (_hasStrengthenEntry && adventureActorRemoveBuff.eventInfo.buffId == buffId_LiftThunder_StrengthenEntry)
			{
				ChangeThunderState(haveThunderState: true);
			}
			if (_hasStrengthenEntry_2 && adventureActorRemoveBuff.eventInfo.buffId == buffId_LiftThunder_StrengthenEntry_2)
			{
				ChangeThunderState_2(haveThunderState: true);
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		if (!_hasStrengthenEntry_2 || !(elementMarkTriggerEvent.markActor == _actor))
		{
			return;
		}
		if (_markTriggerTimeList_StrengthenEntry_2 == null)
		{
			_markTriggerTimeList_StrengthenEntry_2 = new List<FP>(3);
		}
		_markTriggerTimeList_StrengthenEntry_2.Add(_monster.LogicTime);
		if (_markTriggerTimeList_StrengthenEntry_2.Count >= receiveMarkTriggerTimes_LiftThunder_StrengthenEntry_2)
		{
			if (_markTriggerTimeList_StrengthenEntry_2.Last() - _markTriggerTimeList_StrengthenEntry_2.First() <= unitTime_LiftThunder_StrengthenEntry_2)
			{
				ChangeThunderState_2(haveThunderState: false);
				_markTriggerTimeList_StrengthenEntry_2.Clear();
			}
			else
			{
				_markTriggerTimeList_StrengthenEntry_2.RemoveAt(0);
			}
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnActorReceiveDamage(damageEvent);
		if (damageEvent.to is PlayerAdventureActor)
		{
			if (_monster.CheckScoreBossBehaviour((int)entryEnum_ScoreEntry_1) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, checkHitDamageTag_ScoreEntry_1))
			{
				_succeed_ScoreEntry_1 = false;
			}
		}
		else
		{
			if (!(damageEvent.to == _monster) || !_hasStrengthenEntry || !(damageEvent.from is PlayerAdventureActor { isAssist: not false }) || damageEvent.skillSlotType != HotfixEnum.skillSlotType.B)
			{
				return;
			}
			if (_receiveDamageTimeList_StrengthenEntry == null)
			{
				_receiveDamageTimeList_StrengthenEntry = new List<FP>(20);
			}
			_receiveDamageTimeList_StrengthenEntry.Add(_monster.LogicTime);
			if (_receiveDamageTimeList_StrengthenEntry.Count >= receiveAssitDamageTimes_LiftThunder_StrengthenEntry)
			{
				if (_receiveDamageTimeList_StrengthenEntry.Last() - _receiveDamageTimeList_StrengthenEntry.First() <= unitTime_LiftThunder_StrengthenEntry)
				{
					ChangeThunderState(haveThunderState: false);
					_receiveDamageTimeList_StrengthenEntry.Clear();
				}
				else
				{
					_receiveDamageTimeList_StrengthenEntry.RemoveAt(0);
				}
			}
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent { actor: MonsterAdventureActor actor } adventureActorDiedEvent && (adventureActorDiedEvent.killer is PlayerAdventureActor || adventureActorDiedEvent.killer.IsPlayerMinion(out var _)) && _monster.CheckScoreBossBehaviour((int)entryEnum_ScoreEntry_3) && actor.monsterInfo.CheckTag(checkMonsterTag_ScoreEntry_3))
		{
			_monster.TriggerScoreBossBehaviour((int)entryEnum_ScoreEntry_3);
		}
	}

	protected override void OnActorCastEndSkill(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
		base.OnActorCastEndSkill(castSkillEndEvent);
		if (castSkillEndEvent.sender is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor == _monster && _monster.CheckScoreBossBehaviour((int)entryEnum_ScoreEntry_1) && castSkillEndEvent.skillEventInfo.skillId == checkSkillId_ScoreEntry_1 && _succeed_ScoreEntry_1)
		{
			_monster.TriggerScoreBossBehaviour((int)entryEnum_ScoreEntry_1);
		}
	}

	private void ClearThunder()
	{
		if (_thunderCor_StrengthenEntry != null)
		{
			_monster.StopLogicCoroutine(_thunderCor_StrengthenEntry);
		}
		_thunderCor_StrengthenEntry = null;
		List<CoroutineNode> singleThunderCorList_StrengthenEntry = _singleThunderCorList_StrengthenEntry;
		if (singleThunderCorList_StrengthenEntry != null && singleThunderCorList_StrengthenEntry.Count > 0)
		{
			for (int num = _singleThunderCorList_StrengthenEntry.Count - 1; num >= 0; num--)
			{
				_monster.StopLogicCoroutine(_singleThunderCorList_StrengthenEntry.get_Item(num));
			}
			_singleThunderCorList_StrengthenEntry.Clear();
		}
	}

	private void ClearThunder_2()
	{
		if (_thunderCor_StrengthenEntry_2 != null)
		{
			_monster.StopLogicCoroutine(_thunderCor_StrengthenEntry_2);
		}
		_thunderCor_StrengthenEntry_2 = null;
		List<CoroutineNode> singleThunderCorList_StrengthenEntry_ = _singleThunderCorList_StrengthenEntry_2;
		if (singleThunderCorList_StrengthenEntry_ != null && singleThunderCorList_StrengthenEntry_.Count > 0)
		{
			for (int num = _singleThunderCorList_StrengthenEntry_2.Count - 1; num >= 0; num--)
			{
				_monster.StopLogicCoroutine(_singleThunderCorList_StrengthenEntry_2.get_Item(num));
			}
			_singleThunderCorList_StrengthenEntry_2.Clear();
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		_succeed_ScoreEntry_1 = false;
		_receiveDamageTimeList_StrengthenEntry?.Clear();
		ClearThunder();
		_markTriggerTimeList_StrengthenEntry_2?.Clear();
		ClearThunder_2();
	}
}
