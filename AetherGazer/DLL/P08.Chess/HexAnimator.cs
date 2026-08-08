using System;
using System.Collections;
using Chess;
using Pathfinding;
using UnityEngine;

public class HexAnimator : MonoBehaviour
{
	public float relaxTime = 4f;

	public int rushNum = 3;

	public float roleSpeed = 2f;

	public float roleRushSpeed = 3f;

	public float aniCrossFadeTime = 0.2f;

	private const string idle = "stand";

	private const string run = "start";

	public Action onWalkStart;

	public Action onWalkStop;

	protected Action onWalkStopOrigin;

	protected Vector3 wantedPostion;

	protected Vector3 forwardPosition;

	protected IEnumerator forwardCo;

	private CountDownUI m_countDownUI;

	private GameObject m_countDownGO;

	protected Vector3Int gridPosition;

	protected Animator m_animator;

	private int relaxTimer = -1;

	private GridEventTrigger eventTrigger;

	private Collider collider;

	protected bool isNeedRushState = true;

	private bool isInRush;

	public Vector3 WantedPosition
	{
		get
		{
			return wantedPostion;
		}
		set
		{
			wantedPostion = value;
			GridNode gridNode = HexGridCoord.astarPath.data.graphs[0].GetNearest((Int3)wantedPostion).node as GridNode;
			Vector3Int vector3Int = new Vector3Int(gridNode.XCoordinateInGrid, 0, gridNode.ZCoordinateInGrid);
			if (gridPosition.x != vector3Int.x || gridPosition.z != vector3Int.z)
			{
				gridPosition = vector3Int;
				WalkIntoNewNode();
			}
		}
	}

	public Vector3Int GridPosition => gridPosition;

	private void Start()
	{
		wantedPostion = base.transform.position;
		m_animator = GetComponent<Animator>();
		onWalkStart = delegate
		{
			if (relaxTimer > 0)
			{
				FuncTimerManager.inst.StopFuncTimer(relaxTimer);
			}
		};
		onWalkStop = delegate
		{
			LuaHelper.CallFunction("WalkEnd");
			StartToCountRelaxTime();
		};
		onWalkStopOrigin = onWalkStop;
		m_countDownGO = Asset.Instantiate("WarChess/CountTips");
		m_countDownGO.SetActive(value: false);
		m_countDownGO.transform.SetParent(base.transform);
		m_countDownGO.transform.SetSiblingIndex(0);
		m_countDownUI = m_countDownGO.GetComponent<CountDownUI>();
		eventTrigger = GetComponent<GridEventTrigger>();
		if (eventTrigger == null)
		{
			eventTrigger = base.gameObject.AddComponent<GridEventTrigger>();
		}
		GridEventTrigger gridEventTrigger = eventTrigger;
		gridEventTrigger.onPointerClick = (Action<GameObject>)Delegate.Combine(gridEventTrigger.onPointerClick, new Action<GameObject>(ClickRole));
		eventTrigger.callBackGo = base.gameObject;
		collider = GetComponent<Collider>();
		OnStart();
	}

	protected virtual void OnStart()
	{
	}

	public void ClickRole(GameObject go)
	{
		LuaHelper.CallFunction("ClickRole");
	}

	public void SetIsMuteTrigger(bool isMute)
	{
		if (collider != null)
		{
			collider.enabled = !isMute;
		}
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
			ChessHelper.WaitForAnimationEnd(m_animator, RestartRelaxTimer);
		}, relaxTime);
	}

	private void RestartRelaxTimer()
	{
		FuncTimerManager.inst.StartFuncTimer(relaxTimer);
	}

	private void Update()
	{
	}

	protected void OnDestroy()
	{
		if (relaxTimer > 0 && FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(relaxTimer);
		}
	}

	public void ForceRefreshPosition()
	{
		OnAnimatorMove();
	}

	private void OnAnimatorMove()
	{
		Vector3 normalized = (wantedPostion - base.transform.position).normalized;
		if (!(normalized != Vector3.zero))
		{
			_ = forwardPosition;
			if (!(forwardPosition != Vector3.zero))
			{
				return;
			}
		}
		base.transform.position = wantedPostion;
		_ = forwardPosition;
		if (forwardPosition != Vector3.zero)
		{
			base.transform.forward = forwardPosition;
			forwardPosition = Vector3.zero;
		}
		else
		{
			base.transform.forward = normalized;
		}
	}

	public bool IsTouchItemWithoutMove(Vector3 endPoint, Vector3 originalEndPoint, float speed)
	{
		if (wantedPostion == endPoint)
		{
			if (onWalkStart != null)
			{
				onWalkStart();
			}
			if (wantedPostion != originalEndPoint)
			{
				if (forwardCo != null)
				{
					StopCoroutine(forwardCo);
				}
				forwardCo = RotateToWantedPos((originalEndPoint - wantedPostion).normalized, 180f);
				StartCoroutine(forwardCo);
			}
			else if (onWalkStop != null)
			{
				onWalkStop();
			}
			return true;
		}
		return false;
	}

	public IEnumerator MoveAlongPath(ABPath path, float speed)
	{
		if (path.error || path.vectorPath.Count == 0)
		{
			throw new ArgumentException("Cannot follow an empty path");
		}
		if (forwardCo != null)
		{
			StopCoroutine(forwardCo);
		}
		if (onWalkStart != null)
		{
			onWalkStart();
		}
		isInRush = isNeedRushState && path.path.Count > rushNum;
		if (isInRush)
		{
			m_animator.CrossFade("start 0", aniCrossFadeTime);
		}
		else
		{
			m_animator.CrossFade("start", aniCrossFadeTime);
		}
		float distanceAlongSegment = 0f;
		for (int i = 0; i < path.vectorPath.Count - 1; i++)
		{
			Vector3 p0 = path.vectorPath[Mathf.Max(i - 1, 0)];
			Vector3 p1 = path.vectorPath[i];
			Vector3 p2 = path.vectorPath[i + 1];
			Vector3 p3 = path.vectorPath[Mathf.Min(i + 2, path.vectorPath.Count - 1)];
			float segmentLength = Vector3.Distance(p1, p2);
			if (i == path.vectorPath.Count - 2)
			{
				if (isInRush)
				{
					m_animator.CrossFade("end 0", aniCrossFadeTime);
				}
				else
				{
					m_animator.CrossFade("end", aniCrossFadeTime);
				}
			}
			for (; distanceAlongSegment < segmentLength; distanceAlongSegment += Time.deltaTime * (isInRush ? roleRushSpeed : roleSpeed))
			{
				Vector3 vector = AstarSplines.CatmullRom(p0, p1, p2, p3, distanceAlongSegment / segmentLength);
				wantedPostion = vector;
				Vector3Int nearestGridNode = GetNearestGridNode(path, wantedPostion);
				if (gridPosition.x != nearestGridNode.x || gridPosition.z != nearestGridNode.z)
				{
					gridPosition = nearestGridNode;
					WalkIntoNewNode();
				}
				yield return null;
			}
			distanceAlongSegment -= segmentLength;
		}
		wantedPostion = path.vectorPath[path.vectorPath.Count - 1];
		if (wantedPostion != (Vector3)path.originalEndPoint)
		{
			if (forwardCo != null)
			{
				StopCoroutine(forwardCo);
			}
			forwardCo = RotateToWantedPos(((Vector3)path.originalEndPoint - wantedPostion).normalized, 180f);
			StartCoroutine(forwardCo);
		}
		else
		{
			m_animator.CrossFade("stand", aniCrossFadeTime);
			if (onWalkStop != null)
			{
				onWalkStop();
			}
		}
		isInRush = false;
	}

	public IEnumerator GoToNearestNode(Action callBack = null, bool isSkipWalkEnd = false)
	{
		HexEntity hexEntity = HexManager.Instance.FindEntity(gridPosition.x, gridPosition.z);
		IEnumerator enumerator = MoveToPos((Vector3)hexEntity.gridNode.position, roleSpeed, callBack, isSkipWalkEnd);
		StartCoroutine(enumerator);
		return enumerator;
	}

	public IEnumerator MoveToPos(Vector3 position, float speed, Action callBack = null, bool isSkipWalkEnd = false)
	{
		float moveLength = Vector3.Distance(position, wantedPostion);
		for (float distanceAlongSegment = 0f; distanceAlongSegment < moveLength; distanceAlongSegment += Time.deltaTime * speed)
		{
			Vector3 vector = Vector3.Lerp(wantedPostion, position, distanceAlongSegment / moveLength);
			wantedPostion = vector;
			yield return null;
		}
		wantedPostion = position;
		m_animator.CrossFade("stand", aniCrossFadeTime);
		OnAnimatorMove();
		if (onWalkStop != null && !isSkipWalkEnd)
		{
			onWalkStop();
		}
		callBack?.Invoke();
	}

	public IEnumerator RotateToWantedPos(Vector3 forward, float speed)
	{
		yield return null;
		yield return null;
		if (onWalkStop != null)
		{
			onWalkStop();
		}
		forwardPosition = forward;
	}

	private Vector3Int GetNearestGridNode(ABPath path, Vector3 position)
	{
		if (path == null || path.path == null)
		{
			return gridPosition;
		}
		for (int i = 0; i < path.path.Count; i++)
		{
			GridNode gridNode = path.path[i] as GridNode;
			if (Vector3.Distance((Vector3)gridNode.position, position) < 0.5f)
			{
				return new Vector3Int(gridNode.XCoordinateInGrid, 0, gridNode.ZCoordinateInGrid);
			}
		}
		return gridPosition;
	}

	private void WalkIntoNewNode()
	{
		object[] array = LuaHelper.CallFunction("WalkIntoNode", HexManager.Instance.FindEntity(gridPosition.x, gridPosition.z).gridData);
		HexFogManager.Instance.WalkOpenFog(gridPosition.x, gridPosition.z);
		if ((bool)array[0])
		{
			(NScene.GetCurrentScene() as ChessScene).hexGridCoord.RoleStopMove();
		}
	}

	public void SetCountDownText(int num, bool isActive)
	{
		if (m_countDownGO.activeSelf != isActive)
		{
			m_countDownGO.SetActive(isActive);
		}
		if (isActive)
		{
			m_countDownUI.SetText(num);
		}
	}

	public void PlayRoleAnimation(string ani, Action func = null)
	{
		m_animator.Play(ani);
		ChessHelper.WaitForAnimationEnd(m_animator, func);
	}

	public virtual void StopMove()
	{
	}
}
