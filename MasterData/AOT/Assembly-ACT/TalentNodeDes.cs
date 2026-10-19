using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class TalentNodeDes : MonoBehaviour
{
	public LocalizeStringEvent TextTalenName;

	public TextMeshProUGUI TfTalenNodeNum;

	public void Init(int propertyNameId, string valueText)
	{
		if (TextTalenName != null)
		{
			TextTalenName.SetTable("shortcommon");
			TextTalenName.StringReference.TableEntryReference = propertyNameId;
			TextTalenName.RefreshString();
		}
		if (TfTalenNodeNum != null)
		{
			TfTalenNodeNum.text = valueText;
		}
	}
}
