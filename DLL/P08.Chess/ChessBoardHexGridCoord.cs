using ChessBoard;
using Pathfinding;
using UnityEngine;

public class ChessBoardHexGridCoord : MonoBehaviour
{
	public ChessBoardHeroEntity heroEntity;

	public ITraversalProvider traversalProvider;

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

	private ChessBoardMap mapData;

	private void Start()
	{
		ChessBoardScene chessBoardScene = NScene.GetCurrentScene() as ChessBoardScene;
		chessBoardScene.hexGridCoord = this;
		mapData = chessBoardScene.mapData;
		traversalProvider = null;
	}

	public void InitMapGameObject()
	{
		ChessBoardMapData chessBoardMapData = mapData.chessBoardMapData;
		astarPath = new AstarPath(mSimContext);
		astarPath.scanOnStartup = true;
		astarPath.LoadAstartData(ref mapData.mBinMap);
		GridGraph obj = astarPath.data.graphs[0] as GridGraph;
		obj.SetDimensions(chessBoardMapData.width, chessBoardMapData.height, 1.225f);
		obj.UpdateTransform();
		AstarPath.active.Scan();
		ChessBoardHexManager.Instance.Init();
	}

	public void InitRoleBronPoint()
	{
		Int2 bronPos = (NScene.GetCurrentScene() as ChessBoardScene).bronPos;
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(bronPos.x, bronPos.y);
		if (chessBoardHexEntity.gridNode != null)
		{
			heroEntity.InitBronPoint(bronPos, (Vector3)chessBoardHexEntity.gridNode.position, chessBoardHexEntity.gridData.offsetY);
		}
		else
		{
			Debug.LogError("wrong bron pos");
		}
	}

	public void InitRoleDirection()
	{
		ChessBoardScene chessBoardScene = NScene.GetCurrentScene() as ChessBoardScene;
		heroEntity.transform.forward = ChessBoardHelper.forwardMap[chessBoardScene.direction];
	}
}
