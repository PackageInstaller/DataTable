using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TextLimit : MonoBehaviour
{
	private Text textComponent;

	private void Awake()
	{
		textComponent = GetComponent<Text>();
	}

	public string GetLimitedString(string value)
	{
		float num = Mathf.Abs(textComponent.GetComponent<RectTransform>().rect.size.x);
		TextGenerationSettings generationSettings = textComponent.GetGenerationSettings(new Vector2(10000f, 1000f));
		TextGenerator textGenerator = new TextGenerator();
		textGenerator.Populate(value, generationSettings);
		float num2 = 0f;
		IList<UICharInfo> characters = textGenerator.characters;
		for (int i = 0; i < characters.Count; i++)
		{
			num2 += characters[i].charWidth;
			if (num2 > num - 5f)
			{
				value = value.Substring(0, i);
				value += "…";
				Debug.Log("the words length is " + num2);
				break;
			}
		}
		return value;
	}
}
