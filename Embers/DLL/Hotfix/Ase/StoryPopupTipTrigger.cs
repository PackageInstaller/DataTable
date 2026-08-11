namespace Ase;

[Trigger("播放剧情队列弹窗触发器")]
public class StoryPopupTipTrigger : BaseTrigger
{
	public int popupTipQueueId;

	public PopupTipType popupTipType;

	public override string TriggerName => "播放剧情队列弹窗触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (popupTipQueueId > 0)
		{
			Singleton<Story>.Instance.PlayQueueTip(popupTipType, popupTipQueueId);
		}
	}
}
