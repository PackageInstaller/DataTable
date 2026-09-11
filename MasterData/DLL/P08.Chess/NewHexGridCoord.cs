using System;
using System.Collections.Generic;
using NewChess;
using Pathfinding;
using UnityEngine;

public class NewHexGridCoord : MonoBehaviour
{
	public NewHexAnimator mRole;

	public ITraversalProvider traversalProvider = new NewChessITraversalProvider();

	public LineRenderer mMainPathRender;

	public static AstarPath astarPath;

	public ABPath ab;

	protected int m_CurPathIndex;

	protected bool m_IsLogicMoving;

	public SimContext mSimContext;

	public static Int3[] mDirection = new Int3[6]
	{
		new Int3(-1, 0, 1),
		new Int3(0, -1, 1),
		new Int3(1, -1, 0),
		new Int3(1, 0, -1),
		new Int3(0, 1, -1),
		new Int3(-1, 1, 0)
	};

	public static Int2[] mGridDirection = new Int2[6]
	{
		new Int2(1, 1),
		new Int2(0, 1),
		new Int2(-1, 0),
		new Int2(-1, -1),
		new Int2(0, -1),
		new Int2(1, 0)
	};

	private NewMapData mapData;

	private List<Vector3> mSmoothPath = new List<Vector3>();

	public float maxSegmentLength = 0.2743957f;

	public float strength = 0.5f;

	public float iterations = 12f;

	private void Start()
	{
		NewChessScene newChessScene = NScene.GetCurrentScene() as NewChessScene;
		newChessScene.hexGridCoord = this;
		mapData = newChessScene.mapData;
		if (traversalProvider == null)
		{
			traversalProvider = new NewChessITraversalProvider();
		}
	}

	public void InitMapGameObject()
	{
		NewChessMapData chessMapData = mapData.chessMapData;
		astarPath = new AstarPath(mSimContext);
		astarPath.scanOnStartup = true;
		astarPath.LoadAstartData(ref mapData.mBinMap);
		GridGraph obj = astarPath.data.graphs[0] as GridGraph;
		obj.SetDimensions(chessMapData.width, chessMapData.height, 1.225f);
		obj.UpdateTransform();
		AstarPath.active.Scan();
		NewHexManager.Instance.Init();
	}

	public void InitRoleBronPoint()
	{
		Int2 bronPos = (NScene.GetCurrentScene() as NewChessScene).bronPos;
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(bronPos.x, bronPos.y);
		if (newHexEntity.gridNode != null)
		{
			mRole.InitBronPoint(bronPos, newHexEntity.rendererPosition);
		}
		else
		{
			Debug.LogError("wrong bron pos");
		}
	}

	public void InitRoleDirection()
	{
		NewChessScene newChessScene = NScene.GetCurrentScene() as NewChessScene;
		mRole.transform.forward = NewChessHelper.forwardMap[newChessScene.direction];
	}

	public FindABPathResult FindPath(int x, int z, bool isSpecial, bool isCache = false)
	{
		GridNode gridNode = NewHexManager.Instance.FindEntity(x, z).gridNode;
		if (gridNode == null)
		{
			return null;
		}
		ABPath aBPath = ABPath.Construct(astarPath.GetNearest((Int3)mRole.transform.position).node.position, gridNode.position);
		aBPath.nnConstraint = new NNConstraint
		{
			constrainWalkability = true,
			constrainArea = false,
			constrainTags = false,
			constrainDistance = false,
			graphMask = -1
		};
		if (traversalProvider != null)
		{
			aBPath.traversalProvider = traversalProvider;
			aBPath.calculatePartial = false;
		}
		aBPath.Claim(this);
		NewChessHelper.AstarPathHelpCount = 2;
		AstarPath.StartPath(aBPath);
		AstarPath.BlockUntilCalculated(aBPath);
		if (isSpecial && aBPath.path.Count > 0)
		{
			aBPath.path.RemoveAt(aBPath.path.Count - 1);
			aBPath.vectorPath.RemoveAt(aBPath.vectorPath.Count - 1);
		}
		if (isCache)
		{
			if (ab != null)
			{
				ab.Release(this);
			}
			ab = aBPath;
			m_CurPathIndex = 0;
		}
		List<Int2> rangeNodeS = NewChessHelper.GetRangeNodeS(x, z, 1);
		bool isInRange = false;
		for (int i = 0; i < rangeNodeS.Count; i++)
		{
			GridNode gridNode2 = aBPath.endNode as GridNode;
			if (gridNode2.XCoordinateInGrid == rangeNodeS[i].x && gridNode2.ZCoordinateInGrid == rangeNodeS[i].y)
			{
				isInRange = true;
			}
		}
		FindABPathResult result = new FindABPathResult
		{
			abPath = aBPath,
			isInRange = isInRange
		};
		Debug.Log("abPath : " + aBPath.error + "  isOnRange : " + isInRange);
		return result;
	}

	public void MoveToCachePos()
	{
		if (ab != null)
		{
			if (ab.error || ab.vectorPath.Count <= 1)
			{
				StopRoleMoving();
				return;
			}
			RoleMoveStart();
			GridNode gridNode = ab.path[m_CurPathIndex + 1] as GridNode;
			WantToMove(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
			NewHexCameraManager.Instance.LookAtPlayer();
		}
	}

	public void WantToMove(int x, int z)
	{
		LuaHelper.CallFunction("NewChessWantToMove", x, z);
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		mRole.MoveTo(newHexEntity.rendererPosition);
	}

	public void FixRolePosition()
	{
		GridNode gridNode = ab.path[m_CurPathIndex] as GridNode;
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
		mRole.FixPosition(newHexEntity.rendererPosition);
		StopRoleMoving();
	}

	public void MoveRoleLogicPosition(int x, int z)
	{
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		mRole.MoveTo(newHexEntity.rendererPosition, delegate
		{
			mRole.MoveLogicPosition(x, z);
			m_CurPathIndex++;
			if (m_IsLogicMoving)
			{
				if (m_CurPathIndex + 1 < ab.path.Count)
				{
					GridNode gridNode = ab.path[m_CurPathIndex + 1] as GridNode;
					WantToMove(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
					FixRoleAni();
				}
				else
				{
					StopRoleMoving();
				}
			}
		});
	}

	public void RoleMoveStart()
	{
		m_IsLogicMoving = true;
		mRole.OnWalkStart();
		mRole.m_animator.CrossFade("run", mRole.aniCrossFadeTime);
	}

	public void OnRoleMoveStop()
	{
		mRole.OnWalkStopLogic();
		mRole.OnWalkStopRender();
		ClearCachePath();
	}

	public void OnRoleMoveStopRender()
	{
		mRole.OnWalkStopRender();
	}

	public void StopRoleMoving()
	{
		m_IsLogicMoving = false;
		OnRoleMoveStop();
	}

	protected void FixRoleAni()
	{
		if (ab.path.Count > 5)
		{
			if (m_CurPathIndex == 1)
			{
				mRole.m_animator.CrossFade("rush", mRole.aniCrossFadeTime);
			}
			if (m_CurPathIndex + 1 >= ab.path.Count - 1)
			{
				mRole.m_animator.CrossFade("rush_stop", mRole.aniCrossFadeTime);
			}
		}
	}

	public void TelePortRoleToPosition(int x, int z, Action callBack)
	{
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (newHexEntity.gridNode != null)
		{
			StopRoleMoving();
			mRole.Teleport(x, z, newHexEntity.rendererPosition, callBack);
		}
		else
		{
			Debug.LogError("wrong transfer pos");
		}
	}

	public void ClearCachePath()
	{
		if (ab != null)
		{
			ab.Release(this);
			ab = null;
			m_CurPathIndex = 0;
		}
	}

	public void RoleStopMove()
	{
		m_IsLogicMoving = false;
		mRole.OnWalkStopRender();
		ClearCachePath();
	}

	public void RoleSlideToPos(int x, int z, Action callBack = null)
	{
		NewHexEntity hexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (hexEntity.gridNode != null)
		{
			mRole.ClearWantedY();
			StopRoleMoving();
			mRole.MoveTo(hexEntity.rendererPosition, delegate
			{
				OnRoleMoveStopRender();
				mRole.Teleport(x, z, hexEntity.rendererPosition, callBack);
			});
		}
		else
		{
			Debug.LogError("wrong transfer pos");
		}
	}

	public void RoleSlipToPos(int x, int z, Action callBack = null)
	{
		NewHexEntity hexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (hexEntity.gridNode != null)
		{
			mRole.ClearWantedY();
			m_IsLogicMoving = false;
			mRole.OnWalkStopLogic();
			ClearCachePath();
			mRole.m_animator.CrossFade("slip", mRole.aniCrossFadeTime);
			mRole.MoveTo(hexEntity.rendererPosition, delegate
			{
				mRole.Teleport(x, z, hexEntity.rendererPosition, callBack);
			});
		}
		else
		{
			Debug.LogError("wrong transfer pos");
		}
	}

	public void RoleJumpToPos(int x, int z, Action callBack = null)
	{
		NewHexEntity hexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (hexEntity.gridNode != null)
		{
			mRole.ClearWantedY();
			StopRoleMoving();
			mRole.m_animator.CrossFade("jump", mRole.aniCrossFadeTime);
			mRole.MoveTo(hexEntity.rendererPosition, delegate
			{
				OnRoleMoveStopRender();
				mRole.Teleport(x, z, hexEntity.rendererPosition, callBack);
			});
		}
		else
		{
			Debug.LogError("wrong transfer pos");
		}
	}

	private void Update()
	{
	}

	public void Shutdown()
	{
	}

	public static Int3 AxialToCubeCoord(int x, int z)
	{
		int x2 = -x;
		int y = x - z;
		return new Int3(x2, y, z);
	}

	public static Int2 CubeToAxialCoord(int x, int y, int z)
	{
		return new Int2(-x, z);
	}

	public static int GetDistance(Int3 from, Int3 to)
	{
		Int3 @int = to - from;
		return (Mathf.Abs(@int.x) + Mathf.Abs(@int.y) + Mathf.Abs(@int.z)) / 2;
	}

	public static int GetIntDirBySubXZ(int subx, int subz)
	{
		int result = 0;
		for (int i = 0; i < 6; i++)
		{
			if (subx == mGridDirection[i].x && subz == mGridDirection[i].y)
			{
				result = i;
				break;
			}
		}
		return result;
	}

	public Vector3 FindNearestPoint(List<Vector3> path, Vector3 pos, out int nearestIndex)
	{
		nearestIndex = 0;
		float num = float.MaxValue;
		Vector3 result = Vector3.zero;
		for (int i = 0; i < path.Count; i++)
		{
			if (i < path.Count - 1)
			{
				Vector3 vector = VectorMath.ClosestPointOnSegment(path[i], path[i + 1], pos);
				float sqrMagnitude = (vector - pos).sqrMagnitude;
				if (sqrMagnitude <= num)
				{
					num = sqrMagnitude;
					nearestIndex = i;
					result = vector;
				}
			}
		}
		return result;
	}

	public void DrawLine()
	{
		int nearestIndex = 0;
		FindNearestPoint(mSmoothPath, mRole.transform.position, out nearestIndex);
		if (nearestIndex >= 0 && mMainPathRender != null)
		{
			mMainPathRender.positionCount = mSmoothPath.Count - nearestIndex;
			for (int i = 0; i < mSmoothPath.Count - nearestIndex; i++)
			{
				mMainPathRender.SetPosition(i, mSmoothPath[i + nearestIndex].NewY(0.01f));
			}
		}
	}

	public List<Vector3> SmoothSimple(List<GraphNode> path)
	{
		mSmoothPath.Clear();
		if (path.Count < 2)
		{
			for (int i = 0; i < path.Count; i++)
			{
				mSmoothPath.Add((Vector3)path[i].position);
			}
			return mSmoothPath;
		}
		maxSegmentLength = Mathf.Max(maxSegmentLength, 0.005f);
		float num = 0f;
		for (int j = 0; j < path.Count - 1; j++)
		{
			num += Vector3.Distance((Vector3)path[j].position, (Vector3)path[j + 1].position);
		}
		Mathf.FloorToInt(num / maxSegmentLength);
		float num2 = 0f;
		for (int k = 0; k < path.Count - 1; k++)
		{
			Vector3 a = (Vector3)path[k].position;
			Vector3 b = (Vector3)path[k + 1].position;
			float num3;
			for (num3 = Vector3.Distance(a, b); num2 < num3; num2 += maxSegmentLength)
			{
				mSmoothPath.Add(Vector3.Lerp(a, b, num2 / num3));
			}
			num2 -= num3;
		}
		mSmoothPath.Add((Vector3)path[path.Count - 1].position);
		if (strength > 0f)
		{
			for (int l = 0; (float)l < iterations; l++)
			{
				Vector3 vector = mSmoothPath[0];
				for (int m = 1; m < mSmoothPath.Count - 1; m++)
				{
					Vector3 vector2 = mSmoothPath[m];
					mSmoothPath[m] = Vector3.Lerp(vector2, (vector + mSmoothPath[m + 1]) / 2f, strength);
					vector = vector2;
				}
			}
		}
		return mSmoothPath;
	}
}
