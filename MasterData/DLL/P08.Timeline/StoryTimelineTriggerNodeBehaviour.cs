using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineTriggerNodeBehaviour : PlayableBehaviour
{
	public float range = 1f;

	private bool finished;

	private PlayableDirector pd;

	public void Finish()
	{
		finished = true;
		if (pd != null)
		{
			pd.Resume();
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!finished)
		{
			pd = playable.GetGraph().GetResolver() as PlayableDirector;
			pd.Pause();
			GameObject gameObject = playerData as GameObject;
			if (gameObject != null && Application.isPlaying)
			{
				StoryTimelineTriggerMonoBehaviour storyTimelineTriggerMonoBehaviour = U3DUtil.Get<StoryTimelineTriggerMonoBehaviour>(gameObject);
				storyTimelineTriggerMonoBehaviour.range = range;
				storyTimelineTriggerMonoBehaviour.node = this;
				storyTimelineTriggerMonoBehaviour.StartUpdate();
			}
		}
	}
}
