using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

public class AirTestTool : MonoBehaviour
{
	private RectTransform mTran;

	private Transform mRole;

	private Transform mAirTestToolImg;

	private Vector3 mNextAreaPosition;

	private bool mIsNextAreaIndicator;

	private bool mIsAstarPathOpen;

	private bool mIsHasAliveMonsterInCurScene;

	private BattleScene mCurBattleScene;

	private List<Vector3> mMainPathPoints = new List<Vector3>();

	private List<Vector3> mSmoothPath = new List<Vector3>();

	private float maxSegmentLength = 0.2743957f;

	private float mstrength = 0.5f;

	private float miterations = 12f;

	private AstarPath astarPath;

	private byte[] mBinMap;

	private string mCurSceneName;

	private const float HEIGHT = 210f;

	private const float WEIGHT = 210f;

	public static bool mEnableNextAreaDirection = false;

	public static Vector3 mSpecialNextAreaDirection = Vector3.zero;

	public static void SetNextAreaDirection(Vector3 direction)
	{
		mEnableNextAreaDirection = true;
		mSpecialNextAreaDirection = direction;
	}

	public static void CleanNextAreaDirection()
	{
		mEnableNextAreaDirection = false;
	}

	private void Start()
	{
		mTran = GetComponent<RectTransform>();
		mAirTestToolImg = base.transform.GetChild(0);
	}

	private void Update()
	{
		if (mTran == null)
		{
			mTran = GetComponent<RectTransform>();
		}
		if (mAirTestToolImg == null)
		{
			mAirTestToolImg = base.transform.GetChild(0);
		}
		mCurBattleScene = (BattleScene)NScene.GetCurrentScene();
		if (mCurBattleScene == null || mCurBattleScene.GetBattleSimulatorSystem() == null || mCurBattleScene.GetAgentManager() == null || mCurBattleScene.GetAgentManager().GetPlayerAgent() == null)
		{
			return;
		}
		mIsHasAliveMonsterInCurScene = CommonProcessor.GetWorldState().mCurrentAliveMonsterCount > 0;
		if (mIsHasAliveMonsterInCurScene)
		{
			mAirTestToolImg.gameObject.SetActive(value: false);
			return;
		}
		mAirTestToolImg.gameObject.SetActive(mIsNextAreaIndicator || mEnableNextAreaDirection);
		mRole = mCurBattleScene.GetAgentManager().GetPlayerAgent().transform;
		if (mRole == null)
		{
			return;
		}
		mIsNextAreaIndicator = mCurBattleScene.GetNextAreaDirection(out mNextAreaPosition);
		if (mIsNextAreaIndicator || mEnableNextAreaDirection)
		{
			UpdatePathPoints();
			Vector2 vector = CalScreenPoint();
			if ((double)vector.x != double.NaN)
			{
				mTran.localPosition = vector;
			}
		}
	}

	private Vector2 CalScreenPoint()
	{
		Vector3 vector = FindNearestPointByPath(mSmoothPath, mRole.position);
		if (vector == Vector3.zero)
		{
			vector = mNextAreaPosition;
		}
		Vector3 position = mCurBattleScene.GetAgentManager().GetPlayerAgent().transform.position;
		Vector3 vector2 = vector - position;
		Vector2 vector3 = Camera.main.WorldToScreenPoint(position);
		Vector3 vector4 = Camera.main.WorldToScreenPoint(vector);
		vector4.x -= vector3.x;
		vector4.y -= vector3.y;
		vector4 = Camera.main.WorldToScreenPoint(position + vector2.normalized);
		Vector2 vector5 = (Vector2)vector4 - vector3;
		float num = vector5.y / vector5.x;
		float num2 = Mathf.Sign(vector5.x) * Mathf.Sqrt(1f / (2.2675737E-05f + num * num / 44100f));
		float y = Mathf.Sign(vector5.y) * 210f * Mathf.Sqrt(1f - num2 * num2 / 44100f);
		return new Vector2(num2, y);
	}

	private void UpdatePathPoints()
	{
		UpdateNavPathPoints();
		SmoothNavPathPoints();
	}

	private void UpdateNavPathPoints()
	{
		ABPath aBPath = ABPath.Construct((Int3)mRole.transform.position, (Int3)mNextAreaPosition);
		aBPath.nnConstraint.graphMask = 2;
		ClientSimulator.Instance.astarPath.AddSearchPath(aBPath);
		aBPath.Claim(this);
		AstarPath.BlockUntilCalculated(aBPath);
		if (ClientSimulator.Instance.astarPath != null)
		{
			ClientSimulator.Instance.astarPath.Update();
		}
		mIsAstarPathOpen = aBPath.int3Path.Count != 0;
		mMainPathPoints.Clear();
		foreach (Int3 item in aBPath.int3Path)
		{
			mMainPathPoints.Add((Vector3)item);
		}
		aBPath?.Release(this);
	}

	private void SmoothNavPathPoints()
	{
		if (!mIsAstarPathOpen)
		{
			return;
		}
		mSmoothPath.Clear();
		List<Vector3> list = mMainPathPoints;
		if (list.Count < 2)
		{
			for (int i = 0; i < list.Count; i++)
			{
				mSmoothPath.Add(list[i]);
			}
		}
		maxSegmentLength = Mathf.Max(maxSegmentLength, 0.005f);
		float num = 0f;
		for (int j = 0; j < list.Count - 1; j++)
		{
			Vector3 a = list[j];
			Vector3 b = list[j + 1];
			float num2;
			for (num2 = Vector3.Distance(a, b); num < num2; num += maxSegmentLength)
			{
				mSmoothPath.Add(Vector3.Lerp(a, b, num / num2));
			}
			num -= num2;
		}
		mSmoothPath.Add(list[list.Count - 1]);
		if (!(mstrength > 0f))
		{
			return;
		}
		for (int k = 0; (float)k < miterations; k++)
		{
			Vector3 vector = mSmoothPath[0];
			for (int l = 1; l < mSmoothPath.Count - 1; l++)
			{
				Vector3 vector2 = mSmoothPath[l];
				mSmoothPath[l] = Vector3.Lerp(vector2, (vector + mSmoothPath[l + 1]) / 2f, mstrength);
				vector = vector2;
			}
		}
	}

	private Vector3 FindNearestPointByPath(List<Vector3> path, Vector3 pos)
	{
		if (mEnableNextAreaDirection)
		{
			return mSpecialNextAreaDirection;
		}
		if (path.Count <= 0)
		{
			return Vector3.zero;
		}
		Vector3 result = path[0];
		float num = Vector3.Distance(path[0], pos);
		foreach (Vector3 item in path)
		{
			if (Vector3.Distance(item, pos) <= num)
			{
				result = item;
			}
		}
		return result;
	}

	private void BuildAstarMesh()
	{
		string b = mCurBattleScene.sceneName.Split('/')[1];
		if (!string.Equals(mCurSceneName, b))
		{
			mCurSceneName = b;
			if (astarPath == null)
			{
				astarPath = new AstarPath(new SimContext());
			}
			astarPath.scanOnStartup = true;
			TextAsset textAsset = Asset.Load<TextAsset>("Map/" + mCurSceneName + "_graph.bytes");
			mBinMap = textAsset.bytes;
			astarPath.LoadAstartData(ref mBinMap);
			AstarPath.active.Scan();
		}
	}
}
