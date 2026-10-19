using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.World;
using Pb;

namespace ACT.UI;

public class MapSelfNodeModel : Model<MapSelfNodeModel>, IMapSelfNodeModel
{
	public bool isFirstInit;

	private Dictionary<int, SelfNodeData> _selfNodes;

	private int _maxCount = 99;

	public event Action<SelfNodeData> OnSelfNodeAdded;

	public event Action<int> OnSelfNodeRemoved;

	public event Action<SelfNodeData> OnSelfNodeModified;

	protected override void Init()
	{
		isFirstInit = false;
		if (RuntimeConfigs.data?.game != null)
		{
			_maxCount = RuntimeConfigs.data.game.mapSpotLimit;
		}
		_selfNodes = new Dictionary<int, SelfNodeData>();
	}

	protected override void UnInit()
	{
		Clear();
		isFirstInit = false;
	}

	public void Initialize(MapCustomFlagNtf areaFlagsNtf)
	{
		_selfNodes.Clear();
		if (areaFlagsNtf.AreaFlags == null)
		{
			return;
		}
		foreach (MapCustomFlags value in areaFlagsNtf.AreaFlags.Values)
		{
			foreach (KeyValuePair<int, MapCustomFlag> flag in value.Flags)
			{
				SelfNodeData selfNodeData = SelfNodeData.FromPB(flag.Value);
				if (selfNodeData != null)
				{
					_selfNodes[selfNodeData.id] = selfNodeData;
				}
			}
		}
	}

	public void UpdateModelAreaFlags(MapCustomFlagNtf areaFlagsNtf)
	{
		foreach (MapCustomFlags value2 in areaFlagsNtf.AreaFlags.Values)
		{
			foreach (KeyValuePair<int, MapCustomFlag> flag in value2.Flags)
			{
				if (_selfNodes.TryGetValue(flag.Value.Id, out var value))
				{
					SelfNodeData.UpdateFromPB(value, flag.Value);
					continue;
				}
				SelfNodeData selfNodeData = SelfNodeData.FromPB(flag.Value);
				if (selfNodeData != null)
				{
					_selfNodes[selfNodeData.id] = selfNodeData;
				}
			}
		}
	}

	public void UpdateModelAreaFlags(MapCustomFlag latestCustomFlag)
	{
		if (_selfNodes.TryGetValue(latestCustomFlag.Id, out var value))
		{
			SelfNodeData.UpdateFromPB(value, latestCustomFlag);
			return;
		}
		SelfNodeData selfNodeData = SelfNodeData.FromPB(latestCustomFlag);
		if (selfNodeData != null)
		{
			_selfNodes[selfNodeData.id] = selfNodeData;
		}
	}

	public Dictionary<int, SelfNodeData> GetAllSelfNodes()
	{
		return _selfNodes;
	}

	public int GetSelfNodesNumByArea(MapArea area)
	{
		int num = 0;
		foreach (SelfNodeData value in _selfNodes.Values)
		{
			if (value.mapArea == area)
			{
				num++;
			}
		}
		return num;
	}

	public List<SelfNodeData> GetSelfNodesByArea(MapArea area)
	{
		List<SelfNodeData> list = new List<SelfNodeData>();
		foreach (SelfNodeData value in _selfNodes.Values)
		{
			if (value.mapArea == area)
			{
				list.Add(value);
			}
		}
		return list;
	}

	public SelfNodeData GetSelfNode(int id)
	{
		if (!_selfNodes.TryGetValue(id, out var value))
		{
			return null;
		}
		return value;
	}

	public bool AddSelfNode(SelfNodeData data)
	{
		_selfNodes[data.id] = data;
		OnSelfNodeAdded?.Invoke(data);
		return true;
	}

	public bool RemoveSelfNode(int id)
	{
		if (_selfNodes.Remove(id))
		{
			OnSelfNodeRemoved?.Invoke(id);
			return true;
		}
		return false;
	}

	public void CallModifySelfNodeIconTypeAction(int id)
	{
		if (_selfNodes.TryGetValue(id, out var value))
		{
			OnSelfNodeModified?.Invoke(value);
		}
	}

	public int GetSelfNodeCount()
	{
		return _selfNodes.Count;
	}

	public int GetMaxSelfNodeCount()
	{
		return _maxCount;
	}

	public bool CanAddSelfNode(MapArea area)
	{
		int num = 0;
		foreach (SelfNodeData value in _selfNodes.Values)
		{
			if (value.mapArea == area)
			{
				num++;
			}
		}
		return num < _maxCount;
	}

	public void Clear()
	{
		_selfNodes.Clear();
	}
}
