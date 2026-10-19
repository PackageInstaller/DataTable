using System.Collections.Generic;
using ACT.Battle;
using ACT.World.Modules;
using Fundamental;
using UnityEngine;

namespace ACT.World;

internal class SceneNodeModule : WorldModuleBase
{
	private readonly HashSet<IDynamicWorldPartitionNode> _dynamicNodes = new HashSet<IDynamicWorldPartitionNode>();

	private const float runtimeDynamicEdgeRadius = 20f;

	private const float runtimeDynamicExitRadius = 30f;

	private const float sqrDynamicEdgeRadius = 400f;

	private const float sqrDynamicExitRadius = 900f;

	private readonly List<RuntimeStaticNode> _runtimeStaticNodes = new List<RuntimeStaticNode>();

	internal override bool NeedGotChunkChange => true;

	protected override void OnLeaveWorld(WorldBase world)
	{
		base.OnLeaveWorld(world);
		ReleaseDynamicNodes();
		ReleaseStaticNodes();
	}

	private void ReleaseDynamicNodes()
	{
		foreach (IDynamicWorldPartitionNode dynamicNode in _dynamicNodes)
		{
			dynamicNode.OnReleaseNode();
		}
		_dynamicNodes.Clear();
	}

	private void ReleaseStaticNodes()
	{
		for (int num = _runtimeStaticNodes.Count - 1; num >= 0; num--)
		{
			if (_runtimeStaticNodes[num].loadState == LoadState.Loaded)
			{
				_runtimeStaticNodes[num].OnRelase();
			}
		}
		_runtimeStaticNodes.Clear();
	}

	protected override void OnUpdate()
	{
		if (Singleton<GameState>.instance.RunningState == GameRunningState.Playing)
		{
			UpdateStaticNodes();
			UpdateDynamicNodes();
		}
	}

	private void UpdateDynamicNodes()
	{
		if (!MonoECS.instance.mainEntity.TryGetComponent<CompTransform>(out CompTransform component))
		{
			return;
		}
		Vector3 physicsPosition = component.physicsPosition;
		foreach (IDynamicWorldPartitionNode dynamicNode in _dynamicNodes)
		{
			if ((dynamicNode.position - physicsPosition).sqrMagnitude < 400f)
			{
				dynamicNode.active = true;
			}
		}
	}

	private void UpdateStaticNodes()
	{
		for (int i = 0; i < _runtimeStaticNodes.Count; i++)
		{
			_runtimeStaticNodes[i].loadPolicy = LoadPolicy.DoUnLoad;
		}
		for (int j = 0; j < _runtimeStaticNodes.Count; j++)
		{
			RuntimeStaticNode runtimeStaticNode = _runtimeStaticNodes[j];
			LoadState loadState = runtimeStaticNode.loadState;
			LoadPolicy loadPolicy = runtimeStaticNode.loadPolicy;
			if (loadState == LoadState.UnLoad && loadPolicy == LoadPolicy.DoLoad)
			{
				runtimeStaticNode.loadState = LoadState.Loaded;
				runtimeStaticNode.OnLoad();
			}
			else if (loadState != LoadState.UnLoad && loadPolicy == LoadPolicy.DoUnLoad)
			{
				runtimeStaticNode.loadState = LoadState.UnLoad;
				runtimeStaticNode.OnRelase();
			}
		}
	}

	internal void AddDynamicNode(IDynamicWorldPartitionNode node)
	{
		_dynamicNodes.Add(node);
	}

	internal void RemoveDynamicNode(IDynamicWorldPartitionNode node)
	{
		if (_dynamicNodes.Contains(node))
		{
			node.OnReleaseNode();
			_dynamicNodes.Remove(node);
		}
	}

	internal IDynamicWorldPartitionNode FindDynamicNodeById(int id)
	{
		foreach (IDynamicWorldPartitionNode dynamicNode in _dynamicNodes)
		{
			if (dynamicNode.id == id)
			{
				return dynamicNode;
			}
		}
		return null;
	}

	public void AddRuntimeStaticNode(DropItemStaticNode node)
	{
		_runtimeStaticNodes.Add(node);
	}

	public void RemoveRuntimeStaticNode(DropItemStaticNode node)
	{
		_runtimeStaticNodes.Remove(node);
	}
}
