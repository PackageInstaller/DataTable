using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RogueHudCharacterReplaceItem : MonoBehaviour
{
	public BImage ImageCharacterIcon;

	public LocalizeStringEvent TextNewName;

	public LocalizeStringEvent TextCharacterLevel;

	private ImageAssetStation station;

	private RogueElement element;

	private RogueAssistCharacter assistCharacter;

	private bool _isbuy;

	public void Init(RogueBagItemData data)
	{
		station = Model<RogueNewModel>.Interface.RogueStation;
		element = CoreUtils.GetData(data.RogueItem.ItemId, RuntimeConfigs.data.rogueElements);
		assistCharacter = CoreUtils.GetData(element.id, RuntimeConfigs.data.rogueAssistCharacters);
		station.LoadImage(188, element.iconAddress, ImageCharacterIcon);
		TextNewName.StringReference.TableEntryReference = element.name;
		TextMeshProUGUI component = TextCharacterLevel.GetComponent<TextMeshProUGUI>();
		string localizeString = LocalizationUtility.GetLocalizeString("Common", 2492);
		int tier = assistCharacter.tier;
		component.SetText(localizeString + tier);
	}
}
