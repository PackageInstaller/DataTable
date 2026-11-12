using AIScript.Utils;

namespace AIScript.Character._15801;

public class ParallelScript_Summoned_MainControl : ParallelScript_Summoned
{
	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent && adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor monsterAdventureActor && HavePersonalPerk(515804, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, Config_MainControl.damageTag_AddBuff_P4))
		{
			monsterAdventureActor.buffComponent.AddBuff(15804011, _summoner);
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnSelfBeforeHit(beforeHitEvent);
		if (HavePersonalPerk(515807, out var _) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			int num = _summoner.logicVariable.GetLogicTagValue("ToySummonedCount").AsInt();
			if (_summoner.status == ActorStatus.Special)
			{
				num++;
			}
			if (num > 0)
			{
				int num2 = CommonUtils.GetScriptValue(_actor, 15807011).AsInt();
				AdventureActor.AddFromAttr(15807001, _summoner, (num > num2) ? num2 : num);
			}
		}
	}

	protected void AddMorale(int count)
	{
		if (!(_summoner == null) && count > 0 && _actor.state != ActorState.Death)
		{
			_summoner.buffComponent.AddBuffNum(15800002, count, _summoner);
		}
	}

	protected void RemoveMorale(int count)
	{
		if (!(_summoner == null) && count > 0 && _actor.state != ActorState.Death)
		{
			_summoner.buffComponent.RemoveBuffByBuffId(15800002, count);
		}
	}

	protected virtual bool HaveMoraleLogic()
	{
		return false;
	}

	protected virtual int GetMoraleBuffId()
	{
		return 0;
	}

	protected override void OnSummonerGetBuff(AdventureActorGetBuff getBuffEvent)
	{
		base.OnSummonerGetBuff(getBuffEvent);
		if (getBuffEvent.eventInfo.buffId == 15800002 && HaveMoraleLogic())
		{
			_actor.buffComponent.AddBuff(GetMoraleBuffId(), _actor);
			OnMoraleChange(isAdd: true);
		}
	}

	protected override void OnSummonerRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
		base.OnSummonerRemoveBuff(removeBuffEvent);
		if (removeBuffEvent.eventInfo.buffId == 15800002 && HaveMoraleLogic())
		{
			_actor.buffComponent.RemoveBuffByBuffId(GetMoraleBuffId(), 1);
			OnMoraleChange();
		}
	}

	protected virtual void OnMoraleChange(bool isAdd = false)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
	}
}
