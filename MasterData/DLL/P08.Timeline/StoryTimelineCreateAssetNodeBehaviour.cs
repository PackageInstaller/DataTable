using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCreateAssetNodeBehaviour : PlayableBehaviour
{
	public string path;

	public Vector3 pos;

	public Vector3 fwd;

	private bool finished;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!finished && Application.isPlaying)
		{
			GameObject gameObject = Asset.Instantiate(path);
			if (gameObject != null)
			{
				gameObject.transform.position = pos;
				gameObject.transform.forward = fwd;
			}
			finished = true;
		}
	}
}
