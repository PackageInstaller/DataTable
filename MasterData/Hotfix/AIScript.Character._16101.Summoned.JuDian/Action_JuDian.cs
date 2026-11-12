using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101.Summoned.JuDian;

public class Action_JuDian : AIScript.Monster.Template.Action
{
	private FP searchRange = 15;

	private const int skillId = 16133002;

	private const string areaEffect_JuDian_Attack = "AreaEffect_16101_JuDian";

	private const int perkId_3 = 516103;

	private const int maxCount_3 = 3;

	private const int buffId_01 = 16103011;

	private static readonly FP delayRemove_3 = 0.1;

	private const int perkId_4 = 516104;

	private const int buffId_04 = 16104012;

	private CoroutineNode _corRemoveBuff_3;

	public override LogicEntity SearchTarget()
	{
		LogicEntity logicEntity = (SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor)?.attackTarget;
		if (logicEntity != null)
		{
			return logicEntity;
		}
		List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, searchRange, null, isConfront: true, onlyAlive: true, includeSelf: false, (LogicEntity x) => !x.IsSearchedImmunity());
		if (list != null && list.Count > 0)
		{
			_actor.SearchEntitySortByDistance(list);
			return list.get_Item(0);
		}
		return null;
	}

	public new void OnSpecialEnable()
	{
		base.OnSpecialEnable();
		if (GetPerk(516104))
		{
			_actor.buffComponent.AddBuff(16104012, _actor);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	public new void OnSpecialDisable()
	{
		if (_corRemoveBuff_3 != null)
		{
			_actor.StopLogicCoroutine(_corRemoveBuff_3);
			_corRemoveBuff_3 = null;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		base.OnSpecialDisable();
	}

	private void OnCastSkill(IEvent _evt)
	{
		if (!(_evt is AdventureActorCastSkillEvent { skillEventInfo: not null } adventureActorCastSkillEvent) || adventureActorCastSkillEvent.sender as AdventureActor != _actor || adventureActorCastSkillEvent.skillEventInfo.skillId != 16133002 || !GetPerk(516103))
		{
			return;
		}
		_actor.buffComponent.AddBuff(16103011, _actor);
		if (_actor.buffComponent.GetBuffNumByID(16103011) >= 3)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16101_JuDian", _actor.tsTransform.Position);
			if (_corRemoveBuff_3 != null)
			{
				_actor.StopLogicCoroutine(_corRemoveBuff_3);
			}
			_corRemoveBuff_3 = _actor.StartLogicCoroutine(DelayRemoveBuff01());
		}
	}

	private IEnumerator DelayRemoveBuff01()
	{
		yield return _actor.WaitTime(delayRemove_3);
		_actor.buffComponent.RemoveBuffByBuffId(16103011);
		_corRemoveBuff_3 = null;
	}
}
