using ACT.Game.Data;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RogueBubbleItem : MonoBehaviour
{
	public LocalizeStringEvent TextLocalize;

	public void Init(RogueRoomType roomType)
	{
		if (TextLocalize == null)
		{
			Debug.LogError("Rogue bubble text localization is not configured", this);
			return;
		}
		LocalizationCommonData.CommonString commonString;
		switch (roomType)
		{
		case RogueRoomType.Cion:
			commonString = LocalizationCommonData.CommonString.RogueCoinGate;
			break;
		case RogueRoomType.Ally:
			commonString = LocalizationCommonData.CommonString.RogueAssistGate;
			break;
		case RogueRoomType.Item:
			commonString = LocalizationCommonData.CommonString.RogueItemGate;
			break;
		case RogueRoomType.Shop:
			commonString = LocalizationCommonData.CommonString.RogueResourceGate;
			break;
		case RogueRoomType.Boss:
			commonString = LocalizationCommonData.CommonString.RogueBossGate;
			break;
		default:
			Debug.LogError($"Unsupported rogue bubble room type: {roomType}", this);
			return;
		}
		TextLocalize.StringReference.SetReference("Common", (long)commonString);
	}
}
