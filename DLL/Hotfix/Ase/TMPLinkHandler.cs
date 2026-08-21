using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class TMPLinkHandler : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	[SerializeField]
	private TextMeshProUGUI textMeshPro;

	public void OnPointerClick(PointerEventData eventData)
	{
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		int num = TMP_TextUtilities.FindIntersectingLink((TMP_Text)(object)textMeshPro, (Vector3)eventData.position, eventData.pressEventCamera);
		if (num != -1)
		{
			TMP_LinkInfo val = ((TMP_Text)textMeshPro).textInfo.linkInfo[num];
			Application.OpenURL(((TMP_LinkInfo)(ref val)).GetLinkID());
		}
	}
}
