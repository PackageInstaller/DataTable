using System;

namespace ACT.UI;

public class PopupPreDownloadPromptViewData : UIViewData
{
	public long downloadedBytes;

	public long totalBytes;

	public long requiredSpaceBytes = -1L;

	public Action onConfirm;

	public Action onCancel;

	public Action onInsufficientSpaceConfirm;

	public bool isPreDownloadCompleted;

	public bool showPauseConfirmation;

	public Action onPauseConfirm;
}
