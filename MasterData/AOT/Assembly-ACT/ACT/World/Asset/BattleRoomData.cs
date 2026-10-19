using System;
using System.Collections.Generic;
using System.Threading;
using ACT.BluePrint;
using ACT.Config;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BattleRoomData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public List<TriggerCondition> triggerConditionList;

	public List<MonsterSpawnWave> monsterWaves = new List<MonsterSpawnWave>();

	public bool useClearPerformance = true;

	public bool useAreaCamera;

	public BoxColliderParameters triggerField;

	public BoxColliderParameters conFinerField;

	public float cameraDistance;

	public Vector3 trackedObjectOffset;

	[HideInInspector]
	public Bounds resetTriggerFieldBounds;

	public override bool isStatic => false;

	public override int resetStateId => 0;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.BattleRoom;

	public override int initialStateId => m_initialStateId;

	public override async UniTask CollectPrecacheAsync(PrecacheCollector collector, CancellationToken ct = default(CancellationToken))
	{
		if (monsterWaves == null || monsterWaves.Count == 0)
		{
			return;
		}
		MonsterSpawnWave wave = monsterWaves[0];
		if (wave?.groups == null)
		{
			return;
		}
		for (int i = 0; i < wave.groups.Count; i++)
		{
			ct.ThrowIfCancellationRequested();
			MonsterSpawnGroup group = wave.groups[i];
			if (group?.spawnMonsterList == null)
			{
				continue;
			}
			for (int j = 0; j < group.spawnMonsterList.Count; j++)
			{
				ct.ThrowIfCancellationRequested();
				SpawnMonsterParams spawnMonsterParams = group.spawnMonsterList[j];
				if (spawnMonsterParams != null)
				{
					if (spawnMonsterParams.monsterPointId > 0)
					{
						await CharacterPrecacheCollectUtility.CollectEnemyByMonsterPointIdAsync(spawnMonsterParams.monsterPointId, collector, ct);
					}
					else if (spawnMonsterParams.id > 0)
					{
						await CharacterPrecacheCollectUtility.CollectEnemyByEntityIdAsync(spawnMonsterParams.id, collector, ct);
					}
				}
			}
		}
	}

	private void OnValidate()
	{
	}
}
