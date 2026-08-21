namespace Ase;

[Trigger("怪物组2新手引导触发器")]
public class MonsterGroupEvent2TeachGuideEventTrigger : MonsterGroupEventTrigger
{
	public int GuideId;

	public override string TriggerName => "怪物组-新手引导触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<TeachGuideSystem>().OpenTeachGuideWindow(GuideId, delayShow: false);
	}
}
