using TrueSync;
using UnityEngine;

public class TriggerMonsterAttr : TriggerConditionBase
{
	public enum monsterType
	{
		[InspectorName("指定关系")]
		selectType,
		[InspectorName("指定ID")]
		selectId
	}

	public enum relatiobShip
	{
		[InspectorName("敌对")]
		ennemyType,
		[InspectorName("友好")]
		frendelyType
	}

	public int monsterID;

	public FP _compareHp;

	private FDP _compareHpFDP;

	public override void ToActive()
	{
		base.ToActive();
		_compareHpFDP = (FDP)_compareHp / (FDP)100L;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnActorHpChanged);
	}

	public override void DisableTrigger()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnActorHpChanged);
	}

	protected void OnActorHpChanged(IEvent ievent)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = (AdventureActorReceiveDamageBeforeHitEvent)ievent;
		if (adventureActorReceiveDamageBeforeHitEvent.to == null)
		{
			Debug.Log("trigger1noTarget");
			return;
		}
		if (!(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor))
		{
			Debug.Log("trigger1notMonster");
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor.dataID != monsterID)
		{
			Debug.Log("trigger1notTargetMonster" + monsterAdventureActor.dataID);
			return;
		}
		if (monsterAdventureActor.actorHealthInfo.hpPercentage >= _compareHpFDP)
		{
			Debug.Log("trigger1notEnoughHP");
			return;
		}
		Debug.Log("trigger1Success");
		OnTrigger();
	}
}
