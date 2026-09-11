using UnityEngine;

public class PrefabEffectItem
{
	public GameObject gameObject;

	private Transform transform;

	public float recycleTimes = 0.2f;

	public float existTimes;

	public Vector2 beginPos;

	public Vector2 toPos;

	public bool isShow;

	public void Init(GameObject gameObject)
	{
		this.gameObject = gameObject;
		transform = gameObject.transform;
		isShow = false;
		gameObject.SetActive(value: false);
	}

	public void BeginShow(Vector3 beginPos, Vector2 toPos)
	{
		gameObject.SetActive(value: true);
		this.beginPos = beginPos;
		this.toPos = toPos;
		existTimes = 0f;
		isShow = true;
	}

	public void Process()
	{
		if (isShow)
		{
			existTimes += Time.deltaTime;
			if (existTimes >= recycleTimes)
			{
				isShow = false;
				gameObject.SetActive(value: false);
			}
			transform.position = Vector2.Lerp(beginPos, toPos, existTimes / recycleTimes);
		}
	}
}
