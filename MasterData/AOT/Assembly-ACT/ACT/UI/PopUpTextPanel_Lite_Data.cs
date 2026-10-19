using System;

namespace ACT.UI;

public class PopUpTextPanel_Lite_Data : UIViewData
{
	public int commonId;

	public Action OnConfirm;

	public Action OnCancel;

	public string[] texts;

	public int cancelBtnDes;

	public int confirmBtnDes;
}
