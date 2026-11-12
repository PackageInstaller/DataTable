using UnityEngine;

internal static class AdventureRuntimeBridge
{
	private sealed class AdventurePlayerRuntimeAdapter : IAdventurePlayerRuntime
	{
		public bool TryGetPlayerPosition(out Vector3 position)
		{
			AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
			if (instance == null || instance.playerAgent == null)
			{
				position = default;
				return false;
			}
			position = instance.playerAgent.transform.position;
			return true;
		}

		public bool TryGetPlayerActorGameObject(out GameObject playerActorGameObject)
		{
			AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
			PlayerAdventureActor playerAdventureActor = ((instance != null) ? instance.ActivedPlayerActor : null);
			if (playerAdventureActor == null)
			{
				playerActorGameObject = null;
				return false;
			}
			playerActorGameObject = playerAdventureActor.gameObject;
			return true;
		}
	}

	private sealed class AdventureIndicatorRuntimeAdapter : IAdventureIndicatorRuntime
	{
		public void ActiveOcclusionHighlight(GameObject target)
		{
			SceneSingleton<AdventureIndicatorController>.Instance?.ActiveOcclusionHighlight(target);
		}

		public void DeactiveOcclusionHighlight(GameObject target)
		{
			SceneSingleton<AdventureIndicatorController>.Instance?.DeactiveOcclusionHighlight(target);
		}
	}

	private sealed class AdventureWwiseRuntimeAdapter : IAdventureWwiseRuntime
	{
		public int CurrentLevelType
		{
			get
			{
				AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
				if (!(instance != null))
				{
					return 0;
				}
				return (int)instance.levelType;
			}
		}

		public bool IsInAlert
		{
			get
			{
				AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
				if (instance != null)
				{
					return instance.inAlert();
				}
				return false;
			}
		}

		public int ActivedPlayerActorDataID
		{
			get
			{
				AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
				PlayerAdventureActor playerAdventureActor = ((instance != null) ? instance.ActivedPlayerActor : null);
				if (!(playerAdventureActor != null))
				{
					return 0;
				}
				return playerAdventureActor.dataID;
			}
		}

		public int ActivedPlayerActorId
		{
			get
			{
				AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
				PlayerAdventureActor playerAdventureActor = ((instance != null) ? instance.ActivedPlayerActor : null);
				if (!(playerAdventureActor != null))
				{
					return 0;
				}
				return (int)playerAdventureActor.Id;
			}
		}

		public int ActorCount
		{
			get
			{
				AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
				if (!(instance != null) || instance.ActorLs == null)
				{
					return 0;
				}
				return instance.ActorLs.Count;
			}
		}

		public bool IsStarTowerPrologue => ((MonoSingleton<GameController>.Instance != null) ? AdventureGameContext.LevelLoadParam : null)?.isStarTowerPrologue ?? false;

		public bool TryGetActorSkinId(int characterId, out int skinId)
		{
			skinId = 0;
			AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
			if (instance == null)
			{
				return false;
			}
			if (!instance.GetActorAttribute(characterId, out var attribute))
			{
				return false;
			}
			skinId = attribute.skinId;
			return true;
		}

		public bool TryGetActorGameObject(int actorId, out GameObject gameObject)
		{
			gameObject = null;
			AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
			if (instance == null)
			{
				return false;
			}
			if (!instance.ActorDicts.TryGetValue(actorId, out var value) || value == null || !value.actived)
			{
				return false;
			}
			gameObject = value.gameObject;
			return true;
		}

		public int GetActorDataIdAt(int index)
		{
			AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
			if (instance == null || instance.ActorLs == null)
			{
				return 0;
			}
			if (index < 0 || index >= instance.ActorLs.Count)
			{
				return 0;
			}
			PlayerAdventureActor playerAdventureActor = instance.ActorLs.get_Item(index);
			if (!(playerAdventureActor != null))
			{
				return 0;
			}
			return playerAdventureActor.dataID;
		}
	}

	public static void Register()
	{
		AdventureRuntime.Player = new AdventurePlayerRuntimeAdapter();
		AdventureRuntime.Indicator = new AdventureIndicatorRuntimeAdapter();
		AdventureWwiseRuntime.Current = new AdventureWwiseRuntimeAdapter();
	}

	public static void Unregister()
	{
		AdventureRuntime.Player = null;
		AdventureRuntime.Indicator = null;
		AdventureWwiseRuntime.Current = null;
	}
}
