using System.Threading.Tasks;
using Dorm;
using Dorm.Furniture;
using Pathfinding;
using Pathfinding.Util;
using Sirenix.OdinInspector;
using UnityEngine;

namespace P08.SimBusiness;

public class SceneNavSurface : SerializedMonoBehaviour
{
	internal class EndingConditionProximityInArea : ABPathEndingCondition
	{
		private IProvideInteractArea area;

		internal EndingConditionProximityInArea(ABPath p, IProvideInteractArea area)
			: base(p)
		{
			this.area = area;
		}

		public override bool TargetFound(PathNode node)
		{
			return area.Area.bounds.Contains((Vector3)node.node.position);
		}
	}

	[HideInInspector]
	private readonly RetainedGizmos gizmos = new RetainedGizmos();

	public AstarPath astarPath;

	public TileCoordinate<FloorEntity> floorCoordinate;

	public const float TILE_SIZE = 0.5f;

	private static void DrawNavGraphGizmos(AstarPath astarPath, RetainedGizmos gizmos)
	{
	}

	private void InitAstarPath()
	{
		if (astarPath == null)
		{
			astarPath = new AstarPath(null);
			astarPath.logPathResults = PathLog.Heavy;
		}
	}

	private void FixedUpdate()
	{
		if (astarPath != null)
		{
			astarPath.Update();
		}
	}

	public void LoadAstarPath(string path)
	{
		LoadAstarPath(Asset.Load<TextAsset>(path));
	}

	public void LoadAstarPath(TextAsset asset)
	{
		if (!(asset == null))
		{
			byte[] bytes = asset.bytes;
			LoadAstarPath(ref bytes);
		}
	}

	public void LoadAstarPath(ref byte[] bytes, bool rescan = true)
	{
		InitAstarPath();
		astarPath.LoadAstartData(ref bytes);
		Debug.Log(AstarPath.active);
		OnGraphLoaded(astarPath);
		if (rescan)
		{
			astarPath.Scan();
		}
		AstarPath.OnGraphsUpdated?.Invoke(astarPath);
	}

	private void OnGraphLoaded(AstarPath astarPath)
	{
	}

	public static async Task<Path> CalcPathToTarget(AstarPath astarPath, Vector3 start, Vector3 target)
	{
		XPath path = XPath.Construct(astarPath.GetNearest((Int3)start).node.position, (Int3)target);
		path.endingCondition = new EndingConditionProximity(path, 0.25f);
		path.heuristic = Heuristic.Manhattan;
		TaskCompletionSource<Path> source = new TaskCompletionSource<Path>();
		path.callback = delegate(Path p)
		{
			source.SetResult(p);
		};
		AstarPath.StartPath(path);
		await source.Task;
		return path;
	}

	public static async Task<Path> CalcPathToTarget(AstarPath astarPath, Vector3 start, Transform target)
	{
		NNInfo nearest = astarPath.GetNearest((Int3)start);
		IProvideInteractArea componentInChildren = target.GetComponentInChildren<IProvideInteractArea>();
		XPath path = XPath.Construct(nearest.node.position, (Int3)target.position);
		if (componentInChildren == null)
		{
			path.endingCondition = new EndingConditionProximity(path, 0.25f);
		}
		else
		{
			path.endingCondition = new EndingConditionProximityInArea(path, componentInChildren);
		}
		path.heuristic = Heuristic.Manhattan;
		TaskCompletionSource<Path> source = new TaskCompletionSource<Path>();
		path.callback = delegate(Path p)
		{
			source.SetResult(p);
		};
		AstarPath.StartPath(path);
		await source.Task;
		return path;
	}

	public Path SyncCalcPathToTarget(Vector3 start, Vector3 target)
	{
		NNInfo nearest = astarPath.GetNearest((Int3)start);
		NNInfo nearest2 = astarPath.GetNearest((Int3)target);
		ABPath aBPath = ABPath.Construct(nearest.node.position, nearest2.node.position);
		aBPath.Claim(this);
		AstarPath.StartPath(aBPath);
		AstarPath.BlockUntilCalculated(aBPath);
		return aBPath;
	}

	public void InitCoords(RoomWallTag wallTag)
	{
		floorCoordinate.Init(wallTag.originalPoint, wallTag.width, wallTag.height, TileType.FLOOR);
	}

	private static Vector3 ShelfSnapPosWorldWithoutCoordinateSys(FurnitureEntity shelfEntity, Vector3 position)
	{
		Vector3 zero = Vector3.zero;
		Vector3 vector = position - zero;
		bool flag = Mathf.RoundToInt(Mathf.Abs(shelfEntity.trs.localEulerAngles.y) / 90f) % 2 == 1;
		int width = shelfEntity.width;
		int height = shelfEntity.height;
		int num = (flag ? height : width);
		int num2 = (flag ? width : height);
		Vector3 vector2 = new Vector3(0.5f * (float)num, 0f, 0.5f * (float)num2);
		Vector3 v = new Vector3(vector.x / 0.5f, 0f, vector.z / 0.5f) - vector2;
		Vector3 vector3 = vector2 + (flag ? Vector3Int.CeilToInt(v) : Vector3Int.FloorToInt(v));
		return zero + 0.5f * vector3;
	}

	internal Vector3 ShelfSnapPos(FurnitureEntity goodsEntity, Vector3 input)
	{
		if (floorCoordinate != null)
		{
			bool flag = Mathf.RoundToInt(Mathf.Abs(goodsEntity.trs.localEulerAngles.y) / 90f) % 2 == 1;
			int width = (flag ? goodsEntity.height : goodsEntity.width);
			int height = (flag ? goodsEntity.width : goodsEntity.height);
			return floorCoordinate.FindNearestPosition(input, isLimit: true, wallMountLayOnGround: true, width, height, flag);
		}
		return ShelfSnapPosWorldWithoutCoordinateSys(goodsEntity, input);
	}

	internal bool ShelfCheckCanPlace(FurnitureEntity goodsEntity)
	{
		float y = goodsEntity.trs.localEulerAngles.y;
		return floorCoordinate.GetIsAvailable(goodsEntity.trs.position, goodsEntity.width, goodsEntity.height, y);
	}

	private void Awake()
	{
		floorCoordinate = new TileCoordinate<FloorEntity>(0.5f);
	}

	private void OnEnable()
	{
	}

	private void OnDisable()
	{
	}

	private void OnDestroy()
	{
		if (astarPath != null)
		{
			astarPath.Shutdown();
		}
	}
}
