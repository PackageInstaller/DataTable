using System.Collections.Generic;
using ACT.DialogueSystem;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Settings;

namespace ACT.UI;

public class MonoConversationBubbles : MonoBehaviour
{
	public struct BubbleController
	{
		public MonoConversationBubbles bubbles;

		public MonoConversationBubble bubble;

		public void Show(string text)
		{
			text = LuminDialogueUtility.ProcessPlayerName(text);
			bubble.text.text = text;
			bubble.gameObject.SetActive(value: true);
			bubble.UpdateTextSize();
		}

		public async UniTask Show(int contentId)
		{
			bubble.gameObject.SetActive(value: true);
			string text = LuminDialogueUtility.ProcessPlayerName(await LocalizationSettings.StringDatabase.GetLocalizedStringAsync(bubble.content.StringReference.TableReference, contentId, null, bubble.content.StringReference.LocaleOverride, bubble.content.StringReference.FallbackState).Task);
			bubble.text.text = text;
			bubble.UpdateTextSize();
		}

		public void Hide()
		{
			if (IsValid())
			{
				bubble.gameObject.SetActive(value: false);
			}
		}

		public void UpdateTargetPosition(Vector3 worldPosition)
		{
			if (IsValid() && !(Camera.main == null))
			{
				Vector3 vector = Camera.main.WorldToScreenPoint(worldPosition);
				RectTransformUtility.ScreenPointToLocalPointInRectangle(bubble.transform.parent as RectTransform, vector, Singleton<NewUIManager>.instance.UICamera, out var localPoint);
				RectTransform rectTransform = bubble.transform as RectTransform;
				rectTransform.anchoredPosition = localPoint;
				(bubble.transform.parent as RectTransform).sizeDelta = (bubble.transform.GetChild(0) as RectTransform).sizeDelta;
				ClampBubbleToScreen(rectTransform);
			}
		}

		private void ClampBubbleToScreen(RectTransform bubbleRect)
		{
			RectTransform rectTransform = bubbleRect.parent as RectTransform;
			if (!(rectTransform == null))
			{
				Vector2 size = bubbleRect.rect.size;
				Vector2 anchoredPosition = bubbleRect.anchoredPosition;
				RectTransform rectTransform2 = rectTransform;
				while (rectTransform2.parent != null && rectTransform2.GetComponent<Canvas>() == null)
				{
					rectTransform2 = rectTransform2.parent as RectTransform;
				}
				Vector2 size2 = rectTransform2.rect.size;
				Vector2 pivot = bubbleRect.pivot;
				float num = anchoredPosition.x - size.x * pivot.x;
				float num2 = anchoredPosition.x + size.x * (1f - pivot.x);
				float num3 = anchoredPosition.y - size.y * pivot.y;
				float num4 = anchoredPosition.y + size.y * (1f - pivot.y);
				float num5 = (0f - size2.x) * 0.5f;
				float num6 = size2.x * 0.5f;
				float num7 = (0f - size2.y) * 0.5f;
				float num8 = size2.y * 0.5f;
				if (num < num5)
				{
					anchoredPosition.x += num5 - num;
				}
				else if (num2 > num6)
				{
					anchoredPosition.x -= num2 - num6;
				}
				if (num3 < num7)
				{
					anchoredPosition.y += num7 - num3;
				}
				else if (num4 > num8)
				{
					anchoredPosition.y -= num4 - num8;
				}
				bubbleRect.anchoredPosition = anchoredPosition;
			}
		}

		public void Release()
		{
			if (IsValid())
			{
				bubbles?.ReleaseBubble(bubble);
				bubbles = null;
				bubble = null;
			}
		}

		public bool IsValid()
		{
			return bubble != null;
		}
	}

	public MonoConversationBubble bubbleTemplate;

	private Queue<MonoConversationBubble> bubblePool = new Queue<MonoConversationBubble>();

	public BubbleController SpawnBubble()
	{
		MonoConversationBubble monoConversationBubble = null;
		if (bubblePool.Count > 0)
		{
			monoConversationBubble = bubblePool.Dequeue();
		}
		else
		{
			monoConversationBubble = Object.Instantiate(bubbleTemplate.gameObject, bubbleTemplate.transform.parent).GetComponent<MonoConversationBubble>();
			monoConversationBubble.content.SetTable("MainStory");
		}
		monoConversationBubble.gameObject.SetActive(value: false);
		return new BubbleController
		{
			bubbles = this,
			bubble = monoConversationBubble
		};
	}

	private void ReleaseBubble(MonoConversationBubble bubble)
	{
		bubblePool.Enqueue(bubble);
	}
}
