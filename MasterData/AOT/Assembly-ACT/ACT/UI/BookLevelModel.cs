namespace ACT.UI;

public class BookLevelModel
{
	public int Id { get; }

	public bool Unlock { get; set; }

	public int RewardId { get; set; }

	public BookLevelModel(int id, bool unlock, int rewardId)
	{
		Id = id;
		Unlock = unlock;
		RewardId = rewardId;
	}
}
