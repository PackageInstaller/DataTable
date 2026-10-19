using ACT.Model;
using ACT.UI;
using Bamboo.ECS;

namespace ACT.Battle;

public class CompOperateBtn : EcsComponent
{
	private CharacterOperateBtnGroupData _btnGroupData;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
	}

	public void InitTeamCharacterOperateBtnData()
	{
		if (!owner.IsValid || !Model<CustomUIModel>.HasInstance() || !(Model<CustomUIModel>.Interface.characterOperateBtnConfigs != null))
		{
			return;
		}
		CharacterOperateBtnConfigs characterOperateBtnConfigs = Model<CustomUIModel>.Interface.characterOperateBtnConfigs;
		CompCharacter compCharacter = owner.GetCompCharacter();
		if (compCharacter == null)
		{
			return;
		}
		foreach (CharacterOperateBtnConfig characterConfig in characterOperateBtnConfigs.characterConfigs)
		{
			if (characterConfig.characterId == compCharacter.characterSource.Id())
			{
				_btnGroupData = new CharacterOperateBtnGroupData(characterConfig, owner);
				break;
			}
		}
	}

	public CharacterOperateBtnGroupData GetBtnData()
	{
		return _btnGroupData;
	}
}
