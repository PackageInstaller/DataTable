using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class StatSubInfoItem : UIBehaviour
{
	[SerializeField]
	private TextMeshProUGUI tmp_name;

	[SerializeField]
	private TextMeshProUGUI tmp_value;

	public void OnReset()
	{
		TextMeshProUGUI obj = tmp_name;
		if (obj != null)
		{
			((TMP_Text)obj).SetText(string.Empty, true);
		}
		TextMeshProUGUI obj2 = tmp_value;
		if (obj2 != null)
		{
			((TMP_Text)obj2).SetText("0", true);
		}
	}

	public void SetName(string name)
	{
		TextMeshProUGUI obj = tmp_name;
		if (obj != null)
		{
			((TMP_Text)obj).SetText(name, true);
		}
	}

	public void SetValue(float value)
	{
		TextMeshProUGUI obj = tmp_value;
		if (obj != null)
		{
			((TMP_Text)obj).SetText(value.ToString(), true);
		}
	}
}
