namespace ACT.UI;

public class BookItemSystemModel : BookViewBaseModel
{
	public BookItemSystemModel(int id, int index, bool unlock)
		: base(id, index)
	{
		Unlock = unlock;
	}
}
