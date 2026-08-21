using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineEnableRenderNodeBehaviour : PlayableBehaviour
{
	public string path;

	public bool enable;

	private bool finished;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (finished)
		{
			return;
		}
		GameObject gameObject = playerData as GameObject;
		if (!(gameObject == null))
		{
			Transform transform = gameObject.transform.Find(path);
			if (transform != null)
			{
				transform.gameObject.SetActive(enable);
				finished = true;
			}
		}
	}
}
