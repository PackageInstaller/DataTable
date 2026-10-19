namespace ACT.UI;

public class BookEmptyModel : BookViewBaseModel
{
	public BookEmptyModel(int id, int index, bool unlock)
		: base(id, index)
	{
		Unlock = true;
	}
}
