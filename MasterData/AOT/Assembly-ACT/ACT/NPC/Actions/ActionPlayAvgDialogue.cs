using System;
using ACT.Drama;
using ACT.Event;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Serialization;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionPlayAvgDialogue : NpcInteractAction
{
	[FormerlySerializedAs("dialogueEnvironmentID")]
	public int avgGroupID;

	public override int ActionId => NpcInteractActionIds.PlayAvgDialogue;

	protected override async UniTask DoAction()
	{
		NpcEvent npcEvent = Singleton<EventManager>.instance.GetEvt<NpcEvent>();
		npcEvent.NpcID = Context.Npc.GetCompNpc().NpcConfigUid;
		npcEvent.AvgGroupID = avgGroupID;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_Dialog_Start, npcEvent);
		await Singleton<ConversationManager>.instance.BeginConversation(avgGroupID);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Npc_Dialog_Finish, npcEvent);
		Singleton<EventManager>.instance.ReleaseEvt(npcEvent);
		await base.DoAction();
	}
}
