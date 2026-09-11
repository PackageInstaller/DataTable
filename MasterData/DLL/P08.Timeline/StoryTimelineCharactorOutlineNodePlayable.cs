using UnityEngine.Playables;

public class StoryTimelineCharactorOutlineNodePlayable : PlayableBehaviour
{
	private CharacterEffect characterEffect;

	private bool originalValue;

	public override void OnGraphStop(Playable playable)
	{
		if (characterEffect != null)
		{
			characterEffect.selectedOutline = originalValue;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (characterEffect != null)
		{
			characterEffect.selectedOutline = originalValue;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (characterEffect == null)
		{
			characterEffect = (CharacterEffect)playerData;
			if (characterEffect != null)
			{
				originalValue = characterEffect.selectedOutline;
				characterEffect.selectedOutline = true;
			}
		}
	}
}
