using UnityEngine;
using UnityEngine.Playables;

public class TimelineProcessController : MonoBehaviour
{
	public PlayableDirector playableDirector;

	private void Start()
	{
		if (!playableDirector)
		{
			playableDirector.time = 0.0;
			playableDirector.Pause();
		}
	}

	public void PlayFromTime(double time)
	{
		if (playableDirector != null)
		{
			playableDirector.time = time;
			playableDirector.Play();
		}
		else
		{
			Debug.LogError("PlayableDirector is not assigned!");
		}
	}

	public void PlayFromProgress(float progress)
	{
		if (playableDirector != null)
		{
			progress = Mathf.Clamp01(progress);
			double time = playableDirector.duration * (double)progress;
			playableDirector.time = time;
			playableDirector.Evaluate();
		}
		else
		{
			Debug.LogError("PlayableDirector is not assigned!");
		}
	}
}
