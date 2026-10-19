namespace ACT.UI;

public class BookItemMissionModel : BookViewBaseModel
{
	public bool InProgress { get; }

	public BookItemMissionModel(int id, int index, bool unlock, bool inProgress)
		: base(id, index)
	{
		InProgress = inProgress;
		Unlock = unlock;
	}
}
