namespace Ase;

[Trigger("Timeline2剧情队列弹窗")]
public class Timeline2PopupTipEventTrigger : TimelineEventTrigger
{
	public int popupTipQueueId;

	public PopupTipType popupTipType;

	public override string TriggerName => "Timeline-剧情队列弹窗";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (popupTipQueueId > 0)
		{
			Singleton<Story>.Instance.PlayQueueTip(popupTipType, popupTipQueueId);
		}
	}
}
