using System.Collections.Generic;
using ACT.Game.Data;
using ACT.MultiPlayer;

namespace ACT.Core;

public interface ICharacterSource
{
	bool IsTrailCharacter { get; }

	CharacterUID GetUID();

	int Id();

	int Level();

	int Stage();

	CharacterIdentify GetCharacterIndentify();

	int GetEquipId(int index);

	Equip GetEquip(int index);

	Gem GetGem(int index);

	void GetConstellationStates(List<int> states);

	MPSkill GetUpgradeSkill(int skillid);

	byte GetSkillGroupLevel(int groupId);

	byte GetSkillGroupEventualLevel(int groupId, List<int> addSources = null);

	int GetCharacterSkinId();

	int ColorId();

	void SetSkin(int skinId, int colorId);
}
