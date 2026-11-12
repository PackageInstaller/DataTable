using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._155;

public class Parallel : AIBase
{
	private const int channelSkillId = 100015501;

	private const string areaEffect = "AreaEffect";

	private static readonly FP areaInterval = 1;

	private FP _areaTimer;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	public static string activeTag = "XiaChannelActive";

	public void OnUpdate()
	{
		if (!_actor.logicVariable.GetLogicTagToggle(activeTag) || _actor.forceControl)
		{
			return;
		}
		if (_actor.attackTarget == null || _actor.attackTarget.IsDead())
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			aimTarget.Cancel();
		}
		if (!_actor.logicVariable.GetLogicTagToggle("InXiaChannel"))
		{
			ILRuntimeAPI.CreateSkill(100015501, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
		}
		_areaTimer += _actor.LogicDeltaTime;
		if (_areaTimer >= areaInterval)
		{
			_areaTimer = 0;
			if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect", _actor.attackTarget.tsTransform.Position);
			}
		}
	}
}
