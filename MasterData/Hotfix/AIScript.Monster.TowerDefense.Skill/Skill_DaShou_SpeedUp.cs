using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_DaShou_SpeedUp : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Roll", flushInputedKeys: true, forceInterruptAttack: true);
		while (true)
		{
			AddBuffToTarget(_actor, 807010110);
			yield return WaitTime(0.5);
		}
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 807010110);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
