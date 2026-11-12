#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50111Xbuffjingling.Summons.CanChaZhu;

public class Action : MonsterActionBase
{
	protected static List<BaseBranchInfo> sequenceBranchesList;

	private Dictionary<int, List<int>> sequenceDict;

	private List<int> addShield = new List<int>();

	private List<int> shooting = new List<int>();

	private List<int> waiting = new List<int>();

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTag();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		addShield.Add(1001);
		shooting.Add(1002);
		waiting.Add(1003);
		sequenceBranchesList = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(1001, 50, 360, 2, null, SetShield),
			new BaseBranchInfo(1002, 50, 360, 2, null, shootSkill),
			new BaseBranchInfo(1003, 50, 360, 2, null, Waiting)
		};
		sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = addShield,
			[2] = waiting,
			[3] = shooting
		};
		InitSequenceBranches(1, sequenceBranchesList, sequenceDict);
	}

	private void SetLogicTag()
	{
		SetLogicTagFpValue(_actor, "ShootCount", 1);
	}

	protected override void OnActionDisable()
	{
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		SetLogicTagFpValue(_actor, "ShootCount", 1);
		addShield.Clear();
		shooting.Clear();
	}

	protected IEnumerator UpdateShootCount()
	{
		NovaLogger.Debug("BUFF精灵.AI.开启协程");
		for (int i = 0; i < 10; i++)
		{
			yield return WaitTime(3);
			DispatchCustomEvent("AddShootCount");
			NovaLogger.Debug("BUFF精灵.AI.协程广播自定义事件");
		}
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && string.Equals(adventureActorCustomEvent.eventName, "AddShootCount"))
		{
			FP logicTagFpValue = GetLogicTagFpValue(_actor, "ShootCount");
			if (logicTagFpValue > 0 && logicTagFpValue < 3)
			{
				SetLogicTagFpValue(_actor, "ShootCount", logicTagFpValue + 1);
			}
			else if (logicTagFpValue >= 3)
			{
				SwitchSequence(3, initialIndex: false);
			}
		}
	}

	private IEnumerator SetShield()
	{
		CastSkill(5011160);
		yield return WaitSkillFinish();
		SwitchSequence(2);
	}

	private IEnumerator shootSkill()
	{
		CastSkill(5011161);
		yield return WaitSkillFinish();
		KillActors(new List<LogicEntity> { _actor });
	}

	private IEnumerator Waiting()
	{
		yield return WaitTime(10);
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		StartCor(UpdateShootCount());
	}
}
