namespace Ase;

[Trigger("怪物组2剧情队列弹窗事件触发器")]
public class MonsterGroup2StoryPopupTipEventTrigger : MonsterGroupEventTrigger
{
	public int popupTipQueueId;

	public PopupTipType popupTipType;

	public override string TriggerName => "怪物组-剧情队列弹窗事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (popupTipQueueId > 0)
		{
			Singleton<Story>.Instance.PlayQueueTip(popupTipType, popupTipQueueId);
		}
	}
}
