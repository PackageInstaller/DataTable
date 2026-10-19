using System.Linq;
using System.Threading;
using ACT.Core;
using ACT.Game;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class StartRaidAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		StartRaidActionParam startRaidActionParam = Param as StartRaidActionParam;
		if (RuntimeConfigs.data.raids.TryGetValue(startRaidActionParam.raidId, out var value))
		{
			TeamViewData uiData = new TeamViewData
			{
				isRaidTeam = true,
				enterId = value.belongEntranceData,
				raidId = startRaidActionParam.raidId,
				source = TeamProfileSource.Raid,
				subWorldCharacters = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds.ToArray()
			};
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEAM, uiData);
		}
	}
}
