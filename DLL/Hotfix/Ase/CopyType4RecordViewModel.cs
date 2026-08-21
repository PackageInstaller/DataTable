using GameFramework.Runtime;

namespace Ase;

public class CopyType4RecordViewModel : OptionBase
{
	private SimpleCommand<string> optCommand;

	private string copyRankName;

	private string date;

	private int starGet;

	private int starMax;

	public ICommand OptCommand => optCommand;

	public string CopyRankName => copyRankName;

	public string Date => date;

	public int StarGet => starGet;

	public int StarMax => starMax;

	public CopyType4RecordViewModel()
	{
	}

	public CopyType4RecordViewModel(OptionBase parent, CopyTypeData typeData, int copyIndex, int starGet, int starMax)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		copyRankName = typeData.CopyDataList[copyIndex].CopyRankName;
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow((DRCopyType p) => p.Id == typeData.CopyTypeId);
		date = dataRow.StartTime + " - " + dataRow.EndTime;
		this.starGet = starGet;
		this.starMax = starMax;
	}

	private void OnOpt(string optName)
	{
	}
}
