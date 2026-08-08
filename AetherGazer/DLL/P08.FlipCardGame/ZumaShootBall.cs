using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaShootBall : MonoBehaviour
{
	private float Speed = 5f;

	public BallEffctType effectType;

	public BallColorType colorType;

	public ZumaAnimator zumaAnimator;

	public Transform spriteTrs;

	private bool isInsert;

	private Vector3 rotateEuler = new Vector3(90f, 0f, 0f);

	public void RefrashShow(BallEffctType effectType, BallColorType colorType)
	{
		this.effectType = effectType;
		this.colorType = colorType;
		SetFrameSprite();
	}

	private void SetFrameSprite()
	{
		FrameSprite frameByEffectType = ZumaGameManager.GetInstance().shootBallSpriteMgr.GetFrameByEffectType(effectType, colorType);
		zumaAnimator.ChangeFrameList(frameByEffectType);
	}

	public void Init(BallEffctType effectType, BallColorType colorType, Transform trs, Transform rotateTrs)
	{
		RefrashShow(effectType, colorType);
		base.transform.position = trs.position;
		base.transform.rotation = rotateTrs.rotation;
		Vector3 eulerAngles = base.transform.rotation.eulerAngles;
		eulerAngles.z = 0f - eulerAngles.z;
		spriteTrs.localEulerAngles = eulerAngles;
		base.gameObject.SetActive(value: true);
		if (effectType == BallEffctType.BULLET)
		{
			Speed = ZumaGameManager.GetInstance().shootSpeed + (float)ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.BulletShooterBallShootSpeedAdd);
		}
		else
		{
			Speed = ZumaGameManager.GetInstance().shootSpeed;
		}
	}

	public void Move()
	{
		base.transform.localPosition += -1f * base.transform.right * ZumaGameConst.GetTimeValue() * Speed;
	}

	public bool isOutOfBounds()
	{
		if (base.transform.localPosition.x > 20f || base.transform.localPosition.x < -20f || base.transform.localPosition.y > 20f || base.transform.localPosition.y < -20f)
		{
			return true;
		}
		return false;
	}

	public bool isInsertInList()
	{
		return isInsert;
	}

	public ZumaBaseBall InsertInit(ZumaTrack track)
	{
		isInsert = true;
		return base.gameObject.AddComponent<ZumaBaseBall>().Init(effectType, colorType, track);
	}

	public bool IsCross(Vector3 targetPos, float dis)
	{
		return Vector2.Distance(base.transform.position, targetPos) <= dis;
	}

	public bool IsNormalType()
	{
		return effectType == BallEffctType.NORMAL;
	}

	private ZumaBaseBall GetTargetBall(ZumaBaseBall fb, int offsetIndex, List<ZumaBaseBall> ballSegmentList, int segmentIndex)
	{
		if (offsetIndex > 0)
		{
			fb = fb.Next;
			if (fb == null)
			{
				segmentIndex++;
				if (ballSegmentList.Count <= segmentIndex)
				{
					return null;
				}
				fb = ballSegmentList[segmentIndex];
			}
			return GetTargetBall(fb, offsetIndex - 1, ballSegmentList, segmentIndex);
		}
		if (offsetIndex < 0)
		{
			fb = fb.Pre;
			if (fb == null)
			{
				segmentIndex--;
				if (segmentIndex <= 0)
				{
					return null;
				}
				fb = ballSegmentList[segmentIndex];
			}
			return GetTargetBall(fb, offsetIndex + 1, ballSegmentList, segmentIndex);
		}
		return fb;
	}
}
