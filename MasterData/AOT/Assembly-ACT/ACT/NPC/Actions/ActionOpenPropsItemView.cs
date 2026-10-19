using System;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionOpenPropsItemView : NpcInteractAction
{
	public int missionID;

	public override int ActionId => NpcInteractActionIds.OpenPropsItemView;

	protected override async UniTask DoAction()
	{
		UIOpenResult uiOpenResult = Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_PROPSSUBMISSON, new PropsSubmissonViewData
		{
			npcUid = Context.Npc.GetCompNpc().NpcConfigUid,
			id = missionID
		});
		await UniTask.WaitUntil(() =>
		{
			UIState uIState = Singleton<NewUIManager>.instance.GetUIState(uiOpenResult.Uid);
			return uIState == UIState.Closing || uIState == UIState.Closed || uIState == UIState.None;
		});
		await base.DoAction();
	}
}
