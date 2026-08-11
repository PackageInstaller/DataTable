namespace Ase;

public class CopyHeroItemViewModel : HeroItemViewModel
{
	private bool haveTag;

	private int tagIndex;

	private int seatTag;

	private bool isBlock;

	public bool HaveTag
	{
		get
		{
			return haveTag;
		}
		protected set
		{
			Set(ref haveTag, value, "HaveTag");
		}
	}

	public bool IsBlock
	{
		get
		{
			return isBlock;
		}
		protected set
		{
			Set(ref isBlock, value, "IsBlock");
		}
	}

	public int TagIndex
	{
		get
		{
			return tagIndex;
		}
		protected set
		{
			Set(ref tagIndex, value, "TagIndex");
		}
	}

	public int SeatTag
	{
		get
		{
			return seatTag;
		}
		protected set
		{
			Set(ref seatTag, value, "SeatTag");
		}
	}

	public CopyHeroItemViewModel(OptionBase parent, HeroModel heroModel)
		: base(parent, heroModel)
	{
		tagIndex = 0;
		HaveTag = false;
	}

	public void SetTag(bool haveTag, int tagIndex)
	{
		HaveTag = haveTag;
		TagIndex = tagIndex;
	}

	public void ResetAllTag()
	{
		HaveTag = false;
		TagIndex = 0;
		SeatTag = 0;
		IsBlock = false;
	}

	public void SetTag(int tagIndex, int seatIndex)
	{
		HaveTag = tagIndex != 0;
		TagIndex = tagIndex;
		SeatTag = seatIndex;
		IsBlock = false;
	}

	public void SetBlock(bool isBlock)
	{
		IsBlock = isBlock;
	}

	public override void OnClick()
	{
		SetSelected(value: true);
		parent.ItemOnClick(this);
	}
}
