using UnityEngine;
using UnityEngine.UI;

public class TextExtension : MonoBehaviour
{
	private Text text;

	private RectTransform rectTransform;

	public string suffix = "...";

	private int suffixWidth;

	private void Awake()
	{
		text = base.gameObject.GetComponent<Text>();
		rectTransform = base.gameObject.GetComponent<RectTransform>();
		suffixWidth = CalculateLengthOfText(suffix);
	}

	public void SetText(string value)
	{
		if (text == null)
		{
			Awake();
		}
		text.text = StripLengthWithSuffix(value, (int)rectTransform.rect.width - suffixWidth);
	}

	private string StripLengthWithSuffix(string input, int maxWidth)
	{
		if (CalculateLengthOfText(input) > maxWidth)
		{
			return StripLength(input, maxWidth - suffixWidth) + suffix;
		}
		return input;
	}

	private string StripLength(string input, int maxWidth)
	{
		int num = 0;
		Font font = text.font;
		font.RequestCharactersInTexture(input, text.fontSize, text.fontStyle);
		CharacterInfo info = default(CharacterInfo);
		char[] array = input.ToCharArray();
		int num2 = 0;
		char[] array2 = array;
		foreach (char ch in array2)
		{
			font.GetCharacterInfo(ch, out info, text.fontSize);
			int num3 = num + info.advance;
			if (num3 > maxWidth)
			{
				if (Mathf.Abs(num3 - maxWidth) <= Mathf.Abs(maxWidth - num))
				{
					num = num3;
					num2++;
				}
				break;
			}
			num += info.advance;
			num2++;
		}
		return input.Substring(0, num2);
	}

	private int CalculateLengthOfText(string message)
	{
		int num = 0;
		Font font = text.font;
		font.RequestCharactersInTexture(message, text.fontSize, text.fontStyle);
		CharacterInfo info = default(CharacterInfo);
		char[] array = message.ToCharArray();
		foreach (char ch in array)
		{
			font.GetCharacterInfo(ch, out info, text.fontSize);
			num += info.advance;
		}
		return num;
	}
}
