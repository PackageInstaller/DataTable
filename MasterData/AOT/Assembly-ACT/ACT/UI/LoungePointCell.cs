using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class LoungePointCell : MonoBehaviour
{
	public LocalizeStringEvent pointNameLocalize;

	public TextMeshProUGUI pointNameText;

	public BImage characterHeadImage;

	public GameObject inStoryStatus;

	public GameObject characterStatus;

	public GameObject canTriggerStory;

	public GameObject canTriggerChat;

	public GameObject canTriggerBoth;

	private int _pointId;

	public void Init(int pointId, ImageAssetStation station, int characterId = 0)
	{
		_pointId = pointId;
		LoungePoint loungePoint = Model<LoungeModel>.Interface.IndexToCharacter[_pointId];
		if (loungePoint != null)
		{
			gameObject.SetActive(value: true);
			pointNameLocalize.StringReference.TableEntryReference = loungePoint.name;
			inStoryStatus.SetActive(characterId != 0 && loungePoint.useType == LoungeInteractPointUseType.LoungeInteractPointUseGlobal);
			canTriggerStory.SetActive(loungePoint.waitStory != 0 && loungePoint.performID == 0);
			canTriggerChat.SetActive(loungePoint.waitStory == 0 && loungePoint.performID != 0);
			canTriggerBoth.SetActive(loungePoint.waitStory != 0 && loungePoint.performID != 0);
			characterStatus.SetActive(characterId != 0);
			if (characterId != 0)
			{
				station.LoadImage(126, CharacterSkinRuntimeUtility.ResolveBagCharacterSkinId(characterId), characterHeadImage);
			}
		}
	}
}
