using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase.ECS;

public class MechanismCacheSystem : BaseSystem
{
	private Dictionary<string, IObjectPool<GameObject>> entityPools = new Dictionary<string, IObjectPool<GameObject>>();

	protected override bool IsLogicSystem => false;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		return true;
	}

	public async Task<GameObject> LoadMechanismObj(int entityId, string path)
	{
		string fullPath = AssetUtility.GetEntityAsset(path);
		entityPools.TryGetValue(fullPath, out var value);
		if (value == null)
		{
			GameObject template = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(fullPath);
			if (!entityPools.ContainsKey(fullPath))
			{
				value = new ObjectPool<GameObject>(new MechanismObjFactory(fullPath, template, world.MechanismRoot), 32);
				entityPools.Add(fullPath, value);
			}
			else
			{
				value = entityPools[fullPath];
			}
		}
		return value.Allocate();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (KeyValuePair<string, IObjectPool<GameObject>> entityPool in entityPools)
		{
			if (entityPool.Value != null)
			{
				entityPool.Value.Dispose();
			}
		}
		entityPools.Clear();
		entityPools = null;
	}
}
