using UnityEngine;

public class DelayPlayAction : MonoBehaviour
{
	private Animator animator;

	public float delayTime;

	private float curTime;

	private bool stop;

	public bool PauseAction
	{
		get
		{
			return stop;
		}
		set
		{
			stop = value;
			if (value)
			{
				curTime += Time.deltaTime;
			}
		}
	}

	private void Start()
	{
		animator = base.gameObject.GetComponent("Animator") as Animator;
		if (curTime < delayTime)
		{
			animator.speed = 0f;
		}
	}

	private void Update()
	{
		if (!stop)
		{
			curTime += Time.deltaTime;
			if ((double)(curTime - delayTime) >= 0.0)
			{
				animator.speed = 1f;
			}
		}
	}
}
