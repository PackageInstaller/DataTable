using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public sealed class RogueSettlementTeamItem : MonoBehaviour
{
	public GameObject EmptyNode;

	public GameObject FilledNode;

	public BImage CharacterHead;

	public void SetData(bool hasCharacter, int characterId, bool isMainCharacter, ImageAssetStation station)
	{
		EmptyNode.SetActive(!hasCharacter);
		FilledNode.SetActive(hasCharacter);
		EntityCharacterProbation data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterProbations);
		if (data != null && hasCharacter)
		{
			station.LoadImage(148, data.showIcon, CharacterHead);
		}
		else
		{
			CharacterHead.icon.sprite = null;
		}
	}
}
