using P08.QWorld.PathFinding;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

public class QWorldPathFinderManager
{
	public static QWorldPathFinderManager Instance;

	private SimpleSmoothModifier modifier;

	private AstarPath astarPath;

	private byte[] mBinMap;

	public void Init(string mapPath)
	{
		Instance = this;
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		GameObject gameObject = new GameObject("QWorldPathFinding");
		gameObject.transform.parent = qWorldScene.transform;
		SimpleSmoothModifier simpleSmoothModifier = gameObject.AddComponent<SimpleSmoothModifier>();
		simpleSmoothModifier.maxSegmentLength = 0.7f;
		simpleSmoothModifier.strength = 0.1f;
		modifier = simpleSmoothModifier;
		InitAstar(mapPath);
	}

	private void InitAstar(string mapPath)
	{
		TextAsset textAsset = Asset.Load<TextAsset>(mapPath);
		mBinMap = textAsset.bytes;
		astarPath = new AstarPath(null);
		astarPath.scanOnStartup = true;
		astarPath.LoadAstartData(ref mBinMap);
		for (int i = 0; i < astarPath.graphs.Length; i++)
		{
			RecastGraph obj = astarPath.graphs[i] as RecastGraph;
			obj.mTileHandler = new TileHandler(obj);
			obj.mTileHandler.CreateTileTypesFromGraph();
		}
	}

	public void Tick()
	{
		astarPath?.Update();
	}

	public void FindPath(Int3 start, Int3 end, OnPathDelegate onPathDone)
	{
		if (onPathDone != null)
		{
			AstarPath.StartPath(ABPath.Construct(start, end, onPathDone));
		}
	}

	public void PathSmooth(Path p)
	{
		modifier.Apply(p);
	}

	public void Dispose()
	{
		Instance = null;
	}
}
