using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueEliteDescriptionItem : MonoBehaviour
{
	private static readonly Color LockedTextColor = new Color32(146, 147, 148, byte.MaxValue);

	private static readonly Color UnlockedTextColor = new Color32(168, 223, 125, byte.MaxValue);

	[SerializeField]
	private Image lockedIcon;

	[SerializeField]
	private Image unlockedIcon;

	[SerializeField]
	private TextMeshProUGUI descriptionText;

	public void Init(bool isUnlocked, string description, string unlockCondition)
	{
		lockedIcon.gameObject.SetActive(!isUnlocked);
		unlockedIcon.gameObject.SetActive(isUnlocked);
		if (!isUnlocked && !string.IsNullOrEmpty(unlockCondition))
		{
			description = (string.IsNullOrEmpty(description) ? unlockCondition : (description + "\n" + unlockCondition));
		}
		descriptionText.overrideColorTags = true;
		descriptionText.color = (isUnlocked ? UnlockedTextColor : LockedTextColor);
		descriptionText.text = description;
	}
}
