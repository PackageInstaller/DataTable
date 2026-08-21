using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class HyperlinkText : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	public TextMeshProUGUI text;

	public string linkPrefix;

	public string linkSuffix;

	private Action<string> onLinkClick;

	public Func<string, string> GetFinalLink;

	public void OnPointerClick(PointerEventData eventData)
	{
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		Vector3 vector = new Vector3(eventData.position.x, eventData.position.y, 0f);
		int num = TMP_TextUtilities.FindIntersectingLink((TMP_Text)(object)text, vector, UIUtilly.GetUICamera());
		if (num > -1)
		{
			TMP_LinkInfo val = ((TMP_Text)text).textInfo.linkInfo[num];
			if (GetFinalLink != null)
			{
				onLinkClick?.Invoke(GetFinalLink(((TMP_LinkInfo)(ref val)).GetLinkID()));
			}
			else
			{
				onLinkClick?.Invoke(linkPrefix + ((TMP_LinkInfo)(ref val)).GetLinkID() + linkSuffix);
			}
		}
	}

	public void SetOnLinkClickAction(Action<string> action)
	{
		onLinkClick = action;
	}
}
