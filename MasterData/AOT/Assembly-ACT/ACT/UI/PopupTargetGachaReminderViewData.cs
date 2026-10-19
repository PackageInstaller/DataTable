using System;

namespace ACT.UI;

public class PopupTargetGachaReminderViewData : UIViewData
{
	public int GachaId;

	public Action OnContinue;

	public Action<bool> OnClickSilence;

	public bool SilenceEnabled;
}
