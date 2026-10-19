using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SetupBloodBottleAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		SetupBloodBottleActionParam setupBloodBottleActionParam = Param as SetupBloodBottleActionParam;
		List<PresetTeam> list = new List<PresetTeam>(G.localPlayer.teamInfo.PresetTeams.Clone());
		int mainTeamIdx = G.localPlayer.teamInfo.MainTeamIdx;
		list[mainTeamIdx].EquipPotionId = setupBloodBottleActionParam.bloodBottleId;
		ChangeAllTeamProfile evt = Singleton<EventManager>.instance.GetEvt<ChangeAllTeamProfile>();
		evt.battleIndex = MonoECS.instance.battleEntityIndex;
		evt.battleTeamIndex = mainTeamIdx;
		evt.teamProfiles = list;
		evt.source = TeamProfileSource.World;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Team_ChangeAllTeamProfile, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		return UniTask.CompletedTask;
	}
}
