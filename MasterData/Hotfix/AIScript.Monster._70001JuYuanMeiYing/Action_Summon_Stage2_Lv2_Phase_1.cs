using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Action_Summon_Stage2_Lv2_Phase_1 : MonsterActionBase
{
	private static readonly int Skill_Laser = 7000121;

	private static readonly int Skill_Laser2 = 7000122;

	private static readonly int Skill_Boom = 7000123;

	private static readonly int Skill_Boom2 = 7000124;

	private static readonly int Skill_Danmu = 7000125;

	private static readonly int Skill_Danmu2 = 7000126;

	private static readonly int Skill_Wave = 7000127;

	private static readonly int Skill_Smash = 7000128;

	private static readonly int Skill_Ultra = 7000129;

	private string evt_Boom = "evt_Boom";

	private string evt_Danmu = "evt_Danmu";

	private string evt_Laser = "evt_Laser";

	private string evt_Wave = "evt_Wave";

	private string evt_Smash = "evt_Smash";

	private string evt_Ultra = "evt_Ultra";

	private string evt_Interrupt = "evt_Interrupt";

	private string moveTag = "Move";

	private List<FP> moveTime = new List<FP> { 8, 4, 8, 4 };

	private Dictionary<int, List<string>> dicWayPoint = new Dictionary<int, List<string>>
	{
		[7010022] = new List<string> { "Zuo_01_02", "Zuo_01_03", "Zuo_01_04", "Zuo_01_01" },
		[7010023] = new List<string> { "Zuo_02_02", "Zuo_02_03", "Zuo_02_04", "Zuo_02_01" },
		[7010024] = new List<string> { "You_01_02", "You_01_03", "You_01_04", "You_01_01" },
		[7010025] = new List<string> { "You_02_02", "You_02_03", "You_02_04", "You_02_01" }
	};

	private Dictionary<string, List<int>> ContainList = new Dictionary<string, List<int>>
	{
		["evt_Smash"] = new List<int> { 7010022, 7010025 },
		["evt_Wave"] = new List<int> { 7010024, 7010023 },
		["evt_Boom"] = new List<int> { 7010022, 7010023, 7010024, 7010025 },
		["evt_Danmu"] = new List<int> { 7010022, 7010025 },
		["evt_Laser"] = new List<int> { 7010024, 7010023 }
	};

	private Dictionary<int, int> EffectList = new Dictionary<int, int>
	{
		[7010022] = 700010020,
		[7010023] = 700010021,
		[7010024] = 700010021,
		[7010025] = 700010020
	};

	private List<int> CastSkillList = new List<int>();

	private CoroutineNode corMove;

	private CoroutineNode corCastSkill;

	private CoroutineNode corKill;

	private List<TSVector2> worldWayPoint = new List<TSVector2>();

	private int hpLockCount;

	private string BossLv;

	private bool isHoldMove;

	protected override void OnActionEnable()
	{
		if (_actor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.Tag4.Equals(moveTag))
		{
			_actor.logicVariable.ToggleLogicTag("Patrol", value: true);
			worldWayPoint.Clear();
			foreach (string item in dicWayPoint.get_Item(_actor.dataID))
			{
				worldWayPoint.Add(GetPlaceHolderPosition(item));
			}
			StartCoroutine(ref corMove, DoPatrol());
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		hpLockCount = 1;
		_actor.LockHpAbs((int)_actor.actorHealthInfo.hpMax - hpLockCount);
		BossLv = GetMonsterTagValue((_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor, 1);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		StopCoroutine(ref corMove);
		StopCoroutine(ref corCastSkill);
		StopCoroutine(ref corKill);
		CastSkillList.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.CustomEventOnlySelfOrSummoner, active: true, OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (_actor == null || _actor.isDead || _actor.inDying || _actor.isDeclareDead || !(evt is AdventureActorCustomEvent adventureActorCustomEvent) || string.IsNullOrEmpty(adventureActorCustomEvent.eventName))
		{
			return;
		}
		if (adventureActorCustomEvent.eventName.Equals(evt_Boom))
		{
			if (ContainList.get_Item(evt_Boom).Contains(_actor.dataID))
			{
				if (CastSkillList.Contains(Skill_Boom2))
				{
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
				else
				{
					CastSkillList.Add(Skill_Boom2);
					AddBuffToTarget(_actor, EffectList.get_Item(_actor.dataID));
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
			}
			else if (BossLv == "Lv4")
			{
				StartCoroutine(ref corCastSkill, DoCastSkill());
			}
		}
		if (adventureActorCustomEvent.eventName.Equals(evt_Danmu))
		{
			if (ContainList.get_Item(evt_Danmu).Contains(_actor.dataID))
			{
				if (CastSkillList.Contains(Skill_Danmu2))
				{
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
				else
				{
					CastSkillList.Add(Skill_Danmu2);
					AddBuffToTarget(_actor, EffectList.get_Item(_actor.dataID));
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
			}
			else if (BossLv == "Lv4")
			{
				StartCoroutine(ref corCastSkill, DoCastSkill());
			}
		}
		if (adventureActorCustomEvent.eventName.Equals(evt_Laser))
		{
			if (ContainList.get_Item(evt_Laser).Contains(_actor.dataID))
			{
				if (CastSkillList.Contains(Skill_Laser2))
				{
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
				else
				{
					CastSkillList.Add(Skill_Laser2);
					AddBuffToTarget(_actor, EffectList.get_Item(_actor.dataID));
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
			}
			else if (BossLv == "Lv4")
			{
				StartCoroutine(ref corCastSkill, DoCastSkill());
			}
		}
		if (adventureActorCustomEvent.eventName.Equals(evt_Wave))
		{
			if (ContainList.get_Item(evt_Wave).Contains(_actor.dataID))
			{
				if (CastSkillList.Contains(Skill_Wave))
				{
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
				else
				{
					CastSkillList.Add(Skill_Wave);
					AddBuffToTarget(_actor, EffectList.get_Item(_actor.dataID));
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
			}
			else if (BossLv == "Lv4")
			{
				StartCoroutine(ref corCastSkill, DoCastSkill());
			}
		}
		if (adventureActorCustomEvent.eventName.Equals(evt_Smash))
		{
			if (ContainList.get_Item(evt_Smash).Contains(_actor.dataID))
			{
				if (CastSkillList.Contains(Skill_Smash))
				{
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
				else
				{
					CastSkillList.Add(Skill_Smash);
					AddBuffToTarget(_actor, EffectList.get_Item(_actor.dataID));
					StartCoroutine(ref corCastSkill, DoCastSkill());
				}
			}
			else if (BossLv == "Lv4")
			{
				StartCoroutine(ref corCastSkill, DoCastSkill());
			}
		}
		if (adventureActorCustomEvent.eventName.Equals(evt_Ultra))
		{
			CastSkill(Skill_Ultra);
		}
	}

	private IEnumerator DoCastSkill()
	{
		for (int i = 0; i < CastSkillList.Count; i++)
		{
			CastSkill(CastSkillList.get_Item(i));
			yield return WaitSkillFinish();
		}
		yield return null;
	}

	private IEnumerator DoPatrol()
	{
		_ = worldWayPoint.Count;
		int curIndex = 0;
		TSVector2 position = _actor.tsTransform.Position;
		while (true)
		{
			if (curIndex >= worldWayPoint.Count)
			{
				curIndex = 0;
			}
			FP fP = TSVector2.Distance(worldWayPoint.get_Item(curIndex), position);
			_actor.actorInfo.runSpeed = fP / moveTime.get_Item(curIndex);
			_actor.actorInfo.walkSpeed = fP / moveTime.get_Item(curIndex);
			_actor.RefreshMoveSpeed();
			FP radius = _actor.dtCollider.Radius;
			FP val = _actor.actorInfo.runSpeed * _actor.LogicDeltaTime;
			FP stopDis = TSMath.Max(radius, val);
			while (TSVector2.Distance(worldWayPoint.get_Item(curIndex), _actor.tsTransform.Position) > stopDis)
			{
				if (_actor.logicVariable.GetLogicTagToggle("Patrol"))
				{
					_actor.MoveTo(worldWayPoint.get_Item(curIndex), 0.1f);
				}
				yield return null;
			}
			position = _actor.tsTransform.Position;
			curIndex++;
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			if (hpLockCount < _actor.actorHealthInfo.hpMax + 1)
			{
				_actor.UnlockHp();
				_actor.LockHpAbs((int)_actor.actorHealthInfo.hpMax - hpLockCount);
			}
			hpLockCount++;
		}
	}
}
