using System;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardNPCEntity : MonoBehaviour
{
	public float relaxTime = 4f;

	public float aniCrossFadeTime = 0.2f;

	public Animator m_animator;

	public int wantedPlayActionType = -1;

	public float roleSpeed = 2f;

	public float realRoleSpeed;

	protected bool isMoving;

	protected float pausePlayAniTimer;

	protected Vector3 wantedPosition;

	protected Vector3 wantedDir;

	private Vector3 beginScale;

	protected bool isInJumpState;

	public Transform diceLookAtPoint;

	protected Vector3Int gridPosition;

	public Vector3Int wantedGridPosition;

	protected Action moveCallBack;

	private Vector3 overlapPos = new Vector3(0.15f, 0f, -0.35f);

	private bool isUseOverLap;

	public Vector3Int GridPosition => gridPosition;

	public bool CheckIsSamePos(Vector3 otherGridPosition)
	{
		if (otherGridPosition.x == (float)gridPosition.x && otherGridPosition.z == (float)gridPosition.z)
		{
			return true;
		}
		return false;
	}

	private void Start()
	{
		isMoving = false;
		m_animator = GetComponent<Animator>();
		if ((bool)LuaHelper.CallFunction("ChessBoardGetIsFastModule")[0])
		{
			realRoleSpeed = roleSpeed * 2f;
			m_animator.speed = 2f;
		}
		else
		{
			realRoleSpeed = roleSpeed;
			m_animator.speed = 1f;
		}
		if (wantedPlayActionType > 0)
		{
			PlayAction(wantedPlayActionType);
			wantedPlayActionType = -1;
		}
		beginScale = base.transform.localScale;
	}

	public void OnWalkStop()
	{
		isInJumpState = false;
		gridPosition.x = wantedGridPosition.x;
		gridPosition.z = wantedGridPosition.z;
	}

	public void MoveTo(Vector3 targetPosition, int x, int z, Action callBack = null)
	{
		isMoving = true;
		wantedPosition = targetPosition;
		wantedDir = (wantedPosition - base.transform.position).NewY(0f).normalized;
		PlayOverlap(isShow: false);
		wantedGridPosition.x = x;
		wantedGridPosition.z = z;
		moveCallBack = callBack;
		if (!CheckIsInJumpState())
		{
			m_animator.Play("run");
		}
	}

	public bool CheckIsInJumpState()
	{
		if (isInJumpState || pausePlayAniTimer > 0f)
		{
			return true;
		}
		return false;
	}

	public void InitBronPoint(int x, int z)
	{
		gridPosition = new Vector3Int(x, 0, z);
		wantedGridPosition = new Vector3Int(x, 0, z);
	}

	public void SetHeroPosAndDir(Vector3 pos, int dir, int x, int z)
	{
		base.transform.position = pos;
		base.transform.forward = ChessBoardHelper.forwardMap[dir];
		gridPosition.x = x;
		gridPosition.z = z;
	}

	private void Update()
	{
		if (pausePlayAniTimer > 0f && Vector3.Distance(base.transform.position, wantedPosition) < 0.4f)
		{
			if (pausePlayAniTimer >= 1f)
			{
				m_animator.Play("attack");
			}
			pausePlayAniTimer -= Time.deltaTime;
		}
		else
		{
			if (!isMoving)
			{
				return;
			}
			base.transform.position = Vector3.MoveTowards(base.transform.position, wantedPosition, realRoleSpeed * Time.deltaTime);
			base.transform.forward = Vector3.Slerp(base.transform.forward.NewY(0f), wantedDir, Time.deltaTime * 8f);
			if (Vector3.Distance(base.transform.position, wantedPosition) < 0.02f && moveCallBack != null)
			{
				if ((bool)LuaHelper.CallFunction("ChessBoardGetIsFastModule")[0])
				{
					realRoleSpeed = roleSpeed * 2f;
				}
				else
				{
					realRoleSpeed = roleSpeed;
				}
				base.transform.position = wantedPosition;
				isMoving = false;
				moveCallBack();
				OnWalkStop();
			}
		}
	}

	public void PlayAction(int action)
	{
		switch ((EntityActionType)action)
		{
		case EntityActionType.HERO_STAY_NPC:
			if (base.transform.Find("fx_zhanqi_crown") != null)
			{
				m_animator.Play("duck_yb_b");
			}
			else
			{
				m_animator.Play("duck_yb");
			}
			break;
		case EntityActionType.NPC_STAY_HERO:
			isInJumpState = true;
			m_animator.Play("jump");
			realRoleSpeed = 0.8f;
			if ((bool)LuaHelper.CallFunction("ChessBoardGetIsFastModule")[0])
			{
				realRoleSpeed = 2f;
			}
			else
			{
				realRoleSpeed = 1f;
			}
			break;
		case EntityActionType.CROSS_HERO:
			pausePlayAniTimer = 1f;
			break;
		case EntityActionType.HIT:
			m_animator.Play("shootHit");
			break;
		case EntityActionType.GROW:
			m_animator.Play("grow");
			break;
		case EntityActionType.DICE:
			m_animator.Play("rolldice");
			break;
		case EntityActionType.STAND:
			m_animator.Play("stand");
			break;
		}
	}

	public void PlayOverlap(bool isShow)
	{
		if (isShow)
		{
			isUseOverLap = true;
			LeanTween.move(base.transform.gameObject, base.transform.position + overlapPos, 0.2f);
			LeanTween.scale(base.gameObject, beginScale * 0.6f, 0.1f);
		}
		else if (isUseOverLap)
		{
			LeanTween.move(base.transform.gameObject, base.transform.position - overlapPos, 0.2f);
			LeanTween.scale(base.gameObject, beginScale, 0.1f);
			isUseOverLap = false;
		}
	}
}
