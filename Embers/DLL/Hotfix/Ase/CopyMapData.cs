#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class CopyMapData : MapDataBase
{
	[SerializeField]
	private GameObject mapItemNodeRoot;

	[SerializeField]
	private GameObject monsterNodeRoot;

	[SerializeField]
	public float floorBaseDistance;

	private SceneSystem sceneSystem;

	[SerializeField]
	private int activeType;

	[SerializeField]
	private Vector2 activeAreaPos;

	[SerializeField]
	private Vector2 activeBounds;

	public HeroBornPointConfig HeroBornPointConfig;

	public ScenePoint scenePoint;

	public int ActiveType => activeType;

	public Vector2 ActiveAreaPos => activeAreaPos;

	public Vector2 ActiveBounds => activeBounds;

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
	}

	public void OnStart(object data = null)
	{
	}

	public void OnDispose()
	{
		StopAllBGM();
	}

	public ScenePoint GetHeroBornPoint(string heroBornPointKey, int index)
	{
		return HeroBornPointConfig.GetHeroBornPoint(heroBornPointKey, index);
	}

	public ScenePoint GetScenePoint()
	{
		if (scenePoint != null)
		{
			return scenePoint;
		}
		Log.Error("MapData中没有找到场景点配置..");
		return null;
	}

	public void CallEntities()
	{
		if ((bool)mapItemNodeRoot)
		{
			List<BattleMapItemNode>.Enumerator enumerator = mapItemNodeRoot.GetComponentsInChildren<BattleMapItemNode>().ToList().GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.OnInit(sceneSystem);
				enumerator.Current.CallSyncEntity();
			}
			enumerator.Dispose();
		}
	}

	public List<InteractiveData> GetMonsterData()
	{
		List<InteractiveData> list = new List<InteractiveData>();
		if ((bool)monsterNodeRoot)
		{
			List<MonsterNode>.Enumerator enumerator = monsterNodeRoot.GetComponentsInChildren<MonsterNode>().ToList().GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (!((Object)(object)enumerator.Current == null))
				{
					list.Add(new InteractiveData
					{
						InteractiveId = enumerator.Current.monsterConfigId,
						point = ((Component)(object)enumerator.Current).transform.position,
						rotation = ((Component)(object)enumerator.Current).transform.rotation.eulerAngles
					});
				}
			}
			enumerator.Dispose();
		}
		return list;
	}

	public List<InteractiveData> GetInteractiveData()
	{
		List<InteractiveData> list = new List<InteractiveData>();
		if ((bool)mapItemNodeRoot)
		{
			List<BattleMapItemNode>.Enumerator enumerator = mapItemNodeRoot.GetComponentsInChildren<BattleMapItemNode>().ToList().GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (!((Object)(object)enumerator.Current == null))
				{
					list.Add(new InteractiveData
					{
						InteractiveId = enumerator.Current.syncMapItemId,
						point = ((Component)(object)enumerator.Current).transform.position,
						rotation = ((Component)(object)enumerator.Current).transform.rotation.eulerAngles,
						InteractiveName = enumerator.Current.InteractiveName
					});
					enumerator.Dispose();
				}
			}
		}
		return list;
	}
}
