using System;
using ACT.Config;

namespace ACT.UI;

public class PopupEliteLevelUpViewData : UIViewData
{
	public Action OnConfirm;

	public Action<bool> OnClickSilence;

	public ItemData item_character;

	public ItemData item_generic;

	public int changeNumber;

	public bool showSilence;
}
