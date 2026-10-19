using System;
using ACT.Battle;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.NPC.Actions;

[Serializable]
public class ActionSetKeyPoint : NpcInteractAction
{
	public override int ActionId => NpcInteractActionIds.SetKeyPoint;

	protected override UniTask DoAction()
	{
		Singleton<ConversationManager>.instance.SetKeyPoint(Context.Npc.GetComponent<CompNpc>().NpcConfigUid);
		Singleton<ConversationManager>.instance.SendKeyPoints();
		return base.DoAction();
	}
}
