using System;
using Newtonsoft.Json;
using UnityEngine;

namespace ACT.NPC;

[Serializable]
public class NpcShowRule
{
	[JsonProperty]
	private NpcCondition _conditions = new NpcCondition();

	[JsonProperty]
	private Vector3 _worldPosition;

	[JsonProperty]
	private Vector3 _worldRotation;

	[JsonProperty]
	private YooAssetReference _modelPath;

	[JsonProperty]
	private YooAssetReference _behaviorTreePath;

	public NpcCondition Conditions => _conditions ?? (_conditions = new NpcCondition());

	public Vector3 WorldPosition
	{
		get
		{
			return _worldPosition;
		}
		set
		{
			_worldPosition = value;
		}
	}

	public Vector3 WorldRotation
	{
		get
		{
			return _worldRotation;
		}
		set
		{
			_worldRotation = value;
		}
	}

	public YooAssetReference ModelPath
	{
		get
		{
			return _modelPath;
		}
		set
		{
			_modelPath = value;
		}
	}

	public YooAssetReference BehaviorTreePath
	{
		get
		{
			return _behaviorTreePath;
		}
		set
		{
			_behaviorTreePath = value;
		}
	}

	internal void SetConditions(NpcCondition conditions)
	{
		_conditions = conditions ?? new NpcCondition();
	}
}
