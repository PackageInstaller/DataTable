using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._Common._50111buffjingling;

public class Skill_RoundFriend : SkillAdvancedBase
{
	protected FP fanAngle = 120;

	protected FP innerRange = 6;

	protected FP fanRange = 8;

	protected FP fanRotation = 180;

	protected FP maxTime = 3;

	protected AdventureActor _target;

	protected DeterministicShape _shape;

	protected LookAtTarget _lookAtTarget;

	protected CoroutineNode _waitCoroutine;

	public void OnStart()
	{
		List<LogicEntity> list = new List<LogicEntity>();
		_actor.InitSearchEntityContext(list, onlyAlive: true, includeSelf: false);
		List<MonsterAdventureActor> list2 = new List<MonsterAdventureActor>();
		foreach (LogicEntity item in list)
		{
			MonsterAdventureActor component = item.gameObject.GetComponent<MonsterAdventureActor>();
			if (!(component == null) && component.monsterInfo.subType == HotfixEnum.monsterSubType.Monster)
			{
				list2.Add(component);
			}
		}
		if (list2.Count == 0)
		{
			_skill?.Clear();
			return;
		}
		FP fP = 99999;
		foreach (MonsterAdventureActor item2 in list2)
		{
			FP fP2 = _actor.DistanceWithRadius(item2);
			if (fP2 < fP)
			{
				_target = item2;
				fP = fP2;
			}
		}
		toRandomPoint();
		StopCoroutine(ref _waitCoroutine);
		StartCoroutine(ref _waitCoroutine, waitCoroutine());
	}

	protected void toRandomPoint()
	{
		_shape.shapeType = DeterministicShape.ShapeType.Fan;
		_shape.angle = fanAngle;
		_shape.radius = fanRange;
		_shape.innerRadius = innerRange;
		_shape.position = _target.tsTransform.Position;
		_shape.rotation = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - _target.tsTransform.Position).GetAngle() + fanRotation;
		TSVector2 tSVector = _actor.RandomActorReachablePointInsideShape(_shape);
		if (!(tSVector != _shape.position))
		{
			return;
		}
		_actor.MoveTo(tSVector, 0.1, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				if (_lookAtTarget == null)
				{
					_lookAtTarget = new LookAtTarget();
				}
				_lookAtTarget.BeginLookAtByPos(_actor, activedPlayerActor.tsTransform.Position, 0, 0, () =>
				{
					_skill.Clear();
				});
			}
		});
	}

	protected override void OnSkillDisable()
	{
		_lookAtTarget?.Clear();
		StopCoroutine(ref _waitCoroutine);
		_target = null;
	}

	protected IEnumerator waitCoroutine()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(maxTime));
		_skill.Clear();
	}
}
