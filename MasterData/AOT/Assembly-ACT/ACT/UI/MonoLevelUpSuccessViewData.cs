using System.Collections.Generic;

namespace ACT.UI;

public class MonoLevelUpSuccessViewData : UIViewData
{
	public int fromLevel;

	public int toLevel;

	public List<(int, float, float)> propertyData;

	public int fromSkillPoint;

	public int toSkillPoint;
}
