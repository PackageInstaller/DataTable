using ACT.Game.Data;

namespace ACT.UI;

public class CharactersModel
{
	public bool IsSelect { get; private set; }

	public Character Character { get; }

	public CharactersModel(Character character, bool isSelect)
	{
		IsSelect = isSelect;
		Character = character;
	}

	public void UpdateSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
