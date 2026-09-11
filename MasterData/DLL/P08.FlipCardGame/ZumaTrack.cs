using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaTrack : MonoBehaviour
{
	public Transform beginTrs;

	public SpriteRenderer endSp;

	[SerializeField]
	private GameObject warningObj;

	[SerializeField]
	private GameObject hideItemPrefab;

	public Transform hideNode;

	public List<ZumaBaseBall> ballSegmentList = new List<ZumaBaseBall>();

	public List<ZumaBaseBall> searchDestoryList = new List<ZumaBaseBall>();

	private List<ZumaBaseBall> fallbackList = new List<ZumaBaseBall>();

	private List<ZumaTrackHideEntity> hideList;

	private bool isMoveToBegin;

	public int remainBallNums;

	public int trackID;

	public bool trackGameOver;

	private float unCountRoutePointBegin;

	public int comboBackCount;

	public ZumaGamePlay gamePlay;

	public ZumaTrackData trackData;

	public ZumaTrackBallCreate ballCreate;

	public int ShowCount;

	public List<ZumaBaseBall> effectDestoryList = new List<ZumaBaseBall>();

	public float insertSpeed = 4f;

	public void Init(ZumaGamePlay gamePlay, int trackID)
	{
		this.gamePlay = gamePlay;
		this.trackID = trackID;
		trackGameOver = false;
		trackData = ZumaGameManager.GetInstance().GetTrackData(trackID);
		remainBallNums = trackData.ballCount;
		comboBackCount = 0;
		if (ballCreate == null)
		{
			ballCreate = new ZumaTrackBallCreate();
		}
		ballCreate.InitRandData();
		unCountRoutePointBegin = 0f;
		isMoveToBegin = false;
		ShowWarning(isShow: false);
		ClearAllBallList();
		InitHideList();
		warningObj.transform.localPosition = trackData.endPos;
	}

	public void ShowWarning(bool isShow)
	{
		if (warningObj.activeSelf != isShow)
		{
			warningObj.SetActive(isShow);
		}
	}

	public void InitHideList()
	{
		ClearHideList();
		hideList = new List<ZumaTrackHideEntity>();
		for (int i = 0; i < trackData.hideList.Count; i++)
		{
			ZumaTrackHideEntity component = Object.Instantiate(hideItemPrefab, hideNode).GetComponent<ZumaTrackHideEntity>();
			hideList.Add(component);
			component.Init(trackData.hideList[i]);
		}
	}

	public bool GetIsMoveToBegin()
	{
		return isMoveToBegin;
	}

	public void GetBallColorList(ref Dictionary<BallColorType, bool> colorDict)
	{
		int count = ballSegmentList.Count;
		while (count-- > 0)
		{
			ZumaBaseBall zumaBaseBall = ballSegmentList[count];
			do
			{
				colorDict[zumaBaseBall.colorType] = true;
				zumaBaseBall = zumaBaseBall.Next;
			}
			while (zumaBaseBall != null);
		}
	}

	public bool PathScoreSettle()
	{
		if (unCountRoutePointBegin >= trackData.EndPoint)
		{
			return true;
		}
		ShowWarning(isShow: false);
		Vector3 position = trackData.GetPosition(unCountRoutePointBegin);
		ZumaGameManager.GetInstance().SetZumaGameScore(position, ZumaGameConst.routeScore);
		unCountRoutePointBegin++;
		ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.EndTrackShow);
		return false;
	}

	public void Process()
	{
		if (!trackGameOver)
		{
			bool num = CheckBackEffect();
			if (num)
			{
				CheckMoveToBegin();
				FirstSegmentMove();
			}
			ShootBallInsert();
			SearchDestory();
			CheckFallbackBall();
			BallSegmentConnect();
			UpdateRoutePointPos();
			if (num)
			{
				CheckGameFail();
			}
			CheckShowWarning();
		}
	}

	private void UpdateRoutePointPos()
	{
		if (ballSegmentList.Count != 0)
		{
			unCountRoutePointBegin = ballSegmentList[ballSegmentList.Count - 1].Tail.progress;
		}
	}

	public bool CheckBackEffect()
	{
		if (fallbackList.Count > 0)
		{
			return true;
		}
		if (ballSegmentList.Count == 0)
		{
			return true;
		}
		if (!ZumaGameManager.GetInstance().IsMeetTrackEffect(BallEffctType.BACK, trackID))
		{
			return true;
		}
		ZumaBaseBall zumaBaseBall = ballSegmentList[ballSegmentList.Count - 1];
		if (zumaBaseBall != null)
		{
			float num = ZumaGameConst.GetTimeValue() * ZumaGameManager.GetInstance().GetStrikeEffectValueSpeed(BallEffctType.BACK);
			zumaBaseBall.progress -= num;
			ZumaGameManager.GetInstance().UpdateStrikeEffectValue(BallEffctType.BACK, num, trackID);
			if (zumaBaseBall.Tail.progress <= 0f)
			{
				ZumaGameManager.GetInstance().UpdateStrikeEffectValue(BallEffctType.BACK, 999f, trackID);
			}
			UpdateBallProgress(zumaBaseBall);
			return false;
		}
		return true;
	}

	public void CheckMoveToBegin()
	{
		if (ballSegmentList.Count == 0)
		{
			return;
		}
		if (isMoveToBegin && ZumaGameManager.GetInstance().isGameStart)
		{
			ZumaBaseBall tail = ballSegmentList[ballSegmentList.Count - 1].Tail;
			if (!(tail.progress <= 0.25f))
			{
				return;
			}
			isMoveToBegin = false;
			if (ZumaGameManager.GetInstance().isMoveToBegin)
			{
				Vector3 pos = tail.GetPos(0.1f);
				ZumaGameManager.GetInstance().SetZumaGameScore(pos, 100, isGold: false, isEnter: true);
				ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.BackEnd);
			}
		}
		if (ballSegmentList[0].Tail.progress >= (float)trackData.beginMoveToPoint)
		{
			isMoveToBegin = true;
		}
	}

	private void FirstSegmentMove()
	{
		if (ballSegmentList.Count == 0 && remainBallNums > 0)
		{
			ZumaBaseBall item = gamePlay.CreateZumaBall(this);
			ballSegmentList.Add(item);
			remainBallNums--;
			return;
		}
		if (ballSegmentList.Count == 0)
		{
			trackGameOver = true;
			return;
		}
		ZumaBaseBall zumaBaseBall = ballSegmentList[0];
		if (zumaBaseBall.IsExitStartHole() && remainBallNums > 0)
		{
			bool num = zumaBaseBall.IsJoinStartHole();
			ZumaBaseBall zumaBaseBall2 = gamePlay.CreateZumaBall(this);
			remainBallNums--;
			if (num)
			{
				zumaBaseBall2.Next = zumaBaseBall;
				zumaBaseBall.Pre = zumaBaseBall2;
				zumaBaseBall = zumaBaseBall2;
				ballSegmentList[0] = zumaBaseBall2;
			}
			else
			{
				ballSegmentList.Insert(0, zumaBaseBall2);
			}
		}
		if (!isMoveToBegin)
		{
			zumaBaseBall.progress += ZumaGameConst.GetTimeValue() * trackData.beginMoveSeepd;
		}
		else
		{
			zumaBaseBall.progress += ZumaGameConst.GetTimeValue() * ZumaGameManager.GetInstance().moveSpeed;
		}
		UpdateBallProgress(zumaBaseBall);
	}

	private void CheckGameFail()
	{
		int count = ballSegmentList.Count;
		if (count != 0 && ballSegmentList[count - 1].Tail.IsArriveFailHole())
		{
			gamePlay.gameOver = true;
			LuaHelper.CallFunction("ZumaToLuaBridge.OnZumaOver", false);
		}
	}

	private void CheckShowWarning()
	{
		if (ballSegmentList.Count == 0)
		{
			ShowWarning(isShow: false);
		}
		else if (ballSegmentList[ballSegmentList.Count - 1].Tail.IsArriveWarningHole())
		{
			ShowWarning(isShow: true);
		}
		else
		{
			ShowWarning(isShow: false);
		}
	}

	public bool CheckIsInHideRange(float progress)
	{
		bool flag = false;
		if (hideList != null)
		{
			foreach (ZumaTrackHideEntity hide in hideList)
			{
				flag = hide.CheckIsInRange(progress);
				if (flag)
				{
					break;
				}
			}
		}
		return flag;
	}

	private void ShootBallInsert()
	{
		ZumaGoldItem goldItem = gamePlay.itemManager.goldItem;
		Vector3 position = goldItem.transform.position;
		float dis = 0.18f;
		List<ZumaShootBall> shootBallList = ZumaShootBallManager.Instance.shootBallList;
		int count = shootBallList.Count;
		while (count-- > 0)
		{
			ZumaShootBall zumaShootBall = shootBallList[count];
			if (goldItem.isShow && zumaShootBall.IsCross(position, dis))
			{
				BallEffctType effectType = zumaShootBall.effectType;
				if (effectType == BallEffctType.CHANGECOLOR || effectType == BallEffctType.BOOM)
				{
					StrikeSpeicalEffect(zumaShootBall);
				}
				if (effectType != BallEffctType.BOOM)
				{
					goldItem.TriggerCollision();
				}
				ZumaShootBallManager.Instance.Recovery(zumaShootBall);
				shootBallList.RemoveAt(count);
				continue;
			}
			int count2 = ballSegmentList.Count;
			while (count2-- > 0)
			{
				bool flag = false;
				ZumaBaseBall zumaBaseBall = ballSegmentList[count2];
				do
				{
					if (!zumaBaseBall.disposeAni && !zumaBaseBall.IsInsertOrDispose() && zumaShootBall.IsCross(zumaBaseBall.transform.position, dis))
					{
						if (CheckIsInHideRange(zumaBaseBall.progress))
						{
							break;
						}
						comboBackCount = 0;
						bool flag2 = true;
						if (ZumaGameManager.GetInstance().zumaEndlessManager.isEndless)
						{
							flag2 = false;
						}
						if (zumaShootBall.IsNormalType())
						{
							ZumaBaseBall zumaBaseBall2 = gamePlay.InitInsertBall(this, zumaShootBall.colorType);
							float progress = zumaBaseBall.progress;
							float num = Vector3.Distance(zumaShootBall.transform.position, zumaBaseBall2.GetPos(progress + 1f));
							float num2 = Vector3.Distance(zumaShootBall.transform.position, zumaBaseBall2.GetPos(progress - 1f));
							bool flag3 = false;
							if (zumaBaseBall.colorType == zumaBaseBall2.colorType && zumaBaseBall.SameColorCount(out var _) >= 2)
							{
								flag3 = true;
							}
							bool flag4 = true;
							if (num > num2)
							{
								if (zumaBaseBall.Pre == null)
								{
									flag4 = false;
								}
								else
								{
									zumaBaseBall = zumaBaseBall.Pre;
								}
							}
							if (flag4)
							{
								ZumaBaseBall next = zumaBaseBall.Next;
								zumaBaseBall.Next = zumaBaseBall2;
								zumaBaseBall2.Pre = zumaBaseBall;
								zumaBaseBall2.Next = next;
								if (next != null)
								{
									next.Pre = zumaBaseBall2;
								}
								else if (count2 + 1 < ballSegmentList.Count)
								{
									ZumaBaseBall zumaBaseBall3 = ballSegmentList[count2 + 1];
									if (zumaBaseBall3 != null)
									{
										if (zumaBaseBall3.colorType == zumaBaseBall2.colorType)
										{
											if (zumaBaseBall3.FallbackTarget == null)
											{
												fallbackList.Add(zumaBaseBall3);
												zumaBaseBall3.noRomoveFallBackFlag = true;
											}
											zumaBaseBall3.FallbackTarget = zumaBaseBall2;
										}
										else if (zumaBaseBall3.FallbackTarget != null)
										{
											zumaBaseBall3.FallbackTarget = null;
											for (int num3 = fallbackList.Count - 1; num3 >= 0; num3--)
											{
												if (zumaBaseBall3.CheckIsSamePos(fallbackList[num3].progress))
												{
													fallbackList.RemoveAt(num3);
												}
											}
										}
									}
								}
								zumaBaseBall2.progress = zumaBaseBall.progress + 1f;
							}
							else
							{
								ZumaBaseBall pre = zumaBaseBall.Pre;
								zumaBaseBall.Pre = zumaBaseBall2;
								zumaBaseBall2.Pre = pre;
								zumaBaseBall2.Next = zumaBaseBall;
								ballSegmentList[count2] = zumaBaseBall2;
								if (count2 - 1 >= 0)
								{
									ZumaBaseBall tail = ballSegmentList[count2 - 1].Tail;
									if ((bool)zumaBaseBall && zumaBaseBall.FallbackTarget != null)
									{
										zumaBaseBall.FallbackTarget = null;
										for (int num4 = fallbackList.Count - 1; num4 >= 0; num4--)
										{
											if (zumaBaseBall.CheckIsSamePos(fallbackList[num4].progress))
											{
												fallbackList.RemoveAt(num4);
											}
										}
									}
									if (tail != null && tail.colorType == zumaBaseBall2.colorType && tail.FallbackTarget == null)
									{
										zumaBaseBall2.FallbackTarget = tail;
										fallbackList.Add(zumaBaseBall2);
										zumaBaseBall2.noRomoveFallBackFlag = true;
									}
								}
								zumaBaseBall2.progress = zumaBaseBall.progress;
							}
							if (ZumaGameManager.GetInstance().zumaEndlessManager.isEndless && !zumaBaseBall2.IsMeetDestory(count2))
							{
								flag2 = true;
							}
							if (!flag3)
							{
								zumaBaseBall2.InsertBegin();
							}
							else
							{
								zumaBaseBall2.isDirectDestory = true;
								zumaBaseBall2.transform.position = zumaShootBall.transform.position;
								zumaBaseBall2.InsertEnd();
							}
						}
						else if (zumaShootBall.effectType == BallEffctType.BULLET)
						{
							AudioManager.Instance.Play("effect", "minigame_activity_3_11", "minigame_activity_3_11_zuma_skill01_hit", useStream: false);
							if (ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.BulletShooterBallShootRangeAdd))
							{
								gamePlay.SetAllBallSpeicalEffect(zumaShootBall);
							}
							else
							{
								effectDestoryList.Add(zumaBaseBall);
							}
						}
						else
						{
							StrikeSpeicalEffect(zumaShootBall, zumaBaseBall.colorType);
						}
						if (flag2)
						{
							gamePlay.comboCount = 0;
						}
						ZumaShootBallManager.Instance.Recovery(zumaShootBall);
						shootBallList.RemoveAt(count);
						flag = true;
						break;
					}
					zumaBaseBall = zumaBaseBall.Next;
				}
				while (zumaBaseBall != null);
				if (flag)
				{
					break;
				}
			}
		}
	}

	private void StrikeSpeicalEffect(ZumaShootBall fb, BallColorType hitBallColorType = BallColorType.EmptyColor)
	{
		BallEffctType effectType = fb.effectType;
		if (effectType == BallEffctType.ALMIGHTY)
		{
			int count = ballSegmentList.Count;
			while (count-- > 0)
			{
				ZumaBaseBall zumaBaseBall = ballSegmentList[count];
				do
				{
					if (zumaBaseBall.colorType == hitBallColorType && zumaBaseBall.progress >= 0f)
					{
						effectDestoryList.Add(zumaBaseBall);
					}
					zumaBaseBall = zumaBaseBall.Next;
				}
				while (zumaBaseBall != null);
			}
		}
		else
		{
			gamePlay.SetAllBallSpeicalEffect(fb);
			switch (effectType)
			{
			case BallEffctType.CHANGECOLOR:
				ZumaGameManager.GetInstance().ShowEffect(fb.transform.position, FrameType.EFFECT_CHANGECOLOR, fb.colorType);
				break;
			case BallEffctType.BOOM:
				ZumaGameManager.GetInstance().ShowEffect(fb.transform.position, FrameType.EFFECT_BOOM);
				break;
			}
		}
	}

	private void SearchDestory()
	{
		ShowCount = searchDestoryList.Count;
		bool flag = false;
		int count = searchDestoryList.Count;
		while (count-- > 0)
		{
			ZumaBaseBall zumaBaseBall = searchDestoryList[count];
			List<ZumaBaseBall> list;
			if (!zumaBaseBall.IsInsertOrDispose())
			{
				if (zumaBaseBall.sameCount >= 0)
				{
					continue;
				}
				int num = zumaBaseBall.SameColorCount(out list);
				if (num >= 3)
				{
					comboBackCount++;
					gamePlay.comboCount++;
					foreach (ZumaBaseBall item in list)
					{
						item.DisposeBegin(num, gamePlay.comboCount);
					}
					if (gamePlay.comboCount > 1)
					{
						TriggerCombo(zumaBaseBall.transform.position);
						ZumaAudioManager.Instance.PlayZumaComboAudio(gamePlay.comboCount);
					}
					else
					{
						ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.DisposeBall);
					}
				}
				else
				{
					searchDestoryList.RemoveAt(count);
					RemoveTargetFallBackBall(zumaBaseBall, isNeedDelete: false);
				}
			}
			else
			{
				if (!zumaBaseBall.deleteFlag)
				{
					continue;
				}
				zumaBaseBall.SameColorCount(out list);
				foreach (ZumaBaseBall item2 in list)
				{
					item2.disposeAni = false;
				}
				searchDestoryList.RemoveAt(count);
				RemoveTargetFallBackBall(zumaBaseBall);
				flag = true;
			}
		}
		foreach (ZumaBaseBall effectDestory in effectDestoryList)
		{
			if (!effectDestory.disposeAni)
			{
				comboBackCount = 1;
				if (!ZumaGameManager.GetInstance().zumaEndlessManager.isEndless)
				{
					gamePlay.comboCount = 1;
				}
				break;
			}
		}
		int count2 = effectDestoryList.Count;
		while (count2-- > 0)
		{
			ZumaBaseBall zumaBaseBall2 = effectDestoryList[count2];
			if (!zumaBaseBall2.disposeAni)
			{
				zumaBaseBall2.DisposeBegin(1, gamePlay.comboCount);
			}
			else if (zumaBaseBall2.deleteFlag)
			{
				effectDestoryList.RemoveAt(count2);
				RemoveTargetFallBackBall(zumaBaseBall2);
				flag = true;
				zumaBaseBall2.disposeAni = false;
			}
		}
		if (flag)
		{
			RealDestory();
		}
	}

	private void TriggerCombo(Vector3 ballPos)
	{
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaCombo", gamePlay.comboCount);
		ZumaGameManager.GetInstance().ShowComboEffect(ballPos, ZumaGameManager.GetInstance().shootPos);
		if (comboBackCount > 1)
		{
			ZumaGameManager.GetInstance().StrikeComboEffect(comboBackCount, trackID);
		}
	}

	private void RealDestory()
	{
		int count = ballSegmentList.Count;
		while (count-- > 0)
		{
			int splitNums = 0;
			ZumaBaseBall zumaBaseBall = ballSegmentList[count];
			ZumaBaseBall firstBall = ballSegmentList[count];
			bool flag = false;
			do
			{
				if (zumaBaseBall.deleteFlag)
				{
					if ((bool)zumaBaseBall.Pre && !zumaBaseBall.Pre.deleteFlag)
					{
						firstBall = zumaBaseBall;
					}
					flag = true;
					if (zumaBaseBall.Pre != null)
					{
						zumaBaseBall.Pre.Next = null;
					}
					if (zumaBaseBall.Next != null)
					{
						zumaBaseBall.Next.Pre = null;
					}
					zumaBaseBall.Recovery();
					if (((bool)zumaBaseBall.Next && !zumaBaseBall.Next.deleteFlag) || zumaBaseBall.Next == null)
					{
						SplitSegementList(count, ref splitNums, firstBall, zumaBaseBall);
					}
				}
				zumaBaseBall = zumaBaseBall.Next;
			}
			while (zumaBaseBall != null);
		}
	}

	private void SplitSegementList(int j, ref int splitNums, ZumaBaseBall firstBall, ZumaBaseBall lastBall)
	{
		int num = j + splitNums;
		if ((bool)lastBall.Tail && lastBall.Tail != lastBall)
		{
			if (firstBall.Head == null || firstBall.Head == firstBall)
			{
				ballSegmentList[num] = lastBall.Tail.Head;
			}
			else
			{
				ballSegmentList[num] = firstBall.Head;
				ballSegmentList.Insert(num + 1, lastBall.Tail.Head);
				splitNums++;
			}
		}
		else if (firstBall.Head == null || firstBall.Head == firstBall)
		{
			ballSegmentList.RemoveAt(num);
			splitNums--;
		}
		ZumaBaseBall zumaBaseBall = null;
		if (firstBall.Pre != null)
		{
			zumaBaseBall = firstBall.Pre;
		}
		else if (num > 0)
		{
			zumaBaseBall = ballSegmentList[num - 1].Tail;
			num--;
		}
		else if (num == 0)
		{
			_ = ballSegmentList.Count;
			_ = 0;
		}
		if (zumaBaseBall != null)
		{
			ZumaBaseBall zumaBaseBall2 = null;
			if (lastBall.Next != null)
			{
				zumaBaseBall2 = lastBall.Next;
			}
			else if (num + 1 < ballSegmentList.Count)
			{
				zumaBaseBall2 = ballSegmentList[num + 1];
			}
			if (zumaBaseBall2 != null && zumaBaseBall2.colorType == zumaBaseBall.colorType && zumaBaseBall.IsExitEnterBegin())
			{
				zumaBaseBall2.FallbackTarget = zumaBaseBall;
				fallbackList.Add(zumaBaseBall2);
			}
		}
	}

	private void RemoveTargetFallBackBall(ZumaBaseBall targetBall, bool isNeedDelete = true)
	{
		int count = fallbackList.Count;
		while (count-- > 0)
		{
			ZumaBaseBall zumaBaseBall = fallbackList[count];
			if (zumaBaseBall.CheckIsSamePos(targetBall.progress))
			{
				if (!zumaBaseBall.noRomoveFallBackFlag)
				{
					fallbackList.RemoveAt(count);
				}
				else
				{
					zumaBaseBall.noRomoveFallBackFlag = false;
				}
			}
		}
	}

	private void CheckFallbackBall()
	{
		int num = -1;
		float num2 = -1f;
		int count = fallbackList.Count;
		while (count-- > 0)
		{
			ZumaBaseBall zumaBaseBall = fallbackList[count];
			if (!zumaBaseBall.gameObject.activeSelf || ((bool)zumaBaseBall.FallbackTarget && !zumaBaseBall.FallbackTarget.gameObject.activeSelf))
			{
				fallbackList.RemoveAt(count);
			}
			else if ((bool)zumaBaseBall.FallbackTarget && (zumaBaseBall.FallbackTarget.disposeAni || zumaBaseBall.FallbackTarget.deleteFlag))
			{
				fallbackList.RemoveAt(count);
			}
		}
		int count2 = fallbackList.Count;
		while (count2-- > 0)
		{
			ZumaBaseBall zumaBaseBall2 = fallbackList[count2];
			if (num2 < zumaBaseBall2.progress)
			{
				num2 = zumaBaseBall2.progress;
				num = count2;
			}
		}
		if (num < 0 || num > fallbackList.Count - 1)
		{
			return;
		}
		ZumaBaseBall zumaBaseBall3 = fallbackList[num];
		if (!(zumaBaseBall3 != null))
		{
			return;
		}
		if (zumaBaseBall3.disposeAni)
		{
			if (zumaBaseBall3.deleteFlag)
			{
				fallbackList.RemoveAt(num);
			}
			return;
		}
		zumaBaseBall3.progress -= ZumaGameConst.GetTimeValue() * 15f;
		UpdateBallProgress(zumaBaseBall3);
		if (zumaBaseBall3.progress <= zumaBaseBall3.FallbackTarget.progress + 0.96f)
		{
			searchDestoryList.Add(zumaBaseBall3);
		}
	}

	private void BallSegmentConnect()
	{
		int count = ballSegmentList.Count;
		while (count-- > 0)
		{
			if (ballSegmentList[count].isUnUse)
			{
				ballSegmentList.RemoveAt(count);
			}
		}
		int count2 = ballSegmentList.Count;
		while (count2-- > 1)
		{
			ZumaBaseBall zumaBaseBall = ballSegmentList[count2];
			ZumaBaseBall tail = ballSegmentList[count2 - 1].Tail;
			if (tail.progress >= zumaBaseBall.progress - 1f)
			{
				zumaBaseBall.progress = tail.progress + 1f;
				UpdateBallProgress(zumaBaseBall);
				tail.Next = zumaBaseBall;
				zumaBaseBall.Pre = tail;
				ballSegmentList.RemoveAt(count2);
			}
		}
	}

	public void UpdateBallProgress(ZumaBaseBall ball)
	{
		while (ball != null)
		{
			if (ball.Next != null && !ball.insertFlag)
			{
				if (ball.isDirectDestory)
				{
					ball.Next.progress = ball.progress;
				}
				else
				{
					ball.Next.progress = ball.progress + 1f;
				}
			}
			ball = ball.Next;
		}
	}

	public void ClearAllBallList()
	{
		RecoveryBallList();
		if (ballSegmentList != null)
		{
			ballSegmentList.Clear();
		}
		if (searchDestoryList != null)
		{
			searchDestoryList.Clear();
		}
		if (fallbackList != null)
		{
			fallbackList.Clear();
		}
	}

	public void Dispose()
	{
		ClearAllBallList();
		ClearHideList();
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}

	public void ClearHideList()
	{
		if (hideList == null)
		{
			return;
		}
		foreach (ZumaTrackHideEntity hide in hideList)
		{
			if (hide != null)
			{
				hide.Dispose();
			}
		}
		hideList.Clear();
		hideList = null;
	}

	public void RecoveryBallList()
	{
		int count = ballSegmentList.Count;
		while (count-- > 0)
		{
			ZumaBaseBall zumaBaseBall = ballSegmentList[count];
			do
			{
				zumaBaseBall.Recovery(isClear: true);
				zumaBaseBall = zumaBaseBall.Next;
			}
			while (zumaBaseBall != null);
		}
	}
}
