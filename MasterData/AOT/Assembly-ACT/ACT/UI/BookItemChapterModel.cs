namespace ACT.UI;

public class BookItemChapterModel : BookViewBaseModel
{
	public BookItemChapterModel(int id, int index, bool isLocked)
		: base(id, index)
	{
		Unlock = isLocked;
	}
}
