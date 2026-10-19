using ACT.Utility;

namespace ACT.UI;

public class NormalCardDrawPanel : CardDrawBgComponent
{
	public ActButton Card1JumpToCharacter;

	public int Card1characterId;

	public ActButton Card2JumpToCharacter;

	public int Card2characterId;

	public ActButton Card3JumpToCharacter;

	public int Card3characterId;

	public ActButton Card4JumpToCharacter;

	public int Card4characterId;

	public ActButton Card5JumpToCharacter;

	public int Card5characterId;

	public override void Init()
	{
		base.Init();
		Card1JumpToCharacter.SetBtnClick(() =>
		{
			Jump(Card1characterId);
		});
		Card2JumpToCharacter.SetBtnClick(() =>
		{
			Jump(Card2characterId);
		});
		Card3JumpToCharacter.SetBtnClick(() =>
		{
			Jump(Card3characterId);
		});
		Card4JumpToCharacter.SetBtnClick(() =>
		{
			Jump(Card4characterId);
		});
		Card5JumpToCharacter.SetBtnClick(() =>
		{
			Jump(Card5characterId);
		});
	}

	private void Jump(int characterId)
	{
		if (characterId != 0)
		{
			JumpToCharacter(characterId);
		}
	}
}
