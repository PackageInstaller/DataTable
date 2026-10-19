using ACT.Utility;

namespace ACT.UI;

public class LictletherCardDrawPanel : CardDrawBgComponent
{
	public ActButton ActJumpToCharacter;

	public int characterId;

	public override void Init()
	{
		base.Init();
		ActJumpToCharacter.SetBtnClick(() =>
		{
			JumpToCharacter(characterId);
		});
	}
}
