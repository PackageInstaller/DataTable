using System.Linq;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;

namespace ACT.Manager;

public class AssistNpcModel : Model<AssistNpcModel>
{
	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public void AssistNpcHelp(int npcId)
	{
		G.service.SendAssistNpcHelp(npcId, Singleton<GameManager>.instance.worldManager.ActiveWorldId, null);
		ApcEvent evt = EventTrackSolver.Instance.GetEvt<ApcEvent>();
		evt.apcId = npcId;
		evt.status = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void AssistNpcHelpFinish(int npcId)
	{
		G.service.SendAssistNpcFinish(npcId, null);
		ApcEvent evt = EventTrackSolver.Instance.GetEvt<ApcEvent>();
		evt.apcId = npcId;
		evt.status = 3;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public bool IsNpcAssist(int npcId)
	{
		return G.localPlayer.AssistantSystem.Npcs.Any((AssistantNpc npc) => npc.Id == npcId);
	}
}
