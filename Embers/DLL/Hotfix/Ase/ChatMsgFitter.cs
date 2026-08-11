using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatMsgFitter : MonoBehaviour
{
	public float otherHeight;

	public float paddingW1;

	public float paddingW2;

	public float paddingH;

	public float bgMaxW;

	public float bgMinH;

	public float msgMinH;

	public float msgMaxW;

	public RectTransform msgBg;

	public RectTransform msgItem;

	public ContentSizeFitter contentSizeFitter;

	public void SetBGSize(string text, bool send)
	{
		if (!(msgItem == null))
		{
			if (msgItem.GetComponent<Text>() != null)
			{
				msgItem.GetComponent<Text>().text = text;
			}
			if ((Object)(object)msgItem.GetComponent<TextMeshProUGUI>() != null)
			{
				((TMP_Text)msgItem.GetComponent<TextMeshProUGUI>()).text = text;
			}
			contentSizeFitter.verticalFit = ContentSizeFitter.FitMode.Unconstrained;
			contentSizeFitter.horizontalFit = ContentSizeFitter.FitMode.PreferredSize;
			LayoutRebuilder.ForceRebuildLayoutImmediate(msgItem);
			if (msgItem.sizeDelta.x > bgMaxW - paddingW1 - paddingW2)
			{
				msgItem.sizeDelta = new Vector2(msgMaxW, 0f);
				contentSizeFitter.verticalFit = ContentSizeFitter.FitMode.PreferredSize;
				contentSizeFitter.horizontalFit = ContentSizeFitter.FitMode.Unconstrained;
				LayoutRebuilder.ForceRebuildLayoutImmediate(msgItem);
				msgBg.sizeDelta = new Vector2(bgMaxW, paddingH * 2f + msgItem.sizeDelta.y);
			}
			else
			{
				msgItem.sizeDelta = new Vector2(msgItem.sizeDelta.x, msgMinH);
				msgBg.sizeDelta = new Vector2(paddingW1 + paddingW2 + msgItem.sizeDelta.x, bgMinH);
			}
			msgItem.anchoredPosition = new Vector2(send ? (0f - paddingW1) : paddingW1, 0f - paddingH);
			LayoutRebuilder.ForceRebuildLayoutImmediate(msgBg);
		}
	}

	public void SetCurItemHeight(RectTransform rectTransform)
	{
		rectTransform.sizeDelta = new Vector2(rectTransform.sizeDelta.x, msgBg.sizeDelta.y + otherHeight);
	}
}
