using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class LightTowerRecover : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		RecoverHp evt = EventTrackSolver.Instance.GetEvt<RecoverHp>();
		evt.teleportId = stateObjectBase.swid;
		EventTrackSolver.Instance.Dispatch(evt);
		if (!MonoECS.instance.mainEntity.IsAlive())
		{
			return UniTask.CompletedTask;
		}
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				if (teamCharacter.IsAlive())
				{
					CompAbility? compAbility = teamCharacter.GetCompAbility();
					compAbility.ServerSetHP(compAbility.maxHP);
				}
				else
				{
					Singleton<RespawnManager>.instance.LocalEntityReborn(teamCharacter);
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
				}
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Player_Refresh, null);
		return UniTask.CompletedTask;
	}
}
