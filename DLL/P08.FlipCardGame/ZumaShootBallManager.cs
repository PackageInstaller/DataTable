using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaShootBallManager : MonoBehaviour
{
	public static ZumaShootBallManager Instance;

	public GameObject ballPrefab;

	private ZumaPool<ZumaShootBall> pool;

	public List<ZumaShootBall> shootBallList = new List<ZumaShootBall>();

	private void Awake()
	{
		Instance = this;
		pool = new ZumaPool<ZumaShootBall>(InstanceObject, 5);
	}

	private ZumaShootBall InstanceObject()
	{
		GameObject obj = Object.Instantiate(ballPrefab, base.transform);
		obj.SetActive(value: false);
		return obj.GetComponent<ZumaShootBall>();
	}

	public void Process()
	{
		for (int num = shootBallList.Count - 1; num >= 0; num--)
		{
			if (shootBallList[num].isInsertInList())
			{
				shootBallList.RemoveAt(num);
			}
			else
			{
				shootBallList[num].Move();
				if (shootBallList[num].isOutOfBounds())
				{
					Recovery(shootBallList[num], isOutBound: true);
					shootBallList.RemoveAt(num);
				}
			}
		}
	}

	public void Recovery(ZumaShootBall ball, bool isOutBound = false)
	{
		ball.gameObject.SetActive(value: false);
		pool.AddObject(ball);
		if (!isOutBound)
		{
			if (ball.effectType == BallEffctType.BOOM)
			{
				ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.BoomBall);
			}
			else if (ball.effectType == BallEffctType.CHANGECOLOR)
			{
				ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.ChangeBall);
			}
			else if (ball.effectType == BallEffctType.ALMIGHTY)
			{
				ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.Combo5Hit);
			}
		}
	}

	public void Shoot(BallEffctType curBallEffect, BallColorType colorType, Transform trs, Transform rotateTrs)
	{
		ZumaShootBall ballObj = pool.GetBallObj();
		ballObj.Init(curBallEffect, colorType, trs, rotateTrs);
		shootBallList.Add(ballObj);
	}
}
