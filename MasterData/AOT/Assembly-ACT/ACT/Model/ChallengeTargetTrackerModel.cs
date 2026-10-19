using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class ChallengeTargetTrackerModel : Model<ChallengeTargetTrackerModel>
{
	[Flags]
	public enum RequiredEvent
	{
		None = 0,
		Collect = 1,
		CharacterHp = 2,
		CharacterDie = 4,
		AssistSkill = 8,
		CharacterState = 0x10,
		MonsterPosture = 0x20,
		MonsterDie = 0x40,
		PerfectDodge = 0x80,
		Ultra = 0x100,
		Trap = 0x200,
		CharacterAddAbility = 0x400,
		CharacterSpecialEnergy = 0x800,
		KillEntity = 0x1000,
		CharacterNormalEnergy = 0x2000,
		MotionState = 0x4000,
		Runtime = 0x8000,
		Destructible = 0x10000,
		MotionAttackPattern = 0x20000,
		PojiaToFushi = 0x40000,
		MonsterAbilityAdd = 0x80000,
		Damage = 0x100000,
		TriggerBlock = 0x200000
	}

	public sealed class RuntimeTarget
	{
		public readonly int TargetId;

		public readonly Rules Rule;

		public readonly RequiredEvent RequiredEvents;

		public bool Completed;

		public bool Failed;

		public int Progress;

		public RuntimeTarget(int targetId, Rules rule, RequiredEvent requiredEvents)
		{
			TargetId = targetId;
			Rule = rule;
			RequiredEvents = requiredEvents;
		}
	}

	private struct CharacterHp
	{
		public long Current;

		public long Max;
	}

	private const string AssaultCustomTag = "gongjian";

	private const string StrongAssaultCustomTag = "qiangxi";

	private const string NoiseCustomTag = "zaobo";

	private const int HelaCharacterId = 11601;

	private const int LianCharacterId = 12701;

	private static readonly string[] NoiseAbilityNames = new string[5] { "role_common_freeze", "role_common_pojia", "role_common_fushi", "role_common_cold", "role_common_deepcold" };

	private readonly List<RuntimeTarget> _targets = new List<RuntimeTarget>();

	private readonly List<int> _completedTargetIds = new List<int>();

	private readonly Dictionary<int, CharacterHp> _characterHp = new Dictionary<int, CharacterHp>();

	private readonly Dictionary<int, int> _characterDieCounts = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _potionUseCounts = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _ultraSkillUseCounts = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _dodgeCounts = new Dictionary<int, int>();

	private readonly HashSet<int> _teamCharacterIds = new HashSet<int>();

	private readonly Dictionary<int, int> _teamCharacterKillCounts = new Dictionary<int, int>();

	private readonly Dictionary<int, Dictionary<int, int>> _triggeredStateNameCounts = new Dictionary<int, Dictionary<int, int>>();

	private readonly Dictionary<int, int> _breakMonsterShieldCounts = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _killMonsterOnShieldBrokenCounts = new Dictionary<int, int>();

	private readonly HashSet<int> _ultraSkillCharacterIds = new HashSet<int>();

	private readonly HashSet<int> _teamTeachingLightPointIds = new HashSet<int>();

	private readonly HashSet<int> _collectedTeamTeachingLightPointIds = new HashSet<int>();

	private readonly HashSet<int> _destructibleTargetSwids = new HashSet<int>();

	private readonly HashSet<int> _pendingDestructibleSwids = new HashSet<int>();

	private readonly Dictionary<int, float> _characterAccumulatedResonanceValues = new Dictionary<int, float>();

	private readonly Dictionary<string, List<int>> _characterStateNameIds = new Dictionary<string, List<int>>();

	private readonly Dictionary<string, List<int>> _characterAbilityNameIds = new Dictionary<string, List<int>>();

	private readonly Dictionary<int, List<string>> _characterAbilityCustomTags = new Dictionary<int, List<string>>();

	private readonly HashSet<int> _unsupportedStateNameIds = new HashSet<int>();

	private RequiredEvent _requiredEvents;

	private bool _hasPostureDamageTarget;

	private int _collectCount;

	private int _collectType;

	private int _totalCollectibles;

	private int _teamTeachingLightPointCount;

	private int _totalTeamTeachingLightPoints;

	private bool _hasDestructibleSnapshot;

	private int _assistSkillCount;

	private int _assaultStateStaggerCount;

	private int _perfectDodgeCount;

	private int _triggeredTrapCount;

	private int _damageTakenCount;

	private bool _usedJump;

	private float _consumedAdaptabilityValue;

	private float _consumedResonanceValue;

	private float _characterAirTime;

	private float _challengeRuntime;

	private bool _hasTrackingStartTime;

	private readonly Dictionary<int, int> _characterAssistSkillCounts = new Dictionary<int, int>();

	private readonly Dictionary<int, HashSet<int>> _applyStateMonsterEntityIds = new Dictionary<int, HashSet<int>>();

	private readonly Dictionary<int, HashSet<int>> _skillHitMonsterEntityIds = new Dictionary<int, HashSet<int>>();

	public bool IsPrepared { get; private set; }

	public bool IsTracking { get; private set; }

	public bool IsChallengeCompleted { get; private set; }

	public bool NeedCharacterAddAbilityEvent
	{
		get
		{
			if (IsTracking)
			{
				return (_requiredEvents & RequiredEvent.CharacterAddAbility) != 0;
			}
			return false;
		}
	}

	public bool NeedCharacterStateEvent
	{
		get
		{
			if (IsTracking)
			{
				return (_requiredEvents & RequiredEvent.CharacterState) != 0;
			}
			return false;
		}
	}

	public bool NeedCharacterSpecialEnergyEvent
	{
		get
		{
			if (IsTracking)
			{
				return (_requiredEvents & RequiredEvent.CharacterSpecialEnergy) != 0;
			}
			return false;
		}
	}

	public bool NeedCharacterNormalEnergyEvent
	{
		get
		{
			if (IsTracking)
			{
				return (_requiredEvents & RequiredEvent.CharacterNormalEnergy) != 0;
			}
			return false;
		}
	}

	public bool NeedPostureDamageEvent
	{
		get
		{
			if (IsTracking)
			{
				return _hasPostureDamageTarget;
			}
			return false;
		}
	}

	public bool NeedDestructibleEvent
	{
		get
		{
			if (IsTracking)
			{
				return (_requiredEvents & RequiredEvent.Destructible) != 0;
			}
			return false;
		}
	}

	public IReadOnlyList<int> CompletedTargetIds => _completedTargetIds;

	public event Action<int, bool> TargetCompletedChanged;

	public event Action<int, bool> TargetFailedChanged;

	public event Action<int, int> TargetChanged;

	public void Prepare(IReadOnlyList<ChallengeTargetDefinition> definitions)
	{
		StopTracking();
		_targets.Clear();
		_completedTargetIds.Clear();
		_requiredEvents = RequiredEvent.None;
		_hasPostureDamageTarget = false;
		ClearStateNameMappings();
		if (definitions == null)
		{
			IsPrepared = false;
			return;
		}
		for (int i = 0; i < definitions.Count; i++)
		{
			ChallengeTargetDefinition challengeTargetDefinition = definitions[i];
			if (challengeTargetDefinition.TargetId > 0 && challengeTargetDefinition.Rule != null)
			{
				RuntimeTarget runtimeTarget = new RuntimeTarget(challengeTargetDefinition.TargetId, challengeTargetDefinition.Rule, GetRequiredEvents(challengeTargetDefinition.Rule));
				_targets.Add(runtimeTarget);
				_requiredEvents |= runtimeTarget.RequiredEvents;
				_hasPostureDamageTarget |= challengeTargetDefinition.Rule.rulesId == 47 || challengeTargetDefinition.Rule.rulesId == 42;
			}
		}
		IsPrepared = _targets.Count > 0;
		ResetRuntimeState();
	}

	public void BeginTracking()
	{
		StopTracking();
		ResetRuntimeState();
		IsTracking = true;
		_challengeRuntime = 0f;
		_hasTrackingStartTime = true;
		AddEventListeners();
		InitializeSceneObjectTargets();
	}

	public void MarkChallengeCompleted()
	{
		if (IsTracking)
		{
			CaptureInProgressUltraCharacters();
			IsChallengeCompleted = true;
			EvaluateTargets(RequiredEvent.None, isFinalEvaluation: true);
			RemoveEventListeners();
			IsTracking = false;
		}
	}

	public void StopTracking()
	{
		if (IsTracking)
		{
			RemoveEventListeners();
		}
		IsTracking = false;
	}

	public void Clear()
	{
		StopTracking();
		IsPrepared = false;
		IsChallengeCompleted = false;
		_targets.Clear();
		_completedTargetIds.Clear();
		_requiredEvents = RequiredEvent.None;
		_hasPostureDamageTarget = false;
		ClearStateNameMappings();
		ResetMetrics();
	}

	public bool IsTargetCompleted(int targetId)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets[i].TargetId == targetId)
			{
				return _targets[i].Completed;
			}
		}
		return false;
	}

	public bool IsTargetFailed(int targetId)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets[i].TargetId == targetId)
			{
				return _targets[i].Failed;
			}
		}
		return false;
	}

	public bool TryRecordTargetProgress(int targetId, out int current, out int total)
	{
		current = 0;
		total = 0;
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets[i].TargetId == targetId)
			{
				return TryRecordTargetProgress(_targets[i], out current, out total);
			}
		}
		return false;
	}

	public void RestoreCompletedTargets(IReadOnlyList<int> completedTargetIds)
	{
		if (!IsPrepared || completedTargetIds == null)
		{
			return;
		}
		for (int i = 0; i < completedTargetIds.Count; i++)
		{
			int num = completedTargetIds[i];
			for (int j = 0; j < _targets.Count; j++)
			{
				RuntimeTarget runtimeTarget = _targets[j];
				if (runtimeTarget.TargetId == num && !runtimeTarget.Completed)
				{
					CompleteTarget(runtimeTarget);
					break;
				}
			}
		}
	}

	public void OnTriggerTrap()
	{
		if (IsTracking)
		{
			_triggeredTrapCount++;
			if ((_requiredEvents & RequiredEvent.Trap) != 0)
			{
				EvaluateTargets(RequiredEvent.Trap, isFinalEvaluation: false);
			}
		}
	}

	public void OnBloodBottleUse(Entity entity)
	{
		if (IsTracking && entity.IsValid && entity.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			AddCount(_potionUseCounts, component.characterSource.Id());
		}
	}

	public StageSettleInfo CreateStageSettleInfo()
	{
		float duration = GetWorldRuntime();
		if (Model<TeamTeachingModel>.HasInstance() && Model<TeamTeachingModel>.Interface.TryGetChallengeDurationForSettlement(out var duration2))
		{
			duration = duration2;
		}
		StageSettleInfo stageSettleInfo = new StageSettleInfo
		{
			Duration = duration,
			DieCount = GetCharacterDieCount(),
			TrapCount = (Model<RaidModel>.Interface.IsParkourRaid ? GetCharacterDieCount() : 0),
			PointCount = _collectCount,
			AssistSkillCount = _assistSkillCount,
			TriggeredTrapCount = _triggeredTrapCount
		};
		if (IsChallengeCompleted)
		{
			stageSettleInfo.CompletedChallengeTarget.AddRange(_completedTargetIds);
		}
		MonoECS.instance.chTimeStatisticsManager.Calculate();
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			StageSettleCharacterInfo stageSettleCharacterInfo = new StageSettleCharacterInfo
			{
				CharacterID = 0,
				CharacterLv = 0,
				HpPercent = 0f
			};
			if (teamCharacter.IsValid && teamCharacter.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
			{
				int num = (stageSettleCharacterInfo.CharacterID = component.characterSource.Id());
				stageSettleCharacterInfo.CharacterLv = component.characterSource.Level();
				stageSettleCharacterInfo.Damage = MonoECS.instance.damageStatisticsManager.GetDamageStatistics(num);
				stageSettleCharacterInfo.Duration = MonoECS.instance.chTimeStatisticsManager.GetTimeStatistics(num);
				stageSettleCharacterInfo.HpPercent = teamCharacter.GetCompAbility().HpPercent;
				stageSettleCharacterInfo.PotionUseCount = _potionUseCounts.GetValueOrDefault(num);
				stageSettleCharacterInfo.ExSkillUseCount = _ultraSkillUseCounts.GetValueOrDefault(num);
				stageSettleCharacterInfo.DodgeCount = _dodgeCounts.GetValueOrDefault(num);
				if (_triggeredStateNameCounts.TryGetValue(num, out var value))
				{
					stageSettleCharacterInfo.TriggeredNodeCount.AddRange(value);
				}
				if (num == MonoECS.instance.MainEntityCharacterId)
				{
					stageSettleCharacterInfo.BreakDiffTypeMonsterShieldCount.AddRange(_breakMonsterShieldCounts);
					stageSettleCharacterInfo.KillDiffTypeMonsterOnShieldBrokenCount.AddRange(_killMonsterOnShieldBrokenCounts);
				}
			}
			stageSettleInfo.CharacterInfo.Add(stageSettleCharacterInfo);
		}
		return stageSettleInfo;
	}

	public void RecordDestructibleDestroyed(int swid)
	{
		if (IsTracking && (_requiredEvents & RequiredEvent.Destructible) != RequiredEvent.None)
		{
			TryRegisterDestructibleTarget(GetWorldStateAssetData(swid));
			if (!_hasDestructibleSnapshot)
			{
				InitializeDestructibleTargets();
			}
			if (_pendingDestructibleSwids.Remove(swid))
			{
				EvaluateTargets(RequiredEvent.Destructible, isFinalEvaluation: false);
			}
		}
	}

	public void EvaluateRuntimeTargets()
	{
		if (IsTracking)
		{
			_challengeRuntime += GameManager.timeSystem.GetWorldRuntimeDeltaTime();
		}
		if (IsTracking && (_requiredEvents & RequiredEvent.Destructible) != 0 && !_hasDestructibleSnapshot)
		{
			InitializeDestructibleTargets();
		}
		if (IsTracking && (_requiredEvents & RequiredEvent.Runtime) != 0)
		{
			UpdateCharacterAirTime();
			EvaluateTargets(RequiredEvent.Runtime, isFinalEvaluation: false);
		}
	}

	private void UpdateCharacterAirTime()
	{
		bool flag = false;
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 31)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			return;
		}
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (!entity.IsValid || !entity.TryGetCompCharacter(out CompCharacter component) || component.characterSource == null || !entity.TryGetCompPhysics(out CompPhysics component2) || component2.isGrounded)
		{
			_characterAirTime = 0f;
			return;
		}
		int characterId = component.characterSource.Id();
		if (!IsCharacterMatchedByAirTimeTarget(characterId))
		{
			_characterAirTime = 0f;
		}
		else
		{
			_characterAirTime += GameManager.timeSystem.GetWorldRuntimeDeltaTime();
		}
	}

	private bool IsCharacterMatchedByAirTimeTarget(int characterId)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 31)
			{
				int[] param = runtimeTarget.Rule.param;
				int num = ((param != null && param.Length > 0) ? runtimeTarget.Rule.param[0] : 0);
				if (num <= 0 || num == characterId)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void AddEventListeners()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidCollectInfoChange, OnBattleEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Character_HpChange, OnBattleEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterDie, OnBattleEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnBattleEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnPerfectDodge, OnBattleEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnUltra, OnBattleEvent);
		if ((_requiredEvents & RequiredEvent.Collect) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TeamTeachingLightPointCollected, OnBattleEvent);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TempleInteractRefresh, TempleInteractRefresh);
		}
		if ((_requiredEvents & (RequiredEvent.Collect | RequiredEvent.Destructible)) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.asset_Inited, OnAssetInited);
		}
		if ((_requiredEvents & RequiredEvent.CharacterState) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterStateChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.CharacterAddAbility) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_AddAbility, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.CharacterSpecialEnergy) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterSpeicalEnergyChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.CharacterNormalEnergy) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterNormalEnergyChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MotionState) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_MotionStateChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MonsterPosture) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityPostureChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MonsterDie) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.KillEntity) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.KillEntity, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MotionAttackPattern) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MotionAttackPatternResolved, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.PojiaToFushi) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.PojiaToFushi, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MonsterAbilityAdd) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Ability_Add, OnBattleEvent);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Ability_StackChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.Damage) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.TriggerBlock) != 0)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TriggerBlock, OnTriggerBlock);
		}
	}

	private void RemoveEventListeners()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidCollectInfoChange, OnBattleEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Character_HpChange, OnBattleEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterDie, OnBattleEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnBattleEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnPerfectDodge, OnBattleEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnUltra, OnBattleEvent);
		if ((_requiredEvents & RequiredEvent.Collect) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TeamTeachingLightPointCollected, OnBattleEvent);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TempleInteractRefresh, TempleInteractRefresh);
		}
		if ((_requiredEvents & (RequiredEvent.Collect | RequiredEvent.Destructible)) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.asset_Inited, OnAssetInited);
		}
		if ((_requiredEvents & RequiredEvent.CharacterState) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterStateChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.CharacterAddAbility) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_AddAbility, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.CharacterSpecialEnergy) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterSpeicalEnergyChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.CharacterNormalEnergy) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterNormalEnergyChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MotionState) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Motion_MotionStateChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MonsterPosture) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityPostureChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MonsterDie) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.KillEntity) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.KillEntity, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MotionAttackPattern) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MotionAttackPatternResolved, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.PojiaToFushi) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PojiaToFushi, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.MonsterAbilityAdd) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Ability_Add, OnBattleEvent);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Ability_StackChange, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.Damage) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnDamage, OnBattleEvent);
		}
		if ((_requiredEvents & RequiredEvent.TriggerBlock) != 0)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TriggerBlock, OnTriggerBlock);
		}
	}

	private void OnBattleEvent(BaseEventContent eventContent)
	{
		if (!IsTracking)
		{
			return;
		}
		if (!(eventContent is RaidCollectInfoChangeEvt collectEvent))
		{
			if (!(eventContent is TeamTeachingLightPointCollectedEvt lightPointEvent))
			{
				if (!(eventContent is CharacterHpChangeEvt characterHpChangeEvt))
				{
					if (!(eventContent is BattleCharacterDieEvt battleCharacterDieEvt))
					{
						if (!(eventContent is BattleCharacterChangeEvt battleCharacterChangeEvt))
						{
							if (!(eventContent is CharacterStateChangeEvt stateEvent))
							{
								if (!(eventContent is CharacterTutorialAddAbilityEvt addAbilityEvent))
								{
									if (!(eventContent is CharacterSpecialEnergyGainEvt specialEnergyEvent))
									{
										if (!(eventContent is CharacterSpecialEnergyConsumeEvt specialEnergyEvent2))
										{
											if (!(eventContent is CharacterNormalEnergyConsumeEvt normalEnergyEvent))
											{
												if (!(eventContent is MotionStateChangeEvt motionStateEvent))
												{
													if (!(eventContent is EntityPostureChangeEvt postureEvent))
													{
														if (!(eventContent is EntityDieEvt dieEvent))
														{
															if (!(eventContent is OnKillEntity killEvent))
															{
																if (!(eventContent is MotionAttackPatternResolvedEvt evt))
																{
																	if (!(eventContent is PerfectDodgeEvent perfectDodgeEvent))
																	{
																		CompCharacter component;
																		if (!(eventContent is UltraEvent ultraEvent))
																		{
																			if (!(eventContent is PojiaToFushiEvt))
																			{
																				if (!(eventContent is AbilityAddEvt abilityAddEvt))
																				{
																					if (!(eventContent is AbilityStackChangeEvt abilityStackChangeEvt))
																					{
																						if (eventContent is DamageEvt damageEvent)
																						{
																							OnCharacterDamageTaken(damageEvent);
																							OnSkillHitMonster(damageEvent);
																						}
																					}
																					else
																					{
																						OnMonsterAbilityProgress(abilityStackChangeEvt.eb);
																					}
																				}
																				else
																				{
																					OnMonsterAbilityProgress(abilityAddEvt.eb);
																				}
																			}
																			else
																			{
																				OnPojiaToFushi();
																			}
																		}
																		else if (ultraEvent.entity.TryGetCompCharacter(out component) && component.characterSource != null)
																		{
																			int num = component.characterSource.Id();
																			_ultraSkillCharacterIds.Add(num);
																			AddCount(_ultraSkillUseCounts, num);
																			if ((_requiredEvents & RequiredEvent.Ultra) != 0)
																			{
																				EvaluateTargets(RequiredEvent.Ultra, isFinalEvaluation: false);
																			}
																		}
																	}
																	else if (!perfectDodgeEvent.isWitch)
																	{
																		_perfectDodgeCount++;
																		Entity mainEntity = MonoECS.instance.mainEntity;
																		if (mainEntity.IsValid && mainEntity.TryGetCompCharacter(out CompCharacter component2) && component2.characterSource != null)
																		{
																			AddCount(_dodgeCounts, component2.characterSource.Id());
																		}
																		if ((_requiredEvents & RequiredEvent.PerfectDodge) != 0)
																		{
																			EvaluateTargets(RequiredEvent.PerfectDodge, isFinalEvaluation: false);
																		}
																	}
																}
																else
																{
																	OnMotionAttackPatternResolved(evt);
																}
															}
															else
															{
																OnKillEntity(killEvent);
															}
														}
														else
														{
															OnMonsterDied(dieEvent);
														}
													}
													else
													{
														OnMonsterPostureChanged(postureEvent);
													}
												}
												else
												{
													OnMotionStateChanged(motionStateEvent);
												}
											}
											else
											{
												OnCharacterNormalEnergyConsumed(normalEnergyEvent);
											}
										}
										else
										{
											OnCharacterSpecialEnergyConsumed(specialEnergyEvent2);
										}
									}
									else
									{
										OnCharacterSpecialEnergyGained(specialEnergyEvent);
									}
								}
								else
								{
									OnCharacterAbilityAdded(addAbilityEvent);
								}
							}
							else
							{
								OnCharacterStateChanged(stateEvent);
							}
						}
						else if (battleCharacterChangeEvt.switchSkill)
						{
							_assistSkillCount++;
							RecordEchoStateUseAssistSkill(battleCharacterChangeEvt.newEb);
							RecordDifferentCharacterAssistSkill(battleCharacterChangeEvt.newEb);
							if ((_requiredEvents & RequiredEvent.AssistSkill) != 0)
							{
								EvaluateTargets(RequiredEvent.AssistSkill, isFinalEvaluation: false);
							}
						}
					}
					else
					{
						AddCount(_characterDieCounts, battleCharacterDieEvt.characterId);
						if ((_requiredEvents & RequiredEvent.CharacterDie) != 0)
						{
							EvaluateTargets(RequiredEvent.CharacterDie, isFinalEvaluation: false);
						}
					}
				}
				else
				{
					_characterHp[characterHpChangeEvt.characterId] = new CharacterHp
					{
						Current = characterHpChangeEvt.curHp,
						Max = characterHpChangeEvt.maxHp
					};
					if ((_requiredEvents & RequiredEvent.CharacterHp) != 0)
					{
						EvaluateTargets(RequiredEvent.CharacterHp, isFinalEvaluation: false);
					}
				}
			}
			else
			{
				OnTeamTeachingLightPointCollected(lightPointEvent);
			}
		}
		else
		{
			OnCollectChanged(collectEvent);
		}
	}

	private void CaptureInProgressUltraCharacters()
	{
		if ((_requiredEvents & RequiredEvent.Ultra) == 0)
		{
			return;
		}
		MPPlayer mPPlayer = MonoECS.instance?.localPlayer;
		if (mPPlayer == null)
		{
			return;
		}
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			Entity teamCharacter = mPPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.TryGetCompEffect(out CompEffect component) && component.bInUltraTimeline && teamCharacter.TryGetCompCharacter(out CompCharacter component2) && component2.characterSource != null)
			{
				_ultraSkillCharacterIds.Add(component2.characterSource.Id());
			}
		}
	}

	private void OnCharacterDamageTaken(DamageEvt damageEvent)
	{
		AttackData attackData = damageEvent?.AttackData;
		if (attackData != null && attackData.actualDamage > 0 && attackData.attackee.IsValid && attackData.attackee.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null && _teamCharacterIds.Contains(component.characterSource.Id()))
		{
			_damageTakenCount++;
			EvaluateTargets(RequiredEvent.Damage, isFinalEvaluation: false);
		}
	}

	private void OnCollectChanged(RaidCollectInfoChangeEvt collectEvent)
	{
		if (!RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 4)
			{
				runtimeTarget.Progress = collectEvent.collectCount;
			}
		}
		_collectType = ((value.belongEntranceData == 101) ? 2 : ((value.belongEntranceData == 201) ? 1 : 0));
		_collectCount = collectEvent.collectCount;
		EvaluateTargets(RequiredEvent.Collect, isFinalEvaluation: false);
	}

	private void TempleInteractRefresh(BaseEventContent baseEventContent)
	{
		int templeActiveRobotCount = Model<TempleModel>.Interface.GetTempleActiveRobotCount(Model<TempleModel>.Interface.CurChallengeTempleId);
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 4)
			{
				runtimeTarget.Progress = templeActiveRobotCount;
			}
		}
		_collectType = 3;
		_collectCount = templeActiveRobotCount;
		EvaluateTargets(RequiredEvent.Collect, isFinalEvaluation: false);
	}

	private void OnTeamTeachingLightPointCollected(TeamTeachingLightPointCollectedEvt lightPointEvent)
	{
		int stateWorldAssetUid = lightPointEvent.stateWorldAssetUid;
		if (stateWorldAssetUid > 0)
		{
			if (!_teamTeachingLightPointIds.Contains(stateWorldAssetUid))
			{
				TryRegisterTeamTeachingLightPoint(GetWorldStateAssetData(stateWorldAssetUid));
			}
			if (_teamTeachingLightPointIds.Contains(stateWorldAssetUid) && _collectedTeamTeachingLightPointIds.Add(stateWorldAssetUid))
			{
				_teamTeachingLightPointCount++;
				EvaluateTargets(RequiredEvent.Collect, isFinalEvaluation: false);
			}
		}
	}

	private void OnPojiaToFushi()
	{
		bool flag = false;
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 25)
			{
				runtimeTarget.Progress++;
				flag = true;
			}
		}
		if (flag)
		{
			EvaluateTargets(RequiredEvent.PojiaToFushi, isFinalEvaluation: false);
		}
	}

	private void OnMonsterAbilityProgress(Entity monster)
	{
		if (!monster.IsValid || !monster.TryGetCompMonster(out CompMonster _))
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 24 && IsMonsterStateConditionMatched(monster, runtimeTarget.Rule))
			{
				if (!_applyStateMonsterEntityIds.TryGetValue(runtimeTarget.TargetId, out var value))
				{
					value = new HashSet<int>();
					_applyStateMonsterEntityIds.Add(runtimeTarget.TargetId, value);
				}
				if (value.Add(monster.Id.Index))
				{
					runtimeTarget.Progress++;
					flag = true;
				}
			}
		}
		if (flag)
		{
			EvaluateTargets(RequiredEvent.MonsterAbilityAdd, isFinalEvaluation: false);
		}
	}

	private void RecordDifferentCharacterAssistSkill(Entity character)
	{
		if (character.IsValid && character.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			AddCount(_characterAssistSkillCounts, component.characterSource.Id());
		}
	}

	private void OnSkillHitMonster(DamageEvt damageEvent)
	{
		AttackData attackData = damageEvent?.AttackData;
		if (attackData == null)
		{
			return;
		}
		Entity attackee = attackData.attackee;
		if (!attackee.IsValid || !attackee.TryGetCompMonster(out CompMonster _))
		{
			return;
		}
		int skillID = attackData.skillID;
		if (skillID <= 0)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (runtimeTarget.Completed || runtimeTarget.Rule.rulesId != 44)
			{
				continue;
			}
			int[] param = runtimeTarget.Rule.param;
			if (param != null && param.Length > 0 && runtimeTarget.Rule.param[0] == skillID)
			{
				if (!_skillHitMonsterEntityIds.TryGetValue(runtimeTarget.TargetId, out var value))
				{
					value = new HashSet<int>();
					_skillHitMonsterEntityIds.Add(runtimeTarget.TargetId, value);
				}
				if (value.Add(attackee.Id.Index))
				{
					runtimeTarget.Progress++;
					flag = true;
				}
			}
		}
		if (flag)
		{
			EvaluateTargets(RequiredEvent.Damage, isFinalEvaluation: false);
		}
	}

	private void OnCharacterStateChanged(CharacterStateChangeEvt stateEvent)
	{
		OnStateNameTriggered(stateEvent.characterId, stateEvent.characterState, _characterStateNameIds, RequiredEvent.CharacterState);
	}

	private void OnCharacterAbilityAdded(CharacterTutorialAddAbilityEvt addAbilityEvent)
	{
		OnStateNameTriggered(addAbilityEvent.characterId, addAbilityEvent.abilityName, _characterAbilityNameIds, RequiredEvent.CharacterAddAbility);
		OnCharacterAbilityCustomTagAdded(addAbilityEvent);
	}

	private void OnCharacterAbilityCustomTagAdded(CharacterTutorialAddAbilityEvt addAbilityEvent)
	{
		if (!addAbilityEvent.entity.IsValid || !addAbilityEvent.entity.IsCharacter() || _characterAbilityCustomTags.Count == 0)
		{
			return;
		}
		CompAbility compAbility = addAbilityEvent.entity.GetCompAbility();
		if (compAbility == null)
		{
			return;
		}
		if (!_triggeredStateNameCounts.TryGetValue(addAbilityEvent.characterId, out var value))
		{
			value = new Dictionary<int, int>();
			_triggeredStateNameCounts.Add(addAbilityEvent.characterId, value);
		}
		foreach (KeyValuePair<int, List<string>> characterAbilityCustomTag in _characterAbilityCustomTags)
		{
			List<string> value2 = characterAbilityCustomTag.Value;
			for (int i = 0; i < value2.Count; i++)
			{
				if (compAbility.HasAbilityCustomTag(value2[i]))
				{
					AddCount(value, characterAbilityCustomTag.Key);
					break;
				}
			}
		}
		EvaluateTargets(RequiredEvent.CharacterAddAbility, isFinalEvaluation: false);
	}

	private void OnCharacterSpecialEnergyGained(CharacterSpecialEnergyGainEvt specialEnergyEvent)
	{
		if (specialEnergyEvent.characterId > 0)
		{
			if (specialEnergyEvent.gainedValue > 0f)
			{
				_characterAccumulatedResonanceValues.TryGetValue(specialEnergyEvent.characterId, out var value);
				_characterAccumulatedResonanceValues[specialEnergyEvent.characterId] = value + specialEnergyEvent.gainedValue;
			}
			EvaluateTargets(RequiredEvent.CharacterSpecialEnergy, isFinalEvaluation: false);
		}
	}

	private void OnCharacterSpecialEnergyConsumed(CharacterSpecialEnergyConsumeEvt specialEnergyEvent)
	{
		if (!(specialEnergyEvent.consumedValue <= 0f))
		{
			_consumedResonanceValue += specialEnergyEvent.consumedValue;
			EvaluateTargets(RequiredEvent.CharacterSpecialEnergy, isFinalEvaluation: false);
		}
	}

	private void OnCharacterNormalEnergyConsumed(CharacterNormalEnergyConsumeEvt normalEnergyEvent)
	{
		if (!(normalEnergyEvent.consumedValue <= 0f))
		{
			_consumedAdaptabilityValue += normalEnergyEvent.consumedValue;
			EvaluateTargets(RequiredEvent.CharacterNormalEnergy, isFinalEvaluation: false);
		}
	}

	private void OnMotionStateChanged(MotionStateChangeEvt motionStateEvent)
	{
		if (motionStateEvent.entity.IsCharacter())
		{
			if (MonoECS.instance.mainEntity.GetCompMotion().JumpInAirCount <= 0)
			{
				_usedJump = true;
			}
			EvaluateTargets(RequiredEvent.MotionState, isFinalEvaluation: false);
		}
	}

	private void OnStateNameTriggered(int characterId, string eventName, Dictionary<string, List<int>> stateNameIds, RequiredEvent requiredEvent)
	{
		if (!string.IsNullOrEmpty(eventName) && stateNameIds.TryGetValue(eventName, out var value))
		{
			if (!_triggeredStateNameCounts.TryGetValue(characterId, out var value2))
			{
				value2 = new Dictionary<int, int>();
				_triggeredStateNameCounts.Add(characterId, value2);
			}
			for (int i = 0; i < value.Count; i++)
			{
				AddCount(value2, value[i]);
			}
			EvaluateTargets(requiredEvent, isFinalEvaluation: false);
		}
	}

	private void OnTriggerBlock(BaseEventContent eventContent)
	{
		if (IsTracking)
		{
			int characterId = ((eventContent is TriggerBlockEvt triggerBlockEvt) ? triggerBlockEvt.characterId : 0);
			if (RecordCharacterBlock(characterId))
			{
				EvaluateTargets(RequiredEvent.TriggerBlock, isFinalEvaluation: false);
			}
		}
	}

	private bool RecordCharacterBlock(int characterId)
	{
		bool result = false;
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (runtimeTarget.Completed || runtimeTarget.Rule.rulesId != 37)
			{
				continue;
			}
			int[] param = runtimeTarget.Rule.param;
			int num = ((param != null && param.Length > 0) ? param[0] : 0);
			if (num == 0 || num == characterId)
			{
				int num2 = ((param != null && param.Length > 1) ? param[1] : 0);
				if (num2 <= 0 || (TryGetCharacterHp(characterId, out var hp) && hp.Current * 100 >= hp.Max * num2))
				{
					runtimeTarget.Progress++;
					result = true;
				}
			}
		}
		return result;
	}

	private bool TryGetCharacterHp(int characterId, out CharacterHp hp)
	{
		if (characterId <= 0 || !_characterHp.TryGetValue(characterId, out hp) || hp.Max <= 0)
		{
			hp = default;
			return false;
		}
		return true;
	}

	private void OnMonsterPostureChanged(EntityPostureChangeEvt postureEvent)
	{
		if (postureEvent.oldPosture <= 0 || postureEvent.curPosture > 0)
		{
			return;
		}
		Entity entity = MonoECS.instance.GetEntity(postureEvent.entityId);
		if (entity.IsValid && entity.TryGetCompMonster(out CompMonster _) && entity.TryGetCompAbility(out CompAbility _))
		{
			EntityData data = CoreUtils.GetData(entity.GetTableId(), RuntimeConfigs.data.entityDatas);
			if (data != null)
			{
				AddCount(_breakMonsterShieldCounts, data.type);
			}
			if (IsMainCharacterInAssaultState())
			{
				_assaultStateStaggerCount++;
			}
			RecordCharacterAirBreakMonster();
			RecordBreakMonsterWithState(entity);
			EvaluateTargets(RequiredEvent.MonsterPosture, isFinalEvaluation: false);
		}
	}

	public void OnPostureDamage(AttackData attackData, float beforePosture, float afterPosture)
	{
		if (!IsTracking || !_hasPostureDamageTarget || attackData == null || !attackData.isPostureDamage || beforePosture <= afterPosture)
		{
			return;
		}
		Entity attackee = attackData.attackee;
		if (!attackee.TryGetCompMonster(out CompMonster _) || !attackee.TryGetCompAbility(out CompAbility component2) || !component2.IsWeak)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (runtimeTarget.Completed)
			{
				continue;
			}
			if (runtimeTarget.Rule.rulesId == 47)
			{
				int[] param = runtimeTarget.Rule.param;
				if (param != null && param.Length > 0 && runtimeTarget.Rule.param[0] == attackData.skillID)
				{
					runtimeTarget.Progress++;
					flag = true;
					continue;
				}
			}
			if (runtimeTarget.Rule.rulesId == 42)
			{
				int[] param = runtimeTarget.Rule.param;
				if (param != null && param.Length > 1 && IsCharacterStateConditionMatched(attackData.attacker, runtimeTarget.Rule.param[0], runtimeTarget.Rule.param[1]))
				{
					runtimeTarget.Progress++;
					flag = true;
				}
			}
		}
		if (flag)
		{
			EvaluateTargets(RequiredEvent.MonsterPosture, isFinalEvaluation: false);
		}
	}

	private bool IsCharacterStateConditionMatched(Entity character, int characterId, int stateNameId)
	{
		if (!character.TryGetCompCharacter(out CompCharacter component) || component.characterSource == null || component.characterSource.Id() != characterId || !character.TryGetCompAbility(out CompAbility component2) || RuntimeConfigs.data?.stateNames == null || !RuntimeConfigs.data.stateNames.TryGetValue(stateNameId, out var value))
		{
			return false;
		}
		switch (value.type)
		{
		case 2:
			if (value.nodeID == null)
			{
				return false;
			}
			foreach (Ability ability in component2.abilities)
			{
				if (ability?.config == null)
				{
					continue;
				}
				for (int i = 0; i < value.nodeID.Length; i++)
				{
					if (ContainsAbilityName(value.nodeID[i], ability.config.name))
					{
						return true;
					}
				}
			}
			return false;
		case 3:
		{
			if (value.nodeID == null)
			{
				return false;
			}
			for (int j = 0; j < value.nodeID.Length; j++)
			{
				string[] array = value.nodeID[j]?.Split(',');
				if (array == null)
				{
					continue;
				}
				for (int k = 0; k < array.Length; k++)
				{
					string text = array[k].Trim();
					if (!string.IsNullOrEmpty(text) && component2.HasAbilityCustomTag(text))
					{
						return true;
					}
				}
			}
			return false;
		}
		default:
			if (_unsupportedStateNameIds.Add(stateNameId))
			{
				Debug.LogWarning($"ChallengeTargetTrackerModel: stateName[{stateNameId}] type={value.type} 不支持规则 42。");
			}
			return false;
		}
	}

	private static bool IsMainCharacterInAssaultState()
	{
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (entity.IsValid && entity.TryGetCompAbility(out CompAbility component))
		{
			return component.HasAbilityCustomTag("gongjian");
		}
		return false;
	}

	private void RecordCharacterAirBreakMonster()
	{
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (!entity.IsValid || !entity.TryGetCompCharacter(out CompCharacter component) || component.characterSource == null || !entity.TryGetCompPhysics(out CompPhysics component2) || component2.isGrounded)
		{
			return;
		}
		int num = component.characterSource.Id();
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 46)
			{
				int[] param = runtimeTarget.Rule.param;
				if (param != null && param.Length > 0 && runtimeTarget.Rule.param[0] == num)
				{
					runtimeTarget.Progress++;
				}
			}
		}
	}

	private void OnMonsterDied(EntityDieEvt dieEvent)
	{
		Entity entity = dieEvent.entity;
		if (!entity.IsValid || !entity.TryGetCompMonster(out CompMonster _))
		{
			return;
		}
		RecordKillMonsterWithState(entity);
		RecordKillMonsterWithNoise(entity);
		if (entity.TryGetCompAbility(out CompAbility component2) && component2.IsWeak)
		{
			EntityData data = CoreUtils.GetData(entity.GetTableId(), RuntimeConfigs.data.entityDatas);
			if (data != null)
			{
				AddCount(_killMonsterOnShieldBrokenCounts, data.type);
			}
		}
		EvaluateTargets(RequiredEvent.MonsterDie, isFinalEvaluation: false);
	}

	private void OnKillEntity(OnKillEntity killEvent)
	{
		if (killEvent.attackData == null)
		{
			return;
		}
		Entity attacker = killEvent.attackData.attacker;
		Entity attackee = killEvent.attackData.attackee;
		if (!attackee.TryGetCompMonster(out CompMonster _))
		{
			return;
		}
		RecordBackstageCharacterKill(attacker);
		RecordCharacterKillMonster(attacker, attackee);
		RecordTypedAssistSkillKillMonster(killEvent.attackData, attackee);
		RecordDodgeCounterKill(killEvent.attackData);
		RecordAirbornePlayerKill(attacker);
		RecordTeamCharacterKill(attacker);
		RecordPoisonKill(killEvent.attackData);
		RecordEchoStateKill(attacker);
		if (attacker.TryGetCompCharacter(out CompCharacter _) && attackee.TryGetCompPhysics(out CompPhysics component3) && !component3.isGrounded)
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				RuntimeTarget runtimeTarget = _targets[i];
				if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 30 && IsMonsterStateConditionMatched(attackee, runtimeTarget.Rule, checkStack: false))
				{
					runtimeTarget.Progress++;
				}
			}
		}
		EvaluateTargets(RequiredEvent.KillEntity, isFinalEvaluation: false);
	}

	private void RecordCharacterKillMonster(Entity attacker, Entity monster)
	{
		if (!attacker.TryGetCompCharacter(out CompCharacter component) || component.characterSource == null)
		{
			return;
		}
		EntityData data = CoreUtils.GetData(monster.GetTableId(), RuntimeConfigs.data.entityDatas);
		if (data == null)
		{
			return;
		}
		int num = component.characterSource.Id();
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (runtimeTarget.Completed || runtimeTarget.Rule.rulesId != 32)
			{
				continue;
			}
			int[] param = runtimeTarget.Rule.param;
			if (param != null && param.Length > 0 && runtimeTarget.Rule.param[0] == num)
			{
				int ruleMonsterType = GetRuleMonsterType(runtimeTarget.Rule.param, 1);
				if (ruleMonsterType == 0 || data.type == ruleMonsterType)
				{
					runtimeTarget.Progress++;
				}
			}
		}
	}

	private void RecordTypedAssistSkillKillMonster(AttackData attackData, Entity monster)
	{
		if (attackData.motionPrimaryTypeTag != MotionPrimaryTypeTag.Assist)
		{
			return;
		}
		EntityData data = CoreUtils.GetData(monster.GetTableId(), RuntimeConfigs.data.entityDatas);
		if (data == null)
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 7)
			{
				int ruleMonsterType = GetRuleMonsterType(runtimeTarget.Rule.param);
				if (ruleMonsterType != 0 && data.type == ruleMonsterType)
				{
					runtimeTarget.Progress++;
				}
			}
		}
	}

	private void RecordDodgeCounterKill(AttackData attackData)
	{
		if (attackData.motionTypeTag != MotionTypeTag.DodgeAttack)
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 15)
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private void OnMotionAttackPatternResolved(MotionAttackPatternResolvedEvt evt)
	{
		if (evt == null || evt.source.configMotion == null)
		{
			return;
		}
		MotionPrimaryTypeTag motionPrimaryTypeTag = evt.source.configMotion.motionPrimaryTypeTag;
		MotionTypeTag motionTypeTag = evt.source.configMotion.motionTypeTag;
		if (motionPrimaryTypeTag == MotionPrimaryTypeTag.Assist && evt.killedEnemyCount > 0)
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				RuntimeTarget runtimeTarget = _targets[i];
				if (runtimeTarget.Completed)
				{
					continue;
				}
				if (runtimeTarget.Rule.rulesId == 7)
				{
					if (GetRuleMonsterType(runtimeTarget.Rule.param) == 0)
					{
						runtimeTarget.Progress += evt.killedEnemyCount;
					}
				}
				else if (runtimeTarget.Rule.rulesId == 20)
				{
					runtimeTarget.Progress = Math.Max(runtimeTarget.Progress, evt.killedEnemyCount);
				}
			}
			EvaluateTargets(RequiredEvent.MotionAttackPattern, isFinalEvaluation: false);
		}
		else
		{
			if (motionTypeTag != MotionTypeTag.DodgeAttack || !TryMarkDodgeCounterUse(in evt.source))
			{
				return;
			}
			for (int j = 0; j < _targets.Count; j++)
			{
				RuntimeTarget runtimeTarget2 = _targets[j];
				if (!runtimeTarget2.Completed && runtimeTarget2.Rule.rulesId == 14)
				{
					runtimeTarget2.Progress++;
				}
			}
			EvaluateTargets(RequiredEvent.MotionAttackPattern, isFinalEvaluation: false);
		}
	}

	private static bool TryMarkDodgeCounterUse(in MotionAttackSourceInfo source)
	{
		FSMRuntimeState fSMRuntimeState = FindDodgeCounterMotionState(in source);
		if (fSMRuntimeState == null)
		{
			return true;
		}
		if (fSMRuntimeState.dodgeCounterUseCounted)
		{
			return false;
		}
		fSMRuntimeState.dodgeCounterUseCounted = true;
		return true;
	}

	private static FSMRuntimeState FindDodgeCounterMotionState(in MotionAttackSourceInfo source)
	{
		Entity attacker = source.attacker;
		if (!attacker.IsValid || !attacker.TryGetCompMotion(out CompMotion component) || source.configMotion == null)
		{
			return null;
		}
		if (IsSameDodgeCounterMotion(component.layer0Peak, in source))
		{
			return component.layer0Peak;
		}
		List<FSMRuntimeState>[] layerMotionQueue = component.layerMotionQueue;
		if (layerMotionQueue == null)
		{
			return null;
		}
		foreach (List<FSMRuntimeState> list in layerMotionQueue)
		{
			if (list != null && list.Count != 0)
			{
				FSMRuntimeState fSMRuntimeState = list[list.Count - 1];
				if (IsSameDodgeCounterMotion(fSMRuntimeState, in source))
				{
					return fSMRuntimeState;
				}
			}
		}
		return null;
	}

	private static bool IsSameDodgeCounterMotion(FSMRuntimeState state, in MotionAttackSourceInfo source)
	{
		if (state?.state != null && state.state.index == source.stateIndex)
		{
			return true;
		}
		if (state?.actualMotion != null)
		{
			return state.actualMotion == source.configMotion;
		}
		return false;
	}

	private void RecordAirbornePlayerKill(Entity attacker)
	{
		if (!attacker.TryGetCompCharacter(out CompCharacter _) || !attacker.TryGetCompPhysics(out CompPhysics component2) || component2.isGrounded)
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 33)
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private void RecordTeamCharacterKill(Entity attacker)
	{
		if (attacker.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			int num = component.characterSource.Id();
			if (_teamCharacterIds.Contains(num))
			{
				AddCount(_teamCharacterKillCounts, num);
			}
		}
	}

	private void RecordPoisonKill(AttackData attackData)
	{
		if (!attackData.adjust2AttackType.HasFlag(Adjust2AttackTypeTag.DotAttack) || attackData.element != Element.Born)
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 36)
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private void RecordEchoStateKill(Entity attacker)
	{
		if (!attacker.TryGetCompCharacter(out CompCharacter _) || !attacker.TryGetCompAbility(out CompAbility component2) || !component2.HasAbilityTag(BuffTag.EchoBuff))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 17)
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private void RecordEchoStateUseAssistSkill(Entity character)
	{
		if (!character.TryGetCompCharacter(out CompCharacter _) || !character.TryGetCompAbility(out CompAbility component2) || !component2.HasAbilityTag(BuffTag.EchoBuff))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 18)
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private void RecordBackstageCharacterKill(Entity attacker)
	{
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (!entity.IsValid || !attacker.IsValid || attacker == entity || !attacker.TryGetCompCharacter(out CompCharacter component) || component.characterSource == null)
		{
			return;
		}
		int num = component.characterSource.Id();
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 29)
			{
				int[] param = runtimeTarget.Rule.param;
				if (param != null && param.Length > 0 && runtimeTarget.Rule.param[0] == num)
				{
					runtimeTarget.Progress++;
				}
			}
		}
	}

	private void RecordKillMonsterWithState(Entity monster)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 23 && IsMonsterStateConditionMatched(monster, runtimeTarget.Rule))
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private void RecordKillMonsterWithNoise(Entity monster)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 35)
			{
				int[] param = runtimeTarget.Rule.param;
				int num = ((param != null && param.Length > 0) ? runtimeTarget.Rule.param[0] : 0);
				if (num > 0 && GetMonsterNoiseTypeCount(monster) >= num)
				{
					runtimeTarget.Progress++;
				}
			}
		}
	}

	private static int GetMonsterNoiseTypeCount(Entity monster)
	{
		if (!monster.TryGetCompAbility(out CompAbility component))
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < NoiseAbilityNames.Length; i++)
		{
			if (component.HasAbility(NoiseAbilityNames[i]))
			{
				num++;
			}
		}
		return num;
	}

	private void RecordBreakMonsterWithState(Entity monster)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && runtimeTarget.Rule.rulesId == 49 && IsMonsterStateConditionMatched(monster, runtimeTarget.Rule))
			{
				runtimeTarget.Progress++;
			}
		}
	}

	private bool IsMonsterStateConditionMatched(Entity monster, Rules rule, bool checkStack = true)
	{
		int[] param = rule.param;
		int num = ((param != null && param.Length > 0) ? rule.param[0] : 0);
		if (num <= 0)
		{
			return true;
		}
		if (!monster.TryGetCompAbility(out CompAbility component))
		{
			return false;
		}
		if (RuntimeConfigs.data?.stateNames == null || !RuntimeConfigs.data.stateNames.TryGetValue(num, out var value))
		{
			if (_unsupportedStateNameIds.Add(num))
			{
				Debug.LogWarning($"ChallengeTargetTrackerModel: 规则[{rule.rulesId}]引用的 stateName[{num}]不存在。");
			}
			return false;
		}
		int type = value.type;
		if (type != 1 && type != 2)
		{
			if (_unsupportedStateNameIds.Add(num))
			{
				Debug.LogWarning($"ChallengeTargetTrackerModel: stateName[{num}] type={value.type} 不支持规则[{rule.rulesId}]。");
			}
			return false;
		}
		int num2;
		if (checkStack)
		{
			param = rule.param;
			if (param != null && param.Length > 1 && rule.param[1] > 0)
			{
				num2 = rule.param[1];
				goto IL_0101;
			}
		}
		num2 = 1;
		goto IL_0101;
		IL_0101:
		int num3 = num2;
		if (value.nodeID == null || value.nodeID.Length == 0)
		{
			return false;
		}
		foreach (Ability ability in component.abilities)
		{
			if (ability == null || ability.config == null || ability.stack < num3)
			{
				continue;
			}
			for (int i = 0; i < value.nodeID.Length; i++)
			{
				if (ContainsAbilityName(value.nodeID[i], ability.config.name))
				{
					return true;
				}
			}
		}
		return false;
	}

	private static bool ContainsAbilityName(string configuredNames, string abilityName)
	{
		if (string.IsNullOrEmpty(configuredNames) || string.IsNullOrEmpty(abilityName))
		{
			return false;
		}
		int i = 0;
		while (i < configuredNames.Length)
		{
			int num = configuredNames.IndexOf(',', i);
			int num2;
			for (num2 = ((num < 0) ? configuredNames.Length : num); i < num2 && char.IsWhiteSpace(configuredNames[i]); i++)
			{
			}
			while (num2 > i && char.IsWhiteSpace(configuredNames[num2 - 1]))
			{
				num2--;
			}
			int num3 = num2 - i;
			if (num3 == abilityName.Length && string.Compare(configuredNames, i, abilityName, 0, num3, StringComparison.Ordinal) == 0)
			{
				return true;
			}
			if (num < 0)
			{
				break;
			}
			i = num + 1;
		}
		return false;
	}

	private void EvaluateTargets(RequiredEvent changedEvent, bool isFinalEvaluation)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			RuntimeTarget runtimeTarget = _targets[i];
			if (!runtimeTarget.Completed && !runtimeTarget.Failed && (isFinalEvaluation || (runtimeTarget.RequiredEvents & changedEvent) != 0))
			{
				if (IsTargetCompleted(runtimeTarget, isFinalEvaluation))
				{
					CompleteTarget(runtimeTarget);
				}
				else if (IsTargetFailed(runtimeTarget, isFinalEvaluation))
				{
					FailTarget(runtimeTarget);
				}
				else
				{
					ChangedTarget(runtimeTarget);
				}
			}
		}
	}

	private bool IsTargetCompleted(RuntimeTarget target, bool isFinalEvaluation)
	{
		Rules rule = target.Rule;
		switch ((ChallengeTargetRuleId)rule.rulesId)
		{
		case ChallengeTargetRuleId.ClearRaid:
			return IsChallengeCompleted;
		case ChallengeTargetRuleId.ClearRaidWithinTime:
			if (IsChallengeCompleted && rule.number > 0)
			{
				return GetChallengeRuntime() <= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.InteractFinish:
			return IsChallengeCompleted;
		case ChallengeTargetRuleId.CollectAll:
		{
			int num = _totalCollectibles + _totalTeamTeachingLightPoints;
			if (num > 0)
			{
				return _collectCount + _teamTeachingLightPointCount >= num;
			}
			return false;
		}
		case ChallengeTargetRuleId.SurviveTime:
			if (rule.number > 0)
			{
				return GetChallengeRuntime() >= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.CharacterAirTime:
			return IsCharacterAirTimeCompleted(rule);
		case ChallengeTargetRuleId.CharacterStateDuration:
			return IsCharacterStateDurationCompleted(rule);
		case ChallengeTargetRuleId.DestroyAllDestructibles:
			if (_hasDestructibleSnapshot)
			{
				return _pendingDestructibleSwids.Count == 0;
			}
			return false;
		case ChallengeTargetRuleId.ClearRaidWithoutDoubleJumpOrJump:
			if (IsChallengeCompleted)
			{
				return !_usedJump;
			}
			return false;
		case ChallengeTargetRuleId.DamageTakenCountLessThan:
			if (IsChallengeCompleted)
			{
				return _damageTakenCount < rule.number;
			}
			return false;
		case ChallengeTargetRuleId.CharacterDeathCount:
			if (IsChallengeCompleted)
			{
				return GetCharacterDieCount() <= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.CollectItem:
			return GetCollectionCount(rule.param) >= rule.number;
		case ChallengeTargetRuleId.UseAssistSkill:
			return _assistSkillCount >= rule.number;
		case ChallengeTargetRuleId.BreakMonsterShield:
			return GetCountByMonsterType(_breakMonsterShieldCounts, GetRuleMonsterType(rule.param)) >= rule.number;
		case ChallengeTargetRuleId.TeamHpAtClear:
			if (IsChallengeCompleted)
			{
				return IsAllCharacterHpAbove(rule.number);
			}
			return false;
		case ChallengeTargetRuleId.KillShieldBrokenMonster:
			return GetCountByMonsterType(_killMonsterOnShieldBrokenCounts, GetRuleMonsterType(rule.param)) >= rule.number;
		case ChallengeTargetRuleId.TrapTriggerLessThan:
			if (IsChallengeCompleted)
			{
				return _triggeredTrapCount < rule.number;
			}
			return false;
		case ChallengeTargetRuleId.TrapTriggerAtMost:
			if (IsChallengeCompleted)
			{
				return _triggeredTrapCount <= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.UniqueCharacterDeathCount:
			if (IsChallengeCompleted)
			{
				return _characterDieCounts.Count <= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.CharacterTriggerState:
			return GetTriggeredStateNameCount(rule.param) >= rule.number;
		case ChallengeTargetRuleId.PerfectDodge:
			return _perfectDodgeCount >= rule.number;
		case ChallengeTargetRuleId.AssaultStateStagger:
			return _assaultStateStaggerCount >= rule.number;
		case ChallengeTargetRuleId.CharacterResonance:
			return GetCharacterResonanceCount(rule.param) >= rule.number;
		case ChallengeTargetRuleId.DifferentCharacterUltra:
			return _ultraSkillCharacterIds.Count >= rule.number;
		case ChallengeTargetRuleId.DifferentCharacterAssistSkill:
			return IsDifferentCharacterAssistSkillCompleted(rule);
		case ChallengeTargetRuleId.HelaAndLianEffect:
			return IsHelaAndLianEffectCompleted();
		case ChallengeTargetRuleId.ConsumeAdaptability:
			return _consumedAdaptabilityValue >= (float)rule.number;
		case ChallengeTargetRuleId.ConsumeResonance:
			return _consumedResonanceValue >= (float)rule.number;
		case ChallengeTargetRuleId.TeamCharacterKill:
		{
			int requiredTeamCharacterCount = GetRequiredTeamCharacterCount(rule.param);
			if (requiredTeamCharacterCount > 0)
			{
				return GetQualifiedTeamCharacterKillCount(rule.number) >= requiredTeamCharacterCount;
			}
			return false;
		}
		case ChallengeTargetRuleId.AssistSkillKillMonster:
		case ChallengeTargetRuleId.DodgeCounter:
		case ChallengeTargetRuleId.DodgeCounterKill:
		case ChallengeTargetRuleId.EchoStateKill:
		case ChallengeTargetRuleId.EchoStateUseAssistSkill:
		case ChallengeTargetRuleId.AssistSkillMultiKill:
		case ChallengeTargetRuleId.KillMonsterWithState:
		case ChallengeTargetRuleId.ApplyStateToMonster:
		case ChallengeTargetRuleId.ArmorBreakToCorrosion:
		case ChallengeTargetRuleId.BackstageCharacterKill:
		case ChallengeTargetRuleId.AirborneKillMonsterWithState:
		case ChallengeTargetRuleId.CharacterKillMonster:
		case ChallengeTargetRuleId.AirbornePlayerKill:
		case ChallengeTargetRuleId.KillMonsterWithNoise:
		case ChallengeTargetRuleId.PoisonKill:
		case ChallengeTargetRuleId.CharacterBlockWithHp:
		case ChallengeTargetRuleId.CharacterStateBreakMonster:
		case ChallengeTargetRuleId.SkillHitMonster:
		case ChallengeTargetRuleId.CharacterAirBreakMonster:
		case ChallengeTargetRuleId.SkillBreakMonster:
		case ChallengeTargetRuleId.BreakMonsterWithState:
			return target.Progress >= rule.number;
		default:
			return false;
		}
	}

	private void CompleteTarget(RuntimeTarget target)
	{
		if (!target.Failed)
		{
			int notifyProgress = GetNotifyProgress(target);
			target.Completed = true;
			target.Failed = false;
			_completedTargetIds.Add(target.TargetId);
			TargetChanged?.Invoke(target.TargetId, notifyProgress);
			TargetCompletedChanged?.Invoke(target.TargetId, arg2: true);
		}
	}

	private void FailTarget(RuntimeTarget target)
	{
		if (!target.Completed && !target.Failed)
		{
			int notifyProgress = GetNotifyProgress(target);
			target.Failed = true;
			TargetChanged?.Invoke(target.TargetId, notifyProgress);
			TargetFailedChanged?.Invoke(target.TargetId, arg2: true);
		}
	}

	private void ChangedTarget(RuntimeTarget target)
	{
		if (!target.Completed && !target.Failed)
		{
			TargetChanged?.Invoke(target.TargetId, GetNotifyProgress(target));
		}
	}

	private bool TryRecordTargetProgress(RuntimeTarget target, out int current, out int total)
	{
		current = 0;
		total = 0;
		if (target?.Rule == null || !TryResolveCountProgress(target, out var current2, out total, out var syncProgress))
		{
			return false;
		}
		if (current2 < 0)
		{
			current2 = 0;
		}
		if (syncProgress)
		{
			target.Progress = current2;
		}
		current = current2;
		if (current > total && ShouldClampCountProgress((ChallengeTargetRuleId)target.Rule.rulesId))
		{
			current = total;
		}
		return true;
	}

	private int GetNotifyProgress(RuntimeTarget target)
	{
		if (TryRecordTargetProgress(target, out var current, out var _))
		{
			return current;
		}
		return target.Progress;
	}

	private bool TryResolveCountProgress(RuntimeTarget target, out int current, out int total, out bool syncProgress)
	{
		current = 0;
		total = 0;
		syncProgress = false;
		Rules rule = target.Rule;
		ChallengeTargetRuleId rulesId = (ChallengeTargetRuleId)rule.rulesId;
		if (IsTimerTarget(rulesId) || IsWorldStateTarget(rulesId))
		{
			return false;
		}
		switch (rulesId)
		{
		case ChallengeTargetRuleId.CollectItem:
			current = GetRecordedCollectionCount(rule.param);
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.UseAssistSkill:
			current = _assistSkillCount;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.BreakMonsterShield:
			current = GetCountByMonsterType(_breakMonsterShieldCounts, GetRuleMonsterType(rule.param));
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.KillShieldBrokenMonster:
			current = GetCountByMonsterType(_killMonsterOnShieldBrokenCounts, GetRuleMonsterType(rule.param));
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.CharacterTriggerState:
			current = GetTriggeredStateNameCount(rule.param);
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.PerfectDodge:
			current = _perfectDodgeCount;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.AssaultStateStagger:
			current = _assaultStateStaggerCount;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.CharacterResonance:
			current = GetCharacterResonanceCount(rule.param);
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.DifferentCharacterUltra:
			current = _ultraSkillCharacterIds.Count;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.DifferentCharacterAssistSkill:
		{
			if (rule.number <= 0)
			{
				return false;
			}
			current = GetDifferentCharacterAssistQualifiedCount(rule);
			int[] param = rule.param;
			total = ((param != null && param.Length > 0) ? rule.param[0] : 0);
			syncProgress = true;
			break;
		}
		case ChallengeTargetRuleId.ConsumeAdaptability:
			current = Mathf.FloorToInt(_consumedAdaptabilityValue);
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.ConsumeResonance:
			current = Mathf.FloorToInt(_consumedResonanceValue);
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.TeamCharacterKill:
			if (rule.number <= 0)
			{
				return false;
			}
			current = GetQualifiedTeamCharacterKillCount(rule.number);
			total = GetRequiredTeamCharacterCount(rule.param);
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.DamageTakenCountLessThan:
			current = _damageTakenCount;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.CharacterDeathCount:
			current = GetCharacterDieCount();
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.TrapTriggerLessThan:
		case ChallengeTargetRuleId.TrapTriggerAtMost:
			current = _triggeredTrapCount;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.UniqueCharacterDeathCount:
			current = _characterDieCounts.Count;
			total = rule.number;
			syncProgress = true;
			break;
		case ChallengeTargetRuleId.AssistSkillKillMonster:
		case ChallengeTargetRuleId.DodgeCounter:
		case ChallengeTargetRuleId.DodgeCounterKill:
		case ChallengeTargetRuleId.EchoStateKill:
		case ChallengeTargetRuleId.EchoStateUseAssistSkill:
		case ChallengeTargetRuleId.AssistSkillMultiKill:
		case ChallengeTargetRuleId.KillMonsterWithState:
		case ChallengeTargetRuleId.ApplyStateToMonster:
		case ChallengeTargetRuleId.ArmorBreakToCorrosion:
		case ChallengeTargetRuleId.BackstageCharacterKill:
		case ChallengeTargetRuleId.AirborneKillMonsterWithState:
		case ChallengeTargetRuleId.CharacterKillMonster:
		case ChallengeTargetRuleId.AirbornePlayerKill:
		case ChallengeTargetRuleId.KillMonsterWithNoise:
		case ChallengeTargetRuleId.PoisonKill:
		case ChallengeTargetRuleId.CharacterBlockWithHp:
		case ChallengeTargetRuleId.CharacterStateBreakMonster:
		case ChallengeTargetRuleId.SkillHitMonster:
		case ChallengeTargetRuleId.CharacterAirBreakMonster:
		case ChallengeTargetRuleId.SkillBreakMonster:
		case ChallengeTargetRuleId.BreakMonsterWithState:
			current = target.Progress;
			total = rule.number;
			break;
		default:
			return false;
		}
		return total > 0;
	}

	private static bool IsTimerTarget(ChallengeTargetRuleId ruleId)
	{
		if (ruleId != ChallengeTargetRuleId.ClearRaidWithinTime && ruleId != ChallengeTargetRuleId.CharacterAirTime && ruleId != ChallengeTargetRuleId.SurviveTime)
		{
			return ruleId == ChallengeTargetRuleId.CharacterStateDuration;
		}
		return true;
	}

	private static bool IsWorldStateTarget(ChallengeTargetRuleId ruleId)
	{
		if (ruleId != ChallengeTargetRuleId.ClearRaid && ruleId != ChallengeTargetRuleId.InteractFinish && ruleId != ChallengeTargetRuleId.CollectAll && ruleId != ChallengeTargetRuleId.DestroyAllDestructibles && ruleId != ChallengeTargetRuleId.ClearRaidWithoutDoubleJumpOrJump && ruleId != ChallengeTargetRuleId.TeamHpAtClear)
		{
			return ruleId == ChallengeTargetRuleId.HelaAndLianEffect;
		}
		return true;
	}

	private static bool ShouldClampCountProgress(ChallengeTargetRuleId ruleId)
	{
		if (ruleId != ChallengeTargetRuleId.DamageTakenCountLessThan && ruleId != ChallengeTargetRuleId.CharacterDeathCount && ruleId != ChallengeTargetRuleId.TrapTriggerLessThan && ruleId != ChallengeTargetRuleId.TrapTriggerAtMost)
		{
			return ruleId != ChallengeTargetRuleId.UniqueCharacterDeathCount;
		}
		return false;
	}

	private bool IsTargetFailed(RuntimeTarget target, bool isFinalEvaluation)
	{
		Rules rule = target.Rule;
		switch ((ChallengeTargetRuleId)rule.rulesId)
		{
		case ChallengeTargetRuleId.ClearRaidWithinTime:
			if (rule.number > 0)
			{
				return GetChallengeRuntime() > rule.number;
			}
			return false;
		case ChallengeTargetRuleId.DamageTakenCountLessThan:
			if (rule.number > 0)
			{
				return _damageTakenCount >= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.TrapTriggerLessThan:
			if (rule.number > 0)
			{
				return _triggeredTrapCount >= rule.number;
			}
			return false;
		case ChallengeTargetRuleId.TrapTriggerAtMost:
			if (rule.number > 0)
			{
				return _triggeredTrapCount > rule.number;
			}
			return false;
		case ChallengeTargetRuleId.CharacterDeathCount:
			return GetCharacterDieCount() > rule.number;
		case ChallengeTargetRuleId.UniqueCharacterDeathCount:
			return _characterDieCounts.Count > rule.number;
		case ChallengeTargetRuleId.ClearRaidWithoutDoubleJumpOrJump:
			return _usedJump;
		case ChallengeTargetRuleId.TeamHpAtClear:
			if (isFinalEvaluation && IsChallengeCompleted)
			{
				return !IsAllCharacterHpAbove(rule.number);
			}
			return false;
		default:
			return false;
		}
	}

	private void ResetRuntimeState()
	{
		IsChallengeCompleted = false;
		_completedTargetIds.Clear();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets[i].Completed = false;
			_targets[i].Failed = false;
			_targets[i].Progress = 0;
		}
		ResetMetrics();
	}

	private void ResetMetrics()
	{
		_characterHp.Clear();
		_characterDieCounts.Clear();
		_potionUseCounts.Clear();
		_ultraSkillUseCounts.Clear();
		_dodgeCounts.Clear();
		_teamCharacterIds.Clear();
		_teamCharacterKillCounts.Clear();
		_triggeredStateNameCounts.Clear();
		_breakMonsterShieldCounts.Clear();
		_killMonsterOnShieldBrokenCounts.Clear();
		_ultraSkillCharacterIds.Clear();
		_pendingDestructibleSwids.Clear();
		_characterAccumulatedResonanceValues.Clear();
		_teamTeachingLightPointIds.Clear();
		_collectedTeamTeachingLightPointIds.Clear();
		_destructibleTargetSwids.Clear();
		_characterAssistSkillCounts.Clear();
		_applyStateMonsterEntityIds.Clear();
		_skillHitMonsterEntityIds.Clear();
		_collectCount = 0;
		_collectType = 0;
		_totalCollectibles = 0;
		_teamTeachingLightPointCount = 0;
		_totalTeamTeachingLightPoints = 0;
		_hasDestructibleSnapshot = false;
		_assistSkillCount = 0;
		_assaultStateStaggerCount = 0;
		_perfectDodgeCount = 0;
		_triggeredTrapCount = 0;
		_damageTakenCount = 0;
		_usedJump = false;
		_consumedAdaptabilityValue = 0f;
		_consumedResonanceValue = 0f;
		_characterAirTime = 0f;
		_challengeRuntime = 0f;
		_hasTrackingStartTime = false;
		List<Character> curAllCharacters = CharacterDataHelper.GetCurAllCharacters();
		if (curAllCharacters == null)
		{
			return;
		}
		foreach (Character item in curAllCharacters)
		{
			_teamCharacterIds.Add(item.Id);
			_characterHp[item.Id] = new CharacterHp
			{
				Current = item.Hp,
				Max = item.Hp
			};
		}
	}

	private int GetQualifiedTeamCharacterKillCount(int requiredKillCount)
	{
		if (requiredKillCount <= 0)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, int> teamCharacterKillCount in _teamCharacterKillCounts)
		{
			if (teamCharacterKillCount.Value >= requiredKillCount)
			{
				num++;
			}
		}
		return num;
	}

	private static int GetRequiredTeamCharacterCount(int[] param)
	{
		if (param == null || param.Length <= 0 || param[0] <= 0)
		{
			return 0;
		}
		return param[0];
	}

	private RequiredEvent GetRequiredEvents(Rules rule)
	{
		ChallengeTargetRuleId rulesId = (ChallengeTargetRuleId)rule.rulesId;
		RequiredEvent requiredEvent = GetBaseRequiredEvents(rulesId);
		if (rulesId != ChallengeTargetRuleId.KillMonsterWithState && rulesId != ChallengeTargetRuleId.AirborneKillMonsterWithState && rulesId != ChallengeTargetRuleId.CharacterStateBreakMonster && rulesId != ChallengeTargetRuleId.BreakMonsterWithState && rulesId != ChallengeTargetRuleId.CharacterStateDuration && rulesId != ChallengeTargetRuleId.ApplyStateToMonster && TryGetStateNameParamIndex(rulesId, out var paramIndex))
		{
			requiredEvent |= RegisterStateNameEvent(rule, paramIndex);
		}
		if (rulesId == ChallengeTargetRuleId.AssistSkillKillMonster && GetRuleMonsterType(rule.param) != 0)
		{
			requiredEvent |= RequiredEvent.KillEntity;
		}
		return requiredEvent;
	}

	private static RequiredEvent GetBaseRequiredEvents(ChallengeTargetRuleId ruleId)
	{
		switch (ruleId)
		{
		case ChallengeTargetRuleId.CharacterDeathCount:
		case ChallengeTargetRuleId.UniqueCharacterDeathCount:
			return RequiredEvent.CharacterDie;
		case ChallengeTargetRuleId.CollectItem:
			return RequiredEvent.Collect;
		case ChallengeTargetRuleId.CollectAll:
			return RequiredEvent.Collect;
		case ChallengeTargetRuleId.SurviveTime:
			return RequiredEvent.Runtime;
		case ChallengeTargetRuleId.ClearRaidWithinTime:
			return RequiredEvent.Runtime;
		case ChallengeTargetRuleId.CharacterAirTime:
			return RequiredEvent.Runtime;
		case ChallengeTargetRuleId.CharacterStateDuration:
			return RequiredEvent.Runtime;
		case ChallengeTargetRuleId.DestroyAllDestructibles:
			return RequiredEvent.Destructible;
		case ChallengeTargetRuleId.UseAssistSkill:
			return RequiredEvent.AssistSkill;
		case ChallengeTargetRuleId.EchoStateUseAssistSkill:
			return RequiredEvent.AssistSkill;
		case ChallengeTargetRuleId.BreakMonsterShield:
			return RequiredEvent.MonsterPosture;
		case ChallengeTargetRuleId.AssaultStateStagger:
			return RequiredEvent.MonsterPosture;
		case ChallengeTargetRuleId.TeamHpAtClear:
			return RequiredEvent.CharacterHp;
		case ChallengeTargetRuleId.KillShieldBrokenMonster:
			return RequiredEvent.MonsterDie;
		case ChallengeTargetRuleId.KillMonsterWithState:
			return RequiredEvent.MonsterDie;
		case ChallengeTargetRuleId.KillMonsterWithNoise:
			return RequiredEvent.MonsterDie;
		case ChallengeTargetRuleId.AssistSkillKillMonster:
			return RequiredEvent.MotionAttackPattern;
		case ChallengeTargetRuleId.AssistSkillMultiKill:
			return RequiredEvent.MotionAttackPattern;
		case ChallengeTargetRuleId.DodgeCounter:
			return RequiredEvent.MotionAttackPattern;
		case ChallengeTargetRuleId.DodgeCounterKill:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.BackstageCharacterKill:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.CharacterKillMonster:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.AirbornePlayerKill:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.TeamCharacterKill:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.EchoStateKill:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.PoisonKill:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.AirborneKillMonsterWithState:
			return RequiredEvent.KillEntity;
		case ChallengeTargetRuleId.CharacterAirBreakMonster:
			return RequiredEvent.MonsterPosture;
		case ChallengeTargetRuleId.SkillBreakMonster:
			return RequiredEvent.MonsterPosture;
		case ChallengeTargetRuleId.CharacterStateBreakMonster:
			return RequiredEvent.MonsterPosture;
		case ChallengeTargetRuleId.BreakMonsterWithState:
			return RequiredEvent.MonsterPosture;
		case ChallengeTargetRuleId.TrapTriggerLessThan:
		case ChallengeTargetRuleId.TrapTriggerAtMost:
			return RequiredEvent.Trap;
		case ChallengeTargetRuleId.PerfectDodge:
			return RequiredEvent.PerfectDodge;
		case ChallengeTargetRuleId.CharacterResonance:
			return RequiredEvent.CharacterSpecialEnergy;
		case ChallengeTargetRuleId.ConsumeAdaptability:
			return RequiredEvent.CharacterNormalEnergy;
		case ChallengeTargetRuleId.ConsumeResonance:
			return RequiredEvent.CharacterSpecialEnergy;
		case ChallengeTargetRuleId.DifferentCharacterUltra:
			return RequiredEvent.Ultra;
		case ChallengeTargetRuleId.ClearRaidWithoutDoubleJumpOrJump:
			return RequiredEvent.MotionState;
		case ChallengeTargetRuleId.DamageTakenCountLessThan:
			return RequiredEvent.Damage;
		case ChallengeTargetRuleId.CharacterBlockWithHp:
			return RequiredEvent.TriggerBlock;
		case ChallengeTargetRuleId.ArmorBreakToCorrosion:
			return RequiredEvent.PojiaToFushi;
		case ChallengeTargetRuleId.ApplyStateToMonster:
			return RequiredEvent.MonsterAbilityAdd;
		case ChallengeTargetRuleId.DifferentCharacterAssistSkill:
			return RequiredEvent.AssistSkill;
		case ChallengeTargetRuleId.SkillHitMonster:
			return RequiredEvent.Damage;
		case ChallengeTargetRuleId.HelaAndLianEffect:
			return RequiredEvent.Runtime;
		default:
			return RequiredEvent.None;
		}
	}

	private void InitializeSceneObjectTargets()
	{
		if ((_requiredEvents & RequiredEvent.Collect) != 0)
		{
			_totalCollectibles = MonoECS.instance.ruleManager.GetStateWorldAssetNumberByTag(ServiceSaveTag.RaidCollection);
			_collectCount = MonoECS.instance.ruleManager.GetStateWorldAssetInStateNumberByTag(ServiceSaveTag.RaidCollection, 1);
			InitializeTeamTeachingLightPoints();
		}
		if ((_requiredEvents & RequiredEvent.Destructible) != 0)
		{
			InitializeDestructibleTargets();
		}
		EvaluateTargets(RequiredEvent.Collect | RequiredEvent.Destructible, isFinalEvaluation: false);
	}

	private void InitializeTeamTeachingLightPoints()
	{
		foreach (StateWorldAssetData item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas())
		{
			TryRegisterTeamTeachingLightPoint(item);
		}
	}

	private bool TryRegisterTeamTeachingLightPoint(StateWorldAssetData data)
	{
		if (data == null || _teamTeachingLightPointIds.Contains(data.stateWorldAssetUid) || !IsTeamTeachingLightPoint(data))
		{
			return false;
		}
		_teamTeachingLightPointIds.Add(data.stateWorldAssetUid);
		_totalTeamTeachingLightPoints++;
		if (data.stateId == 1)
		{
			_teamTeachingLightPointCount++;
			_collectedTeamTeachingLightPointIds.Add(data.stateWorldAssetUid);
		}
		return true;
	}

	private static bool IsTeamTeachingLightPoint(StateWorldAssetData data)
	{
		if (!(data is InteractObjectData) || !StateWorldAsset.TryGetWorldAssetBySwid(data.stateWorldAssetUid, out var stateWorldAsset) || !(stateWorldAsset.stateObjectBase is InteractObject { interactStates: not null } interactObject))
		{
			return false;
		}
		for (int i = 0; i < interactObject.interactStates.Count; i++)
		{
			InteractState interactState = interactObject.interactStates[i];
			if (interactState == null)
			{
				continue;
			}
			if (ContainsLightPointCollectionAction(interactState.initStateObjectActionList) || ContainsLightPointCollectionAction(interactState.initActionList) || ContainsLightPointCollectionAction(interactState.completeTransitionActionList) || ContainsLightPointCollectionAction(interactState.uninitActionList))
			{
				return true;
			}
			if (interactState.interactEntries == null)
			{
				continue;
			}
			for (int j = 0; j < interactState.interactEntries.Count; j++)
			{
				if (ContainsLightPointCollectionAction(interactState.interactEntries[j]?.InteractActionList))
				{
					return true;
				}
			}
		}
		return false;
	}

	private static bool ContainsLightPointCollectionAction(InteractActionList actionList)
	{
		if (actionList?.interactActions == null)
		{
			return false;
		}
		for (int i = 0; i < actionList.interactActions.Count; i++)
		{
			InteractAction interactAction = actionList.interactActions[i];
			if (interactAction is ReportTeamTeachingLightPointCollected)
			{
				return true;
			}
			if (interactAction == null)
			{
				continue;
			}
			foreach (InteractActionList item in interactAction)
			{
				if (ContainsLightPointCollectionAction(item))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void InitializeDestructibleTargets()
	{
		foreach (StateWorldAssetData item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas())
		{
			TryRegisterDestructibleTarget(item);
		}
		_hasDestructibleSnapshot = _destructibleTargetSwids.Count > 0;
	}

	private bool TryRegisterDestructibleTarget(StateWorldAssetData data)
	{
		if (data == null || _destructibleTargetSwids.Contains(data.stateWorldAssetUid) || !StateWorldAsset.TryGetWorldAssetBySwid(data.stateWorldAssetUid, out var stateWorldAsset) || !(stateWorldAsset.stateObjectBase is InteractObject interactObject) || !HasDestructibleEntry(interactObject, data.initialStateId, data.stateId))
		{
			return false;
		}
		int swid = interactObject.swid;
		if (swid <= 0 || !_destructibleTargetSwids.Add(swid))
		{
			return false;
		}
		_pendingDestructibleSwids.Add(swid);
		_hasDestructibleSnapshot = true;
		return true;
	}

	private void OnAssetInited(BaseEventContent eventContent)
	{
		if (IsTracking && eventContent is AssetInitedEvt assetInitedEvt)
		{
			StateWorldAssetData worldStateAssetData = GetWorldStateAssetData(assetInitedEvt.swuid);
			bool flag = false;
			if ((_requiredEvents & RequiredEvent.Collect) != 0)
			{
				flag |= TryRegisterTeamTeachingLightPoint(worldStateAssetData);
			}
			if ((_requiredEvents & RequiredEvent.Destructible) != 0)
			{
				flag |= TryRegisterDestructibleTarget(worldStateAssetData);
			}
			if (flag)
			{
				EvaluateTargets(RequiredEvent.Collect | RequiredEvent.Destructible, isFinalEvaluation: false);
			}
		}
	}

	private static StateWorldAssetData GetWorldStateAssetData(int swid)
	{
		return Singleton<GameManager>.instance?.worldManager?.GetWorldStateAssetDataBySGOID(swid);
	}

	private static bool HasDestructibleEntry(InteractObject interactObject, int initialStateId, int currentStateId)
	{
		if (interactObject?.interactStates == null)
		{
			return false;
		}
		if (HasDestructibleEntry(interactObject.currentState))
		{
			return true;
		}
		if (currentStateId != initialStateId || initialStateId >= 0)
		{
			return false;
		}
		for (int i = 0; i < interactObject.interactStates.Count; i++)
		{
			if (HasDestructibleEntry(interactObject.interactStates[i]))
			{
				return true;
			}
		}
		return false;
	}

	private static bool HasDestructibleEntry(InteractState state)
	{
		if (state?.interactEntries == null)
		{
			return false;
		}
		for (int i = 0; i < state.interactEntries.Count; i++)
		{
			bool flag;
			switch (state.interactEntries[i]?.InteractType)
			{
			case InteractType.Attack:
			case InteractType.AttackWithOneEntity:
				flag = true;
				break;
			default:
				flag = false;
				break;
			}
			if (flag)
			{
				return true;
			}
		}
		return false;
	}

	private static bool TryGetStateNameParamIndex(ChallengeTargetRuleId ruleId, out int paramIndex)
	{
		switch (ruleId)
		{
		case ChallengeTargetRuleId.CharacterTriggerState:
		case ChallengeTargetRuleId.CharacterStateBreakMonster:
		case ChallengeTargetRuleId.CharacterStateDuration:
			paramIndex = 1;
			return true;
		case ChallengeTargetRuleId.ApplyStateToMonster:
		case ChallengeTargetRuleId.BreakMonsterWithState:
			paramIndex = 0;
			return true;
		default:
			paramIndex = -1;
			return false;
		}
	}

	private RequiredEvent RegisterStateNameEvent(Rules rule, int paramIndex)
	{
		if (rule.param == null || rule.param.Length <= paramIndex || rule.param[paramIndex] <= 0)
		{
			Debug.LogWarning($"ChallengeTargetTrackerModel: 规则[{rule.rulesId}]缺少 stateName 参数。");
			return RequiredEvent.None;
		}
		int num = rule.param[paramIndex];
		if (RuntimeConfigs.data?.stateNames == null || !RuntimeConfigs.data.stateNames.TryGetValue(num, out var value))
		{
			Debug.LogWarning($"ChallengeTargetTrackerModel: 规则[{rule.rulesId}]引用的 stateName[{num}]不存在。");
			return RequiredEvent.None;
		}
		switch (value.type)
		{
		case 1:
			AddStateNameMappings(_characterStateNameIds, value);
			return RequiredEvent.CharacterState;
		case 2:
			AddStateNameMappings(_characterAbilityNameIds, value);
			return RequiredEvent.CharacterAddAbility;
		case 3:
			AddStateNameCustomTagMappings(value);
			return RequiredEvent.CharacterAddAbility;
		default:
			if (_unsupportedStateNameIds.Add(num))
			{
				Debug.LogWarning($"ChallengeTargetTrackerModel: stateName[{num}] type={value.type} 不支持，规则[{rule.rulesId}]不会监听。");
			}
			return RequiredEvent.None;
		}
	}

	private static void AddStateNameMappings(Dictionary<string, List<int>> mappings, StateName stateName)
	{
		if (stateName.nodeID == null)
		{
			return;
		}
		for (int i = 0; i < stateName.nodeID.Length; i++)
		{
			string text = stateName.nodeID[i];
			if (string.IsNullOrEmpty(text))
			{
				continue;
			}
			string[] array = text.Split(',');
			for (int j = 0; j < array.Length; j++)
			{
				string text2 = array[j].Trim();
				if (!string.IsNullOrEmpty(text2))
				{
					if (!mappings.TryGetValue(text2, out var value))
					{
						value = new List<int>();
						mappings.Add(text2, value);
					}
					if (!value.Contains(stateName.id))
					{
						value.Add(stateName.id);
					}
				}
			}
		}
	}

	private void AddStateNameCustomTagMappings(StateName stateName)
	{
		if (stateName.nodeID == null)
		{
			return;
		}
		if (!_characterAbilityCustomTags.TryGetValue(stateName.id, out var value))
		{
			value = new List<string>();
			_characterAbilityCustomTags.Add(stateName.id, value);
		}
		for (int i = 0; i < stateName.nodeID.Length; i++)
		{
			string text = stateName.nodeID[i];
			if (!string.IsNullOrEmpty(text) && !value.Contains(text))
			{
				value.Add(text);
			}
		}
	}

	private void ClearStateNameMappings()
	{
		_characterStateNameIds.Clear();
		_characterAbilityNameIds.Clear();
		_characterAbilityCustomTags.Clear();
		_unsupportedStateNameIds.Clear();
	}

	private static void AddCount(Dictionary<int, int> counts, int key)
	{
		if (counts.TryGetValue(key, out var value))
		{
			counts[key] = value + 1;
		}
		else
		{
			counts.Add(key, 1);
		}
	}

	private int GetCollectionCount(int[] param)
	{
		int num = ((param != null && param.Length > 0) ? param[0] : 0);
		if (num == 3)
		{
			return GetTempleRobotCount();
		}
		if (num != _collectType)
		{
			return 0;
		}
		return _collectCount;
	}

	private int GetRecordedCollectionCount(int[] param)
	{
		int num = ((param != null && param.Length > 0) ? param[0] : 0);
		if (IsTempleChallengeScene())
		{
			if (num != 3)
			{
				return 0;
			}
			return GetTempleRobotCount();
		}
		if (num == 3)
		{
			return 0;
		}
		if (num != _collectType)
		{
			return 0;
		}
		return _collectCount;
	}

	private static bool IsTempleChallengeScene()
	{
		if (MonoECS.instance != null)
		{
			return MonoECS.instance.sceneStatus == SceneStatus.Temple;
		}
		return false;
	}

	private static int GetTempleRobotCount()
	{
		if (!Model<TempleModel>.HasInstance())
		{
			return 0;
		}
		return Model<TempleModel>.Interface.GetTempleActiveRobotCount(Model<TempleModel>.Interface.CurChallengeTempleId);
	}

	private int GetCharacterDieCount()
	{
		int num = 0;
		foreach (KeyValuePair<int, int> characterDieCount in _characterDieCounts)
		{
			num += characterDieCount.Value;
		}
		return num;
	}

	private bool IsAllCharacterHpAbove(int hpPercent)
	{
		if (_characterHp.Count == 0)
		{
			return false;
		}
		foreach (CharacterHp value in _characterHp.Values)
		{
			if (value.Max <= 0 || value.Current * 100 < value.Max * hpPercent)
			{
				return false;
			}
		}
		return true;
	}

	private int GetTriggeredStateNameCount(int[] param)
	{
		if (param == null || param.Length <= 1 || !_triggeredStateNameCounts.TryGetValue(param[0], out var value))
		{
			return 0;
		}
		if (!value.TryGetValue(param[1], out var value2))
		{
			return 0;
		}
		return value2;
	}

	private int GetCharacterResonanceCount(int[] param)
	{
		if (param == null || param.Length <= 0)
		{
			return 0;
		}
		int num = param[0];
		int num2 = 0;
		foreach (float value in _characterAccumulatedResonanceValues.Values)
		{
			if (value >= (float)num)
			{
				num2++;
			}
		}
		return num2;
	}

	private static int GetRuleMonsterType(int[] param, int paramIndex = 0)
	{
		if (param == null || paramIndex < 0 || paramIndex >= param.Length)
		{
			return 0;
		}
		int num = param[paramIndex];
		if (num != 2 && num != 6)
		{
			return 0;
		}
		return param[paramIndex];
	}

	private static int GetCountByMonsterType(Dictionary<int, int> counts, int monsterType)
	{
		if (monsterType == 2 || monsterType == 6)
		{
			if (!counts.TryGetValue(monsterType, out var value))
			{
				return 0;
			}
			return value;
		}
		int num = 0;
		foreach (int value2 in counts.Values)
		{
			num += value2;
		}
		return num;
	}

	private static float GetWorldRuntime()
	{
		return Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
	}

	public int GetChallengeRuntime()
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Abyss)
		{
			return Model<AbyssModel>.Interface.GetAbyssTotalTime();
		}
		if (!_hasTrackingStartTime)
		{
			return 0;
		}
		return Mathf.FloorToInt(_challengeRuntime);
	}

	private bool IsCharacterAirTimeCompleted(Rules rule)
	{
		if (rule.number <= 0 || _characterAirTime < (float)rule.number)
		{
			return false;
		}
		int[] param = rule.param;
		int num = ((param != null && param.Length > 0) ? rule.param[0] : 0);
		if (num <= 0)
		{
			return true;
		}
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (entity.IsValid && entity.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			return component.characterSource.Id() == num;
		}
		return false;
	}

	private bool IsCharacterStateDurationCompleted(Rules rule)
	{
		if (rule.number > 0)
		{
			int[] param = rule.param;
			if (param != null && param.Length > 1)
			{
				int num = rule.param[0];
				int num2 = rule.param[1];
				if (num <= 0 || num2 <= 0)
				{
					return false;
				}
				MPPlayer mPPlayer = MonoECS.instance?.localPlayer;
				if (mPPlayer == null || !mPPlayer.TryGetTeamCharacter(num, out var entity) || !entity.IsValid)
				{
					return false;
				}
				if (!TryGetCharacterStateHoldDurationMs(entity, num2, out var durationMs))
				{
					return false;
				}
				return durationMs >= (long)rule.number * 1000L;
			}
		}
		return false;
	}

	private bool TryGetCharacterStateHoldDurationMs(Entity character, int stateNameId, out long durationMs)
	{
		durationMs = 0L;
		if (!character.TryGetCompAbility(out CompAbility component) || RuntimeConfigs.data?.stateNames == null || !RuntimeConfigs.data.stateNames.TryGetValue(stateNameId, out var value) || value.nodeID == null || value.nodeID.Length == 0)
		{
			return false;
		}
		long num = long.MaxValue;
		bool flag = false;
		switch (value.type)
		{
		case 2:
			foreach (Ability ability in component.abilities)
			{
				if (ability?.config == null || ability.addTimeStamp <= 0)
				{
					continue;
				}
				for (int i = 0; i < value.nodeID.Length; i++)
				{
					if (ContainsAbilityName(value.nodeID[i], ability.config.name))
					{
						flag = true;
						if (ability.addTimeStamp < num)
						{
							num = ability.addTimeStamp;
						}
						break;
					}
				}
			}
			break;
		case 3:
			foreach (Ability ability2 in component.abilities)
			{
				if (ability2?.config != null && ability2.addTimeStamp > 0 && IsAbilityMatchedByCustomTags(ability2, value.nodeID))
				{
					flag = true;
					if (ability2.addTimeStamp < num)
					{
						num = ability2.addTimeStamp;
					}
				}
			}
			break;
		default:
			if (_unsupportedStateNameIds.Add(stateNameId))
			{
				Debug.LogWarning($"ChallengeTargetTrackerModel: stateName[{stateNameId}] type={value.type} 不支持规则 45。");
			}
			return false;
		}
		if (!flag || num == long.MaxValue)
		{
			return false;
		}
		durationMs = TimeManager.LocalTime.NowTimestamp - num;
		return durationMs >= 0;
	}

	private static bool IsAbilityMatchedByCustomTags(Ability ability, string[] configuredTags)
	{
		if (ability?.config == null || configuredTags == null)
		{
			return false;
		}
		for (int i = 0; i < configuredTags.Length; i++)
		{
			string[] array = configuredTags[i]?.Split(',');
			if (array == null)
			{
				continue;
			}
			for (int j = 0; j < array.Length; j++)
			{
				string text = array[j].Trim();
				if (!string.IsNullOrEmpty(text) && ability.config.HasCustomTag(text))
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool IsDifferentCharacterAssistSkillCompleted(Rules rule)
	{
		int[] param = rule.param;
		int num = ((param != null && param.Length > 0) ? rule.param[0] : 0);
		if (num > 0)
		{
			return GetDifferentCharacterAssistQualifiedCount(rule) >= num;
		}
		return false;
	}

	private int GetDifferentCharacterAssistQualifiedCount(Rules rule)
	{
		if (rule == null || rule.number <= 0)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, int> characterAssistSkillCount in _characterAssistSkillCounts)
		{
			if (characterAssistSkillCount.Value >= rule.number)
			{
				num++;
			}
		}
		return num;
	}

	private static bool IsHelaAndLianEffectCompleted()
	{
		MPPlayer mPPlayer = MonoECS.instance?.localPlayer;
		if (mPPlayer == null)
		{
			return false;
		}
		if (!mPPlayer.TryGetTeamCharacter(11601, out var entity) || !entity.IsValid || !mPPlayer.TryGetTeamCharacter(12701, out var entity2) || !entity2.IsValid)
		{
			return false;
		}
		bool flag = HasAbilityCustomTag(entity, "qiangxi");
		bool flag2 = HasAbilityCustomTag(entity, "gongjian");
		bool flag3 = HasAbilityCustomTag(entity2, "qiangxi");
		bool flag4 = HasAbilityCustomTag(entity2, "gongjian");
		if (!(flag & flag4))
		{
			return flag2 & flag3;
		}
		return true;
	}

	private static bool HasAbilityCustomTag(Entity character, string customTag)
	{
		if (!string.IsNullOrEmpty(customTag) && character.TryGetCompAbility(out CompAbility component))
		{
			return component.HasAbilityCustomTag(customTag);
		}
		return false;
	}

	protected override void Init()
	{
		Clear();
	}

	protected override void UnInit()
	{
		Clear();
		TargetCompletedChanged = null;
		TargetFailedChanged = null;
		TargetChanged = null;
	}

	public List<RuntimeTarget> GetTargets()
	{
		return _targets;
	}
}
