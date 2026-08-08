using System;
using NewChess;
using UnityEngine;

public class NewHexAnimator : MonoBehaviour
{
	public float relaxTime = 4f;

	public float aniCrossFadeTime = 0.2f;

	public Animator m_animator;

	protected int relaxTimer = -1;

	public float roleSpeed = 2f;

	protected bool isMoving;

	protected Vector3 wantedPosition;

	protected Vector3Int gridPosition;

	protected Action moveCallBack;

	protected bool isFixing;

	protected float wantedNewY;

	protected float fixSpeed;

	public Vector3Int GridPosition => gridPosition;

	private void Start()
	{
		isMoving = false;
		isFixing = false;
		m_animator = GetComponent<Animator>();
	}

	public void InitBronPoint(Int2 borPoint, Vector3 pos)
	{
		gridPosition = new Vector3Int(borPoint.x, 0, borPoint.y);
		base.transform.position = pos;
		NewHexFogManager.Instance.WalkOpenFog(gridPosition.x, gridPosition.z);
	}

	public void OnWalkStart()
	{
		if (relaxTimer > 0)
		{
			FuncTimerManager.inst.StopFuncTimer(relaxTimer);
		}
	}

	public void OnWalkStopRender()
	{
		m_animator.CrossFade("stand", aniCrossFadeTime);
		StartToCountRelaxTime();
	}

	public void OnWalkStopLogic()
	{
		LuaHelper.CallFunction("NewChessWalkEnd");
	}

	public void StartToCountRelaxTime()
	{
		if (relaxTimer > 0)
		{
			FuncTimerManager.inst.ResetFuncTimer(relaxTimer);
			FuncTimerManager.inst.StartFuncTimer(relaxTimer);
			return;
		}
		relaxTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			m_animator.CrossFade("relax", aniCrossFadeTime);
			FuncTimerManager.inst.StopFuncTimer(relaxTimer);
			NewChessHelper.WaitForAnimationEnd(m_animator, RestartRelaxTimer);
		}, relaxTime);
	}

	private void RestartRelaxTimer()
	{
		FuncTimerManager.inst.StartFuncTimer(relaxTimer);
	}

	private void Update()
	{
		if (isMoving)
		{
			base.transform.position = Vector3.MoveTowards(base.transform.position, wantedPosition, roleSpeed * Time.deltaTime);
			base.transform.forward = Vector3.Slerp(base.transform.forward.NewY(0f), (wantedPosition - base.transform.position).NewY(0f), Time.deltaTime * 8f);
			if (Vector3.Distance(base.transform.position, wantedPosition) < 0.02f && moveCallBack != null)
			{
				base.transform.position = wantedPosition;
				isMoving = false;
				moveCallBack();
			}
		}
		if (isFixing)
		{
			base.transform.position = Vector3.MoveTowards(base.transform.position, base.transform.position.NewY(wantedNewY), fixSpeed * Time.deltaTime);
			if (Vector3.Distance(base.transform.position, base.transform.position.NewY(wantedNewY)) < 0.02f)
			{
				base.transform.position = base.transform.position.NewY(wantedNewY);
				isFixing = false;
			}
		}
	}

	public void MoveTo(Vector3 targetPosition, Action callBack = null)
	{
		isMoving = true;
		wantedPosition = targetPosition;
		moveCallBack = callBack;
	}

	public void FixPosition(Vector3 pos)
	{
		base.transform.position = pos;
		isMoving = false;
		isFixing = false;
	}

	public void YMoveTo(float newY, float fixtime)
	{
		isFixing = true;
		wantedNewY = base.transform.position.y + newY;
		fixSpeed = Math.Abs(newY) / fixtime;
	}

	public void ClearWantedY()
	{
		isFixing = false;
		wantedNewY = 0f;
		fixSpeed = 0f;
	}

	public void MoveLogicPosition(int x, int z)
	{
		WalkOutOldNode();
		int num = x - gridPosition.x;
		int num2 = z - gridPosition.z;
		int dir = 0;
		for (int i = 0; i < 6; i++)
		{
			if (num == NewHexGridCoord.mGridDirection[i].x && num2 == NewHexGridCoord.mGridDirection[i].y)
			{
				dir = i;
				break;
			}
		}
		gridPosition = new Vector3Int(x, 0, z);
		WalkIntoNewNode(isTelePort: false, dir);
	}

	public void Teleport(int x, int z, Vector3 position, Action callBack = null)
	{
		WalkOutOldNode();
		gridPosition = new Vector3Int(x, 0, z);
		base.transform.position = position;
		WalkIntoNewNode(isTelePort: true, NewChessHelper.GetDirectionByForward(base.transform.forward));
		if (callBack != null)
		{
			callBack();
			callBack = null;
		}
	}

	private void WalkIntoNewNode(bool isTelePort, int dir)
	{
		NewGridData gridData = NewHexManager.Instance.FindEntity(gridPosition.x, gridPosition.z).gridData;
		LuaHelper.CallFunction("NewChessWalkIntoNode", gridData, isTelePort, dir);
		NewHexFogManager.Instance.WalkOpenFog(gridPosition.x, gridPosition.z);
	}

	public void WalkOutOldNode()
	{
		LuaHelper.CallFunction("NewChessWalkOutNode", NewHexManager.Instance.FindEntity(gridPosition.x, gridPosition.z).gridData);
	}

	protected void OnDestroy()
	{
		if (relaxTimer > 0 && FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(relaxTimer);
		}
	}
}
