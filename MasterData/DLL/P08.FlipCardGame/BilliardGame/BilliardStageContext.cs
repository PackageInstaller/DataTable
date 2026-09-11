namespace BilliardGame;

public struct BilliardStageContext
{
	public int StageId;

	public int HeroId1;

	public int HeroId2;

	public int HeroId3;

	public int GetPlayer(int index)
	{
		return index switch
		{
			0 => HeroId1, 
			1 => HeroId2, 
			2 => HeroId3, 
			_ => HeroId1, 
		};
	}
}
