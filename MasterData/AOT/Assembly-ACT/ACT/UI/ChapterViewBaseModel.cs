namespace ACT.UI;

public class ChapterViewBaseModel
{
	public int ChapterIndex { get; private set; }

	public bool IsSelect { get; private set; }

	public bool IsDisabled { get; private set; }

	public ChapterViewBaseModel(int index, bool isSelect, bool isDisabled = false)
	{
		ChapterIndex = index;
		IsSelect = isSelect;
		IsDisabled = isDisabled;
	}

	public void SetIsSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
