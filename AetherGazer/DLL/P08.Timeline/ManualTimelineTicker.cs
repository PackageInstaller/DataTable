using UnityEngine;
using UnityEngine.Playables;

[RequireComponent(typeof(PlayableDirector))]
public class ManualTimelineTicker : MonoBehaviour
{
	private PlayableDirector mDirector;

	public float max_step = 0.1f;

	private void Awake()
	{
		mDirector = GetComponent<PlayableDirector>();
		mDirector.timeUpdateMode = DirectorUpdateMode.Manual;
	}

	private void Update()
	{
		if (mDirector != null)
		{
			mDirector.playableGraph.Evaluate(Mathf.Min(Time.deltaTime, max_step));
		}
	}
}
