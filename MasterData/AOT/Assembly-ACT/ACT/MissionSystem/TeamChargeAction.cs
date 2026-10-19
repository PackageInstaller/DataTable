using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class TeamChargeAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				CompCharacter compCharacter = teamCharacter.GetCompCharacter();
				CompAbility? compAbility = teamCharacter.GetCompAbility();
				float skillEnergy = RuntimeConfigs.data.entityCharacterDatas[compCharacter.characterSource.Id()].skillEnergy;
				compAbility.CurrentUltimateSkillValue = skillEnergy;
			}
		}
		return UniTask.CompletedTask;
	}
}
