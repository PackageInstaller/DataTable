using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class DataNodeComponent : BaseComponent
{
	private int serialId;

	private Dictionary<string, EntityDataNode> dataNodes = new Dictionary<string, EntityDataNode>();

	public string AddMark(string configId, int layer, float mTime, string markType, MarkTimeType timeType)
	{
		dataNodes.TryGetValue(configId, out var value);
		if (value == null)
		{
			EntityDataNode entityDataNode = ReferencePool.Acquire<EntityDataNode>();
			entityDataNode.configId = configId;
			entityDataNode.markType = markType;
			entityDataNode.curTime = 0f;
			entityDataNode.maxTime = mTime;
			entityDataNode.curLayer = layer;
			entityDataNode.isActive = true;
			entityDataNode.type = 1;
			entityDataNode.markTimeType = timeType;
			entityDataNode.entity = mBaseEntity;
			dataNodes.Add(entityDataNode.configId, entityDataNode);
			return entityDataNode.configId;
		}
		value.curLayer += layer;
		value.maxTime = mTime;
		value.curTime = 0f;
		value.isActive = true;
		return value.configId;
	}

	public void AddData<T>(string configKey, IDataNodeValue<T> value)
	{
		if (dataNodes.ContainsKey(configKey))
		{
			dataNodes[configKey].ResetData(value);
			return;
		}
		EntityDataNode entityDataNode = ReferencePool.Acquire<EntityDataNode>();
		entityDataNode.configId = configKey;
		entityDataNode.curTime = 0f;
		entityDataNode.maxTime = 0f;
		entityDataNode.curLayer = 0;
		entityDataNode.isActive = true;
		entityDataNode.type = 2;
		entityDataNode.markTimeType = MarkTimeType.None;
		entityDataNode.ResetData(value);
		dataNodes.Add(configKey, entityDataNode);
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		Dictionary<string, EntityDataNode>.Enumerator enumerator = dataNodes.GetEnumerator();
		List<EntityDataNode> list = CollectionPool<List<EntityDataNode>, EntityDataNode>.Get();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.OnUpdate(deltaTime);
			if (!enumerator.Current.Value.isActive)
			{
				list.Add(enumerator.Current.Value);
			}
		}
		enumerator.Dispose();
		foreach (EntityDataNode item in list)
		{
			dataNodes.Remove(item.configId);
			ReferencePool.Release(item);
		}
		CollectionPool<List<EntityDataNode>, EntityDataNode>.Release(list);
	}

	public int GetMarkLayer(string markId)
	{
		dataNodes.TryGetValue(markId, out var value);
		if (value == null || !value.isActive)
		{
			return 0;
		}
		return value.curLayer;
	}

	public new T GetData<T>(string configKey)
	{
		dataNodes.TryGetValue(configKey, out var value);
		if (value == null)
		{
			return default(T);
		}
		if (value.GetData is IDataNodeValue<T> dataNodeValue)
		{
			return dataNodeValue.GetValue();
		}
		return default(T);
	}

	public void RemoveMark(string markId)
	{
		dataNodes.TryGetValue(markId, out var value);
		if (value != null)
		{
			value.isActive = false;
		}
	}

	public void RemoveMarkLayer(string markId, int layer)
	{
		dataNodes.TryGetValue(markId, out var value);
		if (value != null)
		{
			value.curLayer = Mathf.Max(0, value.curLayer - layer);
			if (value.curLayer == 0)
			{
				value.isActive = false;
			}
		}
	}

	public void RemoveAllMark()
	{
		foreach (KeyValuePair<string, EntityDataNode> dataNode in dataNodes)
		{
			if (dataNode.Value.type == 1)
			{
				dataNode.Value.isActive = false;
			}
		}
	}

	public void RemoveMarkByType(string markType)
	{
		foreach (KeyValuePair<string, EntityDataNode> dataNode in dataNodes)
		{
			if (dataNode.Value.markType.Equals(markType))
			{
				dataNode.Value.isActive = false;
			}
		}
	}

	public void RemoveMarkLayerByType(string markType, int layer)
	{
		foreach (KeyValuePair<string, EntityDataNode> dataNode in dataNodes)
		{
			EntityDataNode value = dataNode.Value;
			if (value.markType.Equals(markType))
			{
				value.curLayer = Mathf.Max(0, value.curLayer - layer);
				if (value.curLayer == 0)
				{
					value.isActive = false;
				}
			}
		}
	}

	public void RemoveData(string configKey)
	{
		dataNodes.TryGetValue(configKey, out var value);
		if (value != null)
		{
			value.isActive = false;
		}
	}
}
