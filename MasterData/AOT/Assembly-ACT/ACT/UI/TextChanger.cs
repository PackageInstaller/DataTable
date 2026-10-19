using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TextChanger : LuminSerializedMonoBehaviour
{
	public class TextModify
	{
		public TMP_Text text;

		public Color normal;

		public Color selected;
	}

	public TextModify[] texts;

	private void Awake()
	{
		if (!enabled)
		{
			ApplyColor(isSelected: false);
		}
	}

	private void OnEnable()
	{
		ApplyColor(isSelected: true);
	}

	private void OnDisable()
	{
		ApplyColor(isSelected: false);
	}

	public void SetColor(bool isSelect)
	{
		ApplyColor(isSelect);
	}

	private void ApplyColor(bool isSelected)
	{
		if (texts == null)
		{
			return;
		}
		TextModify[] array = texts;
		foreach (TextModify textModify in array)
		{
			if (textModify != null && !(textModify.text == null))
			{
				textModify.text.color = (isSelected ? textModify.selected : textModify.normal);
			}
		}
	}
}
