using System;
using System.Text.RegularExpressions;
using ACT.Utility;
using TMPro;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoNameChangeView : BaseUIView
{
	public class MonoNameChangeData : UIViewData
	{
		public enum ChangeNameRule
		{
			Default = 1,
			AllowSameName
		}

		public LocalizeStringData titleLocalizeData;

		public string name;

		public Action<string, Action<bool>> changeNameEvent;

		public ChangeNameRule changeNameRule = ChangeNameRule.Default;

		public LocalizeStringData cancelLocalizeData;

		public LocalizeStringData confirmLocalizeData;
	}

	public TextMeshProUGUI curName;

	public TMP_InputField inputName;

	private MonoNameChangeData data;

	public ActButton cancelBtn;

	public ActButton confirmBtn;

	public LocalizeStringEvent cancelDes;

	public LocalizeStringEvent confirmDes;

	public int overlongTip = 917;

	public int overshortTip = 916;

	public int unconventionalTip = 918;

	public int overlong = 9;

	public int overshort = 1;

	protected override void Init()
	{
		base.Init();
		data = uiViewData as MonoNameChangeData;
		if (data != null)
		{
			curName.text = data.name;
			inputName.text = data.name;
			cancelDes?.SetReference(data.cancelLocalizeData);
			confirmDes?.SetReference(data.confirmLocalizeData);
			cancelBtn?.SetBtnClick(Close);
			confirmBtn?.SetBtnClick(OnClick);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		data = null;
	}

	public void OnClick()
	{
		if (!data.changeNameRule.HasFlag(MonoNameChangeData.ChangeNameRule.AllowSameName) && inputName.text == data.name)
		{
			Close();
			return;
		}
		string text = inputName.text;
		Match match = Regex.Match(text, "^[一-龥A-Za-z0-9]*$");
		if (string.IsNullOrEmpty(text) || !match.Success)
		{
			GameUtility.OpenToolTip(unconventionalTip);
			return;
		}
		int length = inputName.text.Length;
		if (length < overshort)
		{
			GameUtility.OpenToolTip(overshortTip);
		}
		else if (length > overlong)
		{
			GameUtility.OpenToolTip(overlongTip);
		}
		else
		{
			data.changeNameEvent?.Invoke(inputName.text, ChangeNameCallback);
		}
	}

	public void ChangeNameCallback(bool r)
	{
		if (r)
		{
			Close();
		}
		else if (data != null)
		{
			curName.text = data.name;
			inputName.text = data.name;
		}
	}
}
