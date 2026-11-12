using AdventureBehaviour;
using TrueSync;

namespace AIScript.PassiveSkill;

public class PerkSkill_5110203 : SkillAdvancedBase
{
	private readonly string _bulletPath = "Actor/Common/Weapons/Perks/PerkSkill_bullet_5110203";

	protected override void OnSkillEnable()
	{
		if (_actor.attackTarget != null && ((AdventureActor)_actor.attackTarget).actorHealthInfo.isAlive)
		{
			TSVector2 position = _actor.tsTransform.Position + new TSVector2(0, 0.1);
			string bulletPath = _bulletPath;
			AdventureActor actor = _actor;
			FP range = 5;
			TSVector2 position2 = ((AdventureActor)_actor.attackTarget).tsTransform.Position;
			ILRuntimeAPI.Shoot(bulletPath, actor, range, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget);
		}
		_skill.Clear();
	}
}
