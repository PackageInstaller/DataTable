using UnityEngine.Timeline;

namespace Ase;

[CustomStyle("StoryPopupSignalEmitter")]
public class StoryPopupSignalEmitter : CustomSignalEmitter
{
	public int tipId;

	private PopupTipType type;

	public void DoExecute()
	{
		Singleton<Story>.Instance.PlayQueueTip(type, tipId);
	}
}
