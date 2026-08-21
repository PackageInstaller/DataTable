using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Yarn.Unity;

public class CharacterColorView : DialogueViewBase
{
	[Serializable]
	public class CharacterColorData
	{
		public string characterName;

		public Color displayColor = Color.white;
	}

	[SerializeField]
	private Color defaultColor = Color.white;

	[SerializeField]
	private CharacterColorData[] colorData;

	[SerializeField]
	private List<TextMeshProUGUI> lineTexts = new List<TextMeshProUGUI>();

	public override void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		string characterName = dialogueLine.CharacterName;
		Color displayColor = defaultColor;
		if (!string.IsNullOrEmpty(characterName))
		{
			CharacterColorData[] array = colorData;
			foreach (CharacterColorData characterColorData in array)
			{
				if (characterColorData.characterName.Equals(characterName, StringComparison.InvariantCultureIgnoreCase))
				{
					displayColor = characterColorData.displayColor;
					break;
				}
			}
		}
		foreach (TextMeshProUGUI lineText in lineTexts)
		{
			((Graphic)(object)lineText).color = displayColor;
		}
		onDialogueLineFinished();
	}
}
