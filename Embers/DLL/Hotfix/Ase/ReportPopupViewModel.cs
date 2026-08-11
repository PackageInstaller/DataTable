using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ReportPopupViewModel : OptionBase
{
	private Vector2 screenPosition;

	private Vector2 btnPosition;

	private SimpleCommand openReportCmd;

	private ReportTypeEnum reportType;

	private string reportName;

	private long reportUid;

	public SimpleCommand OpenReportCmd => openReportCmd;

	public Vector2 BtnPosition
	{
		get
		{
			return btnPosition;
		}
		private set
		{
			Set(ref btnPosition, value, "BtnPosition");
		}
	}

	public ReportPopupViewModel()
	{
	}

	public ReportPopupViewModel(OptionBase parent, Vector3 worldPosition, ReportTypeEnum reportType, string reportName, long reportUid)
	{
		base.parent = parent;
		openReportCmd = new SimpleCommand(OpenReport);
		this.reportType = reportType;
		this.reportName = reportName;
		this.reportUid = reportUid;
		screenPosition = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), worldPosition);
	}

	public void RefreshPosition(RectTransform rectTransform)
	{
		Vector2 vector = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPosition, UIUtilly.GetUICamera(), ref vector);
		BtnPosition = vector;
	}

	private void OpenReport()
	{
		openReportCmd.Enabled = false;
		openWindowRequest.Raise(new OpenViewArg(typeof(ReportWindow), new ReportViewModel(this, reportType, reportName, reportUid)));
		Close();
	}
}
