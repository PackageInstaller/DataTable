using System.Globalization;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Controls;

public class KeyControl : ButtonControl
{
	private int m_ScanCode;

	public Key keyCode { get; set; }

	public int scanCode
	{
		get
		{
			RefreshConfigurationIfNeeded();
			return m_ScanCode;
		}
	}

	protected override void RefreshConfiguration()
	{
		base.displayName = null;
		m_ScanCode = 0;
		QueryKeyNameCommand command = QueryKeyNameCommand.Create(keyCode);
		if (base.device.ExecuteCommand(ref command) <= 0)
		{
			return;
		}
		m_ScanCode = command.scanOrKeyCode;
		string str = command.ReadKeyName();
		if (string.IsNullOrEmpty(str))
		{
			base.displayName = str;
			return;
		}
		TextInfo textInfo = CultureInfo.InvariantCulture.TextInfo;
		string str2 = textInfo.ToLower(str);
		if (string.IsNullOrEmpty(str2))
		{
			base.displayName = str;
		}
		else
		{
			base.displayName = textInfo.ToTitleCase(str2);
		}
	}
}
