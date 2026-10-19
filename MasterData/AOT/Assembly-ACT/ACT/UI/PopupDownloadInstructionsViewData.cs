using System;

namespace ACT.UI;

public class PopupDownloadInstructionsViewData : UIViewData
{
	public DownloadInstructionsMode mode;

	public long totalBytes;

	public bool isCarrierNetwork;

	public string packageName;

	public string downloadSize;

	public Action onConfirm;

	public Action onCancel;
}
