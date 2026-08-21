using System.Collections.Generic;
using Ase;
using Cysharp.Threading.Tasks;
using UnityEngine;

public class CreateCopyData
{
	private CopyMapData _copyMapData;

	private MonsterMapData _monsterMapData;

	public async UniTask<bool> LoadBattleSceneMapData(string mapDataName, GameResourceSystem resourceSystem, GameObject worldRoot, int copyId = 0)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
		if (dataRow != null && !string.IsNullOrEmpty(dataRow.ActivityMapData))
		{
			return LoadMonsterMapData(worldRoot, resourceSystem);
		}
		GameObject gameObject = await resourceSystem.InstantiateAsync(AssetUtility.GetCopyMapDataAsset(mapDataName), worldRoot.transform);
		if (gameObject == null)
		{
			return false;
		}
		gameObject.name = "------ MapData ------";
		gameObject.transform.SetParent(worldRoot.transform);
		_copyMapData = gameObject.GetComponent<CopyMapData>();
		return (Object)(object)_copyMapData != null;
	}

	public bool LoadMonsterMapData(GameObject worldRoot, GameResourceSystem resourceSystem)
	{
		GameObject gameObject = ((Component)(object)Object.FindObjectOfType<MonsterMapData>())?.gameObject;
		if (gameObject == null)
		{
			return false;
		}
		gameObject.name = "------ MapData ------";
		gameObject.transform.SetParent(worldRoot.transform);
		_monsterMapData = gameObject.GetComponent<MonsterMapData>();
		_monsterMapData.OnInit(resourceSystem.GetSystem<SceneSystem>());
		return true;
	}

	public ScenePoint GetHeroBornPoint(string heroBornPointKey, int index)
	{
		if ((Object)(object)_copyMapData != null)
		{
			return _copyMapData.GetHeroBornPoint(heroBornPointKey, index);
		}
		if ((Object)(object)_monsterMapData != null)
		{
			return _monsterMapData.GetHeroBornPoint(heroBornPointKey, index);
		}
		return null;
	}

	public ScenePoint GetScenePoint()
	{
		if ((Object)(object)_copyMapData != null)
		{
			return _copyMapData.GetScenePoint();
		}
		if ((Object)(object)_monsterMapData != null)
		{
			return _monsterMapData.GetScenePoint();
		}
		return null;
	}

	public List<InteractiveData> GetInteractiveData()
	{
		if ((Object)(object)_copyMapData != null)
		{
			return _copyMapData.GetInteractiveData();
		}
		return null;
	}

	public void Clear()
	{
		_copyMapData = null;
	}

	public float GetFloorBaseDistance()
	{
		return _copyMapData?.floorBaseDistance ?? 0f;
	}

	public bool IsCopyMapData()
	{
		return (Object)(object)_copyMapData != null;
	}

	public bool IsMonsterMapData()
	{
		return (Object)(object)_monsterMapData != null;
	}

	public int GetBattleActiveType()
	{
		if ((Object)(object)_copyMapData != null)
		{
			return _copyMapData.ActiveType;
		}
		return -1;
	}

	public Vector3 GetBattleActiveAreaPos()
	{
		if ((Object)(object)_copyMapData != null)
		{
			return _copyMapData.ActiveAreaPos;
		}
		return Vector3.zero;
	}

	public Vector2 GetBattleActiveBounds()
	{
		if ((Object)(object)_copyMapData != null)
		{
			return _copyMapData.ActiveBounds;
		}
		return Vector2.zero;
	}

	public void StartMonsterCopyTask()
	{
		_monsterMapData?.StartTask();
	}

	public void PlayBGM()
	{
		if ((Object)(object)_copyMapData != null)
		{
			_copyMapData.PlayBGM();
		}
		if ((Object)(object)_monsterMapData != null)
		{
			_monsterMapData.PlayBGM();
		}
	}
}
