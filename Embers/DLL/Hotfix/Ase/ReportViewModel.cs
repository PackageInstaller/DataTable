#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Lockstep.Core;

namespace Ase;

public class ReportViewModel : OptionBase
{
	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private ReportTypeEnum reportType;

	private string name;

	private string reportTypeName;

	private long uid;

	private string reportRemark;

	private ReportItemViewModel curSelect;

	private List<ReportItemViewModel> reportItemList;

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

	public string ReportTypeName
	{
		get
		{
			return reportTypeName;
		}
		private set
		{
			Set(ref reportTypeName, value, "ReportTypeName");
		}
	}

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<ReportItemViewModel> ItemList => reportItemList;

	public ReportViewModel(OptionBase parent, ReportTypeEnum reportType, string name, long uid, string reportRemark = "")
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.reportType = reportType;
		this.name = name;
		this.uid = uid;
		this.reportRemark = reportRemark;
		reportItemList = new List<ReportItemViewModel>();
		DRReportType dataRow = GameEntry.DataTable.GetDataRow<DRReportType>(reportType.ToInt());
		if (dataRow == null)
		{
			Log.Error($"ReportType表找不到Id为【{reportType.ToInt()}】的数据！");
			return;
		}
		reportTypeName = dataRow.ReportName;
		for (int i = 0; i < dataRow.ReportList.Count; i++)
		{
			DRReportContent dataRow2 = GameEntry.DataTable.GetDataRow<DRReportContent>(dataRow.ReportList[i]);
			if (dataRow2 != null)
			{
				reportItemList.Add(new ReportItemViewModel(this, dataRow2.Content, dataRow2.Id));
			}
			else
			{
				Log.Error($"ReportContent表找不到Id为【{dataRow.ReportList[i]}】的数据！");
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ReportItemViewModel reportItem)
		{
			SelectReportItem(reportItem);
		}
	}

	private void SelectReportItem(ReportItemViewModel reportItem)
	{
		if (reportItem != null && (curSelect == null || reportItem != curSelect))
		{
			if (curSelect != null)
			{
				curSelect.SetSelect(isSelect: false);
			}
			curSelect = reportItem;
			curSelect.SetSelect(isSelect: true);
		}
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OnSubmit".Equals(optName))
		{
			if (curSelect == null)
			{
				Toast.ShowInfo("请选择举报内容！");
				optCommand.Enabled = true;
				return;
			}
			long num = await Singleton<ServiceSystem>.Instance.GetService<IChatService>().Report(reportType, uid, curSelect.ReportId, reportRemark);
			if (num == 0L)
			{
				Toast.ShowInfo("举报成功！");
				Close();
			}
			else if (num > 0)
			{
				Toast.ShowInfo("请在 " + Utility.DateTime.FormatUnixTimestamp(num, "yyyy-MM-dd HH:mm:ss") + " 后再尝试提交");
			}
			else if (num == -1)
			{
				Toast.ShowInfo("举报失败！请重试！");
			}
		}
		else if ("OnCancel".Equals(optName))
		{
			Close();
		}
		optCommand.Enabled = true;
	}
}
