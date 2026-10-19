using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoConversationBubble : MonoBehaviour
{
	public Image bg;

	public TextMeshProUGUI text;

	public LocalizeStringEvent content;

	public float horizontalSizeOffset = 100f;

	public float verticallSizeOffset = 40f;

	private void OnAwake()
	{
	}

	private void Update()
	{
	}

	public void UpdateTextSize()
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(text.transform as RectTransform);
	}

	public void UpdateBgSize()
	{
		RectTransform rectTransform = bg.rectTransform;
		RectTransform rectTransform2 = text.rectTransform;
		rectTransform.sizeDelta = new Vector2(rectTransform2.sizeDelta.x + horizontalSizeOffset, rectTransform2.sizeDelta.y + verticallSizeOffset);
	}
}
