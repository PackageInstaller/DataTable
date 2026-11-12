using System;
using PathologicalGames;
using UnityEngine;

public class AdventureMonsterTimelinePlayer : MonoBehaviour
{
	protected AdventureActor _actor;

	protected Action _onTimelineComplete;

	public AdventureActor actor => _actor;

	public static AdventureMonsterTimelinePlayer Play(GameObject prefab, AdventureActor actor, Action onComplete = null)
	{
		AdventureMonsterTimelinePlayer adventureMonsterTimelinePlayer = Spawn(prefab, actor).AddOrGetComponent<AdventureMonsterTimelinePlayer>();
		adventureMonsterTimelinePlayer.Play(actor, onComplete);
		return adventureMonsterTimelinePlayer;
	}

	public void Play(AdventureActor actor, Action onComplete = null)
	{
		_actor = actor;
		_onTimelineComplete = onComplete;
		_actor?.Hide(performanceMode: true);
		_actor?.EnableInvincible();
		gameObject.transform.position = _actor.transform.position;
		gameObject.transform.rotation = _actor.transform.rotation;
		SceneSingleton<PerformManager>.Instance.PlayTimelinePerform(gameObject, OnFinish);
	}

	public void OnFinish(bool _)
	{
		_actor?.Visible();
		_actor?.DisableInvincible();
		_actor = null;
		_onTimelineComplete?.Invoke();
		_onTimelineComplete = null;
		Despawn(gameObject);
	}

	public static void PreLoad(GameObject prefab)
	{
		Despawn(Spawn(prefab));
	}

	public static GameObject Spawn(GameObject prefab, AdventureActor actor = null)
	{
		GameObject gameObject = null;
		if (actor != null)
		{
			PrefabPool prefabPool = PoolManager.Pools.get_Item("Timeline").GetPrefabPool(prefab);
			if (prefabPool != null)
			{
				for (int i = 0; i < prefabPool.despawned.Count; i++)
				{
					AdventureMonsterTimelinePlayer component = prefabPool.despawned.get_Item(i).GetComponent<AdventureMonsterTimelinePlayer>();
					if (component != null && component.actor == actor)
					{
						gameObject = prefabPool.SpawnFromDespawnedInstanceAt(i, Vector3.zero, Quaternion.identity, null).gameObject;
						break;
					}
				}
			}
		}
		if (gameObject == null)
		{
			SpawnPool spawnPool = PoolManager.Pools.get_Item("Timeline");
			Transform transform = ((!(spawnPool != null)) ? UnityEngine.Object.Instantiate(prefab, Vector3.zero, Quaternion.identity).transform : spawnPool.Spawn(prefab.transform, Vector3.zero, Quaternion.identity));
			transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Timeline"));
			transform.gameObject.AddOrGetComponent<AdventureTimelineConfig>();
			gameObject = transform.gameObject;
		}
		return gameObject;
	}

	public static void Despawn(GameObject timelineObj)
	{
		if (PoolManager.Pools.TryGetValue("Timeline", out var spawnPool))
		{
			spawnPool.Despawn(timelineObj.transform, spawnPool.group);
		}
		timelineObj.SetActive(value: false);
	}
}
