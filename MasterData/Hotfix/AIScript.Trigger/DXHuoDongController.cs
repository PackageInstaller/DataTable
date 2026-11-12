using System.Collections.Generic;
using TrueSync;

namespace AIScript.Trigger;

public class DXHuoDongController : AIBase
{
	private readonly int dropItemId = 119;

	private readonly FP dropCd = 1;

	private readonly Dictionary<string, FP> dropRateDic = new Dictionary<string, FP> { ["Wave_1"] = 50 };

	private readonly Dictionary<string, int> dropLimitDic = new Dictionary<string, int>
	{
		["Wave_1"] = 1,
		["Wave_2"] = 1,
		["Wave_3"] = 1
	};

	private FP _dropRate;

	private int _dropLimit;

	private FP _lastDropTime;

	private int _dropCount;

	public void OnEnable()
	{
		_dropRate = 100;
		_dropLimit = -1;
		_lastDropTime = 0;
		_dropCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED", OnRoomWaveSpawnLogicEnabled);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
	}

	private void OnRoomWaveSpawnLogicEnabled(IEvent evt)
	{
		if (evt is AdventureLevelRoomWaveSpawnLogicEnabledEvent { wave: var wave })
		{
			if (dropRateDic.TryGetValue(wave, out var value))
			{
				_dropRate = value;
			}
			else
			{
				_dropRate = 100;
			}
			if (dropLimitDic.TryGetValue(wave, out var value2))
			{
				_dropLimit = value2;
			}
			else
			{
				_dropLimit = -1;
			}
			_dropCount = 0;
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent { to: MonsterAdventureActor to } adventureActorReceiveAttackEvent && (adventureActorReceiveAttackEvent.from is PlayerAdventureActor || adventureActorReceiveAttackEvent.from.IsPlayerMinion(out var _)))
		{
			TryDropItem(to.tsTransform.Position);
		}
	}

	private bool TryDropItem(TSVector2 position)
	{
		if (_dropLimit >= 0 && _dropCount >= _dropLimit)
		{
			return false;
		}
		if (_lastDropTime > 0 && LockStepManager.time - _lastDropTime <= dropCd)
		{
			return false;
		}
		if (TSRandom.Range(FP.Zero, 100) <= _dropRate)
		{
			AdventureActor owner = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
			SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(owner, dropItemId, position);
			_lastDropTime = LockStepManager.time;
			_dropCount++;
			return true;
		}
		return false;
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ROOM_WAVE_SPAWNLOGIC_ENABLED", OnRoomWaveSpawnLogicEnabled);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
	}
}
