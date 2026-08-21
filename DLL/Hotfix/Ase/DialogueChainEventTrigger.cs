namespace Ase;

public class DialogueChainEventTrigger : BaseEventTriggerNode
{
	public override string TriggerName => "Npc事件触发器";

	public void UpdateEventNpcTriggerName()
	{
		UpdateEventTriggerName();
	}
}
