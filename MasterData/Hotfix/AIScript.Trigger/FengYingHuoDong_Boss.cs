using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trigger;

public class FengYingHuoDong_Boss : AIBase
{
	private readonly int monsterDataId = 3070010;

	private readonly string areaPath = "Area_99900_FengYingHuoDong";

	private readonly FP delayTime = 8;

	private readonly Dictionary<string, FP> areaDelayDic = new Dictionary<string, FP> { ["Wave_2"] = 4 };

	private readonly Dictionary<string, string> areaPosNameDic = new Dictionary<string, string> { ["Wave_2"] = "WindPoint_1" };

	private readonly Dictionary<string, FP> areaRotDic = new Dictionary<string, FP>();

	private AdventureActor _monster;

	private List<CoroutineNode> areaCoroutines = new List<CoroutineNode>(3);

	public void OnEnable()
	{
		areaCoroutines.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED", OnRoomWaveSpawnLogicEnabled);
	}

	private AdventureActor GetActor()
	{
		if (_monster == null)
		{
			List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(monsterDataId);
			if (list.Count > 0)
			{
				_monster = list.get_Item(0) as AdventureActor;
			}
		}
		return _monster;
	}

	private void OnRoomWaveSpawnLogicEnabled(IEvent evt)
	{
		if (!(evt is AdventureLevelRoomWaveSpawnLogicEnabledEvent { wave: var wave }) || !areaDelayDic.TryGetValue(wave, out var value))
		{
			return;
		}
		GetActor();
		if (_monster != null)
		{
			CoroutineNode coroutineNode = _monster.StartLogicCoroutine(WaitPlayArea(wave, value));
			if (coroutineNode != null)
			{
				areaCoroutines.Add(coroutineNode);
			}
		}
	}

	private IEnumerator WaitPlayArea(string Wave, FP delay)
	{
		yield return _monster.StartLogicCoroutine(_monster.WaitForSeconds(delay), runImmediately: true);
		TSVector2 pos = TSVector2.zero;
		if (areaPosNameDic.TryGetValue(Wave, out var value))
		{
			pos = CommonUtils_MonsterAPI.GetPlaceHolderPosition(value);
		}
		ILRuntimeAPI.PlayAreaEffect(rotation: (!areaRotDic.TryGetValue(Wave, out var value2)) ? ((FP)(TSRandom.Range(0, 4) * 90)) : value2, actor: _monster, fxAlias: areaPath, position: pos);
		while (delayTime > 0)
		{
			yield return _monster.StartLogicCoroutine(_monster.WaitForSeconds(delayTime), runImmediately: true);
			FP rotation = TSRandom.Range(0, 4) * 90;
			ILRuntimeAPI.PlayAreaEffect(_monster, areaPath, pos, rotation);
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED", OnRoomWaveSpawnLogicEnabled);
		if (_monster != null && areaCoroutines.Count > 0)
		{
			for (int i = 0; i < areaCoroutines.Count; i++)
			{
				_monster.StopLogicCoroutine(areaCoroutines.get_Item(i));
			}
			areaCoroutines.Clear();
		}
	}
}
