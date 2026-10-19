namespace ACT.UI;

public class BookItemLevelModel : BookViewBaseModel
{
	public BookItemLevelModel(int id, int index, bool unlock)
		: base(id, index)
	{
		Unlock = unlock;
	}
}
