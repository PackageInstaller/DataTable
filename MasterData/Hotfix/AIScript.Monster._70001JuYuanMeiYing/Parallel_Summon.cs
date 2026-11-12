using System.Collections;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Parallel_Summon : Parallel
{
	private readonly FP healInterval = 5;

	private readonly string areaEffect_Heal = "Area_70001_Summon_Heal";

	private readonly FP meteorInterval = 4;

	private readonly FP meteorRadius = 6;

	private readonly string areaEffect_Meteor = "Area_70001_Summon_Meteor";

	private CoroutineNode _corHeal;

	private CoroutineNode _corMeteor;

	public override void OnStart()
	{
		base.OnStart();
		StartCoroutine(ref _corHeal, DoHeal());
		StartCoroutine(ref _corMeteor, DoMeteor());
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref _corHeal);
		StopCoroutine(ref _corMeteor);
	}

	private IEnumerator DoHeal()
	{
		while (true)
		{
			yield return _actor.WaitTime(healInterval);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Heal, _actor.tsTransform.Position);
		}
	}

	private IEnumerator DoMeteor()
	{
		while (true)
		{
			yield return _actor.WaitTime(meteorInterval);
			if (TryGetTargetPosition(out var position))
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Circle,
					position = position,
					innerRadius = 0,
					radius = meteorRadius
				});
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Meteor, randomPointInShape);
			}
		}
	}

	private bool TryGetTargetPosition(out TSVector2 position)
	{
		if (_actor.monsterTarget is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
		{
			position = adventureActor.tsTransform.Position;
			return true;
		}
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor != null && playerAdventureActor.actorHealthInfo.isAlive)
		{
			position = playerAdventureActor.tsTransform.Position;
			return true;
		}
		position = default;
		return false;
	}
}
