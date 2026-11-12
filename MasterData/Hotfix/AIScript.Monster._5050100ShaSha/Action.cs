#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Action : AIBase
{
	protected enum SkillId
	{
		Dash = 5050101,
		Sweep = 5050102,
		ChargeFlick = 5050103,
		Crush = 5050104,
		CrargeBreath = 5050105,
		WaterSpit = 5050106,
		WaterSpit3 = 5050116,
		ShadowBall = 5050107,
		ShadowGathering = 5050108,
		TravelAround = 5050109,
		Whelmed = 5050110,
		ToRandomPoint = 5050113,
		Jump = 5050114
	}

	protected readonly Dictionary<int, List<FP>> skillInfo = new Dictionary<int, List<FP>>
	{
		{
			5050101,
			new List<FP> { 20, 10, 15, 2, 60 }
		},
		{
			5050102,
			new List<FP> { 2, 3, 5, 2, 60 }
		},
		{
			5050104,
			new List<FP> { 10, 0, 5, 2, 60 }
		},
		{
			5050114,
			new List<FP> { 10, 3, 30, 2, 360 }
		},
		{
			5050103,
			new List<FP> { 7, 3, 5, 5, 60 }
		},
		{
			5050105,
			new List<FP> { 20, 0, 12, 5, 30 }
		},
		{
			5050106,
			new List<FP> { 4, 0, 12, 5, 60 }
		},
		{
			5050116,
			new List<FP> { 8, 0, 20, 5, 60 }
		},
		{
			5050107,
			new List<FP> { 8, 0, 16, 5, 30 }
		},
		{
			5050108,
			new List<FP> { 8, 0, 30, 5, 360 }
		}
	};

	protected readonly int ViolentBuffId = 505010110;

	protected FP ViolentTime = 60;

	protected FP stageOneWaitTime = 0.1;

	protected FP stageTwoWaitTime = 0.1;

	protected readonly Dictionary<int, FP> StageOne_DisLessThan6_Front = new Dictionary<int, FP>
	{
		{ 5050102, 30 },
		{ 5050101, 20 },
		{ 5050103, 30 },
		{ 5050105, 20 },
		{ -2, 10 }
	};

	protected readonly Dictionary<int, FP> StageOne_DisMoreThan6_Front = new Dictionary<int, FP>
	{
		{ 5050106, 50 },
		{ 5050101, 30 },
		{ 5050105, 30 },
		{ -1, 20 }
	};

	protected readonly Dictionary<int, FP> StageTwo_DisLessThan6_Front = new Dictionary<int, FP>
	{
		{ 5050102, 20 },
		{ 5050101, 20 },
		{ 5050103, 30 },
		{ -2, 10 },
		{ -3, 20 }
	};

	protected readonly Dictionary<int, FP> StageTwo_DisMoreThan6_Front_Violent = new Dictionary<int, FP>
	{
		{ 5050116, 40 },
		{ 5050101, 20 },
		{ 5050107, 30 },
		{ -4, 10 }
	};

	protected readonly Dictionary<int, FP> StageTwo_DisMoreThan6_Front_ViolentNone = new Dictionary<int, FP>
	{
		{ 5050106, 30 },
		{ 5050105, 30 },
		{ -1, 10 }
	};

	protected readonly List<int> specialSkillList = new List<int> { 5050114, 5050108, 5050107 };

	protected readonly Dictionary<int, List<int>> dicSpecialSkillGroup = new Dictionary<int, List<int>>
	{
		{
			-2,
			new List<int> { 5050103, 5050101, 5050105 }
		},
		{
			-3,
			new List<int> { 5050102, 5050103, 5050105 }
		},
		{
			-4,
			new List<int> { 5050105, 5050107, 5050107, 5050116 }
		}
	};

	protected readonly FP crushSearchRadius = 7;

	protected readonly FP crushSearchInnerRadius = 3;

	private LogicVariable _logicVariable;

	protected int _receiveDamage;

	protected CoroutineNode _corCountDown;

	protected TraceTarget _traceTarget;

	protected readonly Dictionary<int, FP> _runSkillCDEnd = new Dictionary<int, FP>();

	protected LookAtTarget _lookAtTarget;

	protected int _currentStage = 1;

	protected CoroutineNode _waitCreateSkill;

	protected bool _waitShadow;

	protected int tempSkillId;

	protected int toughnessCount;

	protected bool isToughnessWhelmed;

	protected bool isSpecialSkillListEnd;

	protected int runSpecialSkillListCount;

	protected List<int> tmpSpecialGroup = new List<int>();

	protected int tmpSpecialIndex;

	protected bool tmpRunSpecialGroup;

	protected FP tmpWaitTime;

	public void OnEnable()
	{
		isToughnessWhelmed = false;
		toughnessCount = 0;
		_currentStage = 1;
		_waitShadow = false;
		ShowBlood(isShow: true);
		InitSkill();
		if (_lookAtTarget == null)
		{
			_lookAtTarget = new LookAtTarget();
		}
		_actor.logicVariable.SetLogicTagValue("ViolentBuffId", ViolentBuffId);
		_actor.logicVariable.SetLogicTagValue("SkillId_whelmed", 5050110);
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		_actor.EnableImmuneControl();
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			monsterAdventureActor.monsterToughnessInfo.isUseDefaultBrokenState = false;
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
	}

	protected void ShowBlood(bool isShow)
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			monsterAdventureActor.ShowBlood(isShow);
		}
	}

	public void OnStart()
	{
		_logicVariable = ActorHelper.GetFlowLogicVariable(_actor.gameObject);
		stageRandomSkill();
		_actor.StopImmuneControlCueEffect();
	}

	protected void InitSkill()
	{
		foreach (int key in skillInfo.Keys)
		{
			_runSkillCDEnd.set_Item(key, (FP)0);
		}
	}

	public void OnStop()
	{
		if (_lookAtTarget != null)
		{
			_lookAtTarget.StopLookAt();
			_lookAtTarget.Clear();
		}
		if (_traceTarget != null)
		{
			_traceTarget.Clear();
			_traceTarget = null;
		}
	}

	public void OnUpdate()
	{
		if (_logicVariable.GetLogicTagToggle("5050100ShaShaViolent_Start"))
		{
			_receiveDamage = 0;
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent_Start", value: false);
		}
		if (_logicVariable.GetLogicTagToggle("5050100EndWhelmed"))
		{
			_actor.logicVariable.ToggleLogicTag("5050100EndWhelmed", value: false);
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
			_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		}
		if (_logicVariable.GetLogicTagToggle("CheckSkill_ShaSha"))
		{
			stageRandomSkill();
			_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		}
	}

	public void OnDisable()
	{
		if (_lookAtTarget != null)
		{
			_lookAtTarget.StopLookAt();
			_lookAtTarget.Clear();
		}
		if (_traceTarget != null)
		{
			_traceTarget.Clear();
			_traceTarget = null;
		}
		StopCoroutine(ref _corCountDown);
		StopCoroutine(ref _waitCreateSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
		_actor.DisableSuperArmor();
	}

	protected void OnRemoveBuff(IEvent evt)
	{
		if (evt.sender as AdventureActor == _actor && (evt as AdventureActorRemoveBuff).eventInfo.buffId == ViolentBuffId)
		{
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent", value: false);
			StopCoroutine(ref _corCountDown);
			StartCoroutine(ref _corCountDown, CorCountDown());
		}
	}

	private void OnToughnessState(IEvent evt)
	{
		MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent = evt as MonsterToughnessStateChangeEvent;
		if (_actor != null && _actor.Id == monsterToughnessStateChangeEvent.actor.Id && monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			_actor.InterruptForceControl();
			toughnessCount++;
			StopCoroutine(ref _waitCreateSkill);
			_lookAtTarget?.StopLookAt();
			if (toughnessCount <= 2)
			{
				NovaLogger.Debug("鲨鱼 破除韧性  眩晕");
				isToughnessWhelmed = true;
				_actor.actorSkillManage.DestoryAllSkill();
				_actor.InterruptAttack(force: true);
				_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
				_traceTarget?.Clear();
				tmpRunSpecialGroup = false;
				ILRuntimeAPI.CreateSkill(5050110, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
			}
			if (_currentStage == 2)
			{
				_actor.actorSkillManage.DestoryAllSkill();
				NovaLogger.Debug("鲨鱼 破除狂暴  执行眩晕");
				_actor.InterruptAttack(force: true);
				_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
				_traceTarget?.Clear();
				tmpRunSpecialGroup = false;
				ILRuntimeAPI.CreateSkill(5050110, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
				_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent", value: false);
			}
		}
	}

	protected IEnumerator CorCountDown()
	{
		_waitShadow = false;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(ViolentTime));
		_waitShadow = true;
	}

	protected bool checkSkill(int _skillid, FP _logicTime)
	{
		if (_skillid < 0)
		{
			return true;
		}
		if (!_runSkillCDEnd.ContainsKey(_skillid) || !skillInfo.ContainsKey(_skillid) || skillInfo.get_Item(_skillid).Count < 1)
		{
			return true;
		}
		if (_runSkillCDEnd.get_Item(_skillid) < _logicTime && skillInfo.get_Item(_skillid).get_Item(1) < _logicTime)
		{
			return true;
		}
		return false;
	}

	protected bool havePlayer()
	{
		List<LogicEntity> list = CommonUtils.SearchNearTargetsByCircle(_actor, crushSearchRadius, isConfront: true, includeSelf: false);
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				if (TSVector2.Distance(_actor.tsTransform.Position, list.get_Item(i).tsTransform.Position) > crushSearchInnerRadius)
				{
					return true;
				}
			}
		}
		return false;
	}

	protected FP RandomSkill(Dictionary<int, FP> dicGroup, FP waitTime, int _stage)
	{
		FP fP = 0;
		Dictionary<int, FP> dictionary = new Dictionary<int, FP>();
		FP logicTime = _actor.LogicTime;
		foreach (KeyValuePair<int, FP> item in dicGroup)
		{
			if (checkSkill(item.Key, logicTime))
			{
				fP += item.Value;
				dictionary.set_Item(item.Key, fP);
			}
		}
		if (fP > 0)
		{
			FP fP2 = TSRandom.Range(0, fP);
			foreach (KeyValuePair<int, FP> item2 in dictionary)
			{
				if (!(fP2 < item2.Value))
				{
					continue;
				}
				if (item2.Key >= 0)
				{
					CreateSkill(item2.Key, waitTime);
				}
				else if (item2.Key == -1)
				{
					LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
					if (!CommonUtils.CheckTargetIsValid(logicEntity, 0L))
					{
						logicEntity = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
					}
					_actor.MoveTo(logicEntity.tsTransform.Position, 5, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
					{
						if (!_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
						{
							if (_stage == 1)
							{
								CheckStageOne();
							}
							else
							{
								CheckStageTwo();
							}
						}
					});
				}
				else
				{
					tmpRunSpecialGroup = true;
					tmpSpecialGroup = dicSpecialSkillGroup.get_Item(item2.Key);
					tmpSpecialIndex = 0;
					tmpWaitTime = 0;
					stageRandomSkill();
				}
				break;
			}
		}
		return fP;
	}

	protected void CheckStageOne()
	{
		if (_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
		{
			return;
		}
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (!CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			logicEntity = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		}
		FP fP = _actor.DistanceWithRadius(logicEntity);
		TSVector2 forward = _actor.tsTransform.Forward;
		TSVector2 b = logicEntity.tsTransform.Position - _actor.tsTransform.Position;
		FP fP2 = TSVector2.Angle(forward, b);
		if (fP < 5)
		{
			if (fP2 <= 90)
			{
				if (havePlayer() && fP2 > 60 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
				{
					CreateSkill(5050104, stageOneWaitTime);
				}
				else if (RandomSkill(StageOne_DisLessThan6_Front, stageOneWaitTime, 1) == 0)
				{
					_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
					_actor.actorSkillManage.DestoryAllSkill();
					NovaLogger.Debug("鲨鱼 执行徘徊");
					ILRuntimeAPI.CreateSkill(5050113, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
				}
			}
			else if (havePlayer() && fP2 < 120 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
			{
				CreateSkill(5050104, stageOneWaitTime);
			}
			else if (_runSkillCDEnd.get_Item(5050103) < _actor.LogicTime)
			{
				CreateSkill(5050103, stageOneWaitTime);
			}
			else
			{
				_lookAtTarget?.StopLookAt();
				if (_lookAtTarget == null)
				{
					_lookAtTarget = new LookAtTarget();
				}
				_lookAtTarget.BeginLookAt(_actor, logicEntity, 1, 150, () =>
				{
					CheckStageOne();
				});
			}
		}
		else if (fP2 <= 90)
		{
			if (havePlayer() && fP2 > 60 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
			{
				CreateSkill(5050104, stageOneWaitTime);
			}
			else
			{
				RandomSkill(StageOne_DisMoreThan6_Front, stageOneWaitTime, 1);
			}
		}
		else if (havePlayer() && fP2 < 150 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
		{
			CreateSkill(5050104, stageOneWaitTime);
		}
		else
		{
			_lookAtTarget?.StopLookAt();
			if (_lookAtTarget == null)
			{
				_lookAtTarget = new LookAtTarget();
			}
			_lookAtTarget.BeginLookAt(_actor, logicEntity, 1, 150, () =>
			{
				CheckStageOne();
			});
		}
	}

	protected void CheckStageTwo()
	{
		if (_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
		{
			return;
		}
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (!CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			logicEntity = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		}
		FP fP = _actor.DistanceWithRadius(logicEntity);
		TSVector2 forward = _actor.tsTransform.Forward;
		TSVector2 b = logicEntity.tsTransform.Position - _actor.tsTransform.Position;
		FP fP2 = TSVector2.Angle(forward, b);
		if (fP < 5)
		{
			if (fP2 <= 90)
			{
				if (havePlayer() && fP2 > 60 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
				{
					CreateSkill(5050104, stageTwoWaitTime);
				}
				else if (RandomSkill(StageTwo_DisLessThan6_Front, stageTwoWaitTime, 2) <= 0)
				{
					_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
					_actor.actorSkillManage.DestoryAllSkill();
					NovaLogger.Debug("鲨鱼 执行徘徊");
					ILRuntimeAPI.CreateSkill(5050113, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
				}
			}
			else if (havePlayer() && fP2 < 120 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
			{
				CreateSkill(5050104, stageTwoWaitTime);
			}
			else if (checkSkill(5050103, _actor.LogicTime))
			{
				CreateSkill(5050103, stageTwoWaitTime);
			}
			else
			{
				_lookAtTarget?.StopLookAt();
				if (_lookAtTarget == null)
				{
					_lookAtTarget = new LookAtTarget();
				}
				_lookAtTarget.BeginLookAt(_actor, logicEntity, 1, 150, () =>
				{
					CheckStageTwo();
				});
			}
		}
		else if (fP2 <= 90)
		{
			if (_actor.buffComponent.CheckBuffByBuffID(ViolentBuffId))
			{
				if (havePlayer() && fP2 > 60 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
				{
					CreateSkill(5050104, stageTwoWaitTime);
				}
				else if (RandomSkill(StageTwo_DisMoreThan6_Front_Violent, stageTwoWaitTime, 2) <= 0)
				{
					_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
					_actor.actorSkillManage.DestoryAllSkill();
					NovaLogger.Debug("鲨鱼 执行徘徊");
					ILRuntimeAPI.CreateSkill(5050113, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
				}
			}
			else if (havePlayer() && fP2 > 60 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
			{
				CreateSkill(5050104, stageTwoWaitTime);
			}
			else
			{
				RandomSkill(StageTwo_DisMoreThan6_Front_ViolentNone, stageTwoWaitTime, 2);
			}
		}
		else if (havePlayer() && fP2 < 120 && _runSkillCDEnd.get_Item(5050104) < _actor.LogicTime)
		{
			CreateSkill(5050104, stageTwoWaitTime);
		}
		else
		{
			_lookAtTarget?.StopLookAt();
			if (_lookAtTarget == null)
			{
				_lookAtTarget = new LookAtTarget();
			}
			_lookAtTarget.BeginLookAt(_actor, logicEntity, 1, 150, () =>
			{
				CheckStageTwo();
			});
		}
	}

	protected void CreateSkill(int skillId, FP waitTime)
	{
		if (_actor.actorHealthInfo.isAlive)
		{
			StopCoroutine(ref _waitCreateSkill);
			StartCoroutine(ref _waitCreateSkill, waitTimeRunSkill(skillId, waitTime));
		}
	}

	protected IEnumerator waitTimeRunSkill(int skillId, FP waitTime)
	{
		tempSkillId = skillId;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime));
		if (skillId != 5050104)
		{
			LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
			if (_traceTarget == null)
			{
				_traceTarget = new TraceTarget();
			}
			_traceTarget.BeginTrace(_actor, target, skillInfo.get_Item(skillId).get_Item(2), -1, skillInfo.get_Item(skillId).get_Item(3), () =>
			{
				TSVector2 a = target.tsTransform.Position - _actor.tsTransform.Position;
				TSVector2 forward = _actor.tsTransform.Forward;
				if (TSVector2.Angle(a, forward) > skillInfo.get_Item(skillId).get_Item(4) && skillId != 5050103)
				{
					_lookAtTarget?.StopLookAt();
					if (_lookAtTarget == null)
					{
						_lookAtTarget = new LookAtTarget();
					}
					_lookAtTarget.BeginLookAt(_actor, target, 0, 0, () =>
					{
						if (!_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
						{
							_runSkillCDEnd.set_Item(skillId, _actor.LogicTime + skillInfo.get_Item(skillId).get_Item(0));
							NovaLogger.Debug("鲨鱼 执行技能 +++ " + skillId);
							ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, OnFinishCallback);
						}
					});
				}
				else if (!_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
				{
					_runSkillCDEnd.set_Item(skillId, _actor.LogicTime + skillInfo.get_Item(skillId).get_Item(0));
					NovaLogger.Debug("鲨鱼 执行技能 +++ " + skillId);
					ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, OnFinishCallback);
				}
			}, OnTraceCancel);
		}
		else if (!_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
		{
			_runSkillCDEnd.set_Item(skillId, _actor.LogicTime + skillInfo.get_Item(skillId).get_Item(0));
			NovaLogger.Debug("鲨鱼 执行技能 +++ " + skillId);
			ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, OnFinishCallback);
		}
	}

	protected void OnTraceCancel(bool targetDied, bool isInterrupt, bool isTimeout, bool isDistanceOut)
	{
		bool logicTagToggle = _logicVariable.GetLogicTagToggle("5050100ShaShaSpecial");
		if (_actor.actorHealthInfo.isAlive && !logicTagToggle && tempSkillId != 0)
		{
			_runSkillCDEnd.set_Item(tempSkillId, _actor.LogicTime + skillInfo.get_Item(tempSkillId).get_Item(0));
			NovaLogger.Debug("鲨鱼 执行技能 +++ " + tempSkillId);
			ILRuntimeAPI.CreateSkill(tempSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, OnFinishCallback);
		}
	}

	protected void OnFinishCallback(bool success)
	{
		tempSkillId = 0;
		if (_waitShadow)
		{
			_waitShadow = false;
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
			_actor.actorSkillManage.DestoryAllSkill();
			NovaLogger.Debug("鲨鱼 执行大招");
			tmpRunSpecialGroup = false;
			ILRuntimeAPI.CreateSkill(5050108, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
		}
		else
		{
			NovaLogger.Debug("鲨鱼 技能执行完成");
			if (!_logicVariable.GetLogicTagToggle("5050100ShaShaSpecial"))
			{
				stageRandomSkill();
			}
		}
	}

	protected void stageRandomSkill()
	{
		if (_logicVariable.GetLogicTagToggle("5050100ShaShaChangeStage"))
		{
			_currentStage = 2;
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: true);
			_actor.actorSkillManage.DestoryAllSkill();
			tmpRunSpecialGroup = false;
			NovaLogger.Debug("鲨鱼 执行环游");
			ILRuntimeAPI.CreateSkill(5050109, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaChangeStage", value: false);
		}
		else if (tmpRunSpecialGroup)
		{
			CreateSkill(tmpSpecialGroup.get_Item(tmpSpecialIndex), tmpWaitTime);
			tmpSpecialIndex++;
			if (tmpSpecialIndex == tmpSpecialGroup.Count)
			{
				tmpRunSpecialGroup = false;
			}
		}
		else if (_currentStage == 1)
		{
			CheckStageOne();
		}
		else if (!isSpecialSkillListEnd)
		{
			CreateSkill(specialSkillList.get_Item(runSpecialSkillListCount), 0);
			runSpecialSkillListCount++;
			if (runSpecialSkillListCount == specialSkillList.Count)
			{
				isSpecialSkillListEnd = true;
			}
		}
		else
		{
			CheckStageTwo();
		}
	}
}
