using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.Data.SceneRouters;

[Serializable]
public class SceneChunkRouterData
{
	[SerializeField]
	[HideInInspector]
	private Vector3 _center;

	[SerializeField]
	[HideInInspector]
	private Vector3 _size;

	[SerializeField]
	[HideInInspector]
	private int _uid;

	[SerializeField]
	[HideInInspector]
	private int _nextRouterUid = -1;

	[SerializeField]
	[HideInInspector]
	private int _nextChunkGuid = -1;

	[SerializeField]
	[HideInInspector]
	private Vector3 _position;

	[SerializeField]
	[HideInInspector]
	private Vector3 _spawnOffset;

	[SerializeField]
	[HideInInspector]
	private bool _spawnToGround;

	[SerializeField]
	[HideInInspector]
	private float _fadeDuration;

	[SerializeField]
	[HideInInspector]
	[FormerlySerializedAs("_debugName")]
	private string _displayName;

	public string DisplayName => _displayName;

	public int Uid => _uid;

	public int NextRouterUid => _nextRouterUid;

	public int NextChunkGuid => _nextChunkGuid;

	public Vector3 ColliderCenter => _center;

	public Vector3 ColliderSize => _size;

	public Vector3 SpawnOffset => _spawnOffset;

	public float FadeDuration => _fadeDuration;

	public Vector3 Position => _position;

	public bool NeedSpawnToGround => _spawnToGround;
}
