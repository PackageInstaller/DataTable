namespace Ase;

public class HeroFrameSetItemData : ItemOptionBase
{
	private int _seatIndex;

	private bool _showBtnPart;

	private bool _showBtnMask;

	private string _frame = "";

	private string _btnText;

	private int _curFrameId;

	public int SeatIndex
	{
		get
		{
			return _seatIndex;
		}
		set
		{
			Set(ref _seatIndex, value, "SeatIndex");
		}
	}

	public bool ShowBtnPart
	{
		get
		{
			return _showBtnPart;
		}
		set
		{
			Set(ref _showBtnPart, value, "ShowBtnPart");
		}
	}

	public bool ShowBtnMask
	{
		get
		{
			return _showBtnMask;
		}
		set
		{
			Set(ref _showBtnMask, value, "ShowBtnMask");
		}
	}

	public string Frame
	{
		get
		{
			return _frame;
		}
		set
		{
			Set(ref _frame, value, "Frame");
		}
	}

	public string BtnText
	{
		get
		{
			return _btnText;
		}
		set
		{
			Set(ref _btnText, value, "BtnText");
		}
	}

	public int CurFrameId
	{
		get
		{
			return _curFrameId;
		}
		set
		{
			Set(ref _curFrameId, value, "CurFrameId");
		}
	}

	public HeroFrameSetItemData()
	{
	}

	public HeroFrameSetItemData(OptionBase parent, int seatIndex, int curFrameId)
	{
		base.parent = parent;
		SeatIndex = seatIndex;
		CurFrameId = curFrameId;
		SetFrame(curFrameId);
	}

	public void OnBtnApplyClick()
	{
		parent?.ItemOnClick(this);
	}

	public void SetFrame(int frameId)
	{
		CurFrameId = frameId;
		Frame = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(frameId)?.EdgePath ?? "";
	}
}
