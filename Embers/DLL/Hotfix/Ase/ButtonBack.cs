using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ButtonBack : Button
{
	[SerializeField]
	private TextMeshProUGUI firstText;

	[SerializeField]
	private TextMeshProUGUI secondText;

	[SerializeField]
	private TextMeshProUGUI shadowText;

	public new string name;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			name = value;
			SetText(name);
		}
	}

	public void SetText(string str)
	{
		if (!string.IsNullOrEmpty(str))
		{
			((TMP_Text)firstText).text = str.Substring(0, 1);
			if (str.Length > 0)
			{
				((TMP_Text)secondText).text = str.Substring(1);
				((TMP_Text)shadowText).text = str.Substring(1);
			}
		}
	}
}
