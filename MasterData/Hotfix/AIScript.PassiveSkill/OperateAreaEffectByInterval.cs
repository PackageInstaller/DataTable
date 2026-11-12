using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.PassiveSkill;

public class OperateAreaEffectByInterval : PassiveSkillBase
{
	private FP interval = 2;

	private string areaEffectAlias = "AreaEffect_VampireMonster";

	private CoroutineNode countdownCoroutineNode;

	private long areaEffectId;

	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		areaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		StopCoroutine(ref countdownCoroutineNode);
		ILRuntimeAPI.StopAreaEffect(areaEffectId);
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.to != _actor))
		{
			ILRuntimeAPI.StopAreaEffect(areaEffectId);
			areaEffectId = 0L;
			StartCoroutine(ref countdownCoroutineNode, Countdown());
		}
	}

	private IEnumerator Countdown()
	{
		yield return _actor.WaitTime(interval);
		areaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
	}
}
