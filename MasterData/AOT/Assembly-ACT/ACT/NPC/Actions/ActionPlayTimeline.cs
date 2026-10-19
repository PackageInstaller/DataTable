using System;
using ACT.Drama;
using ACT.Event;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionPlayTimeline : NpcInteractAction
{
	public int timelineID;

	public override int ActionId => NpcInteractActionIds.PlayTimeline;

	protected override async UniTask DoAction()
	{
		await base.DoAction();
		await DoActionInternal();
	}

	private async UniTask DoActionInternal()
	{
		NpcEvent npcEvent = Singleton<EventManager>.instance.GetEvt<NpcEvent>();
		npcEvent.NpcID = Context.Npc.GetCompNpc().NpcConfigUid;
		npcEvent.AvgGroupID = timelineID;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_Timeline_Start, npcEvent);
		await Singleton<TimelineConversationManager>.instance.PlayTimeline(timelineID);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_Timeline_Finish, npcEvent);
		Singleton<EventManager>.instance.ReleaseEvt(npcEvent);
	}
}
