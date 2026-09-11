using UnityEngine;

namespace Dorm.Character.Animation;

[DisallowMultipleComponent]
public class DormSubtitleEventSMB : DormEntityStateEventBehaviour
{
	public Subtitle[] subtitles;

	public override void InvokeEvent(DormComplexEntity entity, in AnimatorStateInfo stateInfo, int layerIndex)
	{
		DormEntityAction.Notify("DORM_CHARACTER_PLAY_SUBTITLE_SEQ", entity.id, subtitles);
	}
}
