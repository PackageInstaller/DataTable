using UnityEngine;

public class CowRun : MonoBehaviour
{
	public float speed;

	private bool isPause;

	private bool isStop;

	private void Start()
	{
	}

	private void Update()
	{
		if (!isPause && !isStop && base.gameObject.activeInHierarchy)
		{
			base.gameObject.transform.localPosition += Vector3.right * speed * Time.deltaTime;
		}
	}

	public void SetSpeed(float sp)
	{
		speed = sp;
	}

	public void SetPause(bool pause)
	{
		isPause = pause;
	}

	public void SetStop(bool st)
	{
		isStop = st;
	}
}
