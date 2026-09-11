using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.UI;

public class InputFieldHelper : MonoBehaviour
{
	private InputField input;

	private List<string> patten = new List<string> { "\\p{Cs}", "\\p{Co}", "\\p{Cn}", "[\\u2702-\\u27B0]" };

	private void Start()
	{
		input = base.gameObject.GetComponent<InputField>();
		if (input != null)
		{
			input.onValidateInput = delegate(string text, int charIndex, char addedChar)
			{
				string str = addedChar.ToString();
				return FilterEmoji(str).IsNotNullOrEmpty() ? addedChar : '\0';
			};
		}
	}

	private void OnDestroy()
	{
	}

	private string FilterEmoji(string str)
	{
		for (int i = 0; i < patten.Count; i++)
		{
			str = Regex.Replace(str, patten[i], "");
		}
		return str;
	}

	public string TextLimit(string text, int num)
	{
		if (text.Length <= num)
		{
			return text;
		}
		return text.Substring(0, num);
	}
}
