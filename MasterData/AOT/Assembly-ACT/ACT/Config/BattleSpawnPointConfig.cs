using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class BattleSpawnPointConfig
{
	[SerializeField]
	private int _monsterPointId;

	[SerializeField]
	private Vector3 _spawnPosition;

	[SerializeField]
	private bool _isLeft = true;

	[SerializeField]
	private bool _isHaveBornEffect = true;

	[SerializeField]
	private bool _bornInActive;

	[SerializeField]
	private bool _usePathOffsetChange = true;

	[SerializeField]
	private bool _shareBossInfoUI;

	[SerializeField]
	private Vector3 _hatredSize;

	[SerializeField]
	private Vector3 _hatredOffset;

	[SerializeField]
	private bool _useRayCastCheckBlock;

	[SerializeField]
	private Vector3 _loseBattleSize;

	[SerializeField]
	private Vector3 _loseBattleOffset;

	[SerializeField]
	private bool _loseBattleCanCheckBlock;

	[SerializeField]
	private string[] _buffList;

	[SerializeField]
	private int _groupUid = -1;

	[SerializeField]
	private int _groupIndex = -1;

	[SerializeField]
	private Vector3[] _patrolPoints;

	[SerializeField]
	private BattleSpawnInfoPointConfig[] _infoPoints;

	[SerializeField]
	private BattleSpawnAiEntry[] _aiConfig;

	[SerializeField]
	private BattleSpawnBornBehaviorEntry[] _bornBehaviorConfigs;

	[SerializeField]
	private Vector3 _jumpInBornPos;

	public int MonsterPointId => _monsterPointId;

	public Vector3 SpawnPosition => _spawnPosition;

	public bool IsLeft => _isLeft;

	public bool IsHaveBornEffect => _isHaveBornEffect;

	public bool BornInActive => _bornInActive;

	public bool UsePathOffsetChange => _usePathOffsetChange;

	public bool ShareBossInfoUI => _shareBossInfoUI;

	public Vector3 HatredSize => _hatredSize;

	public Vector3 HatredOffset => _hatredOffset;

	public bool UseRayCastCheckBlock => _useRayCastCheckBlock;

	public Vector3 LoseBattleSize => _loseBattleSize;

	public Vector3 LoseBattleOffset => _loseBattleOffset;

	public bool LoseBattleCanCheckBlock => _loseBattleCanCheckBlock;

	public string[] BuffList => _buffList;

	public int GroupUid => _groupUid;

	public int GroupIndex => _groupIndex;

	public Vector3[] PatrolPoints => _patrolPoints;

	public BattleSpawnInfoPointConfig[] InfoPoints => _infoPoints;

	public BattleSpawnAiEntry[] AiConfig => _aiConfig;

	public BattleSpawnBornBehaviorEntry[] BornBehaviorConfigs => _bornBehaviorConfigs;

	public Vector3 JumpInBornPos => _jumpInBornPos;
}
