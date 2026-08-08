using System;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
[RequireComponent(typeof(Mask))]
public class TextScroll : MonoBehaviour
{
	public Text text;

	public float space = 15f;

	public float scrollSpeed = 1f;

	public float textwidth;

	public bool useTextWidth;

	public float useTextWidthRate = 1f;

	private bool isScroll;

	private float contentWidth;

	private RectTransform rect;

	private Transform copy;

	private Vector2 pivot;

	private TextAnchor anchor;

	private Vector3 localPosition;

	private Listener listener;

	private void Awake()
	{
		rect = base.transform.GetComponent<RectTransform>();
		contentWidth = rect.rect.width;
		InitScript();
	}

	private void Start()
	{
		listener = new Listener();
		listener.MyValue = text.text;
		listener.MyActive = text.gameObject.activeSelf;
		listener.OnValueChanged += WhenChangeText;
		SetIsScroll();
	}

	private void Update()
	{
		if (listener == null)
		{
			return;
		}
		if (this.text != null)
		{
			listener.MyValue = this.text.text;
			listener.MyActive = this.text.gameObject.activeSelf;
			Text text = copy?.GetComponent<Text>();
			if (null != text && this.text.color != text.color)
			{
				text.color = this.text.color;
			}
		}
		if (isScroll)
		{
			float num = CalculateLengthOfText(this.text.text);
			if (copy == null)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(this.text.gameObject);
				gameObject.name = "copy";
				copy = gameObject.transform;
				copy.SetParent(base.transform);
				copy.localScale = this.text.transform.localScale;
				copy.GetComponent<Text>().text = this.text.text;
				copy.localPosition = new Vector3(1.5f * num + space, this.text.transform.localPosition.y, this.text.transform.localPosition.z);
				copy.gameObject.SetActive(value: true);
			}
			if (this.text.transform.localPosition.x < (0f - contentWidth) / 2f - num / 2f)
			{
				this.text.transform.localPosition = new Vector3(copy.transform.localPosition.x + num + space, this.text.transform.localPosition.y, this.text.transform.localPosition.z);
			}
			if (copy.transform.localPosition.x < (0f - contentWidth) / 2f - num / 2f)
			{
				copy.transform.localPosition = new Vector3(this.text.transform.localPosition.x + num + space, copy.transform.localPosition.y, copy.transform.localPosition.z);
			}
			this.text.transform.localPosition = new Vector3(this.text.transform.localPosition.x - scrollSpeed, this.text.transform.localPosition.y, this.text.transform.localPosition.z);
			copy.transform.localPosition = new Vector3(copy.transform.localPosition.x - scrollSpeed, copy.transform.localPosition.y, copy.transform.localPosition.z);
		}
	}

	private void InitScript()
	{
		base.transform.GetComponent<Image>().raycastTarget = false;
		base.transform.GetComponent<Mask>().showMaskGraphic = false;
		RectTransform component = text.transform.GetComponent<RectTransform>();
		localPosition = component.localPosition;
		pivot = component.pivot;
		anchor = text.alignment;
	}

	private void WhenChangeText(object sender, EventArgs args)
	{
		SetIsScroll();
	}

	private void SetIsScroll()
	{
		RectTransform component = text.transform.GetComponent<RectTransform>();
		if (!text.gameObject.activeSelf)
		{
			copy = base.transform.Find("copy");
			if (copy != null)
			{
				copy.gameObject.SetActive(value: false);
			}
			isScroll = false;
			RestoreText();
			return;
		}
		float num = CalculateLengthOfText(text.text);
		if (useTextWidth)
		{
			space = num;
			space = useTextWidthRate * space;
		}
		if (num > contentWidth)
		{
			copy = base.transform.Find("copy");
			if (copy != null)
			{
				base.transform.gameObject.SetActive(value: true);
			}
			else
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(text.gameObject);
				gameObject.name = "copy";
				copy = gameObject.transform;
				copy.SetParent(base.transform);
				copy.localScale = text.transform.localScale;
				Text component2 = copy.GetComponent<Text>();
				component2.alignment = TextAnchor.MiddleCenter;
				component2.transform.GetComponent<RectTransform>().pivot = new Vector2(0.5f, 0.5f);
			}
			text.alignment = TextAnchor.MiddleCenter;
			component.pivot = new Vector2(0.5f, 0.5f);
			copy.GetComponent<Text>().text = text.text;
			component.localPosition = new Vector3(0.5f * num, component.localPosition.y, component.localPosition.z);
			copy.localPosition = new Vector3(1.5f * num + space, component.localPosition.y, component.localPosition.z);
			copy.gameObject.SetActive(value: true);
			isScroll = true;
		}
		else
		{
			copy = base.transform.Find("copy");
			if (copy != null)
			{
				copy.gameObject.SetActive(value: false);
			}
			isScroll = false;
			RestoreText();
		}
	}

	private float CalculateLengthOfText(string message)
	{
		string text = StringFilter(message);
		int num = 0;
		Font font = this.text.font;
		font.RequestCharactersInTexture(text, this.text.fontSize, this.text.fontStyle);
		CharacterInfo info = default(CharacterInfo);
		char[] array = text.ToCharArray();
		foreach (char ch in array)
		{
			font.GetCharacterInfo(ch, out info, this.text.fontSize);
			num += info.advance;
		}
		return num;
	}

	private string StringFilter(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return "";
		}
		string text = "";
		Regex regex = new Regex("<color=(.*?)>");
		Regex regex2 = new Regex("</color>");
		text = regex.Replace(str, "");
		return regex2.Replace(text, "");
	}

	private void RestoreText()
	{
		RectTransform component = text.transform.GetComponent<RectTransform>();
		component.pivot = pivot;
		text.alignment = anchor;
		component.localPosition = localPosition;
	}

	private void OnDestroy()
	{
		if (listener != null)
		{
			listener.OnValueChanged -= WhenChangeText;
		}
	}
}
