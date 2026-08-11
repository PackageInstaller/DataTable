using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放剧情队列弹窗", 0)]
[Category("✫ DragonLost/Story")]
[Description("播放指定队列弹窗ID的剧情队列弹窗。")]
public class PlayStoryPopupTipAction : ActionTaskBase
{
	[Name("队列弹窗ID", 0)]
	[Description("要播放的队列弹窗的ID。")]
	public BBParameter<int> popupTipQueueId;

	[Name("弹窗类型", 0)]
	[Description("要播放的弹窗类型。")]
	public PopupTipType popupTipType;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (popupTipQueueId != null && popupTipQueueId.value > 0)
		{
			Singleton<Story>.Instance.PlayQueueTip(popupTipType, popupTipQueueId.value);
		}
		OnActionFinish();
	}
}
