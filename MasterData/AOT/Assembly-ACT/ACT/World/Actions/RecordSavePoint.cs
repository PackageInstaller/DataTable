using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class RecordSavePoint : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		_ = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		Dictionary<int, CharacterStatus> dictionary = new Dictionary<int, CharacterStatus>();
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				CompAbility compAbility = teamCharacter.GetCompAbility();
				CharacterStatus characterStatus = new CharacterStatus
				{
					ExPower = compAbility.CurrentUltimateSkillValue
				};
				int hpSync = RuntimeConfigs.data.game.hpSync;
				characterStatus.Hp = Mathf.CeilToInt((float)compAbility.hp * 1f / (float)compAbility.maxHP * (float)hpSync);
				characterStatus.AssistPower = compAbility.AssistValue;
				characterStatus.EnergyPower = compAbility.EnergyValue;
				dictionary.Add(teamCharacter.GetCompCharacter().characterSource.Id(), characterStatus);
			}
		}
		return UniTask.CompletedTask;
	}
}
