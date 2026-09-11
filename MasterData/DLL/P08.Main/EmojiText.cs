using System;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.UI;

public class EmojiText : MonoBehaviour
{
	public Action<Image, string> onProcessComplete;

	private const char emSpace = '\u2001';

	private const string regexTag = "{emoji:(?<id>\\d*)}";

	public void SetText(Text textToEdit, string inputString)
	{
		StartCoroutine(ProcessText(textToEdit, inputString));
	}

	private IEnumerator ProcessText(Text label, string input)
	{
		Regex regex = new Regex("{emoji:(?<id>\\d*)}");
		List<EmojiItem> replaceEmojiList = new List<EmojiItem>();
		EmojiEffect emojiEffect = label.GetComponent<EmojiEffect>();
		if (emojiEffect == null)
		{
			emojiEffect = label.gameObject.AddComponent<EmojiEffect>();
		}
		int num = 0;
		int num2 = 0;
		foreach (Match item in regex.Matches(input))
		{
			string text = item.Value.ToString();
			int p = item.Index - num + num2;
			num += text.Length;
			num2++;
			text = text.Replace("{emoji:", "");
			text = text.Replace("}", "");
			replaceEmojiList.Add(new EmojiItem(p, text));
		}
		if (num2 == 0)
		{
			yield break;
		}
		string text2 = regex.Replace(input, '\u2001'.ToString());
		label.text = text2;
		yield return null;
		List<Image> list = emojiEffect.SetEmojiByEmojiRawImage(replaceEmojiList);
		if (onProcessComplete != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				onProcessComplete(list[i], replaceEmojiList[i].emoji);
			}
		}
	}
}
