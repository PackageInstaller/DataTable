namespace Ase;

public class BonfireActiveViewModel : OptionBase
{
	private int bonfireId;

	private DRTransferPoint drData;

	private string bonfireName;

	public string BonfireName
	{
		get
		{
			return bonfireName;
		}
		set
		{
			Set(ref bonfireName, value, "BonfireName");
		}
	}

	public BonfireActiveViewModel()
	{
	}

	public BonfireActiveViewModel(OptionBase parent, int bonfireId)
	{
		base.parent = parent;
		this.bonfireId = bonfireId;
		drData = GameEntry.DataTable.GetDataRow<DRTransferPoint>(bonfireId);
		BonfireName = drData?.TransferPointName ?? "";
	}

	public void GamePause()
	{
		parent?.ItemOnClick(ProcessOperationEnum.GamePause);
	}

	public void GameResume()
	{
		parent?.ItemOnClick(ProcessOperationEnum.GameResume);
	}

	public override void Close()
	{
		base.Close();
	}
}
