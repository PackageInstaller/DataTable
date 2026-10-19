namespace ACT.Config.Condition;

public class CheckIsHaveCharacter : GuideStepCondition
{
	public int CharacterID;

	public override bool CheckCondition()
	{
		return CharacterDataHelper.CheckIsHaveCharacterById(CharacterID);
	}
}
