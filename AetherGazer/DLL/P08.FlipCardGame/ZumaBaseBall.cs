using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaBaseBall : MonoBehaviour
{
	public float progress;

	protected SpriteRenderer spriteRendener;

	public BallColorType colorType;

	public BallEffctType effectType;

	public bool isDirectDestory;

	public bool deleteFlag;

	public ZumaBaseBall FallbackTarget;

	public bool disposeAni;

	public bool insertFlag;

	public bool isUnUse;

	public bool noRomoveFallBackFlag;

	private bool insertFrameAni;

	public bool insertAni;

	private float insertAniProgress;

	private Vector3 insertBeginPos;

	public ZumaTrack track;

	private ZumaAnimator _bgAnimator;

	public int sameCount = -1;

	public ZumaAnimator bgAnimator
	{
		get
		{
			if (_bgAnimator == null)
			{
				_bgAnimator = base.transform.GetComponent<ZumaAnimator>();
			}
			return _bgAnimator;
		}
	}

	public ZumaBaseBall Next { get; set; }

	public ZumaBaseBall Pre { get; set; }

	public ZumaBaseBall Tail
	{
		get
		{
			ZumaBaseBall zumaBaseBall = this;
			while (true)
			{
				if (zumaBaseBall.Next == null)
				{
					return zumaBaseBall;
				}
				if (zumaBaseBall.Next.isUnUse)
				{
					break;
				}
				zumaBaseBall = zumaBaseBall.Next;
			}
			return zumaBaseBall;
		}
	}

	public ZumaBaseBall Head
	{
		get
		{
			ZumaBaseBall zumaBaseBall = this;
			while (true)
			{
				if (zumaBaseBall.Pre == null)
				{
					return zumaBaseBall;
				}
				if (zumaBaseBall.Pre.isUnUse)
				{
					break;
				}
				zumaBaseBall = zumaBaseBall.Pre;
			}
			return zumaBaseBall;
		}
	}

	public ZumaBaseBall Init(BallEffctType effectType, BallColorType colorType, ZumaTrack track)
	{
		this.effectType = effectType;
		this.colorType = colorType;
		this.track = track;
		SpawnInit();
		base.gameObject.SetActive(value: true);
		Sprite spirteRender = ZumaGameManager.GetInstance().trackBallSpriteMgr.GetFrameBg(effectType, colorType).spriteList[0];
		SetSpirteRender(spirteRender);
		InitData();
		InitShow();
		isDirectDestory = false;
		return this;
	}

	public virtual void ChangeColorType(BallColorType colorType)
	{
	}

	public virtual void InitShow()
	{
	}

	public virtual void Recovery(bool isClear = false)
	{
	}

	public void SpawnInit()
	{
		spriteRendener = GetComponent<SpriteRenderer>();
	}

	public void SetSpirteRender(Sprite sp)
	{
		if (spriteRendener == null)
		{
			SpawnInit();
		}
		spriteRendener.sprite = sp;
	}

	public void InitData()
	{
		progress = 0f;
		deleteFlag = false;
		disposeAni = false;
		insertFlag = false;
		isUnUse = false;
		noRomoveFallBackFlag = false;
		insertFrameAni = false;
		insertAni = false;
		insertAniProgress = 0f;
		Next = null;
		Pre = null;
		sameCount = -1;
		bgAnimator.ClearState();
		FallbackTarget = null;
	}

	public void InsertBegin()
	{
		insertFlag = true;
		insertAni = true;
		insertFrameAni = true;
		insertAniProgress = 0f;
		insertBeginPos = GetPos(progress);
		Sprite spirteRender = ZumaGameManager.GetInstance().trackBallSpriteMgr.GetFrameSprite(FrameType.EFFECT_INSERT).spriteList[0];
		SetSpirteRender(spirteRender);
		ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.InsertBallBegin);
	}

	public void InsertEnd()
	{
		insertFlag = false;
		insertAni = false;
		insertAniProgress = 0f;
		InsertAniEnd();
		track.searchDestoryList.Add(this);
		ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.InsertBallEnd);
	}

	public void InsertAniEnd()
	{
		if (insertFrameAni)
		{
			Sprite spirteRender = ZumaGameManager.GetInstance().trackBallSpriteMgr.GetFrameBg(effectType, colorType).spriteList[0];
			SetSpirteRender(spirteRender);
			insertFrameAni = false;
		}
	}

	public void ProgressUpdate()
	{
		if (isDirectDestory || IsArriveFailHole())
		{
			return;
		}
		Vector3 pos = GetPos(progress);
		if (insertAni)
		{
			insertAniProgress += ZumaGameConst.GetTimeValue() * track.insertSpeed;
			if (insertAniProgress <= 1f)
			{
				base.transform.position = Vector3.Lerp(insertBeginPos, pos, insertAniProgress);
				if (Next != null)
				{
					Next.progress = progress + Mathf.Lerp(0f, 1f, insertAniProgress);
					track.UpdateBallProgress(Next);
				}
				if (insertAniProgress > 0.6f)
				{
					InsertAniEnd();
				}
			}
			else
			{
				if (Next != null)
				{
					Next.progress = progress + 1f;
					track.UpdateBallProgress(Next);
				}
				InsertEnd();
			}
		}
		else
		{
			base.transform.position = pos;
		}
	}

	public virtual void DisposeBeginFunc()
	{
	}

	public void DisposeBegin(int sameCount, int curComboCount)
	{
		if (!deleteFlag && !disposeAni)
		{
			int num = ZumaGameConst.hitScore;
			if (ZumaGameManager.GetInstance().zumaSkillManager.CheckIsMeetSkillEffect(SkillType.StopMove, ZumaEffectType.StopMoveOpenScoreAdd))
			{
				num += ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.StopMoveOpenScoreAdd);
			}
			ZumaGameManager.GetInstance().SetZumaGameScore(base.transform.position, ZumaGameConst.CountComboScorePower(curComboCount) * num);
			this.sameCount = sameCount;
			disposeAni = true;
			bgAnimator.ChangeFrameList(ZumaGameManager.GetInstance().trackBallSpriteMgr.GetFrameSprite(FrameType.EFFECT_DISPOSE));
			DisposeBeginFunc();
		}
	}

	public void DisposeEnd()
	{
		sameCount = -1;
		deleteFlag = true;
		bgAnimator.ClearState();
	}

	public Vector3 GetPos(float progress)
	{
		return track.trackData.GetPosition(progress);
	}

	public bool CheckIsSamePos(float progress)
	{
		return Mathf.Abs(progress - this.progress) <= 0.05f;
	}

	public void Update()
	{
		if (!isUnUse)
		{
			ProgressUpdate();
			UpdateHideShow();
			IsArriveFailHole();
			if (disposeAni && bgAnimator.CheckIsFinish())
			{
				DisposeEnd();
			}
		}
	}

	public virtual void UpdateHideShow()
	{
	}

	public int SameColorCount(out List<ZumaBaseBall> list)
	{
		list = new List<ZumaBaseBall>();
		list.Add(this);
		int num = 1;
		ZumaBaseBall zumaBaseBall = this;
		while (zumaBaseBall.Pre != null && zumaBaseBall.Pre.colorType == colorType && !IsInsertOrDispose() && zumaBaseBall.Pre.progress >= 0f)
		{
			num++;
			zumaBaseBall = zumaBaseBall.Pre;
			list.Add(zumaBaseBall);
			if (!(zumaBaseBall != null))
			{
				break;
			}
		}
		zumaBaseBall = this;
		while (zumaBaseBall.Next != null && zumaBaseBall.Next.colorType == colorType && !IsInsertOrDispose() && zumaBaseBall.Next.progress >= 0f)
		{
			num++;
			zumaBaseBall = zumaBaseBall.Next;
			list.Add(zumaBaseBall);
			if (!(zumaBaseBall != null))
			{
				break;
			}
		}
		return num;
	}

	public bool IsMeetDestory(int segment)
	{
		ZumaBaseBall zumaBaseBall2;
		ZumaBaseBall zumaBaseBall = (zumaBaseBall2 = null);
		if ((bool)Next)
		{
			zumaBaseBall = Next;
		}
		else if (segment + 1 < track.ballSegmentList.Count && (bool)track.ballSegmentList[segment + 1])
		{
			zumaBaseBall = track.ballSegmentList[segment + 1];
		}
		if (zumaBaseBall != null && (bool)zumaBaseBall.Next && zumaBaseBall.colorType == colorType && zumaBaseBall.colorType == zumaBaseBall.Next.colorType)
		{
			return true;
		}
		if ((bool)Pre)
		{
			zumaBaseBall2 = Pre;
		}
		else if (segment - 1 >= 0 && (bool)track.ballSegmentList[segment - 1])
		{
			zumaBaseBall2 = track.ballSegmentList[segment - 1];
		}
		if (zumaBaseBall2 != null && (bool)zumaBaseBall2.Pre && zumaBaseBall2.colorType == colorType && zumaBaseBall2.colorType == zumaBaseBall2.Pre.colorType)
		{
			return true;
		}
		if ((bool)zumaBaseBall && (bool)zumaBaseBall2 && zumaBaseBall2.colorType == colorType && zumaBaseBall.colorType == colorType)
		{
			return true;
		}
		return false;
	}

	public bool IsExitBegin()
	{
		return progress >= 0f;
	}

	public bool IsExitEnterBegin()
	{
		return progress > 0f;
	}

	public bool IsExitStartHole()
	{
		return progress >= 1f;
	}

	public bool IsJoinStartHole()
	{
		return progress <= 1.2f;
	}

	public bool IsArriveWarningHole()
	{
		if (progress < track.trackData.EndPoint && progress >= track.trackData.EndPoint - 7f)
		{
			return true;
		}
		return false;
	}

	public bool IsArriveFailHole()
	{
		if (progress >= track.trackData.EndPoint)
		{
			bool result = true;
			ZumaBaseBall zumaBaseBall = this;
			do
			{
				if (zumaBaseBall != null && (zumaBaseBall.insertFlag || zumaBaseBall.deleteFlag || zumaBaseBall.disposeAni))
				{
					result = false;
					break;
				}
				zumaBaseBall = zumaBaseBall.Pre;
			}
			while (zumaBaseBall != null);
			return result;
		}
		return false;
	}

	public bool IsInsertOrDispose()
	{
		if (!disposeAni && !deleteFlag && !insertFlag)
		{
			return false;
		}
		return true;
	}
}
