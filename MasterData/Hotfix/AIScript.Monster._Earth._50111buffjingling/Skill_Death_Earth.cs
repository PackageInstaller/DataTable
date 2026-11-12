namespace AIScript.Monster._Earth._50111buffjingling;

public class Skill_Death_Earth : SkillSimpleBase
{
	private static int BuffID = 501110020;

	protected override void OnSkillEnable()
	{
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
		{
			RemoveBuffFromTarget(item, BuffID);
		}
	}
}
