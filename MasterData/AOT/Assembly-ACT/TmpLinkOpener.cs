using ACT.UI;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class TmpLinkOpener : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	[SerializeField]
	private TextMeshProUGUI text;

	public void OnPointerClick(PointerEventData eventData)
	{
		if (text == null)
		{
			return;
		}
		int num = TMP_TextUtilities.FindIntersectingLink(text, eventData.position, Singleton<NewUIManager>.instance.UICamera);
		if (num != -1)
		{
			TMP_LinkInfo tMP_LinkInfo = text.textInfo.linkInfo[num];
			string linkID = tMP_LinkInfo.GetLinkID();
			if (IsValidUrl(linkID))
			{
				Application.OpenURL(linkID);
			}
			else
			{
				Debug.LogWarning("非法链接: " + linkID);
			}
		}
	}

	private bool IsValidUrl(string url)
	{
		if (!url.StartsWith("http://"))
		{
			return url.StartsWith("https://");
		}
		return true;
	}
}
