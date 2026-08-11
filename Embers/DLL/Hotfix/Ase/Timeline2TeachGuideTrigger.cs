namespace Ase;

[Trigger("Timeline2新手引导触发器")]
public class Timeline2TeachGuideTrigger : TimelineEventTrigger
{
	public int TeachGuideId;

	public override string TriggerName => "Timeline-新手引导触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<TeachGuideSystem>().OpenTeachGuideWindow(TeachGuideId, delayShow: false);
	}
}
