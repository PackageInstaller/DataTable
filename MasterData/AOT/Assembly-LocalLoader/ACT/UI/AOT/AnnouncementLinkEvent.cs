using System;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using bamboosdk;

namespace ACT.UI.AOT;

public class AnnouncementLinkEvent : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	private TextMeshProUGUI tmpObject { get; set; }

	private void Awake()
	{
		tmpObject = GetComponent<TextMeshProUGUI>();
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		int num = TMP_TextUtilities.FindIntersectingLink(tmpObject.textInfo.textComponent, eventData.pressPosition, eventData.pressEventCamera);
		if (num == -1)
		{
			return;
		}
		TMP_LinkInfo tMP_LinkInfo = tmpObject.textInfo.linkInfo[num];
		string linkID = tMP_LinkInfo.GetLinkID();
		if (Uri.TryCreate(linkID, UriKind.Absolute, out var _))
		{
			JObject jObject = new JObject
			{
				["title"] = tMP_LinkInfo.GetLinkText(),
				["link"] = linkID,
				["system_id"] = 7003
			};
			BamBooSdk.getInstance().taEvent("hyperlink_click", jObject.ToString());
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("Trying to execute OpenURL for: " + linkID);
			}
			Application.OpenURL(linkID);
		}
	}
}
