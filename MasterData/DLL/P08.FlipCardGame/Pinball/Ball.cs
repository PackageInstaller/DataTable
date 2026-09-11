using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pinball;

public class Ball
{
	private readonly float mRadius;

	private Vector2 mPosition;

	private Vector2 mVelocity;

	public Transform mTransform;

	private float moveTime;

	private float predictTime;

	private Vector2 predictPos;

	private Vector2 predictVel;

	private bool over;

	private int lastCollisionId;

	private int collisionCount;

	private int collisionBlockCount;

	private int overCount;

	public BallType bType;

	public bool Static;

	private int convertRemainTime;

	private ParticleSystem effectChangePs;

	private ParticleSystem effectBreakPs;

	private ParticleSystem effectBuffAddPs;

	private ParticleSystem effectBuffOnePs;

	private ParticleSystem effectBuffTwoPs;

	private int breakTimer;

	private int currentBuffNum;

	private float[] spareParam;

	private float[] arrorParam;

	private float[] explosionParam;

	private BallBuffType currentBuffs;

	private int spareBuffRemainCount;

	public Ball(float r, Transform trs, BallType type)
	{
		mRadius = r;
		mTransform = trs;
		bType = type;
		Static = true;
		mPosition = new Vector2(trs.localPosition.x, trs.localPosition.y);
		mVelocity = Vector2.zero;
		moveTime = 0f;
		predictTime = 0f;
		predictPos = Vector2.zero;
		predictVel = Vector2.zero;
		over = true;
		lastCollisionId = -1;
		collisionCount = 0;
		collisionBlockCount = 0;
		overCount = ((type != BallType.tempBall) ? PinballGameManager.Instance.GetBaseOverTimes() : 0);
		convertRemainTime = 0;
		BindEffect();
	}

	public void Release()
	{
		mTransform = null;
		effectBreakPs = null;
		effectBuffAddPs = null;
		effectBuffOnePs = null;
		effectBuffTwoPs = null;
	}

	private void BindEffect()
	{
		effectBreakPs = mTransform.Find("Effectballdie/di_glo").GetComponent<ParticleSystem>();
		effectBuffAddPs = mTransform.Find("Effectballhuiju/1/glow").GetComponent<ParticleSystem>();
		effectBuffOnePs = mTransform.Find("Effectballweirao/1/lizi").GetComponent<ParticleSystem>();
		effectBuffTwoPs = mTransform.Find("Effectballweirao2/1/lizi").GetComponent<ParticleSystem>();
		effectBreakPs.Stop();
		effectBuffAddPs.Stop();
		effectBuffOnePs.Stop();
		effectBuffTwoPs.Stop();
		currentBuffNum = 0;
	}

	public void ActiveBall(Vector2 velocity)
	{
		mVelocity = velocity;
		MoveUpdate();
		moveTime = 0f;
		collisionCount = 0;
		collisionBlockCount = 0;
		PredictCollision();
		Static = false;
	}

	public void ResetBall(bool onlyStatic)
	{
		if (!onlyStatic)
		{
			mPosition = PinballGameManager.Instance.ResetPos;
			PlayBallAnim(show: true);
		}
		mVelocity = Vector2.zero;
		moveTime = 0f;
		predictTime = 0f;
		predictPos = Vector2.zero;
		predictVel = Vector2.zero;
		over = true;
		lastCollisionId = -1;
		collisionBlockCount = 0;
		collisionCount = 0;
		spareBuffRemainCount = 0;
		MoveUpdate();
		Static = true;
	}

	public void KinematicsUpdate(float dt)
	{
		if (Static)
		{
			return;
		}
		float num = dt;
		int num2 = 0;
		while (num > 0f && num2 < 6)
		{
			num2++;
			float num3 = predictTime - moveTime;
			if (num3 < 0f)
			{
				num3 = 0f;
			}
			if (num3 > 0f && num3 < 0.0001f)
			{
				num3 = 0.0001f;
			}
			float num4 = Mathf.Min(num, num3);
			if (num4 < num3 - 1E-08f)
			{
				mPosition += mVelocity * num4;
				moveTime += num4;
				num -= num4;
				MoveUpdate();
				continue;
			}
			mPosition = predictPos;
			moveTime = predictTime;
			num -= num4;
			MoveUpdate();
			HandleCollision();
			if (over)
			{
				break;
			}
			if (predictTime - moveTime <= 0.0001f)
			{
				moveTime += 0.0001f;
			}
		}
		if (num > 0f)
		{
			mPosition += mVelocity * num;
			moveTime += num;
			MoveUpdate();
		}
	}

	private void HandleCollision()
	{
		if (over)
		{
			PinballGameManager.Instance.StopABall(predictPos, onGround: true);
			ResetBall(onlyStatic: true);
			PlayBallAnim(show: false);
			return;
		}
		float num = Mathf.Max(0.4f * 0.12f, 0.01f);
		Vector2 vector = mVelocity;
		if (mVelocity.sqrMagnitude > 1E-08f)
		{
			mPosition = predictPos + mVelocity.normalized * num;
		}
		else
		{
			mPosition = predictPos + Vector2.up * num;
			mVelocity = new Vector2(0f, 0.02f);
		}
		Dictionary<int, BallPolygon> activeBlocks = PinballGameManager.Instance.activeBlocks;
		if (activeBlocks.ContainsKey(lastCollisionId))
		{
			if (PinballGameManager.Instance.arrowBuffRemainCount > 0 && lastCollisionId != -1 && !Enum.IsDefined(typeof(StaticItemType), (int)activeBlocks[lastCollisionId].GetPType()))
			{
				mVelocity = vector;
				predictVel = vector;
				(activeBlocks[lastCollisionId] as NormalBlock).ChangeToTargerRemainHp(-1);
				PinballGameManager.Instance.arrowBuffRemainCount--;
				if (PinballGameManager.Instance.arrowBuffRemainCount <= 0 && HasBuff(BallBuffType.arrow))
				{
					RemoveBuff(BallBuffType.arrow);
				}
			}
			Vector2 localPosition = activeBlocks[lastCollisionId].GetLocalPosition();
			if (activeBlocks[lastCollisionId].HasGameObject() && (activeBlocks[lastCollisionId].GetPType() != PolygonType.resetBlock || (!PinballGameManager.Instance.isSupplmenting && !PinballGameManager.Instance.isSupplmentFrame)))
			{
				activeBlocks[lastCollisionId].OnCollision(this);
			}
			mVelocity = predictVel;
			PinballGameManager.Instance.collsionCount++;
			collisionCount++;
			collisionBlockCount++;
			if (PinballGameManager.Instance.explosionBuffRemainCount > 0 && lastCollisionId != -1 && activeBlocks[lastCollisionId].GetPType() != PolygonType.portal && !PinballGameManager.Instance.isExplosionFrame)
			{
				PinballGameManager.Instance.BallExplosionInCircle(localPosition, PinballGameManager.Instance.explosionBuffRange);
				PinballGameManager.Instance.explosionBuffRemainCount--;
				if (PinballGameManager.Instance.explosionBuffRemainCount <= 0)
				{
					RemoveBuff(BallBuffType.explosion);
				}
			}
			if (HasBuff(BallBuffType.spare) && lastCollisionId != -1)
			{
				PinballGameManager.Instance.SpareBall(mPosition, (int)spareParam[1], isBallTrigger: true);
				RemoveBuff(BallBuffType.spare);
			}
		}
		else if (lastCollisionId == -1)
		{
			mVelocity = predictVel;
			collisionCount++;
			AudioManager.Instance.Play("effect", "minigame_activity_4_6", "minigame_activity_4_6_marble_wall", useStream: false);
		}
		if (bType == BallType.emptinessBall && collisionCount >= 10)
		{
			PinballGameManager.Instance.StopABall(predictPos, onGround: false);
			ResetBall(onlyStatic: true);
			PlayBallAnim(show: false);
			over = true;
		}
		else
		{
			moveTime = 0f;
			PredictCollision();
		}
	}

	public bool OnRoundAfter()
	{
		if (bType == BallType.tempBall)
		{
			PinballGameManager.Instance.FreeTempBall(this);
			return true;
		}
		UnityEngine.Object.Destroy(mTransform.gameObject);
		return true;
	}

	public void ConvertBallType(BallType newType, int time, float[] param)
	{
		convertRemainTime = time;
		if (newType != bType)
		{
			bType = newType;
			if (newType == BallType.powerBall)
			{
				overCount += (int)param[2];
			}
			GameObject gameObject = UnityEngine.Object.Instantiate(PinballGameManager.Instance.ballTemplate[(int)(newType - 1)], PinballGameManager.Instance.ballRootTrs);
			gameObject.transform.localPosition = mTransform.localPosition;
			mTransform.gameObject.SetActive(value: false);
			UnityEngine.Object.Destroy(mTransform.gameObject);
			mTransform = gameObject.transform;
			BindEffect();
			if (effectChangePs != null)
			{
				effectChangePs.Play();
			}
		}
	}

	public void SetBuffWithCount(BallBuffType buffType, int count, float[] param = null)
	{
		AddBuff(buffType);
		switch (buffType)
		{
		case BallBuffType.explosion:
			explosionParam = param;
			PinballGameManager.Instance.explosionBuffRemainCount = count;
			PinballGameManager.Instance.explosionBuffRange = explosionParam[2];
			break;
		case BallBuffType.spare:
			spareParam = param;
			spareBuffRemainCount = count;
			break;
		case BallBuffType.arrow:
			arrorParam = param;
			PinballGameManager.Instance.arrowBuffRemainCount = count;
			break;
		}
	}

	public void JustShow(bool show)
	{
		mTransform.SetActive(show);
	}

	public void PlayBallAnim(bool show)
	{
		if (show)
		{
			mTransform.gameObject.SetActive(value: true);
		}
		else
		{
			if (!(mTransform != null))
			{
				return;
			}
			effectBreakPs.Play();
			breakTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				if (mTransform != null)
				{
					mTransform.gameObject.SetActive(value: false);
				}
				FuncTimerManager.inst.RemoveFuncTimer(breakTimer);
			}, 0.33f, 1);
		}
	}

	private void MoveUpdate()
	{
		if (mTransform != null)
		{
			mTransform.localPosition = mPosition;
		}
	}

	private void PredictCollision()
	{
		predictTime = 560000f;
		predictPos = Vector2.zero;
		predictVel = Vector2.zero;
		over = false;
		if (mVelocity.magnitude < 1E-05f)
		{
			predictTime = 0f;
			over = true;
			return;
		}
		int num = -1;
		Dictionary<int, BallPolygon> activeBlocks = PinballGameManager.Instance.activeBlocks;
		foreach (BallPolygon value in activeBlocks.Values)
		{
			if (value is NormalBlock normalBlock && normalBlock.HasGameObject())
			{
				normalBlock.AdjustVerticesAndNormals();
			}
		}
		foreach (int key in activeBlocks.Keys)
		{
			Vector2 newPosition = Vector2.zero;
			Vector2 newVelocity = Vector2.zero;
			float num2 = activeBlocks[key].CheckCollision(mPosition, mVelocity, mRadius, out newPosition, out newVelocity);
			if (num2 > 0f && num2 < predictTime)
			{
				predictTime = num2;
				predictPos = newPosition;
				predictVel = newVelocity;
				num = key;
			}
		}
		lastCollisionId = num;
		float num3 = ((mVelocity.x < -1E-05f) ? ((mRadius - mPosition.x) / mVelocity.x) : 560000f);
		if (num3 < predictTime)
		{
			predictTime = num3;
			predictPos = mPosition + predictTime * mVelocity;
			predictVel = new Vector2(0f - mVelocity.x, mVelocity.y);
		}
		float num4 = ((mVelocity.y > 1E-05f) ? ((10f - mRadius - mPosition.y) / mVelocity.y) : 560000f);
		if (num4 < predictTime)
		{
			predictTime = num4;
			predictPos = mPosition + predictTime * mVelocity;
			predictVel = new Vector2(mVelocity.x, 0f - mVelocity.y);
		}
		float num5 = ((mVelocity.x > 1E-05f) ? ((10f - mRadius - mPosition.x) / mVelocity.x) : 560000f);
		if (num5 < predictTime)
		{
			predictTime = num5;
			predictPos = mPosition + predictTime * mVelocity;
			predictVel = new Vector2(0f - mVelocity.x, mVelocity.y);
		}
		float num6 = ((mVelocity.y < -1E-05f) ? ((0f - mRadius - mPosition.y) / mVelocity.y) : 560000f);
		if (num6 < predictTime)
		{
			predictTime = num6;
			predictPos = mPosition + predictTime * mVelocity;
			if (overCount > 0)
			{
				overCount--;
				predictVel = new Vector2(mVelocity.x, 0f - mVelocity.y);
			}
			else
			{
				overCount = PinballGameManager.Instance.GetBaseOverTimes();
				predictVel = Vector2.zero;
				over = true;
			}
		}
	}

	public void SetPosition(Vector2 position)
	{
		mPosition = position;
	}

	public Vector2 GetVelocity()
	{
		return mVelocity;
	}

	public Vector2 SetVelocity(Vector2 ve)
	{
		return mVelocity = ve;
	}

	public Vector3 GetVec3Velocity()
	{
		return new Vector3(mVelocity.x, mVelocity.y, 0f);
	}

	public float GetRadius()
	{
		return mRadius;
	}

	public void AddBuff(BallBuffType buffType)
	{
		currentBuffs |= buffType;
		effectBuffAddPs.Play();
		currentBuffNum++;
		UpdateBuffEffect();
	}

	public void UpdateBuffEffect()
	{
		if (currentBuffNum == 1)
		{
			effectBuffOnePs.Play();
			effectBuffTwoPs.Stop();
		}
		else if (currentBuffNum == 2)
		{
			effectBuffOnePs.Play();
			effectBuffTwoPs.Play();
		}
		else if (currentBuffNum == 0)
		{
			effectBuffOnePs.Stop();
			effectBuffTwoPs.Stop();
		}
	}

	public bool HasBuff(BallBuffType buffType)
	{
		return (currentBuffs & buffType) != 0;
	}

	public void RemoveBuff(BallBuffType buffType)
	{
		currentBuffs &= ~buffType;
		currentBuffNum--;
		UpdateBuffEffect();
	}

	public void ResetBuff()
	{
		currentBuffs = BallBuffType.None;
		currentBuffNum = 0;
	}

	public BallBuffType GetCurrentBuffs()
	{
		return currentBuffs;
	}
}
