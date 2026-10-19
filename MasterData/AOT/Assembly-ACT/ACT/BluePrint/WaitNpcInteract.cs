using System;
using System.Collections;
using ACT.Event;
using Fundamental;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class WaitNpcInteract : WaitUnit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	private sealed class Data : IGraphElementData
	{
		public SwitchInstruction WaitInteract = new SwitchInstruction();

		public int ID;

		public void IsInteract(BaseEventContent baseEventContent)
		{
			if (baseEventContent is NPCInteract nPCInteract && nPCInteract.npcId == ID)
			{
				WaitInteract.status = true;
			}
		}
	}

	[DoNotSerialize]
	public ValueInput npcId;

	protected override void Definition()
	{
		base.Definition();
		npcId = ValueInput("npcId", 0);
		Requirement(npcId, enter);
	}

	protected override IEnumerator Await(Flow flow)
	{
		Data data = flow.stack.GetElementData<Data>(this);
		data.ID = flow.GetValue<int>(npcId);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_NPC_Interact, data.IsInteract);
		yield return data.WaitInteract;
		data.WaitInteract.Reset();
		yield return exit;
	}

	public override void Uninstantiate(GraphReference instance)
	{
		Data elementData = instance.ToStackPooled().GetElementData<Data>(this);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_NPC_Interact, elementData.IsInteract);
		base.Uninstantiate(instance);
	}

	public IGraphElementData CreateData()
	{
		return new Data();
	}
}
