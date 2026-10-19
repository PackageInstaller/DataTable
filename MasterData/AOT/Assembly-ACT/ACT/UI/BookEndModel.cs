namespace ACT.UI;

public class BookEndModel : BookViewBaseModel
{
	public BookEndModel(int id, int index, bool unlock)
		: base(id, index)
	{
		Unlock = true;
	}
}
