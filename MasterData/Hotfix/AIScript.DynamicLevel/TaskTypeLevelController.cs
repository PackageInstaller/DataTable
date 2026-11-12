#define LOG_DEBUG
#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using Google.Protobuf.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace AIScript.DynamicLevel;

public class TaskTypeLevelController : AdventureLevelController
{
	private class TaskTarget
	{
		private const int DefaultTotalProgess = 1;

		private string _param1;

		private string _param2;

		private string _param3;

		private string _param4;

		private readonly List<string> _param5 = new List<string>(5);

		private Action<TaskTarget> _onFinish;

		private Action<TaskTarget> _onProcessUpdate;

		private FP _progess;

		private FP _totalProgess;

		private CoroutineNode _progessCor;

		public HotfixEnum.LevelQuestTargetType TargetType { get; private set; }

		public int TaskId { get; private set; }

		public int TaskTargetId { get; private set; }

		public bool Success { get; private set; }

		public FP CurrentProcess => _progess;

		public FP TotaltProcess => _totalProgess;

		public void Init(int taskId, int taskTargetId, Action<TaskTarget> onFinish, Action<TaskTarget> onProcessUpdate)
		{
			TaskId = taskId;
			TaskTargetId = taskTargetId;
			Success = false;
			_progess = 0;
			_totalProgess = 0;
			_onFinish = onFinish;
			_onProcessUpdate = onProcessUpdate;
			InitConfig();
		}

		private void InitConfig()
		{
			LevelQuestTarget levelQuestTarget = Singleton<HotfixDataController>.Instance.GetLevelQuestTarget(TaskTargetId);
			if (levelQuestTarget != null)
			{
				TargetType = (HotfixEnum.LevelQuestTargetType)levelQuestTarget.QuestType;
				_param1 = levelQuestTarget.Param1;
				_param2 = levelQuestTarget.Param2;
				_param3 = levelQuestTarget.Param3;
				_param4 = levelQuestTarget.Param4;
				_param5.AddRange(levelQuestTarget.Param5);
				InitTotalProgess();
				NovaLogger.Debug($"初始化任务目标,Id:{TaskTargetId},类型:{TargetType},目标进度:{_totalProgess},所属任务Id:{TaskId}");
			}
		}

		private void InitTotalProgess()
		{
			switch (TargetType)
			{
			case HotfixEnum.LevelQuestTargetType.KillMonster:
			case HotfixEnum.LevelQuestTargetType.CastDodgeSkill:
			case HotfixEnum.LevelQuestTargetType.HoldRushState:
			case HotfixEnum.LevelQuestTargetType.CastAssitSkill:
			case HotfixEnum.LevelQuestTargetType.CastAssitUltraSkill:
			case HotfixEnum.LevelQuestTargetType.BreakMonsterToughness:
			case HotfixEnum.LevelQuestTargetType.CastSkill:
			case HotfixEnum.LevelQuestTargetType.UseCombo:
			case HotfixEnum.LevelQuestTargetType.KillMonsterByDamageTag:
			case HotfixEnum.LevelQuestTargetType.DamagedByDamageTag:
			case HotfixEnum.LevelQuestTargetType.CastSkillEnd:
			case HotfixEnum.LevelQuestTargetType.DamagedByDamageIdGroup:
			case HotfixEnum.LevelQuestTargetType.KillMonsterCount:
			{
				if (CommonUtils.TryParseStringParamToFP(_param1, out var fpValue))
				{
					_totalProgess = fpValue;
				}
				break;
			}
			default:
				_totalProgess = 1;
				break;
			}
			if (_totalProgess <= 0)
			{
				_totalProgess = 1;
			}
		}

		public bool CheckSuccessed()
		{
			if (Success)
			{
				return true;
			}
			if (TargetType == HotfixEnum.LevelQuestTargetType.RecoverEnergy && CommonUtils.TryParseStringParamToInt(_param1, out var intValue))
			{
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					if (actorL.dataID == intValue)
					{
						if ((FP)actorL.playerSkillCd.GetEnergy() >= actorL.playerSkillCd.GetTotalEnergy())
						{
							UpdateProgess(_totalProgess);
						}
						break;
					}
				}
			}
			return Success;
		}

		public void OnPlayerEnergyRecoverMax(PlayerAdventureActor actor)
		{
			if (!Success && TargetType == HotfixEnum.LevelQuestTargetType.RecoverEnergy && CommonUtils.TryParseStringParamToInt(_param1, out var intValue) && actor.dataID == intValue)
			{
				UpdateProgess(1);
			}
		}

		public void OnPlayerCastSkill(PlayerAdventureActor actor, SkillEventInfo skillEventInfo)
		{
			if (Success)
			{
				return;
			}
			switch (TargetType)
			{
			case HotfixEnum.LevelQuestTargetType.CastDodgeSkill:
				if (skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
				{
					UpdateProgess(1);
				}
				break;
			case HotfixEnum.LevelQuestTargetType.HoldRushState:
				if (skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.C)
				{
					if (_progessCor != null)
					{
						SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(_progessCor);
					}
					_progessCor = SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(ProgessLogic());
				}
				break;
			case HotfixEnum.LevelQuestTargetType.CastAssitSkill:
				if (actor.isAssist && skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
				{
					UpdateProgess(1);
				}
				break;
			case HotfixEnum.LevelQuestTargetType.CastAssitUltraSkill:
				if (actor.isAssist && skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
				{
					UpdateProgess(1);
				}
				break;
			case HotfixEnum.LevelQuestTargetType.CastSkill:
			{
				if (CommonUtils.TryParseStringParamToInt(_param2, out var intValue) && skillEventInfo.skillId == intValue)
				{
					UpdateProgess(1);
				}
				break;
			}
			case HotfixEnum.LevelQuestTargetType.BreakMonsterToughness:
			case HotfixEnum.LevelQuestTargetType.ReceiveTriggerOpId:
				break;
			}
		}

		public void OnReduceSkillSection(PlayerAdventureActor actor, int skillId, HotfixEnum.skillSlotType skillSlotType)
		{
			if (Success)
			{
				return;
			}
			switch (TargetType)
			{
			case HotfixEnum.LevelQuestTargetType.CastAssitSkill:
				if (actor.isAssist && skillSlotType == HotfixEnum.skillSlotType.B)
				{
					UpdateProgess(1);
				}
				break;
			case HotfixEnum.LevelQuestTargetType.CastAssitUltraSkill:
				if (actor.isAssist && skillSlotType == HotfixEnum.skillSlotType.D)
				{
					UpdateProgess(1);
				}
				break;
			case HotfixEnum.LevelQuestTargetType.CastSkill:
			{
				if (CommonUtils.TryParseStringParamToInt(_param2, out var intValue) && intValue == skillId)
				{
					UpdateProgess(1);
				}
				break;
			}
			case HotfixEnum.LevelQuestTargetType.BreakMonsterToughness:
			case HotfixEnum.LevelQuestTargetType.ReceiveTriggerOpId:
				break;
			}
		}

		public void OnPlayerPlayCombo(PlayerAdventureActor actor, string comboTag)
		{
			if (!Success && TargetType == HotfixEnum.LevelQuestTargetType.UseCombo && _param5.Count > 0 && _param5.Contains(comboTag))
			{
				UpdateProgess(1);
			}
		}

		public void OnPlayerCastSkillEnd(PlayerAdventureActor actor, SkillEventInfo skillEventInfo)
		{
			if (Success)
			{
				return;
			}
			int intValue;
			if (TargetType == HotfixEnum.LevelQuestTargetType.HoldRushState)
			{
				if (skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.C)
				{
					if (_progessCor != null)
					{
						SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(_progessCor);
					}
					_progessCor = null;
				}
			}
			else if (TargetType == HotfixEnum.LevelQuestTargetType.CastSkillEnd && CommonUtils.TryParseStringParamToInt(_param2, out intValue) && skillEventInfo.skillId == intValue)
			{
				UpdateProgess(1);
			}
		}

		public void OnPlayerCauseDamage(PlayerAdventureActor actor, MonsterAdventureActor monster, int damageId, IList<int> damageTag)
		{
			if (Success)
			{
				return;
			}
			if (TargetType == HotfixEnum.LevelQuestTargetType.DamagedByDamageTag)
			{
				if (damageTag != null && damageTag.Contains(CommonHelper.StringToHash(_param2)))
				{
					UpdateProgess(1);
				}
			}
			else if (TargetType == HotfixEnum.LevelQuestTargetType.DamagedByDamageIdGroup && _param5.Count > 0 && _param5.Contains(damageId.ToString()))
			{
				UpdateProgess(1);
			}
		}

		public void OnBreakMonsterToughness(PlayerAdventureActor actor, MonsterAdventureActor monster)
		{
			if (!Success && TargetType == HotfixEnum.LevelQuestTargetType.BreakMonsterToughness)
			{
				UpdateProgess(1);
			}
		}

		public void OnPlayerKillMonster(PlayerAdventureActor actor, MonsterAdventureActor monster, IList<int> damageTag)
		{
			if (Success)
			{
				return;
			}
			if (TargetType == HotfixEnum.LevelQuestTargetType.KillMonster)
			{
				if (CommonUtils.TryParseStringParamToInt(_param2, out var intValue) && monster.dataID == intValue)
				{
					UpdateProgess(1);
				}
			}
			else if (TargetType == HotfixEnum.LevelQuestTargetType.KillMonsterByDamageTag)
			{
				if (CommonUtils.TryParseStringParamToInt(_param3, out var intValue2) && monster.dataID == intValue2 && damageTag != null && damageTag.Contains(CommonHelper.StringToHash(_param2)))
				{
					UpdateProgess(1);
				}
			}
			else if (TargetType == HotfixEnum.LevelQuestTargetType.KillMonsterCount && actor.IsConfrontWith(monster))
			{
				UpdateProgess(1);
			}
		}

		public void OnMonsterDied(MonsterAdventureActor monster)
		{
			if (!Success && TargetType == HotfixEnum.LevelQuestTargetType.KillAllMonster && ModuleController<AdventureModuleController>.Instance.QueryMonsterActorAliveCount(excludePlayerSummoned: true) <= 0)
			{
				UpdateProgess(1);
			}
		}

		public void OnReceiveInteractiveEvent(string eventId)
		{
			if (!Success && TargetType == HotfixEnum.LevelQuestTargetType.ReceiveTriggerOpId && string.Equals(_param1, eventId))
			{
				UpdateProgess(1);
			}
		}

		private IEnumerator ProgessLogic()
		{
			FP progress = 0;
			while (!Success)
			{
				if (TargetType == HotfixEnum.LevelQuestTargetType.HoldRushState)
				{
					progress += LockStepManager.deltaTime;
					if (progress >= 1)
					{
						UpdateProgess(progress);
						progress = 0;
					}
				}
				yield return null;
			}
		}

		private void UpdateProgess(FP progess)
		{
			if (!Success)
			{
				_progess += progess;
				_progess = TSMath.Clamp(_progess, 0, _totalProgess);
				_onProcessUpdate?.Invoke(this);
				NovaLogger.Debug($"任务Id:{TaskId},任务目标Id:{TaskTargetId},任务目标类型:{TargetType},进度:{_progess}/{_totalProgess}");
				if (_progess >= _totalProgess)
				{
					Finish(success: true);
				}
			}
		}

		private void Finish(bool success)
		{
			NovaLogger.Debug($"任务Id:{TaskId},任务目标Id:{TaskTargetId},结束");
			Success = success;
			_onFinish?.Invoke(this);
		}

		public void Clear()
		{
			_param1 = null;
			_param2 = null;
			_param3 = null;
			_param4 = null;
			_param5.Clear();
			if (_progessCor != null)
			{
				SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(_progessCor);
			}
			_progessCor = null;
			_progess = 0;
			_totalProgess = 0;
			_onFinish = null;
			_onProcessUpdate = null;
			TaskId = 0;
			TaskTargetId = 0;
			Success = false;
		}
	}

	protected new AdventureModuleLevelLoadParams levelLoadParams;

	private readonly Queue<int> _taskQueue = new Queue<int>(3);

	private int _currentTaskId;

	private readonly List<TaskTarget> _currentTaskTargets = new List<TaskTarget>(3);

	private Queue<TaskTarget> _taskPool = new Queue<TaskTarget>(3);

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		levelLoadParams = ModuleController<AdventureModuleController>.Instance?.levelLoadParams;
		SceneSingleton<AdventureIndicatorController>.Instance.SetupDefaultBlobIndicators();
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		base.LevelLoadComplete(sceneName);
		string[] array = sceneName.Split('/');
		sceneName = array[array.Length - 1];
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(sceneName).GetRootGameObjects();
		foreach (GameObject gameObject in rootGameObjects)
		{
			if (gameObject.name == "==== Navigation ====")
			{
				HandleNavigation(gameObject, sceneName);
			}
		}
	}

	public override void LevelStart(Action callback = null)
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ENERGY_CHANGE", OnActorEnergyChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION", OnActorProactiveReduceSkillSection);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_PLAY_COMBO", OnActorPlayCombo);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnActorCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnMonsterToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnReceiveInteractiveEvent);
		base.LevelStart(callback);
		callback?.Invoke();
	}

	private void OnActorEnergyChange(IEvent evt)
	{
		if (!(evt is AdventureActorEnergyChangeEvent adventureActorEnergyChangeEvent))
		{
			return;
		}
		if (adventureActorEnergyChangeEvent.actor is PlayerAdventureActor actor && adventureActorEnergyChangeEvent.currentEnergy == adventureActorEnergyChangeEvent.totalEnergy)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnPlayerEnergyRecoverMax(actor);
			}
		}
		OnActorEnergyChange(adventureActorEnergyChangeEvent);
	}

	private void OnActorCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorCastSkillEvent.sender is PlayerAdventureActor actor)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnPlayerCastSkill(actor, adventureActorCastSkillEvent.skillEventInfo);
			}
		}
		else if (adventureActorCastSkillEvent.sender is AdventureActor entity && entity.IsPlayerMinion(out summoner))
		{
			for (int num2 = _currentTaskTargets.Count - 1; num2 >= 0; num2--)
			{
				_currentTaskTargets.get_Item(num2).OnPlayerCastSkill(summoner, adventureActorCastSkillEvent.skillEventInfo);
			}
		}
		OnActorCastSkill(adventureActorCastSkillEvent);
	}

	private void OnActorPlayCombo(IEvent evt)
	{
		if (!(evt is AdventureActorPlayComboEvent adventureActorPlayComboEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorPlayComboEvent.sender is PlayerAdventureActor actor)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnPlayerPlayCombo(actor, adventureActorPlayComboEvent.comboTag);
			}
		}
		else if (adventureActorPlayComboEvent.sender is AdventureActor entity && entity.IsPlayerMinion(out summoner))
		{
			for (int num2 = _currentTaskTargets.Count - 1; num2 >= 0; num2--)
			{
				_currentTaskTargets.get_Item(num2).OnPlayerPlayCombo(summoner, adventureActorPlayComboEvent.comboTag);
			}
		}
		OnActorPlayCombo(adventureActorPlayComboEvent);
	}

	private void OnActorCastSkillEnd(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorCastSkillEndEvent.sender is PlayerAdventureActor actor)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnPlayerCastSkillEnd(actor, adventureActorCastSkillEndEvent.skillEventInfo);
			}
		}
		else if (adventureActorCastSkillEndEvent.sender is AdventureActor entity && entity.IsPlayerMinion(out summoner))
		{
			for (int num2 = _currentTaskTargets.Count - 1; num2 >= 0; num2--)
			{
				_currentTaskTargets.get_Item(num2).OnPlayerCastSkillEnd(summoner, adventureActorCastSkillEndEvent.skillEventInfo);
			}
		}
		OnActorCastEndSkill(adventureActorCastSkillEndEvent);
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to } adventureActorReceiveDamageEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor actor)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnPlayerCauseDamage(actor, to, adventureActorReceiveDamageEvent.hitDamageId, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
		else if (adventureActorReceiveDamageEvent.from.IsPlayerMinion(out summoner))
		{
			for (int num2 = _currentTaskTargets.Count - 1; num2 >= 0; num2--)
			{
				_currentTaskTargets.get_Item(num2).OnPlayerCauseDamage(summoner, to, adventureActorReceiveDamageEvent.hitDamageId, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
		OnActorReceiveDamage(adventureActorReceiveDamageEvent);
	}

	private void OnMonsterToughnessStateChange(IEvent evt)
	{
		if (!(evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent))
		{
			return;
		}
		if (monsterToughnessStateChangeEvent.isToughnessBroken && monsterToughnessStateChangeEvent.source is PlayerAdventureActor actor)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnBreakMonsterToughness(actor, monsterToughnessStateChangeEvent.actor as MonsterAdventureActor);
			}
		}
		OnMonsterToughnessStateChange(monsterToughnessStateChangeEvent);
	}

	private void OnActorDied(IEvent evt)
	{
		if (!(evt is AdventureActorDiedEvent adventureActorDiedEvent))
		{
			return;
		}
		if (adventureActorDiedEvent.actor is MonsterAdventureActor monster)
		{
			PlayerAdventureActor summoner;
			if (adventureActorDiedEvent.killer is PlayerAdventureActor actor)
			{
				for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
				{
					_currentTaskTargets.get_Item(num).OnPlayerKillMonster(actor, monster, adventureActorDiedEvent.damageTag);
				}
			}
			else if (adventureActorDiedEvent.killer.IsPlayerMinion(out summoner))
			{
				for (int num2 = _currentTaskTargets.Count - 1; num2 >= 0; num2--)
				{
					_currentTaskTargets.get_Item(num2).OnPlayerKillMonster(summoner, monster, adventureActorDiedEvent.damageTag);
				}
			}
			for (int num3 = _currentTaskTargets.Count - 1; num3 >= 0; num3--)
			{
				_currentTaskTargets.get_Item(num3).OnMonsterDied(monster);
			}
		}
		OnActorDied(adventureActorDiedEvent);
	}

	private void OnReceiveInteractiveEvent(IEvent evt)
	{
		if (evt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger)
		{
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnReceiveInteractiveEvent(adventureInteractiveIDTrigger.interactiveID);
			}
			OnReceiveInteractiveEvent(adventureInteractiveIDTrigger);
		}
	}

	private void OnActorProactiveReduceSkillSection(IEvent evt)
	{
		if (evt is AdventureActorProactiveReduceSkillSectionEvent { sender: PlayerAdventureActor sender, skillEventInfo: not null } adventureActorProactiveReduceSkillSectionEvent)
		{
			int skillId = adventureActorProactiveReduceSkillSectionEvent.skillEventInfo.skillId;
			HotfixEnum.skillSlotType skillSlotType = adventureActorProactiveReduceSkillSectionEvent.skillEventInfo.skillSlotType;
			for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
			{
				_currentTaskTargets.get_Item(num).OnReduceSkillSection(sender, skillId, skillSlotType);
			}
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_ENERGY_CHANGE", OnActorEnergyChange);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION", OnActorProactiveReduceSkillSection);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_PLAY_COMBO", OnActorPlayCombo);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnActorCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnMonsterToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("INTERACTIVEID", OnReceiveInteractiveEvent);
		_taskQueue.Clear();
		_currentTaskTargets.Clear();
		_currentTaskId = 0;
	}

	protected virtual void OnActorEnergyChange(AdventureActorEnergyChangeEvent energyChangeEvent)
	{
	}

	protected virtual void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnActorPlayCombo(AdventureActorPlayComboEvent playComboEvent)
	{
	}

	protected virtual void OnActorCastEndSkill(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
	}

	protected virtual void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnMonsterToughnessStateChange(MonsterToughnessStateChangeEvent toughnessStateChangeEvent)
	{
	}

	protected virtual void OnActorDied(AdventureActorDiedEvent diedEvent)
	{
	}

	protected virtual void OnReceiveInteractiveEvent(AdventureInteractiveIDTrigger interactiveIDTriggerEvent)
	{
	}

	protected void InitTask(IList<int> taskIds, bool triggerFirstTask = false)
	{
		if (taskIds == null || taskIds.Count <= 0)
		{
			NovaLogger.Error("未配置任务");
			return;
		}
		_taskQueue.Clear();
		for (int i = 0; i < taskIds.Count; i++)
		{
			_taskQueue.Enqueue(taskIds.get_Item(i));
		}
		if (triggerFirstTask)
		{
			TriggerNextTask();
		}
	}

	protected void TriggerNextTask()
	{
		if (_taskQueue.Count > 0)
		{
			_currentTaskId = _taskQueue.Dequeue();
			InitTaskTarget();
			OnTriggerNextTask(_currentTaskId);
		}
	}

	private void InitTaskTarget()
	{
		if (_currentTaskId <= 0)
		{
			return;
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("TaskLevel_InitTask", _currentTaskId);
		LevelQuest levelQuest = Singleton<HotfixDataController>.Instance.GetLevelQuest(_currentTaskId);
		if (levelQuest == null)
		{
			return;
		}
		if (_currentTaskTargets.Count > 0)
		{
			for (int i = 0; i < _currentTaskTargets.Count; i++)
			{
				RecycleTaskTarget(_currentTaskTargets.get_Item(i));
			}
			_currentTaskTargets.Clear();
		}
		RepeatedField<int> levelQuestTargetIds = levelQuest.LevelQuestTargetIds;
		if (levelQuestTargetIds.Count > 0)
		{
			for (int j = 0; j < levelQuestTargetIds.Count; j++)
			{
				_currentTaskTargets.Add(GenerateTaskTarget(_currentTaskId, levelQuestTargetIds.get_Item(j), OnTaskTargetFinish, OnTaskTargetProcessUpdate));
			}
		}
		for (int num = _currentTaskTargets.Count - 1; num >= 0; num--)
		{
			_currentTaskTargets.get_Item(num).CheckSuccessed();
		}
	}

	protected void RestartCurrentTask()
	{
		if (_currentTaskId > 0)
		{
			InitTaskTarget();
		}
	}

	private void OnTaskTargetProcessUpdate(TaskTarget taskTarget)
	{
		if (_currentTaskId == taskTarget.TaskId)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TaskLevel_UpdateTaskTargetProcess", taskTarget.TaskId, taskTarget.TaskTargetId, taskTarget.CurrentProcess, taskTarget.TotaltProcess);
		}
	}

	private void OnTaskTargetFinish(TaskTarget taskTarget)
	{
		if (_currentTaskId != taskTarget.TaskId)
		{
			return;
		}
		if (taskTarget.Success)
		{
			RecycleTaskTarget(taskTarget);
			_currentTaskTargets.Remove(taskTarget);
			bool flag = _currentTaskTargets.Count <= 0;
			OnTaskTargetSuccess(_currentTaskId, taskTarget.TaskTargetId, flag);
			if (flag)
			{
				bool flag2 = _taskQueue.Count <= 0;
				OnTaskFinish(_currentTaskId, flag2);
				MonoSingleton<LuaManager>.Instance.FireEvent("TaskLevel_TaskFinish", flag2);
			}
		}
		else
		{
			OnTaskTargetFailed(_currentTaskId, taskTarget.TaskTargetId);
		}
	}

	protected virtual void OnTriggerNextTask(int taskId)
	{
	}

	protected virtual void OnTaskTargetSuccess(int taskId, int taskTargetId, bool isLasTaskTarget = false)
	{
	}

	protected virtual void OnTaskTargetFailed(int taskId, int taskTargetId)
	{
	}

	protected virtual void OnTaskFinish(int taskId, bool isLastTask = false)
	{
	}

	private TaskTarget GenerateTaskTarget(int questId, int questTargetId, Action<TaskTarget> onFinish = null, Action<TaskTarget> onProcessUpdate = null)
	{
		TaskTarget taskTarget = ((_taskPool.Count <= 0) ? new TaskTarget() : _taskPool.Dequeue());
		taskTarget.Init(questId, questTargetId, onFinish, onProcessUpdate);
		return taskTarget;
	}

	private void RecycleTaskTarget(TaskTarget taskTarget)
	{
		if (taskTarget != null)
		{
			taskTarget.Clear();
			_taskPool.Enqueue(taskTarget);
		}
	}
}
