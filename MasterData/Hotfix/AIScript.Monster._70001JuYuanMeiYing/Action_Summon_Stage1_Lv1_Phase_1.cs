using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Action_Summon_Stage1_Lv1_Phase_1 : MonsterActionBase
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

	private string moveTag = "Move";

	private List<FP> moveTime = new List<FP> { 8, 2, 2, 2, 2, 8 };

	private Dictionary<int, List<string>> dicWayPoint = new Dictionary<int, List<string>>
	{
		[7010011] = new List<string> { "Zuo_01_02", "Zuo_01_03", "Zuo_01_04", "Zuo_01_05", "Zuo_01_02", "Zuo_01_01" },
		[7010010] = new List<string> { "Zuo_02_02", "Zuo_02_03", "Zuo_02_04", "Zuo_02_05", "Zuo_02_02", "Zuo_02_01" },
		[7010013] = new List<string> { "You_01_02", "You_01_03", "You_01_04", "You_01_05", "You_01_02", "You_01_01" },
		[7010012] = new List<string> { "You_02_02", "You_02_03", "You_02_04", "You_02_05", "You_02_02", "You_02_01" }
	};

	private CoroutineNode corMove;

	private CoroutineNode corKill;

	private int hpLockCount;

	private List<TSVector2> worldWayPoint = new List<TSVector2>();

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
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
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		StopCoroutine(ref corMove);
		StopCoroutine(ref corKill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.CustomEventOnlySelfOrSummoner, active: true, OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (!(_actor == null) && !_actor.isDead && !_actor.inDying && !_actor.isDeclareDead && evt is AdventureActorCustomEvent adventureActorCustomEvent && !string.IsNullOrEmpty(adventureActorCustomEvent.eventName))
		{
			if (adventureActorCustomEvent.eventName.Equals(evt_Boom))
			{
				CastSkill(Skill_Boom);
			}
			else if (adventureActorCustomEvent.eventName.Equals(evt_Danmu))
			{
				CastSkill(Skill_Danmu);
			}
			else if (adventureActorCustomEvent.eventName.Equals(evt_Laser))
			{
				CastSkill(Skill_Laser);
			}
			else if (adventureActorCustomEvent.eventName.Equals(evt_Wave))
			{
				CastSkill(Skill_Wave);
			}
			else if (adventureActorCustomEvent.eventName.Equals(evt_Ultra))
			{
				StopCoroutine(ref corMove);
				_actor.StandBy();
			}
		}
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
