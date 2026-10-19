using ACT.Model;

namespace ACT.Config.Action;

public class SetCharacterTargetLevel : GuideStepAction
{
	public int CharacterTargetLevel;

	public override void Execute(GuideStepData data)
	{
		Model<GuideModel>.Interface.SetCharacterTargetLevel(CharacterTargetLevel);
	}
}
