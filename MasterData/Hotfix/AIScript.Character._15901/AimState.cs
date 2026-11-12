using TrueSync;

namespace AIScript.Character._15901;

public class AimState : IState
{
	private FP exitTime = 0.5f;

	private FP timer;

	public override void Enter()
	{
		base.Enter();
		timer = 0;
		_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor, default, playStartAnim: true, () =>
		{
			Exit();
		}, () =>
		{
			Exit();
		});
	}

	public override void Update()
	{
		base.Update();
		timer += _actor.LogicDeltaTime;
		if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
		{
			Exit();
		}
		if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && timer > exitTime)
		{
			if (_actor.attackTarget == null)
			{
				_aimTarget.Cancel();
			}
			Exit();
		}
	}
}
