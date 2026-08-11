using UnityEngine;

public class TimeDelay : MonoBehaviour
{
	public GameObject delayObject;

	public float delayTime = 2f;

	public float continuedTime = 5f;

	private float startTime;

	private void OnEnable()
	{
		if (!(delayObject == null))
		{
			startTime = Time.time;
			delayObject.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (!(delayObject == null))
		{
			if (Time.time - startTime >= delayTime + continuedTime)
			{
				delayObject.SetActive(value: false);
			}
			else if (Time.time - startTime >= delayTime)
			{
				delayObject.SetActive(value: true);
			}
		}
	}
}
