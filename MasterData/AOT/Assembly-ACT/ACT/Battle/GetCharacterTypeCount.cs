namespace ACT.Battle;

public class GetCharacterTypeCount : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return CharacterDataHelper.GetCharacterRepository(0).Characters.Count >= param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		return CharacterDataHelper.GetCharacterRepository(0).Characters.Count;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
