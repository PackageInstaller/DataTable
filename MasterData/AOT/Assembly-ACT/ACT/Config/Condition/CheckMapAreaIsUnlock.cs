using ACT.UI;
using ACT.World;

namespace ACT.Config.Condition;

public class CheckMapAreaIsUnlock : GuideStepCondition
{
	public int mapAreaId;

	public override bool CheckCondition()
	{
		if (MapUtility.AreaUnlock((ACT.World.MapArea)mapAreaId))
		{
			return true;
		}
		return false;
	}
}
