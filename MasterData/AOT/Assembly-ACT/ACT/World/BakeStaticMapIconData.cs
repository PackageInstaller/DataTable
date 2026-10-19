using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World;

[Serializable]
public struct BakeStaticMapIconData(int uid, Vector3 initPos, int iconTypeId, int linkedUnlockFogId, int subArea)
{
	[SerializeField]
	[FormerlySerializedAs("uid")]
	private int _uid = uid;

	[SerializeField]
	[FormerlySerializedAs("initPos")]
	private Vector3 _initPos = initPos;

	[SerializeField]
	[FormerlySerializedAs("iconDescId")]
	private int _iconDescId = 0;

	[SerializeField]
	[FormerlySerializedAs("iconTypeId")]
	private int _iconTypeId = iconTypeId;

	[SerializeField]
	[FormerlySerializedAs("worldBossId")]
	private int _worldBossId = 0;

	[SerializeField]
	[FormerlySerializedAs("linkedUnlockFogId")]
	private int _linkedUnlockFogId = linkedUnlockFogId;

	[SerializeField]
	[FormerlySerializedAs("subAreaId")]
	private int _subAreaId = subArea;

	public int uid => _uid;

	public Vector3 initPos => _initPos;

	public int iconDescId => _iconDescId;

	public int iconTypeId => _iconTypeId;

	public int worldBossId => _worldBossId;

	public int linkedUnlockFogId => _linkedUnlockFogId;

	public int subAreaId => _subAreaId;

	public bool IsWorldBossIcon()
	{
		return iconTypeId == 1009;
	}
}
