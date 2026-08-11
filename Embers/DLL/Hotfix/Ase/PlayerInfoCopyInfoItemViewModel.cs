namespace Ase;

public class PlayerInfoCopyInfoItemViewModel : OptionBase
{
	private string copyIcon;

	private int copyId;

	private string copyName;

	private long score;

	private string scoreTxt;

	private long zoneId;

	public string CopyIcon
	{
		get
		{
			return copyIcon;
		}
		set
		{
			Set(ref copyIcon, value, "CopyIcon");
		}
	}

	public string CopyName
	{
		get
		{
			return copyName;
		}
		set
		{
			Set(ref copyName, value, "CopyName");
		}
	}

	public string ScoreTxt
	{
		get
		{
			return scoreTxt;
		}
		set
		{
			Set(ref scoreTxt, value, "ScoreTxt");
		}
	}

	public PlayerInfoCopyInfoItemViewModel(OptionBase parent, PbCopyChallengeInfo data, string copyName)
	{
		base.parent = parent;
		copyId = data.Id;
		score = data.Score;
		zoneId = data.Value1;
		this.copyName = copyName;
		InitInfo();
	}

	private void InitInfo()
	{
		DRCopyMain dataRow = GameEntry.DataTable.GetDataRow<DRCopyMain>(copyId);
		copyIcon = dataRow.Icon;
		if (copyId == 5)
		{
			scoreTxt = $"{score}";
			return;
		}
		DRDepthsStar[] dataRows = GameEntry.DataTable.GetDataRows((DRDepthsStar p) => p.Zone == zoneId);
		int num = 0;
		if (dataRows.Length != 0)
		{
			DRDepthsStar dRDepthsStar = dataRows[0];
			for (int num2 = 1; num2 < dataRows.Length; num2++)
			{
				if (dataRows[num2].StarNum > dRDepthsStar.StarNum)
				{
					dRDepthsStar = dataRows[num2];
				}
			}
			num = dRDepthsStar.StarNum;
		}
		scoreTxt = $"{score}/{num}";
	}
}
