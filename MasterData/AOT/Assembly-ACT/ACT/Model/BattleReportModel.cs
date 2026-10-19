using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine.Events;

namespace ACT.Model;

[Obsolete("新版战报请使用：ChallengeTargetTrackerModel")]
public class BattleReportModel : Model<BattleReportModel>
{
	private UnityEvent _onBattleReportUpdate;

	private bool _isRecording;

	private BattleReportResult _currentReport;

	public UnityEvent OnBattleReportUpdate => _onBattleReportUpdate;

	public bool IsRecording => _isRecording;

	protected override void Init()
	{
		_isRecording = false;
		_onBattleReportUpdate = new UnityEvent();
	}

	protected override void UnInit()
	{
		Release();
		_isRecording = false;
		_onBattleReportUpdate.RemoveAllListeners();
		_onBattleReportUpdate = null;
	}

	public void BeginRecordReport()
	{
		Release();
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || !Model<ChallengeTargetTrackerModel>.Interface.IsPrepared)
		{
			AddEventListener();
			_isRecording = true;
			_currentReport = new BattleReportResult(CharacterDataHelper.GetCurAllCharacters());
			_currentReport.SceneStatus = MonoECS.instance.sceneStatus;
		}
	}

	public void EndRecordReport()
	{
		OnEndRecordReportBefore();
		RemoveEventListener();
		_isRecording = false;
		_onBattleReportUpdate?.Invoke();
	}

	public void Release()
	{
		if (_isRecording)
		{
			EndRecordReport();
		}
		if (_currentReport != null)
		{
			_currentReport.Release();
			_currentReport = null;
		}
	}

	private void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidCollectInfoChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Character_HpChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnUltra, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnPerfectDodge, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterDie, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterStateChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityPostureChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnBattleReportEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TempleInteractRefresh, TempleInteractRefresh);
	}

	private void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidCollectInfoChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnDamage, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Character_HpChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnUltra, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnPerfectDodge, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterDie, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterStateChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityPostureChange, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnBattleReportEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TempleInteractRefresh, TempleInteractRefresh);
	}

	private void OnBattleReportEvent(BaseEventContent baseEventContent)
	{
		if (!_isRecording)
		{
			return;
		}
		if (!(baseEventContent is RaidCollectInfoChangeEvt raidCollectInfoChangeEvt))
		{
			if (!(baseEventContent is DamageEvt damageEvt))
			{
				if (!(baseEventContent is CharacterHpChangeEvt characterHpChangeEvt))
				{
					if (!(baseEventContent is UltraEvent ultraEvent))
					{
						if (!(baseEventContent is PerfectDodgeEvent perfectDodgeEvent))
						{
							if (!(baseEventContent is BattleCharacterDieEvt battleCharacterDieEvt))
							{
								if (!(baseEventContent is BattleCharacterChangeEvt battleCharacterChangeEvt))
								{
									if (!(baseEventContent is CharacterStateChangeEvt characterStateChangeEvt))
									{
										if (!(baseEventContent is EntityPostureChangeEvt entityPostureChangeEvt))
										{
											if (baseEventContent is EntityDieEvt entityDieEvt)
											{
												OnMonsterDie(entityDieEvt);
											}
										}
										else
										{
											OnEntityPostureChange(entityPostureChangeEvt);
										}
									}
									else
									{
										OnCharacterStateChange(characterStateChangeEvt);
									}
								}
								else
								{
									OnBeforeBattleCharacterChange(battleCharacterChangeEvt);
								}
							}
							else
							{
								OnCharacterDie(battleCharacterDieEvt);
							}
						}
						else
						{
							OnPerfectDodge(perfectDodgeEvent);
						}
					}
					else
					{
						OnCharacterUltra(ultraEvent);
					}
				}
				else
				{
					OnCharacterHpChange(characterHpChangeEvt);
				}
			}
			else
			{
				OnDamage(damageEvt);
			}
		}
		else
		{
			OnRaidCollectInfoChange(raidCollectInfoChangeEvt);
		}
		_onBattleReportUpdate?.Invoke();
	}

	private void OnRaidCollectInfoChange(RaidCollectInfoChangeEvt raidCollectInfoChangeEvt)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid && RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value))
		{
			if (value.belongEntranceData == 101)
			{
				_currentReport.ParkourExpCount = raidCollectInfoChangeEvt.collectCount;
			}
			else if (value.belongEntranceData == 201)
			{
				_currentReport.ParkourGoldCount = raidCollectInfoChangeEvt.collectCount;
			}
		}
	}

	private void OnDamage(DamageEvt damageEvt)
	{
		if (damageEvt.AttackData.attacker == MonoECS.instance.mainEntity && _currentReport.CharacterBattleReportDic.TryGetValue(MonoECS.instance.MainEntityCharacterId, out var value))
		{
			value.Damage += damageEvt.AttackData.damage;
			value.ActualDamage += damageEvt.AttackData.actualDamage;
		}
	}

	private void OnCharacterHpChange(CharacterHpChangeEvt characterHpChangeEvt)
	{
		if (_currentReport.CharacterBattleReportDic.TryGetValue(characterHpChangeEvt.characterId, out var value))
		{
			value.CurrentHP = characterHpChangeEvt.curHp;
			value.MaxHP = characterHpChangeEvt.maxHp;
		}
	}

	public void OnBloodBottleUse(Entity entity, int useCount)
	{
		if (_isRecording && entity.IsValid)
		{
			int key = entity.GetCompCharacter().characterSource.Id();
			if (_currentReport.CharacterBattleReportDic.TryGetValue(key, out var value))
			{
				value.PotionUseCount++;
			}
			_onBattleReportUpdate?.Invoke();
		}
	}

	private void OnCharacterUltra(UltraEvent ultraEvent)
	{
		int key = ultraEvent.entity.GetCompCharacter().characterSource.Id();
		if (_currentReport.CharacterBattleReportDic.TryGetValue(key, out var value))
		{
			value.UltralSkillUseCount++;
		}
	}

	private void OnPerfectDodge(PerfectDodgeEvent perfectDodgeEvent)
	{
		if (_currentReport.CharacterBattleReportDic.TryGetValue(MonoECS.instance.MainEntityCharacterId, out var value))
		{
			if (perfectDodgeEvent.isWitch)
			{
				value.WitchDodge++;
			}
			else
			{
				value.PerfectDodge++;
			}
		}
	}

	private void OnCharacterDie(BattleCharacterDieEvt battleCharacterDieEvt)
	{
		if (_currentReport.CharacterBattleReportDic.TryGetValue(battleCharacterDieEvt.characterId, out var value))
		{
			value.DieCount++;
			if (Model<RaidModel>.Interface.IsParkourRaid)
			{
				value.TriggeredTrapCount++;
				value.TrapCount++;
			}
		}
	}

	public void OnTriggerTrap()
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			Model<ChallengeTargetTrackerModel>.Interface.OnTriggerTrap();
		}
		if (_isRecording)
		{
			if (_currentReport.CharacterBattleReportDic.TryGetValue(MonoECS.instance.MainEntityCharacterId, out var value))
			{
				value.TriggeredTrapCount++;
			}
			_onBattleReportUpdate?.Invoke();
		}
	}

	private void OnBeforeBattleCharacterChange(BattleCharacterChangeEvt battleCharacterChangeEvt)
	{
		if (battleCharacterChangeEvt.switchSkill)
		{
			_currentReport.AssistSkillCount++;
		}
	}

	private void OnCharacterStateChange(CharacterStateChangeEvt characterStateChangeEvt)
	{
		int num = -1;
		foreach (KeyValuePair<int, StateName> stateName in RuntimeConfigs.data.stateNames)
		{
			if (stateName.Value.nodeID == null)
			{
				continue;
			}
			string[] nodeID = stateName.Value.nodeID;
			for (int i = 0; i < nodeID.Length; i++)
			{
				if (string.Equals(nodeID[i], characterStateChangeEvt.characterState))
				{
					num = stateName.Value.id;
					break;
				}
			}
			if (num >= 0)
			{
				break;
			}
		}
		if (num >= 0 && _currentReport.CharacterBattleReportDic.TryGetValue(characterStateChangeEvt.characterId, out var value))
		{
			if (value.TriggeredNodeCount.ContainsKey(num))
			{
				value.TriggeredNodeCount[num]++;
			}
			else
			{
				value.TriggeredNodeCount.Add(num, 1);
			}
		}
	}

	private void OnEntityPostureChange(EntityPostureChangeEvt entityPostureChangeEvt)
	{
		if ((entityPostureChangeEvt.oldPosture > 0 && entityPostureChangeEvt.curPosture > 0) || entityPostureChangeEvt.oldPosture <= entityPostureChangeEvt.curPosture)
		{
			return;
		}
		Entity entity = MonoECS.instance.GetEntity(entityPostureChangeEvt.entityId);
		if (!entity.IsValid || !entity.TryGetCompMonster(out CompMonster _) || !_currentReport.CharacterBattleReportDic.TryGetValue(MonoECS.instance.MainEntityCharacterId, out var value))
		{
			return;
		}
		EntityData data = CoreUtils.GetData(entity.GetTableId(), RuntimeConfigs.data.entityDatas);
		if (data != null)
		{
			int type = data.type;
			if (value.BreakDiffTypeMonsterShieldCount.ContainsKey(type))
			{
				value.BreakDiffTypeMonsterShieldCount[type]++;
			}
			else
			{
				value.BreakDiffTypeMonsterShieldCount.Add(type, 1);
			}
		}
	}

	private void OnMonsterDie(EntityDieEvt entityDieEvt)
	{
		Entity entity = entityDieEvt.entity;
		if (!entity.IsValid || !entity.TryGetCompMonster(out CompMonster _) || !entity.TryGetCompAbility(out CompAbility component2) || !component2.IsWeak || !_currentReport.CharacterBattleReportDic.TryGetValue(MonoECS.instance.MainEntityCharacterId, out var value))
		{
			return;
		}
		EntityData data = CoreUtils.GetData(entity.GetTableId(), RuntimeConfigs.data.entityDatas);
		if (data != null)
		{
			int type = data.type;
			if (value.KillDiffTypeMonsterOnShieldBrokenCount.ContainsKey(type))
			{
				value.KillDiffTypeMonsterOnShieldBrokenCount[type]++;
			}
			else
			{
				value.KillDiffTypeMonsterOnShieldBrokenCount.Add(type, 1);
			}
		}
	}

	private void TempleInteractRefresh(BaseEventContent baseEventContent)
	{
		if (_isRecording)
		{
			_currentReport.RobotCount = Model<TempleModel>.Interface.GetTempleActiveRobotCount(Model<TempleModel>.Interface.CurChallengeTempleId);
			_onBattleReportUpdate?.Invoke();
		}
	}

	private void OnEndRecordReportBefore()
	{
		if (_isRecording && _currentReport != null)
		{
			if (MonoECS.instance.sceneStatus == SceneStatus.Abyss)
			{
				_currentReport.Duration = Model<AbyssModel>.Interface.CurLayerTime;
			}
			else
			{
				_currentReport.Duration = Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
			}
		}
	}

	public StageSettleInfo GetStageSettleInfo()
	{
		if (_currentReport == null)
		{
			return null;
		}
		StageSettleInfo stageSettleInfo = new StageSettleInfo();
		stageSettleInfo.Duration = _currentReport.Duration;
		stageSettleInfo.PointCount = ((_currentReport.ParkourExpCount > 0) ? _currentReport.ParkourExpCount : stageSettleInfo.PointCount);
		stageSettleInfo.PointCount = ((_currentReport.ParkourGoldCount > 0) ? _currentReport.ParkourGoldCount : stageSettleInfo.PointCount);
		stageSettleInfo.PointCount = ((_currentReport.RobotCount > 0) ? _currentReport.RobotCount : stageSettleInfo.PointCount);
		stageSettleInfo.AssistSkillCount = _currentReport.AssistSkillCount;
		stageSettleInfo.KillDiffTypeMonsterByAssistSkillCount.AddRange(_currentReport.KillDiffTypeMonsterByAssistSkillCount);
		foreach (KeyValuePair<int, CharacterBattleReport> item in _currentReport.CharacterBattleReportDic)
		{
			CharacterBattleReport value = item.Value;
			stageSettleInfo.DieCount += value.DieCount;
			stageSettleInfo.TrapCount += value.TrapCount;
			stageSettleInfo.TriggeredTrapCount += value.TriggeredTrapCount;
			StageSettleCharacterInfo stageSettleCharacterInfo = new StageSettleCharacterInfo();
			stageSettleCharacterInfo.CharacterID = value.CharacterId;
			stageSettleCharacterInfo.CharacterLv = value.CharacterLevel;
			stageSettleCharacterInfo.Damage = (long)value.Damage;
			stageSettleCharacterInfo.HpPercent = (float)value.CurrentHP / (float)value.MaxHP;
			stageSettleCharacterInfo.PotionUseCount = value.PotionUseCount;
			stageSettleCharacterInfo.ExSkillUseCount = value.UltralSkillUseCount;
			stageSettleCharacterInfo.DodgeCount = value.DodgeCount;
			stageSettleCharacterInfo.Duration = MonoECS.instance.chTimeStatisticsManager.GetTimeStatistics(value.CharacterId);
			stageSettleCharacterInfo.TriggeredNodeCount.AddRange(value.TriggeredNodeCount);
			stageSettleCharacterInfo.BreakDiffTypeMonsterShieldCount.AddRange(value.BreakDiffTypeMonsterShieldCount);
			stageSettleCharacterInfo.KillDiffTypeMonsterOnShieldBrokenCount.AddRange(value.KillDiffTypeMonsterOnShieldBrokenCount);
			stageSettleInfo.CharacterInfo.Add(stageSettleCharacterInfo);
		}
		return stageSettleInfo;
	}

	public BattleReportResult GetBattleReportResult()
	{
		return _currentReport;
	}
}
