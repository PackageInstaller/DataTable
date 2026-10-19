using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using Cysharp.Threading.Tasks;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class FleeMonsterPointData : StateWorldAssetData
{
	public const int ActiveState = 0;

	public const int DeActiveState = 1;

	public const int FleeState = 2;

	private const string monsterPointId = "monsterPointId";

	[SerializeField]
	private YooAssetReference _addressAssetID;

	[SerializeField]
	private int _initialStateId;

	[SerializeField]
	private int _monsterPointId;

	[SerializeField]
	private int _groupUid = -1;

	[SerializeField]
	private int _groupAI = -1;

	[SerializeField]
	private bool _isHaveBornEffect = true;

	[SerializeField]
	private bool _isLeft = true;

	[SerializeField]
	private string[] _buffList;

	[SerializeField]
	private Pos _monsterSpawnPos;

	[SerializeField]
	private Pos[] _fleeWaypoints;

	[SerializeField]
	private MixedBox _fleeTriggerField;

	[OdinSerialize]
	private Dictionary<int, int> _aiDictionary = new Dictionary<int, int>();

	public override YooAssetReference addressAssetID => _addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.TreasureChestMonster;

	public override int initialStateId => _initialStateId;

	public override LoadTiming loadTiming => LoadTiming.AfterSceneLoad;

	public Pos[] FleeWaypoints => _fleeWaypoints;

	public MixedBox FleeTriggerField => _fleeTriggerField;

	public int GetMonsterPointId()
	{
		return _monsterPointId;
	}

	public int GetAiIndex(int behaveId)
	{
		return _aiDictionary?.GetValueOrDefault(behaveId, -1) ?? (-1);
	}

	public string[] GetBuffList()
	{
		return _buffList;
	}

	public Vector3 GetMonsterPosition()
	{
		return _monsterSpawnPos.value;
	}

	public bool GetIsLeft()
	{
		return _isLeft;
	}

	public int GetGroupUid()
	{
		return _groupUid;
	}

	public int GetGroupAi()
	{
		return _groupAI;
	}

	public bool GetIsHaveBornEffect()
	{
		return _isHaveBornEffect;
	}

	public override UniTask CollectPrecacheAsync(PrecacheCollector collector, CancellationToken ct = default(CancellationToken))
	{
		return CharacterPrecacheCollectUtility.CollectEnemyByMonsterPointIdAsync(_monsterPointId, collector, ct);
	}
}
