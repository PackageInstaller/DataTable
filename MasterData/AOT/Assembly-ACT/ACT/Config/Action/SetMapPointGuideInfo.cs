using ACT.Model;
using ACT.UI;

namespace ACT.Config.Action;

public class SetMapPointGuideInfo : GuideStepAction
{
	public MapIconType IconType;

	public int iconId;

	public override void Execute(GuideStepData data)
	{
		Model<MapModel>.Interface.SetMapPointGuideInfo((int)IconType, iconId);
	}
}
