namespace Ase;

[Trigger("对话链2新手引导触发器")]
public class Dialogue2TeachGuideEventTrigger : DialogueChainEventTrigger
{
	public int GuideId;

	public override string TriggerName => "对话链-新手引导触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<TeachGuideSystem>().OpenTeachGuideWindow(GuideId, delayShow: false);
	}
}
