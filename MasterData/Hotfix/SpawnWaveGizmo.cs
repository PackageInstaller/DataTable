using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Gizmo/Spawn Wave")]
public class SpawnWaveGizmo : MonoBehaviour
{
	public WaveRefreshType waveRefreshType;

	public int eventWaveIndex;

	protected bool _isListenEvent;

	protected int _waveIndex;

	public void Initialize(int waveIndex)
	{
		_waveIndex = waveIndex;
		switch (waveRefreshType)
		{
		case WaveRefreshType.Direct:
			EnableWave();
			break;
		case WaveRefreshType.WaveAllDead:
			_isListenEvent = true;
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_WAVE_MONSTER_ALL_DEAD", OnWaveAllDead);
			break;
		case WaveRefreshType.EventTrigger:
			break;
		}
	}

	private void OnWaveAllDead(IEvent evt)
	{
		if (((AdventureWaveMonsterAllDeadEvent)evt).index == eventWaveIndex)
		{
			EnableWave();
		}
	}

	private void EnableWave()
	{
		List<SpawnPlanGizmo> list = new List<SpawnPlanGizmo>();
		SpawnPlanGizmo[] array = Object.FindObjectsOfType<SpawnPlanGizmo>();
		foreach (SpawnPlanGizmo spawnPlanGizmo in array)
		{
			if (spawnPlanGizmo.isActiveAndEnabled && FilterPlan(spawnPlanGizmo))
			{
				list.Add(spawnPlanGizmo);
			}
		}
		if (list.Count == 0)
		{
			Debug.LogWarning("the wave have no plan take effect, wave name:" + gameObject.name);
			return;
		}
		int num = 0;
		if (list.Count > 1)
		{
			num = MonoSingleton<GameController>.Instance.Random_Roguelike(0, list.Count);
			string msg = $"EnableWave:rdmIndex={num}";
			MonoSingleton<GameController>.Instance.SaveMsg(msg);
		}
		list.get_Item(num).Initialize(_waveIndex);
	}

	private bool FilterPlan(SpawnPlanGizmo spawnPlan)
	{
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower && (ModuleController<AdventureModuleController>.Instance.currentFloor < spawnPlan.floorRange.x || ModuleController<AdventureModuleController>.Instance.currentFloor > spawnPlan.floorRange.y))
		{
			return false;
		}
		if (!spawnPlan.weather.HasFlag(ModuleController<AdventureModuleController>.Instance.weather))
		{
			return false;
		}
		return spawnPlan.timeOfDay.HasFlag(ModuleController<AdventureModuleController>.Instance.timeOfDay);
	}

	private void OnDestroy()
	{
		if (_isListenEvent)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_WAVE_MONSTER_ALL_DEAD", OnWaveAllDead);
		}
	}
}
