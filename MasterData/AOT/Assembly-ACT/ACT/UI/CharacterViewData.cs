using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;

namespace ACT.UI;

public class CharacterViewData : UIViewData
{
	public CharacterUID? defaultCharacterUID;

	public int defaultCharacterId = -1;

	public int PageIndex = -1;

	public SceneStatus OpenSceneStatus;

	public List<Character> DisplayCharacters;

	public bool HasDisplayCharacters
	{
		get
		{
			List<Character> displayCharacters = DisplayCharacters;
			if (displayCharacters != null)
			{
				return displayCharacters.Count > 0;
			}
			return false;
		}
	}
}
