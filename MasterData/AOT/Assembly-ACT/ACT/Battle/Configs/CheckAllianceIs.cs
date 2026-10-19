using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断阵营", "Predicate", new string[] { "check", "alliance", "is", "predicate", "condition" })]
public class CheckAllianceIs : ConfigPredicate
{
	public CheckTarget target;

	public Alliance alliance;

	private Entity m_Target;

	public override bool Check(ActionMemory memory)
	{
		m_Target = memory.target.entity;
		switch (target)
		{
		case CheckTarget.Target:
			m_Target = memory.target.entity;
			break;
		case CheckTarget.Owner:
			m_Target = memory.owner;
			break;
		}
		CompAlliance compAlliance = m_Target.GetCompAlliance();
		if (compAlliance == null)
		{
			return false;
		}
		if (m_Target != null)
		{
			return (compAlliance.alliance & alliance) != 0;
		}
		return false;
	}
}
