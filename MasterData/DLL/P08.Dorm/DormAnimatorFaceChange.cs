using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

[RequireComponent(typeof(SDCharacter))]
public class DormAnimatorFaceChange : MonoBehaviour
{
	public int faceTotalNum;

	public float faceChangeTime = 0.1f;

	public float restTime = 2f;

	public int startIndex;

	private int timer;

	public SDCharacter sDCharacter;

	private int currentIndex;

	private int timerTimes;

	private float waitTime;

	private void Start()
	{
		if (!Application.isPlaying)
		{
			return;
		}
		if (sDCharacter == null)
		{
			sDCharacter = GetComponent<SDCharacter>();
		}
		if (!(sDCharacter != null))
		{
			return;
		}
		currentIndex = startIndex;
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (timerTimes % (2 * faceTotalNum - 1) == 0)
			{
				if (waitTime < restTime)
				{
					waitTime += faceChangeTime;
					return;
				}
				waitTime = 0f;
				currentIndex = 0;
			}
			int sheetFaceId = (int)Mathf.PingPong(currentIndex, faceTotalNum - 1);
			sDCharacter.sheetFaceId = sheetFaceId;
			timerTimes++;
			currentIndex++;
		}, faceChangeTime);
	}

	private void OnDestroy()
	{
		if (timer != 0 && FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
		}
	}
}
