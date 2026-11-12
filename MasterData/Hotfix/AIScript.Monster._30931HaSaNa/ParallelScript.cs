using AIScript.Monster.Template;
using AdventureBehaviour;

namespace AIScript.Monster._30931HaSaNa;

public class ParallelScript : Parallel
{
	public override void OnStart()
	{
		base.OnStart();
		_actor.ActiveDefaultModelGroup();
		_actor.actorScaleInfo.colliderScale = _actor.actorScaleInfo.originColliderScale;
		_actor.ResumeAnimationGroup();
		OcclusionRendererOccluder[] componentsInChildren = _actor.GetComponentsInChildren<OcclusionRendererOccluder>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.SetActive(value: false);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnActorAttacked);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnActorAttacked);
	}

	private void OnActorAttacked(IEvent e)
	{
		if ((e as AdventureActorReceiveAttackEvent).hitDamageId == 30931181 && !_actor.IsSearchedImmunity())
		{
			new PlayFX().Play(_actor, null, "ToughnessRestore", default, _actor.tsTransform.Position, default);
		}
	}
}
