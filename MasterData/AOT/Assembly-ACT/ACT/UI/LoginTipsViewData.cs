using System;
using UnityEngine.Localization;

namespace ACT.UI;

public class LoginTipsViewData : UIViewData
{
	public int titleId;

	public int commonId;

	public bool onlyConfirm;

	public Action OnConfirm;

	public Action OnCancel;

	public string[] Titletexts;

	public string[] texts;

	public bool needPause;

	public bool onlyClickOnce;

	public bool useLongCommon;

	public LocalizedString content_longCommon;

	public string audioOpenSound;

	public string audioCloseSound;

	public string audioConfirmSound;

	public string audioCancelSound;
}
