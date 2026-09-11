using UnityEngine;

public class UIShake : MonoBehaviour
{
	public float distance;

	public float minTime;

	public float maxTime;

	private Vector2 oriPos;

	private float curTime;

	private void Awake()
	{
		oriPos = (base.transform as RectTransform).anchoredPosition;
	}

	public void StartShake()
	{
		curTime = Random.Range(minTime, maxTime);
	}

	private void Update()
	{
		if (!(curTime < 0f))
		{
			curTime -= Time.deltaTime;
			if (curTime < 0f)
			{
				(base.transform as RectTransform).anchoredPosition = oriPos;
				return;
			}
			float x = Random.Range(0f - distance, distance);
			float y = Random.Range(0f - distance, distance);
			(base.transform as RectTransform).anchoredPosition = oriPos + new Vector2(x, y);
		}
	}
}
