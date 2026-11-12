using AdventureBehaviour;
using TrueSync;

namespace AIScript.PassiveSkill;

public class PerkSkill_5110602 : SkillAdvancedBase
{
	private readonly string _bulletPath = "Actor/Common/Weapons/Perks/PerkSkill_bullet_5110602";

	protected override void OnSkillEnable()
	{
		string bulletPath = _bulletPath;
		AdventureActor actor = _actor;
		FP range = 5;
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 position2 = _actor.tsTransform.Position;
		ILRuntimeAPI.Shoot(bulletPath, actor, range, position, default, position2);
		_skill.Clear();
	}
}
