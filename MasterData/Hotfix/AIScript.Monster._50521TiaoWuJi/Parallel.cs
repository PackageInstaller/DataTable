using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Parallel : AIBase
{
	public static readonly TSVector2[,] Area_Points = new TSVector2[4, 4]
	{
		{
			new TSVector2(-7.5, 7.5),
			new TSVector2(-2.5, 7.5),
			new TSVector2(2.5, 7.5),
			new TSVector2(7.5, 7.5)
		},
		{
			new TSVector2(-7.5, 2.5),
			new TSVector2(-2.5, 2.5),
			new TSVector2(2.5, 2.5),
			new TSVector2(7.5, 2.5)
		},
		{
			new TSVector2(-7.5, -2.5),
			new TSVector2(-2.5, -2.5),
			new TSVector2(2.5, -2.5),
			new TSVector2(7.5, -2.5)
		},
		{
			new TSVector2(-7.5, -7.5),
			new TSVector2(-2.5, -7.5),
			new TSVector2(2.5, -7.5),
			new TSVector2(7.5, -7.5)
		}
	};

	private readonly List<List<string>> Area_GroupList = new List<List<string>>
	{
		new List<string> { "Area_Skill01_Normal_Green", "Area_Skill01_Normal_Yellow", "Area_Skill01_Normal_Red", "Area_Skill01_Normal_Purple" },
		new List<string> { "Area_Skill02_Normal_Green", "Area_Skill02_Normal_Yellow", "Area_Skill02_Normal_Red", "Area_Skill02_Normal_Purple" },
		new List<string> { "Area_Skill03_Normal_Green_A", "Area_Skill03_Normal_Yellow", "Area_Skill03_Normal_Red", "Area_Skill03_Normal_Purple" },
		new List<string> { "Area_Skill03_Normal_Green_B", "Area_Skill03_Normal_Yellow", "Area_Skill03_Normal_Red", "Area_Skill03_Normal_Purple" },
		new List<string> { "Area_Skill03_Normal_Green_C", "Area_Skill03_Normal_Yellow", "Area_Skill03_Normal_Red", "Area_Skill03_Normal_Purple" },
		new List<string> { "Area_Skill03_Normal_Green_D", "Area_Skill03_Normal_Yellow", "Area_Skill03_Normal_Red", "Area_Skill03_Normal_Purple" },
		new List<string> { "Area_Skill03_Normal_MUM_Green", "Area_Skill03_Normal_MUM_Yellow", "Area_Skill03_Normal_MUM_Red", "Area_Skill03_Normal_MUM_Purple" },
		new List<string> { "Area_Skill03_Normal_8_Red", "Area_Skill03_Normal_Purple", "Area_Empty", "Area_Empty" },
		new List<string> { "Area_Skill03_Normal_StartMoving_Green", "Area_Empty", "Area_Empty", "Area_Empty" },
		new List<string> { "Area_Skill03_Normal_StopMoving_Yellow", "Area_Skill03_Normal_Red", "Area_Skill03_Normal_Purple", "Area_Empty" }
	};

	private readonly List<List<FP>> wait_Time = new List<List<FP>>
	{
		new List<FP> { 0.25, 0.25, 0.25 },
		new List<FP> { 0.5, 0.5, 0.5 },
		new List<FP> { 1, 1, 1 }
	};

	private readonly Dictionary<List<int[,]>, List<FP>> dicType = new Dictionary<List<int[,]>, List<FP>>
	{
		{
			new List<int[,]>
			{
				new int[0, 0],
				new int[0, 1],
				new int[0, 2],
				new int[0, 3],
				new int[3, 0],
				new int[3, 1],
				new int[3, 2],
				new int[3, 3]
			},
			new List<FP> { 2.0, 3, 2 }
		},
		{
			new List<int[,]>
			{
				new int[1, 0],
				new int[1, 1],
				new int[1, 2],
				new int[1, 3],
				new int[2, 0],
				new int[2, 1],
				new int[2, 2],
				new int[2, 3]
			},
			new List<FP> { 2.0, 7, 2 }
		},
		{
			new List<int[,]>
			{
				new int[0, 0],
				new int[0, 1],
				new int[0, 2],
				new int[0, 3],
				new int[1, 0],
				new int[2, 0],
				new int[3, 0],
				new int[3, 1],
				new int[3, 2],
				new int[3, 3],
				new int[2, 3],
				new int[1, 3]
			},
			new List<FP> { 2.0, 4, 2 }
		},
		{
			new List<int[,]>
			{
				new int[1, 1],
				new int[1, 2],
				new int[2, 1],
				new int[2, 2]
			},
			new List<FP> { 2.0, 7, 2 }
		},
		{
			new List<int[,]>
			{
				new int[0, 1],
				new int[0, 2],
				new int[1, 0],
				new int[2, 0],
				new int[3, 1],
				new int[3, 2],
				new int[1, 3],
				new int[2, 3]
			},
			new List<FP> { 2.0, 5, 2 }
		},
		{
			new List<int[,]>
			{
				new int[0, 0],
				new int[1, 1],
				new int[2, 2],
				new int[3, 3],
				new int[0, 3],
				new int[1, 2],
				new int[2, 1],
				new int[3, 0]
			},
			new List<FP> { 2.0, 7, 2 }
		},
		{
			new List<int[,]>
			{
				new int[0, 2],
				new int[1, 3],
				new int[1, 1],
				new int[2, 2],
				new int[2, 0],
				new int[3, 1]
			},
			new List<FP> { 2.0, 6, 2 }
		},
		{
			new List<int[,]>
			{
				new int[0, 1],
				new int[1, 2],
				new int[2, 3],
				new int[1, 0],
				new int[2, 1],
				new int[3, 2]
			},
			new List<FP> { 2.0, 7, 2 }
		}
	};

	private readonly List<TSVector2> soloDashPoint = new List<TSVector2>
	{
		new TSVector2(-3.5, 2.5),
		new TSVector2(-2.5, -2.5),
		new TSVector2(1.6, -6.2),
		new TSVector2(1.8, -0.6)
	};

	private readonly FP soloDashSpeed = 6;

	private readonly FP soloAngleLimit = 360;

	private CoroutineNode corPlayArea;

	private List<CoroutineNode> corPlayAreaList = new List<CoroutineNode>();

	private LogicVariable _logicVariable;

	private CoroutineNode corDicType;

	private int soloDashCount;

	private Dash _dash;

	private bool isSoloLook;

	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.TiaoWuJi_001;

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.TiaoWuJi_002;

	private const string logicTag_Tetris_2 = "IsTetris";

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.TiaoWuJi_003;

	private const int needTriggerCount_3 = 10;

	private bool _achievementTypeFinish_1;

	private bool _canFinishAchievementType_1;

	private bool _achievementTypeFinish_2;

	private bool _achievementTypeFinish_3;

	private int _triggerCount_3;

	public void OnEnable()
	{
		soloDashCount = 0;
		isSoloLook = false;
		_logicVariable = ActorHelper.GetFlowLogicVariable(_actor.gameObject);
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfect);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	public void OnUpdate()
	{
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Solo"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Solo", value: false);
			ClearCor();
			int num = (int)(long)_logicVariable.GetLogicTagValue("50521TiaoWuJi_speedType");
			int num2 = (int)(long)_logicVariable.GetLogicTagValue("50521TiaoWuJi_areaGroup");
			TSVector2 pos = FindNearestPoint();
			DoNormalSpeedOne(pos, wait_Time.get_Item(num - 1), Area_GroupList.get_Item(num2 - 1));
		}
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Solo_TurnStart"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Solo_TurnStart", value: false);
			isSoloLook = true;
		}
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Solo_TurnEnd"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Solo_TurnEnd", value: false);
			isSoloLook = false;
		}
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Solo_ChargeStart"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Solo_ChargeStart", value: false);
			SoloDash();
		}
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Solo_ChargeEnd"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Solo_ChargeEnd", value: false);
			DashFinishCallback();
		}
		if (isSoloLook)
		{
			TSVector2 normalized = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).normalized;
			_actor.LookAtDir(normalized, 0);
		}
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Dute"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Dute", value: false);
			ClearCor();
			int speedType = (int)(long)_logicVariable.GetLogicTagValue("50521TiaoWuJi_speedType");
			int num3 = (int)(long)_logicVariable.GetLogicTagValue("50521TiaoWuJi_areaGroup");
			FP logicTagValue = _logicVariable.GetLogicTagValue("50521TiaoWuJi_Dute_Type");
			if (logicTagValue == 1)
			{
				FromStype_1(speedType, Area_GroupList.get_Item(num3 - 1));
			}
			else if (logicTagValue == 2)
			{
				FromStype_2(speedType, Area_GroupList.get_Item(num3 - 1));
			}
			else
			{
				FromStype_3(speedType, Area_GroupList.get_Item(num3 - 1));
			}
		}
		if (_logicVariable.GetLogicTagToggle("50521TiaoWuJi_Tutti"))
		{
			_actor.logicVariable.ToggleLogicTag("50521TiaoWuJi_Tutti", value: false);
			ClearCor();
			corDicType = _actor.StartLogicCoroutine(DoCorDicType());
		}
	}

	private void DoNormalSpeedOne(TSVector2 pos, List<FP> times, List<string> group)
	{
		StartCoroutine(ref corPlayArea, PlayArae(pos, times, group));
	}

	private void DoNormalSpeedList(List<int[,]> points, List<FP> times, List<string> group)
	{
		for (int i = 0; i < points.Count; i++)
		{
			CoroutineNode item = _actor.StartLogicCoroutine(PlayArae(Area_Points[points.get_Item(i).GetLength(0), points.get_Item(i).GetLength(1)], times, group));
			corPlayAreaList.Add(item);
		}
	}

	private TSVector2 FindNearestPoint()
	{
		TSVector2 result = new TSVector2(0, 0);
		FP fP = 9999;
		TSVector2 position = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position;
		for (int i = 0; i < Area_Points.GetLength(0); i++)
		{
			for (int j = 0; j < Area_Points.GetLength(1); j++)
			{
				FP fP2 = TSVector2.Distance(position, Area_Points[i, j]);
				if (fP2 < fP)
				{
					fP = fP2;
					result = Area_Points[i, j];
				}
			}
		}
		return result;
	}

	private int[,] FindNearestCoordinate()
	{
		int[,] result = new int[0, 0];
		FP fP = 9999;
		TSVector2 position = _actor.tsTransform.Position;
		for (int i = 0; i < Area_Points.GetLength(0); i++)
		{
			for (int j = 0; j < Area_Points.GetLength(1); j++)
			{
				FP fP2 = TSVector2.Distance(position, Area_Points[i, j]);
				if (fP2 < fP)
				{
					fP = fP2;
					result = new int[i, j];
				}
			}
		}
		return result;
	}

	private IEnumerator PlayArae(TSVector2 pos, List<FP> times, List<string> group)
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, group.get_Item(0), pos, _actor.tsTransform.Rotation);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(times.get_Item(0)));
		ILRuntimeAPI.PlayAreaEffect(_actor, group.get_Item(1), pos, _actor.tsTransform.Rotation);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(times.get_Item(1)));
		ILRuntimeAPI.PlayAreaEffect(_actor, group.get_Item(2), pos, _actor.tsTransform.Rotation);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(times.get_Item(2)));
		ILRuntimeAPI.PlayAreaEffect(_actor, group.get_Item(3), pos, _actor.tsTransform.Rotation);
	}

	private void FromStype_1(int speedType, List<string> group)
	{
		int[,] array = FindNearestCoordinate();
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		int length3 = Area_Points.GetLength(0);
		int length4 = Area_Points.GetLength(1);
		List<int[,]> list = new List<int[,]>();
		for (int i = length - 1; i <= length + 1; i++)
		{
			for (int j = length2 - 1; j <= length2 + 1; j++)
			{
				int num = i;
				int num2 = j;
				if (num >= 0 && num < length3 && num2 >= 0 && num2 < length4)
				{
					int[,] item = new int[num, num2];
					list.Add(item);
				}
			}
		}
		DoNormalSpeedList(list, wait_Time.get_Item(speedType - 1), group);
	}

	private void FromStype_2(int speedType, List<string> group)
	{
		int[,] array = FindNearestCoordinate();
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		int length3 = Area_Points.GetLength(0);
		int length4 = Area_Points.GetLength(1);
		List<int[,]> list = new List<int[,]> { new int[length, length2] };
		for (int i = 0; i < length3; i++)
		{
			if (i != length)
			{
				int[,] item = new int[i, length2];
				list.Add(item);
			}
		}
		for (int j = 0; j < length4; j++)
		{
			if (j != length2)
			{
				int[,] item2 = new int[length, j];
				list.Add(item2);
			}
		}
		DoNormalSpeedList(list, wait_Time.get_Item(speedType - 1), group);
	}

	private void FromStype_3(int speedType, List<string> group)
	{
		int[,] array = FindNearestCoordinate();
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		int length3 = Area_Points.GetLength(0);
		int length4 = Area_Points.GetLength(1);
		List<int[,]> list = new List<int[,]> { new int[length, length2] };
		for (int i = 1; i < length3; i++)
		{
			int num = length - i;
			if (num >= 0 && num < length3)
			{
				int num2 = length2 - i;
				if (num2 >= 0 && num2 < length4)
				{
					list.Add(new int[num, num2]);
				}
				int num3 = length2 + i;
				if (num3 >= 0 && num3 < length4)
				{
					list.Add(new int[num, num3]);
				}
			}
			int num4 = length + i;
			if (num4 >= 0 && num4 < length3)
			{
				int num5 = length2 - i;
				if (num5 >= 0 && num5 < length4)
				{
					list.Add(new int[num4, num5]);
				}
				int num6 = length2 + i;
				if (num6 >= 0 && num6 < length4)
				{
					list.Add(new int[num4, num6]);
				}
			}
		}
		DoNormalSpeedList(list, wait_Time.get_Item(speedType - 1), group);
	}

	private IEnumerator DoCorDicType()
	{
		foreach (KeyValuePair<List<int[,]>, List<FP>> item in dicType)
		{
			int num = (int)(long)item.Value.get_Item(1);
			int num2 = (int)(long)item.Value.get_Item(2);
			DoNormalSpeedList(item.Key, wait_Time.get_Item(num2 - 1), Area_GroupList.get_Item(num - 1));
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(item.Value.get_Item(0)));
		}
	}

	private void SoloDash()
	{
		TSVector2 tSVector = soloDashPoint.get_Item(soloDashCount);
		TSVector2 normalized = (tSVector - _actor.tsTransform.Position).normalized;
		FP distance = TSVector2.Distance(tSVector, _actor.tsTransform.Position);
		if (_dash == null)
		{
			_dash = new Dash();
		}
		_dash.BeginDash(_actor, normalized, soloDashSpeed, distance, soloAngleLimit, DashFinishCallback, null, null, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		soloDashCount++;
		if (soloDashCount == soloDashPoint.Count)
		{
			soloDashCount = 0;
		}
	}

	private void DashFinishCallback()
	{
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
	}

	private void ClearCor()
	{
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
		StopCoroutine(ref corPlayArea);
		for (int i = 0; i < corPlayAreaList.Count; i++)
		{
			StopCoroutine(corPlayAreaList.get_Item(i));
		}
		corPlayAreaList.Clear();
		if (corDicType != null)
		{
			_actor.StopLogicCoroutine(corDicType);
			corDicType = null;
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfect);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ClearCor();
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.TiaoWuJi_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.TiaoWuJi_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.TiaoWuJi_003);
		_canFinishAchievementType_1 = true;
		_triggerCount_3 = 0;
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from is MonsterAdventureActor && adventureActorReceiveDamageEvent.to is PlayerAdventureActor && !_achievementTypeFinish_1 && _canFinishAchievementType_1)
		{
			_canFinishAchievementType_1 = adventureActorReceiveDamageEvent.damageToShieldAndHp <= 0;
		}
	}

	private void OnTriggerPerfect(IEvent evt)
	{
		if (!_achievementTypeFinish_3)
		{
			_triggerCount_3++;
			if (_triggerCount_3 >= 10)
			{
				_achievementTypeFinish_3 = SetAchievementState(HotfixEnum.questCompleteCondClient.TiaoWuJi_003);
			}
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor == _actor)
		{
			if (!_achievementTypeFinish_1 && _canFinishAchievementType_1)
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.TiaoWuJi_001);
			}
			if (!_achievementTypeFinish_2 && _actor.logicVariable.GetLogicTagToggle("IsTetris"))
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.TiaoWuJi_002);
			}
		}
	}

	private bool SetAchievementState(HotfixEnum.questCompleteCondClient achievementType)
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType))
		{
			return true;
		}
		ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(achievementType);
		return ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType);
	}
}
