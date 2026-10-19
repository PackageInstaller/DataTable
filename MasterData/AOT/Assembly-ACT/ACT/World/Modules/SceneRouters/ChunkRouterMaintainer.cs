using System.Collections.Generic;
using ACT.World.Data.SceneRouters;
using ACT.World.SceneChunks;

namespace ACT.World.Modules.SceneRouters;

internal class ChunkRouterMaintainer
{
	internal readonly int ChunkId;

	private readonly Dictionary<int, SceneRouterTriggerEntryControl> _routerEntryControlMap;

	private readonly SceneRouterModule _routerModule;

	private readonly List<SceneRouterTriggerEntryControl> _routerEntryControls;

	private bool _isLoaded;

	public bool CantTeleport => _routerModule.CantTeleport();

	public List<SceneRouterTriggerEntryControl> RouterEntryControls => _routerEntryControls;

	internal ChunkRouterMaintainer(SceneRouterModule module, SceneChunk chunkData)
	{
		_routerModule = module;
		ChunkId = chunkData.ChunkId;
		_routerEntryControlMap = new Dictionary<int, SceneRouterTriggerEntryControl>();
		_routerEntryControls = new List<SceneRouterTriggerEntryControl>();
		SceneChunkRouterData[] sceneRouters = chunkData.SceneRouters;
		foreach (SceneChunkRouterData sceneChunkRouterData in sceneRouters)
		{
			SceneRouterTriggerEntryControl sceneRouterTriggerEntryControl = new SceneRouterTriggerEntryControl(this, sceneChunkRouterData);
			if (_routerEntryControlMap.TryAdd(sceneChunkRouterData.Uid, sceneRouterTriggerEntryControl))
			{
				_routerEntryControls.Add(sceneRouterTriggerEntryControl);
			}
		}
	}

	public bool TryGetRouterData(int routeId, out SceneChunkRouterData data)
	{
		data = null;
		if (_routerEntryControlMap != null && _routerEntryControlMap.TryGetValue(routeId, out var value))
		{
			data = value.Data;
		}
		return data != null;
	}

	internal void Load()
	{
		if (_isLoaded)
		{
			return;
		}
		_isLoaded = true;
		foreach (KeyValuePair<int, SceneRouterTriggerEntryControl> item in _routerEntryControlMap)
		{
			item.Value.Load();
		}
	}

	internal void Unload()
	{
		if (!_isLoaded)
		{
			return;
		}
		_isLoaded = false;
		foreach (KeyValuePair<int, SceneRouterTriggerEntryControl> item in _routerEntryControlMap)
		{
			item.Value.Unload();
		}
	}

	internal void Release()
	{
		Unload();
		_routerEntryControlMap.Clear();
		_routerEntryControls.Clear();
	}

	internal void ExecuteTransition(SceneChunkRouterData data)
	{
		_routerModule.ExecuteTransition(data);
	}
}
