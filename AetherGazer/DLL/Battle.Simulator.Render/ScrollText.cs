using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class ScrollText : MonoBehaviour
{
	public Text text;

	public Mask mask;

	private float maskLength;

	private float curLength;

	public float speed = 10f;

	private Vector3 speedVect;

	private bool isStop;

	private bool isStart;

	public float startTime = 1f;

	public float stopTime = 1f;

	private bool needScroll;

	private float time;

	private float originPosX;

	private float targetPosX;

	public void Init(string textStr)
	{
		maskLength = (mask.transform as RectTransform).rect.width;
		text.text = textStr;
		StartCoroutine(InitScroll());
	}

	private IEnumerator InitScroll()
	{
		yield return new WaitForEndOfFrame();
		curLength = (text.transform as RectTransform).rect.width;
		originPosX = text.transform.localPosition.x;
		needScroll = curLength > maskLength;
		targetPosX = curLength - maskLength;
		speedVect = Vector3.zero.NewX(speed);
		isStart = true;
	}

	public void Update()
	{
		if (!needScroll)
		{
			return;
		}
		if (isStop)
		{
			time -= Time.deltaTime;
			if (time <= 0f)
			{
				isStop = false;
				time = startTime;
				targetPosX = curLength - maskLength;
				text.transform.localPosition = text.transform.localPosition.NewX(originPosX);
				isStart = true;
			}
		}
		else if (isStart)
		{
			time -= Time.deltaTime;
			if (time <= 0f)
			{
				isStart = false;
			}
		}
		else
		{
			targetPosX -= speed;
			Vector3 localPosition = text.transform.localPosition;
			localPosition -= speedVect;
			text.transform.localPosition = localPosition;
			if (targetPosX <= 0f)
			{
				time = stopTime;
				isStop = true;
			}
		}
	}
}
