using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

public class NavArrowRender : MonoBehaviour
{
	public Transform mRole;

	public GameObject mTargetPosEffect;

	private Transform mTargetTranEffect;

	private TargetIndicatorUI mTargetIndicatorUI;

	public float mOffsetRecalc = 15f;

	public Vector3 mHeightOffset = new Vector3(0f, 0.09f, 0f);

	private List<Int3> mMainPathPoints = new List<Int3>();

	private List<Vector3> mSmoothPath = new List<Vector3>();

	private List<Int3> mEntryPoints = new List<Int3>();

	private List<Vector3> mPathPoint = new List<Vector3>(16);

	public bool FindPathFromSelf;

	public bool isActive = true;

	public LineRenderer mMainPathRender;

	public Vector3 nextPostion;

	private bool isTrigger;

	private float mPathLength;

	private float progress;

	private float percent;

	public float maxSegmentLength = 0.2743957f;

	private bool uniformLength = true;

	public float strength = 0.5f;

	public float iterations = 12f;

	private int mEntryIndex = -1;

	private Int3 mEntryPoint;

	private bool mShowBranch;

	private Vector3 mSpawnPoint = Vector3.zero;

	public void OnEnable()
	{
	}

	public void UpdatePathPoints()
	{
		isTrigger = (NScene.GetCurrentScene() as BattleScene).GetNextAreaDirection(out var direction);
		if (isTrigger && direction != nextPostion)
		{
			nextPostion = direction;
			Int3 @int = (Int3)mRole.position;
			if (!FindPathFromSelf)
			{
				@int = (Int3)(NScene.GetCurrentScene() as BattleScene).GetCharInitPos();
				mSpawnPoint = (Vector3)@int;
			}
			FindMainPathEntry(@int);
			mPathPoint.Clear();
			mSmoothPath.Clear();
			for (int i = 0; i < mMainPathPoints.Count; i++)
			{
				mPathPoint.Add((Vector3)mMainPathPoints[i]);
			}
			SmoothSimple(mPathPoint);
			percent = 0f;
			progress = 0f;
			FindNearestPoint(mSmoothPath, mRole.position, out var nearestIndex);
			if (nearestIndex >= 0 && mSmoothPath.Count > 0)
			{
				progress = (float)(nearestIndex + 1) / (float)mSmoothPath.Count;
			}
			mMainPathRender.sharedMaterial.SetFloat("_progress", progress);
			mMainPathRender.sharedMaterial.SetFloat("_percent", percent);
			mPathLength *= 1f - progress;
			mMainPathRender.positionCount = mSmoothPath.Count;
			for (int j = 0; j < mSmoothPath.Count; j++)
			{
				mMainPathRender.SetPosition(j, mSmoothPath[j]);
			}
			if (mSmoothPath.Count > 0 && mTargetTranEffect != null)
			{
				if (!mTargetTranEffect.gameObject.activeInHierarchy)
				{
					mTargetTranEffect.gameObject.SetActive(value: true);
				}
				mTargetTranEffect.position = mSmoothPath[mSmoothPath.Count - 1];
			}
		}
		if (!isTrigger)
		{
			ClosePath();
		}
	}

	public void ClosePath()
	{
		mMainPathPoints.Clear();
		mPathPoint.Clear();
		mSmoothPath.Clear();
		mMainPathRender.positionCount = 0;
		mPathLength = 0f;
		if (mTargetTranEffect != null)
		{
			mTargetTranEffect.gameObject.SetActive(value: false);
		}
		if (mTargetIndicatorUI != null && mTargetIndicatorUI.MUnderPathControl)
		{
			mTargetIndicatorUI.DrawUI(enable: false, Vector3.zero, Vector3.zero, 0f);
		}
	}

	public void ShiftList(int offset)
	{
		if (offset >= mPathPoint.Count - 1)
		{
			mPathPoint.Clear();
		}
		else if (offset < mPathPoint.Count - 1)
		{
			for (int i = 0; i < mPathPoint.Count; i++)
			{
				mPathPoint[i] = mPathPoint[offset + i];
			}
			for (int j = offset; j < mPathPoint.Count; j++)
			{
				mPathPoint.RemoveAt(j);
			}
		}
	}

	public bool FindEntry(Vector3 rolePosition, long offset)
	{
		float num = float.MaxValue;
		int num2 = -1;
		bool result = false;
		mEntryPoints.Clear();
		if (mMainPathPoints.Count == 1)
		{
			result = true;
			mEntryPoint = mMainPathPoints[0];
		}
		else if (mMainPathPoints.Count >= 2)
		{
			for (int i = 0; i < mMainPathPoints.Count; i++)
			{
				if (i < mMainPathPoints.Count - 1)
				{
					Vector3 vector = VectorMath.ClosestPointOnSegment((Vector3)mMainPathPoints[i], (Vector3)mMainPathPoints[i + 1], rolePosition);
					float sqrMagnitude = (vector - rolePosition).sqrMagnitude;
					if (sqrMagnitude <= num)
					{
						num = sqrMagnitude;
						mEntryPoint = (Int3)vector;
						result = true;
						num2 = i;
					}
				}
			}
			if (num2 >= 0)
			{
				int j;
				for (j = num2 + 1; j < mMainPathPoints.Count; j++)
				{
					Int3 @int = mMainPathPoints[j];
					Int3 int2 = @int - mEntryPoint;
					int2 = new Int3(int2.x, 0, int2.z);
					if (offset <= 0)
					{
						break;
					}
					long longMagnitude = int2.LongMagnitude;
					if (longMagnitude < offset)
					{
						mEntryPoint = @int;
						offset -= longMagnitude;
						continue;
					}
					mEntryPoint += int2.NormalizeTo((int)offset);
					break;
				}
				for (; j < mMainPathPoints.Count; j++)
				{
					mEntryPoints.Add(mMainPathPoints[j]);
				}
			}
		}
		return result;
	}

	public Int3 GetNearestPoint(List<Int3> path, Int3 target)
	{
		long num = long.MaxValue;
		int num2 = -1;
		for (int i = 0; i < path.Count; i++)
		{
			long sqrMagnitudeLong = (target - path[i]).sqrMagnitudeLong;
			if (sqrMagnitudeLong < num)
			{
				num = sqrMagnitudeLong;
				num2 = i;
			}
		}
		if (num2 >= 0)
		{
			return path[num2];
		}
		return Int3.zero;
	}

	public Int3 FindMainPathEntry(Int3 startPos)
	{
		ABPath aBPath = ABPath.Construct(startPos, (Int3)nextPostion);
		aBPath.nnConstraint.graphMask = 2;
		ClientSimulator.Instance.astarPath.AddSearchPath(aBPath);
		aBPath.Claim(this);
		AstarPath.BlockUntilCalculated(aBPath);
		if (ClientSimulator.Instance.astarPath != null)
		{
			ClientSimulator.Instance.astarPath.Update();
		}
		Int3 result = (Int3)nextPostion;
		mMainPathPoints.Clear();
		for (int i = 0; i < aBPath.int3Path.Count; i++)
		{
			mMainPathPoints.Add(aBPath.int3Path[i]);
		}
		aBPath.Release(this);
		mEntryPoint = result;
		return result;
	}

	public bool FindBranchPath(bool showBranch = false)
	{
		mShowBranch = showBranch;
		Vector3 position = mRole.position;
		if (mSmoothPath.Count >= 2)
		{
			FindNearestPoint(mSmoothPath, position, out var nearestIndex);
			if (nearestIndex != mSmoothPath.Count - 1 && (VectorMath.ClosestPointOnLine(mSmoothPath[nearestIndex], mSmoothPath[nearestIndex + 1], position) - position).sqrMagnitude < mOffsetRecalc)
			{
				return false;
			}
		}
		if (!FindEntry(position, 0L))
		{
			NNInfoInternal nearest = ClientSimulator.Instance.astarPath.graphs[1].GetNearest((Int3)position);
			if (nearest.node == null)
			{
				Vector3 vector = position;
				Debug.LogError("无法找到导航信息:" + vector.ToString());
				return false;
			}
			mEntryPoint = nearest.node.position;
		}
		mPathPoint.Clear();
		mSmoothPath.Clear();
		if (showBranch)
		{
			if (!(ClientSimulator.Instance.astarPath.graphs[0] as IRaycastableGraph).Linecast((Int3)position, mEntryPoint))
			{
				mPathPoint.Add(position);
				mPathPoint.Add((Vector3)mEntryPoint);
			}
			else
			{
				ABPath aBPath = ABPath.Construct((Int3)position, mEntryPoint);
				aBPath.nnConstraint.graphMask = 1;
				ClientSimulator.Instance.astarPath.AddSearchPath(aBPath);
				aBPath.Claim(this);
				AstarPath.BlockUntilCalculated(aBPath);
				if (ClientSimulator.Instance.astarPath != null)
				{
					ClientSimulator.Instance.astarPath.Update();
				}
				SimPathStartEndModifer.Apply(aBPath);
				SimPathFunnelModifier.Apply(aBPath, unwrap: false, splitAtEveryPortal: false);
				for (int i = 0; i < aBPath.int3Path.Count; i++)
				{
					if (!(ClientSimulator.Instance.astarPath.graphs[0] as IRaycastableGraph).Linecast((Int3)position, aBPath.int3Path[i]))
					{
						if (mPathPoint.Count <= 1)
						{
							mPathPoint.Add((Vector3)aBPath.int3Path[i]);
						}
						else
						{
							mPathPoint[1] = (Vector3)aBPath.int3Path[i];
						}
					}
					else
					{
						mPathPoint.Add((Vector3)aBPath.int3Path[i]);
					}
				}
				aBPath.Release(this);
			}
		}
		else
		{
			mPathPoint.Add((Vector3)mEntryPoint);
		}
		for (int j = 0; j < mEntryPoints.Count; j++)
		{
			mPathPoint.Add((Vector3)mEntryPoints[j]);
		}
		SmoothSimple(mPathPoint);
		return true;
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

	private void Update()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null || battleScene.GetBattleSimulatorSystem() == null || battleScene.GetAgentManager() == null || battleScene.GetAgentManager().GetPlayerAgent() == null)
		{
			return;
		}
		mRole = battleScene.GetAgentManager().GetPlayerAgent().transform;
		if (mRole == null)
		{
			return;
		}
		if (mTargetIndicatorUI == null)
		{
			mTargetIndicatorUI = BattleUI.GetBattleUI().TragetIndicatorUI;
		}
		if (ClientSimulator.Instance.astarPath.graphs.Length >= 2 && ClientSimulator.Instance.astarPath.graphs[1] is PointGraph)
		{
			if (isActive)
			{
				UpdatePathPoints();
				DrawLine();
			}
			else
			{
				ClosePath();
			}
		}
	}

	public void ShowPath(bool isActive)
	{
		this.isActive = isActive;
	}

	public void DrawLine()
	{
		int nearestIndex = 0;
		FindNearestPoint(mSmoothPath, mRole.position, out nearestIndex);
		if (nearestIndex >= 0 && mMainPathRender != null && mSmoothPath.Count > 0)
		{
			float b = (float)(nearestIndex + 1) / (float)mSmoothPath.Count;
			progress = Mathf.Lerp(progress, b, Time.deltaTime * 5f);
			mMainPathRender.sharedMaterial.SetFloat("_progress", progress);
			percent += Time.deltaTime;
			mMainPathRender.sharedMaterial.SetFloat("_percent", Mathf.Clamp01(percent));
			float distance = mPathLength * (1f - progress);
			if (mTargetIndicatorUI != null && mTargetIndicatorUI.MUnderPathControl)
			{
				mTargetIndicatorUI.DrawUI(enable: true, mRole.position, mSmoothPath[mSmoothPath.Count - 1], distance);
			}
		}
	}

	public List<Vector3> SmoothSimple(List<Vector3> path)
	{
		mSmoothPath.Clear();
		if (path.Count < 2)
		{
			for (int i = 0; i < path.Count; i++)
			{
				mSmoothPath.Add(path[i]);
			}
			return mSmoothPath;
		}
		if (uniformLength)
		{
			maxSegmentLength = Mathf.Max(maxSegmentLength, 0.005f);
			mPathLength = 0f;
			for (int j = 0; j < path.Count - 1; j++)
			{
				mPathLength += Vector3.Distance(path[j], path[j + 1]);
			}
			Mathf.FloorToInt(mPathLength / maxSegmentLength);
			float num = 0f;
			for (int k = 0; k < path.Count - 1; k++)
			{
				Vector3 a = path[k];
				Vector3 b = path[k + 1];
				float num2;
				for (num2 = Vector3.Distance(a, b); num < num2; num += maxSegmentLength)
				{
					mSmoothPath.Add(Vector3.Lerp(a, b, num / num2));
				}
				num -= num2;
			}
			mSmoothPath.Add(path[path.Count - 1]);
		}
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

	private static Vector3 Lerp(Vector3[] pts, float t)
	{
		int num = pts.Length - 3;
		int num2 = Mathf.Min(Mathf.FloorToInt(t * (float)num), num - 1);
		float num3 = t * (float)num - (float)num2;
		Vector3 vector = pts[num2];
		Vector3 vector2 = pts[num2 + 1];
		Vector3 vector3 = pts[num2 + 2];
		Vector3 vector4 = pts[num2 + 3];
		return 0.5f * ((-vector + 3f * vector2 - 3f * vector3 + vector4) * (num3 * num3 * num3) + (2f * vector - 5f * vector2 + 4f * vector3 - vector4) * (num3 * num3) + (-vector + vector3) * num3 + 2f * vector2);
	}
}
