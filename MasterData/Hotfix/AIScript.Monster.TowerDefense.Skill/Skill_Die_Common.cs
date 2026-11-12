using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_Die_Common : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		if (_actor.tsTransform.PositionY >= 0)
		{
			_actor.PlayDeathAnim();
		}
		PlayEffect("fx_td_base_monster_die");
		yield return WaitTime(1);
	}
}
