using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(RectTransform))]
public class RollingNumber : MonoBehaviour
{
	public enum RollAlignment
	{
		Left,
		Center,
		Right
	}

	private class DigitColumn
	{
		public GameObject gameObject;

		public int currentDigit;

		private Text textMain;

		private Text textNext;

		private float height;

		public DigitColumn(Transform parent, Font font, int fontSize, Color color, float width, float height)
		{
			this.height = height;
			gameObject = new GameObject("DigitColumn");
			gameObject.transform.SetParent(parent, worldPositionStays: false);
			RectTransform rectTransform = gameObject.AddComponent<RectTransform>();
			rectTransform.anchorMin = new Vector2(0.5f, 0.5f);
			rectTransform.anchorMax = new Vector2(0.5f, 0.5f);
			rectTransform.sizeDelta = new Vector2(width, height);
			LayoutElement layoutElement = gameObject.AddComponent<LayoutElement>();
			layoutElement.minWidth = width;
			layoutElement.minHeight = height;
			textMain = CreateText("TextMain", font, fontSize, color, width, height, gameObject.transform);
			textNext = CreateText("TextNext", font, fontSize, color, width, height, gameObject.transform);
			SetDigitImmediate(0, isBlank: false);
		}

		public void SetActive(bool active)
		{
			gameObject.SetActive(active);
		}

		private Text CreateText(string name, Font font, int fontSize, Color color, float width, float height, Transform parent)
		{
			GameObject obj = new GameObject(name);
			obj.transform.SetParent(parent, worldPositionStays: false);
			Text text = obj.AddComponent<Text>();
			text.font = font;
			text.fontSize = fontSize;
			text.color = color;
			text.alignment = TextAnchor.MiddleCenter;
			RectTransform rectTransform = text.rectTransform;
			rectTransform.anchorMin = new Vector2(0.5f, 0.5f);
			rectTransform.anchorMax = new Vector2(0.5f, 0.5f);
			rectTransform.sizeDelta = new Vector2(width, height);
			return text;
		}

		public void SetDigitImmediate(int digit, bool isBlank)
		{
			currentDigit = digit;
			textMain.text = (isBlank ? "" : digit.ToString());
			textMain.rectTransform.anchoredPosition = Vector2.zero;
			textNext.rectTransform.anchoredPosition = new Vector2(0f, 0f - height);
		}

		public IEnumerator RollTo(int targetDigit, float stepDuration, bool isScrollingUp, bool isTargetBlank)
		{
			int steps = (isScrollingUp ? ((targetDigit - currentDigit + 10) % 10) : ((currentDigit - targetDigit + 10) % 10));
			bool flag = textMain.text == "";
			if (steps == 0)
			{
				if ((!isTargetBlank || flag) && !(!isTargetBlank & flag))
				{
					textMain.rectTransform.anchoredPosition = Vector2.zero;
					yield break;
				}
				steps = 1;
			}
			textMain.rectTransform.anchoredPosition = Vector2.zero;
			for (int i = 0; i < steps; i++)
			{
				int nextDigit = ((steps != 1 || targetDigit != currentDigit) ? (isScrollingUp ? ((currentDigit + 1) % 10) : ((currentDigit - 1 + 10) % 10)) : currentDigit);
				bool isBlankFace = isTargetBlank && i == steps - 1;
				textNext.text = (isBlankFace ? "" : nextDigit.ToString());
				textNext.rectTransform.anchoredPosition = new Vector2(0f, isScrollingUp ? (0f - height) : height);
				float timer = 0f;
				while (timer < stepDuration)
				{
					timer += Time.deltaTime;
					float num = Mathf.Clamp01(timer / stepDuration);
					if (isScrollingUp)
					{
						textMain.rectTransform.anchoredPosition = new Vector2(0f, height * num);
						textNext.rectTransform.anchoredPosition = new Vector2(0f, 0f - height + height * num);
					}
					else
					{
						textMain.rectTransform.anchoredPosition = new Vector2(0f, (0f - height) * num);
						textNext.rectTransform.anchoredPosition = new Vector2(0f, height - height * num);
					}
					yield return null;
				}
				currentDigit = nextDigit;
				Text text = textMain;
				textMain = textNext;
				textNext = text;
				textMain.rectTransform.anchoredPosition = Vector2.zero;
				textMain.text = (isBlankFace ? "" : currentDigit.ToString());
			}
		}
	}

	[Header("排版设置")]
	public RollAlignment alignment = RollAlignment.Center;

	[Header("文字外观设置")]
	public Font font;

	public int fontSize = 40;

	public Color textColor = Color.white;

	[Header("滚动动画设置")]
	public float singleRollDuration = 0.1f;

	public float staggerDelay = 0.1f;

	public int prewarmDigits = 6;

	private int currentValue = -1;

	private float digitWidth;

	private float digitHeight;

	private HorizontalLayoutGroup layoutGroup;

	private List<DigitColumn> activeColumns = new List<DigitColumn>();

	private Stack<DigitColumn> columnPool = new Stack<DigitColumn>();

	private RectTransform parentRect;

	private bool isInitialized;

	private void Awake()
	{
		InitIfNeeded();
	}

	private void InitIfNeeded()
	{
		if (!isInitialized)
		{
			isInitialized = true;
			parentRect = GetComponent<RectTransform>();
			MeasureDigitSize();
			SetupParentComponents();
			for (int i = 0; i < prewarmDigits; i++)
			{
				DigitColumn digitColumn = CreateNewColumn();
				digitColumn.SetActive(active: false);
				columnPool.Push(digitColumn);
			}
		}
	}

	private void OnValidate()
	{
		if (Application.isPlaying && layoutGroup != null && parentRect != null)
		{
			ApplyAlignment();
		}
	}

	public int GetCurValue()
	{
		return currentValue;
	}

	public void ScrollTo(int targetValue)
	{
		InitIfNeeded();
		if (base.gameObject.activeInHierarchy && targetValue != currentValue)
		{
			int startValue = currentValue;
			currentValue = targetValue;
			StopAllCoroutines();
			StartCoroutine(ScrollSequence(targetValue, startValue));
		}
		else if (!base.gameObject.activeInHierarchy)
		{
			SetValueImmediate(targetValue);
		}
	}

	public void SetValueImmediate(int value)
	{
		InitIfNeeded();
		if (base.gameObject.activeInHierarchy)
		{
			StopAllCoroutines();
		}
		currentValue = value;
		string text = value.ToString();
		EnsureColumnCount(text.Length);
		for (int i = 0; i < text.Length; i++)
		{
			activeColumns[i].SetDigitImmediate(text[i] - 48, isBlank: false);
		}
	}

	private IEnumerator ScrollSequence(int targetValue, int startValue)
	{
		bool globalIsScrollingUp = targetValue > startValue;
		bool isLeftAlign = alignment == RollAlignment.Left;
		string targetStr = targetValue.ToString();
		int targetActualLen = targetStr.Length;
		int maxLen = Mathf.Max(targetActualLen, activeColumns.Count);
		targetStr = ((!isLeftAlign) ? targetStr.PadLeft(maxLen, '0') : targetStr.PadRight(maxLen, '0'));
		EnsureColumnCount(maxLen);
		for (int i = 0; i < maxLen; i++)
		{
			int num = targetStr[i] - 48;
			int currentDigit = activeColumns[i].currentDigit;
			bool isTargetBlank = (isLeftAlign ? (i >= targetActualLen) : (i < maxLen - targetActualLen));
			int num2 = (num - currentDigit + 10) % 10;
			int num3 = (currentDigit - num + 10) % 10;
			bool isScrollingUp = num2 < num3 || (num3 >= num2 && globalIsScrollingUp);
			StartCoroutine(activeColumns[i].RollTo(num, singleRollDuration, isScrollingUp, isTargetBlank));
			yield return new WaitForSeconds(staggerDelay);
		}
		float seconds = (float)maxLen * staggerDelay + 5f * singleRollDuration;
		yield return new WaitForSeconds(seconds);
		EnsureColumnCount(targetActualLen);
	}

	private void EnsureColumnCount(int targetLength)
	{
		bool flag = alignment == RollAlignment.Left;
		while (activeColumns.Count > targetLength)
		{
			int index = (flag ? (activeColumns.Count - 1) : 0);
			DigitColumn digitColumn = activeColumns[index];
			activeColumns.RemoveAt(index);
			digitColumn.SetActive(active: false);
			columnPool.Push(digitColumn);
		}
		while (activeColumns.Count < targetLength)
		{
			DigitColumn digitColumn2;
			if (columnPool.Count > 0)
			{
				digitColumn2 = columnPool.Pop();
				digitColumn2.SetActive(active: true);
			}
			else
			{
				digitColumn2 = CreateNewColumn();
			}
			digitColumn2.SetDigitImmediate(0, isBlank: true);
			if (flag)
			{
				digitColumn2.gameObject.transform.SetAsLastSibling();
				activeColumns.Add(digitColumn2);
			}
			else
			{
				digitColumn2.gameObject.transform.SetAsFirstSibling();
				activeColumns.Insert(0, digitColumn2);
			}
		}
	}

	private DigitColumn CreateNewColumn()
	{
		return new DigitColumn(base.transform, font, fontSize, textColor, digitWidth, digitHeight);
	}

	private void MeasureDigitSize()
	{
		GameObject obj = new GameObject("Temp");
		Text text = obj.AddComponent<Text>();
		text.font = font;
		text.fontSize = fontSize;
		text.text = "8";
		digitWidth = text.preferredWidth;
		digitHeight = text.preferredHeight;
		Object.Destroy(obj);
	}

	private void SetupParentComponents()
	{
		if (!base.gameObject.GetComponent<RectMask2D>())
		{
			base.gameObject.AddComponent<RectMask2D>();
		}
		layoutGroup = base.gameObject.GetComponent<HorizontalLayoutGroup>();
		if (layoutGroup == null)
		{
			layoutGroup = base.gameObject.AddComponent<HorizontalLayoutGroup>();
		}
		layoutGroup.childControlWidth = false;
		layoutGroup.childControlHeight = false;
		layoutGroup.childForceExpandWidth = false;
		layoutGroup.childForceExpandHeight = false;
		ContentSizeFitter contentSizeFitter = base.gameObject.GetComponent<ContentSizeFitter>();
		if (contentSizeFitter == null)
		{
			contentSizeFitter = base.gameObject.AddComponent<ContentSizeFitter>();
		}
		contentSizeFitter.horizontalFit = ContentSizeFitter.FitMode.MinSize;
		contentSizeFitter.verticalFit = ContentSizeFitter.FitMode.MinSize;
		ApplyAlignment();
	}

	private void ApplyAlignment()
	{
		if (alignment == RollAlignment.Left)
		{
			parentRect.pivot = new Vector2(0f, 0.5f);
			layoutGroup.childAlignment = TextAnchor.MiddleLeft;
		}
		else if (alignment == RollAlignment.Center)
		{
			parentRect.pivot = new Vector2(0.5f, 0.5f);
			layoutGroup.childAlignment = TextAnchor.MiddleCenter;
		}
		else if (alignment == RollAlignment.Right)
		{
			parentRect.pivot = new Vector2(1f, 0.5f);
			layoutGroup.childAlignment = TextAnchor.MiddleRight;
		}
	}
}
