using System.Collections.Generic;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssCharacterItem : MonoBehaviour
{
	public List<AbyssTeamItem> character1;

	public List<AbyssTeamItem> character2;

	public List<AbyssTeamItem> character3;

	public List<BImage> character1Icon;

	public List<BImage> character2Icon;

	public List<BImage> character3Icon;

	public List<Button> eleBtns;

	public Sprite normalSprite;

	public void SetTeamCharacter(int teamIndex, int index, int charId, int charLevel)
	{
		switch (teamIndex)
		{
		case 0:
			character1[index].SetInfo(charId, charLevel);
			this.GetImageStation().LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, charId, character1Icon[index]);
			break;
		case 1:
			character2[index].SetInfo(charId, charLevel);
			this.GetImageStation().LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, charId, character2Icon[index]);
			break;
		case 2:
			character3[index].SetInfo(charId, charLevel);
			this.GetImageStation().LoadSprite(GameLoader.meta.CharacterSquareHeadIconAssetID, charId, character3Icon[index]);
			break;
		}
	}

	public void RemoveCharacter(int teamIndex, int index)
	{
		switch (teamIndex)
		{
		case 0:
			character1[index].UnLoad(normalSprite);
			character1Icon[index].UnLoad(releaseSprite: true, normalSprite);
			break;
		case 1:
			character2[index].UnLoad(normalSprite);
			character2Icon[index].UnLoad(releaseSprite: true, normalSprite);
			break;
		case 2:
			character3[index].UnLoad(normalSprite);
			character3Icon[index].UnLoad(releaseSprite: true, normalSprite);
			break;
		}
	}

	public ElementalResonance ChangeBtnState(int teamIndex)
	{
		for (int i = 0; i < eleBtns.Count; i++)
		{
			if (i == teamIndex)
			{
				eleBtns[i].interactable = true;
			}
			else
			{
				eleBtns[i].interactable = false;
			}
		}
		return eleBtns[teamIndex].GetComponent<ElementalResonance>();
	}

	public void UnLoadSprite()
	{
		for (int i = 0; i < 3; i++)
		{
			character1[i]?.UnLoad(normalSprite);
			character1Icon[i]?.UnLoad(releaseSprite: true, normalSprite);
			character2[i]?.UnLoad(normalSprite);
			character2Icon[i]?.UnLoad(releaseSprite: true, normalSprite);
			character3[i]?.UnLoad(normalSprite);
			character3Icon[i]?.UnLoad(releaseSprite: true, normalSprite);
		}
	}
}
