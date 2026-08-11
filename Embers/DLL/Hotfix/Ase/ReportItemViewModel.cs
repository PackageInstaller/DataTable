namespace Ase;

public class ReportItemViewModel : SelectItemViewModel
{
	private string name;

	private int reportId;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public int ReportId => reportId;

	public ReportItemViewModel(OptionBase parent, string name, int reportId)
		: base(parent)
	{
		base.parent = parent;
		this.name = name;
		this.reportId = reportId;
	}

	public ReportItemViewModel(OptionBase parent)
		: base(parent)
	{
		base.parent = parent;
	}

	public void RefreshData(string name, int reportId)
	{
		Name = name;
		this.reportId = reportId;
	}

	public ReportItemViewModel()
	{
	}
}
