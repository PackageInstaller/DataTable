using System.Collections;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		_actor.PauseMovementAvoidance();
		_actor.PauseMovementBlock();
		yield break;
	}
}
