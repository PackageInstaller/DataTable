namespace Ase;

public class ToHaveEmoteItemModel : OptionBase
{
	public string emoteIconPath;

	private int id;

	private int timeLimitGroupId;

	private int sortId;

	private bool isSelected;

	private EmoteDragState emoteDrag;

	public int Id => id;

	public int SortId => sortId;

	public int TimeLimitGroupId => timeLimitGroupId;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public string EmoteIconPath
	{
		get
		{
			return emoteIconPath;
		}
		set
		{
			Set(ref emoteIconPath, value, "EmoteIconPath");
		}
	}

	public EmoteDragState EmoteDrag
	{
		get
		{
			return emoteDrag;
		}
		set
		{
			Set(ref emoteDrag, value, "EmoteDrag");
		}
	}

	public ToHaveEmoteItemModel()
	{
	}

	public ToHaveEmoteItemModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public ToHaveEmoteItemModel(OptionBase parent, string emoteIconPath, int id, int groupId, int sortId, int timeLimitGroupId)
	{
		base.parent = parent;
		this.emoteIconPath = emoteIconPath;
		this.id = id;
		this.timeLimitGroupId = groupId;
		this.sortId = sortId;
		this.timeLimitGroupId = timeLimitGroupId;
	}

	public void SetDragEmoteIcon(string emoteIconPath)
	{
		EmoteIconPath = emoteIconPath;
	}

	public void OnClike()
	{
		parent?.ItemOnClick(this);
	}
}
