using System;
using ChessBoard;
using UnityEngine;

public class ChessBoardHeroEntity : MonoBehaviour
{
	public bool isSelectingMovePos;

	public bool isSelectingNpc;

	public bool isSelectingMapPos;

	public float relaxTime = 10f;

	public float aniCrossFadeTime = 0.1f;

	public Animator m_animator;

	public float roleSpeed = 2f;

	protected bool isMoving;

	protected Vector3 wantedPosition;

	protected Vector3 wantedDir;

	public GameObject ybEffectPrefab;

	private GameObject ybEffectGo;

	protected int effectTimer = -1;

	protected bool isInJumpState;

	public Transform diceLookAtPoint;

	protected Vector3Int gridPosition;

	private Vector3Int wantedGridPosition;

	protected Action moveCallBack;

	private bool IsNeedOverlap;

	public Vector3Int GridPosition => gridPosition;

	private void Start()
	{
		isMoving = false;
		m_animator = GetComponent<Animator>();
	}

	public void InitBronPoint(Int2 borPoint, Vector3 pos, float offsetY)
	{
		gridPosition = new Vector3Int(borPoint.x, 0, borPoint.y);
		wantedGridPosition = new Vector3Int(borPoint.x, 0, borPoint.y);
		Vector3 position = pos.NewY(offsetY);
		base.transform.position = position;
	}

	public void SetHeroPosAndDir(Vector3 pos, int dir, int x, int z)
	{
		base.transform.position = pos;
		base.transform.forward = ChessBoardHelper.forwardMap[dir];
		gridPosition.x = x;
		gridPosition.z = z;
	}

	public void OnWalkStart()
	{
		SetOtherEntityOverlap(isShow: false);
	}

	public void OnWalkStop()
	{
		isInJumpState = false;
		StartToCountRelaxTime();
		gridPosition.x = wantedGridPosition.x;
		gridPosition.z = wantedGridPosition.z;
	}

	public void StartToCountRelaxTime()
	{
	}

	public void MoveTo(Vector3 targetPosition, int x, int z, Action callBack = null)
	{
		OnWalkStart();
		isMoving = true;
		wantedPosition = targetPosition;
		wantedDir = (wantedPosition - base.transform.position).NewY(0f).normalized;
		wantedGridPosition.x = x;
		wantedGridPosition.z = z;
		moveCallBack = callBack;
		ChessBoardCameraManager.Instance.LookAtPlayer();
		if (!CheckIsInJumpState())
		{
			m_animator.CrossFade("summer_run", 0.1f);
		}
	}

	private void Update()
	{
		if (isMoving)
		{
			base.transform.position = Vector3.MoveTowards(base.transform.position, wantedPosition, roleSpeed * Time.deltaTime);
			base.transform.forward = Vector3.Slerp(base.transform.forward.NewY(0f), wantedDir, Time.deltaTime * 8f);
			float num = Vector3.Distance(base.transform.position, wantedPosition);
			if (num < 0.02f && moveCallBack != null)
			{
				base.transform.position = wantedPosition;
				isMoving = false;
				OnWalkStop();
				moveCallBack();
			}
			if (IsNeedOverlap && num < 0.6f)
			{
				IsNeedOverlap = false;
				SetOtherEntityOverlap(isShow: true);
			}
		}
	}

	protected void OnDestroy()
	{
		if (effectTimer > 0 && FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(effectTimer);
		}
		if ((bool)ybEffectGo)
		{
			UnityEngine.Object.Destroy(ybEffectGo);
		}
	}

	public bool CheckIsInJumpState()
	{
		if (isInJumpState)
		{
			return true;
		}
		return false;
	}

	public void SetOverlapState(bool Value)
	{
		IsNeedOverlap = Value;
	}

	private void SetOtherEntityOverlap(bool isShow)
	{
		int nPCIDByPos = ChessBoardNPCManager.Instance.GetNPCIDByPos(wantedGridPosition);
		if (nPCIDByPos > 0)
		{
			ChessBoardNPCManager.Instance.PlayNPCOverlap(nPCIDByPos, isShow);
		}
	}

	public void PlayAction(int action)
	{
		switch ((EntityActionType)action)
		{
		case EntityActionType.HERO_STAY_NPC:
			isInJumpState = true;
			m_animator.Play("jump01");
			break;
		case EntityActionType.HAPPY:
			m_animator.Play("happy01", -1, 0f);
			break;
		case EntityActionType.HAPPY_BIG:
			m_animator.CrossFade("happy02", aniCrossFadeTime);
			break;
		case EntityActionType.SAD:
			m_animator.CrossFade("sad02", aniCrossFadeTime);
			break;
		case EntityActionType.SAD_BIG:
			m_animator.CrossFade("sad03", aniCrossFadeTime);
			break;
		case EntityActionType.NPC_STAY_HERO:
			YbEffect();
			break;
		case EntityActionType.CROSS_HERO:
			m_animator.CrossFade("hit", aniCrossFadeTime);
			break;
		case EntityActionType.DICE:
			m_animator.CrossFade("summer_rolldice", aniCrossFadeTime);
			break;
		case EntityActionType.SHOCK:
			m_animator.CrossFade("summer_shock", aniCrossFadeTime);
			break;
		case EntityActionType.DOUBT:
			m_animator.CrossFade("summer_doubt", aniCrossFadeTime);
			break;
		case EntityActionType.NERVOUS:
			m_animator.CrossFade("summer_nervous", aniCrossFadeTime);
			break;
		case EntityActionType.STAND:
			m_animator.CrossFade("stand_female", aniCrossFadeTime);
			break;
		case EntityActionType.IDLE:
			m_animator.CrossFade("happy02", aniCrossFadeTime);
			break;
		case EntityActionType.HIT:
		case EntityActionType.GROW:
			break;
		}
	}

	public void YbEffect()
	{
		if (ybEffectGo == null)
		{
			ybEffectGo = ybEffectPrefab;
			ybEffectGo.transform.SetParent(base.transform.parent, worldPositionStays: false);
		}
		ybEffectGo.transform.position = base.transform.position;
		ybEffectGo.gameObject.SetActive(value: true);
		base.transform.localScale = Vector3.zero;
		ybEffectGo.transform.forward = base.transform.forward;
		if (effectTimer > 0)
		{
			FuncTimerManager.inst.StopFuncTimer(effectTimer);
			FuncTimerManager.inst.ResetFuncTimer(effectTimer);
		}
		else
		{
			effectTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				FuncTimerManager.inst.StopFuncTimer(effectTimer);
				effectTimer = -1;
				ybEffectGo.gameObject.SetActive(value: false);
				base.transform.localScale = Vector3.one;
			}, 0.65f, -1, autoStart: false);
		}
		FuncTimerManager.inst.StartFuncTimer(effectTimer);
	}
}
