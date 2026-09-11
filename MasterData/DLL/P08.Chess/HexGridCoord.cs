using System;
using System.Collections;
using System.Collections.Generic;
using Chess;
using Pathfinding;
using UnityEngine;

public class HexGridCoord : MonoBehaviour
{
	public HexAnimator mRole;

	public ITraversalProvider traversalProvider;

	public LineRenderer mMainPathRender;

	public static AstarPath astarPath;

	private ABPath ab;

	private IEnumerator co;

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

	private MapData mapData;

	private IEnumerator stopCoTmp;

	private List<Vector3> mSmoothPath = new List<Vector3>();

	public float maxSegmentLength = 0.2743957f;

	public float strength = 0.5f;

	public float iterations = 12f;

	private void Start()
	{
		ChessScene chessScene = NScene.GetCurrentScene() as ChessScene;
		chessScene.hexGridCoord = this;
		mapData = chessScene.mapData;
		traversalProvider = null;
	}

	public void InitMapGameObject()
	{
		ChessMapData chessMapData = mapData.chessMapData;
		astarPath = new AstarPath(mSimContext);
		astarPath.scanOnStartup = true;
		astarPath.LoadAstartData(ref mapData.mBinMap);
		GridGraph obj = astarPath.data.graphs[0] as GridGraph;
		obj.SetDimensions(chessMapData.width, chessMapData.height, 1.225f);
		obj.UpdateTransform();
		AstarPath.active.Scan();
		HexManager.Instance.Init();
	}

	public void InitRoleBronPoint()
	{
		Vector2 bronPos = (NScene.GetCurrentScene() as ChessScene).bronPos;
		GridNode gridNode = HexManager.Instance.FindEntity((int)bronPos.x, (int)bronPos.y).gridNode;
		if (gridNode != null)
		{
			mRole.WantedPosition = (Vector3)gridNode.position;
			mRole.StartToCountRelaxTime();
		}
		else
		{
			Debug.LogError("wrong bron pos");
		}
	}

	public void InitRoleDirection()
	{
		ChessScene chessScene = NScene.GetCurrentScene() as ChessScene;
		mRole.transform.forward = ChessHelper.forwardMap[chessScene.direction];
	}

	public void TelePortRoleToPosition(int x, int z)
	{
		ClearCachePath();
		GridNode gridNode = HexManager.Instance.FindEntity(x, z).gridNode;
		if (gridNode != null)
		{
			mRole.WantedPosition = (Vector3)gridNode.position;
		}
		else
		{
			Debug.LogError("wrong transfer pos");
		}
	}

	public FindABPathResult FindPath(int x, int z, bool isCache = false)
	{
		GridNode gridNode = HexManager.Instance.FindEntity(x, z).gridNode;
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
			aBPath.calculatePartial = true;
		}
		aBPath.Claim(this);
		AstarPath.StartPath(aBPath);
		AstarPath.BlockUntilCalculated(aBPath);
		if (isCache)
		{
			if (ab != null)
			{
				ab.Release(this);
			}
			ab = aBPath;
		}
		List<Int2> rangeNodeS = ChessHelper.GetRangeNodeS(x, z, 1);
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
		if (ab != null && !ab.error && ab.vectorPath.Count != 0)
		{
			if (co != null)
			{
				StopCoroutine(co);
			}
			List<Vector3> vectorPath = ab.vectorPath;
			if (!mRole.IsTouchItemWithoutMove(vectorPath[vectorPath.Count - 1], (Vector3)ab.originalEndPoint, 2f))
			{
				co = mRole.MoveAlongPath(ab, 2f);
				StartCoroutine(co);
				SmoothSimple(ab.path);
			}
			HexCameraManager.Instance.LookAtPlayer();
		}
	}

	public void ClearCachePath()
	{
		if (co != null)
		{
			StopCoroutine(co);
		}
		if (ab != null)
		{
			ab = null;
		}
	}

	public void RoleStopMove(Action callBack = null, bool isSkipWalkEnd = false)
	{
		if (co != null)
		{
			StopCoroutine(co);
		}
		mRole.StopMove();
		if (stopCoTmp != null)
		{
			StopCoroutine(stopCoTmp);
		}
		stopCoTmp = mRole.GoToNearestNode(callBack, isSkipWalkEnd);
	}

	private void Update()
	{
	}

	public void Shutdown()
	{
		if (co != null)
		{
			StopCoroutine(co);
		}
		if (stopCoTmp != null)
		{
			StopCoroutine(stopCoTmp);
		}
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
