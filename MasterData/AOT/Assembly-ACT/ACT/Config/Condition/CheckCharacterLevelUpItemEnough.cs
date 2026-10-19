using ACT.Battle;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Config.Condition;

public class CheckCharacterLevelUpItemEnough : GuideStepCondition
{
	public int AddLevel = 1;

	public override bool CheckCondition()
	{
		if (MonoECS.instance.mainEntity.GetCompCharacter() == null)
		{
			return false;
		}
		if (MonoECS.instance.mainEntity.GetCompCharacter().characterSource.IsTrailCharacter)
		{
			return false;
		}
		Character character = G.localPlayer.GetCharacter(MonoECS.instance.mainEntity.GetCompCharacter().characterSource.Id());
		if (character == null)
		{
			return false;
		}
		if (character.Level >= AddLevel)
		{
			return false;
		}
		PlayerLevelData data = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas);
		if (data == null)
		{
			return false;
		}
		int characterLevel = data.characterLevel;
		if (character.Level >= characterLevel)
		{
			return false;
		}
		int num = Mathf.Min(AddLevel, characterLevel);
		if (num - character.Level <= 0)
		{
			return false;
		}
		int xpTotal = RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId()].xpTotal;
		int num2 = RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId(num)].xpTotal - xpTotal - character.Exp;
		if (num2 < 0)
		{
			num2 = 0;
		}
		int num3 = Mathf.CeilToInt((float)num2 / RuntimeConfigs.data.game.expToCoinData);
		G.detailUserInfo.Attributes.TryGetValue(2, out var value);
		G.detailUserInfo.Attributes.TryGetValue(1, out var value2);
		if (value2 >= num2)
		{
			return value >= num3;
		}
		return false;
	}
}
