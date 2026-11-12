using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10017XiChenQi;

public class Skill_MoveToPoint : SkillAdvancedBase
{
	protected FP positionX = 0;

	protected FP positionY = 0;

	protected FP radius = 2;

	protected LookAtTarget _lookAtTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		TSVector2 center = new TSVector2(positionX, positionY);
		center = TrueSyncExtensions.RandomPointInsideRing(center, 0, radius);
		_actor.MoveTo(center, 0.1, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
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
		base.OnSkillDisable();
		_lookAtTarget?.Clear();
		_lookAtTarget = null;
	}
}
