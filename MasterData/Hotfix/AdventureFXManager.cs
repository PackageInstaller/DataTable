using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using PathologicalGames;
using TrueSync;
using UnityEngine;

public class AdventureFXManager : SceneSingleton<AdventureFXManager>
{
	public enum CueEffectType
	{
		None,
		Hurt,
		SuperArmor,
		ImmuneControl,
		Invincible
	}

	public enum CueEffectTargetBodySize
	{
		Normal,
		Large
	}

	protected class TintEffectPair
	{
		public CueEffectType type;

		public RendererMaterialStackComponent component;

		public CustomModelMaterialVariantComponent customMaterialVariant;

		public bool isLoop;

		public float timer;

		public float duration;

		public GameRenderUtils.TintCueEffectStyle style;

		public int priority;

		public CueEffectTargetBodySize bodySize;

		[MethodImpl((MethodImplOptions)256)]
		public int GetCueIndex()
		{
			if (type == CueEffectType.Hurt)
			{
				return 0;
			}
			return 1;
		}

		[MethodImpl((MethodImplOptions)256)]
		public void Clear()
		{
			type = CueEffectType.None;
			component = null;
			customMaterialVariant = null;
			isLoop = false;
			timer = 0f;
			duration = 0f;
			style = GameRenderUtils.TintCueEffectStyle.None;
			priority = 0;
			bodySize = CueEffectTargetBodySize.Normal;
		}
	}

	public const long NULL_TOKEN = 0L;

	internal static long TOKEN_COUNTER = 0L;

	protected static float _globalTimeScale = 1f;

	protected LogManager.Logger _logger;

	protected bool _lock;

	protected readonly List<AdventureFXHandler> _delayInsertList = new List<AdventureFXHandler>();

	protected readonly List<AdventureFXHandler> _delayDropList = new List<AdventureFXHandler>();

	protected List<TintEffectPair> tintCueEffects = new List<TintEffectPair>(50);

	protected List<TintEffectPair> tintCueEffectPool = new List<TintEffectPair>(50);

	protected bool tintCueEffectsDirty;

	public List<AdventureFXHandler> handlers { get; protected set; } = new List<AdventureFXHandler>();

	public static float globalTimeScale
	{
		get
		{
			return _globalTimeScale;
		}
		set
		{
			_globalTimeScale = value;
			SceneSingleton<AdventureFXManager>.Instance?.OnGlobalTimeScaleChanged();
		}
	}

	public static Action<AdventureFXHandler> onFXHandlerSpawn { get; set; }

	public static Action<AdventureFXHandler> onFXHandlerDespawn { get; set; }

	public static Action<AdventureFXPlayer> onFXPlayerPlay { get; set; }

	public static Action<AdventureFXPlayer> onFXPlayerPlayInRemain { get; set; }

	public static Action<AdventureFXPlayer> onFXPlayerBind { get; set; }

	public static Action<AdventureFXPlayer> onFXPlayerOwnerActorBind { get; set; }

	public static bool IsPlayingTimeline { get; set; }

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure_FX");
	}

	internal void DriveUpdate()
	{
		_lock = true;
		for (int i = 0; i < handlers.Count; i++)
		{
			handlers.get_Item(i).DoUpdate();
		}
		_lock = false;
		UpdateDelayRegisterList();
		UpdateExtensions();
	}

	internal void DriveLateUpdate()
	{
		_lock = true;
		for (int i = 0; i < handlers.Count; i++)
		{
			handlers.get_Item(i).DoLateUpdate();
		}
		_lock = false;
		UpdateDelayRegisterList();
	}

	internal void RegisterFXHandler(AdventureFXHandler handler, bool delayInsert = false)
	{
		onFXHandlerSpawn?.Invoke(handler);
		if (!delayInsert)
		{
			handler.token = ++TOKEN_COUNTER;
		}
		if (_lock)
		{
			if (!_delayDropList.Remove(handler))
			{
				_delayInsertList.Add(handler);
			}
		}
		else
		{
			handlers.Add(handler);
		}
	}

	internal void UnRegisterFXHandler(AdventureFXHandler handler, bool delayDrop = false)
	{
		onFXHandlerDespawn?.Invoke(handler);
		if (!delayDrop)
		{
			handler.token = 0L;
		}
		if (_lock)
		{
			if (!_delayInsertList.Remove(handler))
			{
				_delayDropList.Add(handler);
			}
		}
		else
		{
			handlers.Remove(handler);
		}
	}

	protected void UpdateDelayRegisterList()
	{
		for (int i = 0; i < _delayDropList.Count; i++)
		{
			UnRegisterFXHandler(_delayDropList.get_Item(i), delayDrop: true);
		}
		_delayDropList.Clear();
		for (int j = 0; j < _delayInsertList.Count; j++)
		{
			RegisterFXHandler(_delayInsertList.get_Item(j), delayInsert: true);
		}
		_delayInsertList.Clear();
	}

	protected void OnGlobalTimeScaleChanged()
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			handlers.get_Item(i).OnTimeScaleChanged();
		}
	}

	public AdventureFXHandler FindHandlerByToken(int token)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			if (handlers.get_Item(i).token == token)
			{
				return handlers.get_Item(i);
			}
		}
		for (int j = 0; j < _delayInsertList.Count; j++)
		{
			if (_delayInsertList.get_Item(j).token == token)
			{
				return _delayInsertList.get_Item(j);
			}
		}
		return null;
	}

	public AdventureFXHandler FindHandlerByTag(string tag)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			if (handlers.get_Item(i).fxTag == tag)
			{
				return handlers.get_Item(i);
			}
		}
		for (int j = 0; j < _delayInsertList.Count; j++)
		{
			if (_delayInsertList.get_Item(j).fxTag == tag)
			{
				return _delayInsertList.get_Item(j);
			}
		}
		return null;
	}

	public void FindAllHandlersByTag(List<AdventureFXHandler> result, string tag)
	{
		result.Clear();
		for (int i = 0; i < handlers.Count; i++)
		{
			if (handlers.get_Item(i).fxTag == tag)
			{
				result.Add(handlers.get_Item(i));
			}
		}
		for (int j = 0; j < _delayInsertList.Count; j++)
		{
			if (_delayInsertList.get_Item(j).fxTag == tag)
			{
				result.Add(_delayInsertList.get_Item(j));
			}
		}
	}

	public void StopSubFXPlayers(long token, bool dontPlaySubFX = false)
	{
		if (token != 0L)
		{
			StopSubFXPlayers_Internal(handlers);
			StopSubFXPlayers_Internal(_delayInsertList);
		}
		void StopSubFXPlayers_Internal(List<AdventureFXHandler> list)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (num < list.Count)
				{
					AdventureFXPlayer adventureFXPlayer = list.get_Item(num) as AdventureFXPlayer;
					if (!(adventureFXPlayer == null) && (adventureFXPlayer.token == token || adventureFXPlayer.rootPlayerToken == token))
					{
						adventureFXPlayer.Stop(dontPlaySubFX);
					}
				}
			}
		}
	}

	public void StopAllFXPlayersByTag(string tag, bool dontPlaySubFX = false)
	{
		StopAllFXPlayersByTag_Internal(handlers);
		StopAllFXPlayersByTag_Internal(_delayInsertList);
		void StopAllFXPlayersByTag_Internal(List<AdventureFXHandler> list)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (num < list.Count)
				{
					AdventureFXPlayer adventureFXPlayer = list.get_Item(num) as AdventureFXPlayer;
					if (!(adventureFXPlayer == null) && adventureFXPlayer.tag == tag)
					{
						adventureFXPlayer.Stop(dontPlaySubFX);
					}
				}
			}
		}
	}

	public void StopAllFXPlayersByOwner(GameObject owner = null, bool dontPlaySubFX = false)
	{
		StopAllFXPlayersByOwner_Internal(handlers);
		StopAllFXPlayersByOwner_Internal(_delayInsertList);
		void StopAllFXPlayersByOwner_Internal(List<AdventureFXHandler> list)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (num < list.Count)
				{
					AdventureFXPlayer adventureFXPlayer = list.get_Item(num) as AdventureFXPlayer;
					if (!(adventureFXPlayer == null) && adventureFXPlayer.owner == owner)
					{
						adventureFXPlayer.Stop(dontPlaySubFX);
					}
				}
			}
		}
	}

	public void StopAllFXPlayers(bool dontPlaySubFX = false)
	{
		StopAllFXPlayers_Internal(handlers);
		StopAllFXPlayers_Internal(_delayInsertList);
		void StopAllFXPlayers_Internal(List<AdventureFXHandler> list)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (num < list.Count)
				{
					AdventureFXPlayer adventureFXPlayer = list.get_Item(num) as AdventureFXPlayer;
					if (!(adventureFXPlayer == null))
					{
						adventureFXPlayer.Stop(dontPlaySubFX);
					}
				}
			}
		}
	}

	public void InterruptFXPlayersByOwner(GameObject owner, bool dontPlaySubFX = false)
	{
		InterruptFXPlayersByOwner_Internal(handlers);
		InterruptFXPlayersByOwner_Internal(_delayInsertList);
		void InterruptFXPlayersByOwner_Internal(List<AdventureFXHandler> list)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (num < list.Count)
				{
					AdventureFXPlayer adventureFXPlayer = list.get_Item(num) as AdventureFXPlayer;
					if (!(adventureFXPlayer == null) && adventureFXPlayer.owner == owner && adventureFXPlayer.cancelOnInterrupt)
					{
						adventureFXPlayer.Stop(dontPlaySubFX);
					}
				}
			}
		}
	}

	public void SetFXPlayersRenderLayerByTag(string tag, int layer)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.tag == tag)
			{
				adventureFXPlayer.SetRenderLayer(layer);
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null) && adventureFXPlayer2.tag == tag)
			{
				adventureFXPlayer2.SetRenderLayer(layer);
			}
		}
	}

	public void SetFXPlayersRenderLayerByOwner(GameObject owner, int layer)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.owner == owner)
			{
				adventureFXPlayer.SetRenderLayer(layer);
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null) && adventureFXPlayer2.owner == owner)
			{
				adventureFXPlayer2.SetRenderLayer(layer);
			}
		}
	}

	public void SetFXPlayersRenderLayerByOwnerActor(AdventureActor ownerActor, int layer, bool bindWithActorOnly = false)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.ownerActor == ownerActor && (!bindWithActorOnly || !(adventureFXPlayer.bindActor == null)))
			{
				adventureFXPlayer.SetRenderLayer(layer);
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null) && adventureFXPlayer2.ownerActor == ownerActor && (!bindWithActorOnly || !(adventureFXPlayer2.bindActor == null)))
			{
				adventureFXPlayer2.SetRenderLayer(layer);
			}
		}
	}

	public void ResetFXPlayersRenderLayerByTag(string tag)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.tag == tag)
			{
				adventureFXPlayer.ResetRenderLayer();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null) && adventureFXPlayer2.tag == tag)
			{
				adventureFXPlayer2.ResetRenderLayer();
			}
		}
	}

	public void ResetFXPlayersRenderLayerByOwner(GameObject owner)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.owner == owner)
			{
				adventureFXPlayer.ResetRenderLayer();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null) && adventureFXPlayer2.owner == owner)
			{
				adventureFXPlayer2.ResetRenderLayer();
			}
		}
	}

	public void ResetFXPlayersRenderLayerByOwnerActor(AdventureActor ownerActor)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.ownerActor == ownerActor)
			{
				adventureFXPlayer.ResetRenderLayer();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null) && adventureFXPlayer2.ownerActor == ownerActor)
			{
				adventureFXPlayer2.ResetRenderLayer();
			}
		}
	}

	public void ResetAllFXPlayersRenderLayer()
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null))
			{
				adventureFXPlayer.ResetRenderLayer();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXPlayer adventureFXPlayer2 = _delayInsertList.get_Item(num) as AdventureFXPlayer;
			if (!(adventureFXPlayer2 == null))
			{
				adventureFXPlayer2.ResetRenderLayer();
			}
		}
	}

	public void HideAllFX()
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXHandler adventureFXHandler = handlers.get_Item(i);
			if (!(adventureFXHandler == null))
			{
				adventureFXHandler.Hide();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXHandler adventureFXHandler2 = _delayInsertList.get_Item(num);
			if (!(adventureFXHandler2 == null))
			{
				adventureFXHandler2.Hide();
			}
		}
	}

	public void HideAllFX<T>() where T : AdventureFXHandler
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			T val = handlers.get_Item(i) as T;
			if (!(val == null))
			{
				val.Hide();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			T val2 = _delayInsertList.get_Item(num) as T;
			if (!(val2 == null))
			{
				val2.Hide();
			}
		}
	}

	public void HideAllFXByTag(string tag)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXHandler adventureFXHandler = handlers.get_Item(i);
			if (!(adventureFXHandler == null) && !(adventureFXHandler.tag != tag))
			{
				adventureFXHandler.Hide();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXHandler adventureFXHandler2 = _delayInsertList.get_Item(num);
			if (!(adventureFXHandler2 == null) && !(adventureFXHandler2.tag != tag))
			{
				adventureFXHandler2.Hide();
			}
		}
	}

	public void VisibleAllFX()
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXHandler adventureFXHandler = handlers.get_Item(i);
			if (!(adventureFXHandler == null))
			{
				adventureFXHandler.Visible();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXHandler adventureFXHandler2 = _delayInsertList.get_Item(num);
			if (!(adventureFXHandler2 == null))
			{
				adventureFXHandler2.Visible();
			}
		}
	}

	public void VisibleAllFX<T>() where T : AdventureFXHandler
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			T val = handlers.get_Item(i) as T;
			if (!(val == null))
			{
				val.Visible();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			T val2 = _delayInsertList.get_Item(num) as T;
			if (!(val2 == null))
			{
				val2.Visible();
			}
		}
	}

	public void VisibleAllFXByTag(string tag)
	{
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXHandler adventureFXHandler = handlers.get_Item(i);
			if (!(adventureFXHandler == null) && !(adventureFXHandler.tag != tag))
			{
				adventureFXHandler.Visible();
			}
		}
		for (int num = _delayInsertList.Count - 1; num >= 0; num--)
		{
			AdventureFXHandler adventureFXHandler2 = _delayInsertList.get_Item(num);
			if (!(adventureFXHandler2 == null) && !(adventureFXHandler2.tag != tag))
			{
				adventureFXHandler2.Visible();
			}
		}
	}

	public static GameObject PreloadFX(string assetPath = null, GameObject prefab = null)
	{
		if (!string.IsNullOrEmpty(assetPath))
		{
			assetPath = "Assets/AssetBundles/" + assetPath;
			if (!assetPath.EndsWith(".prefab"))
			{
				assetPath += ".prefab";
			}
			prefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, assetPath, typeof(GameObject)) as GameObject;
		}
		if (prefab != null)
		{
			AdventureMarkFXHandler component2;
			if (prefab.TryGetComponent<AdventureBuffFXHandler>(out var _))
			{
				AdventureBuffFXHandler.PreloadFX(prefab);
			}
			else if (prefab.TryGetComponent<AdventureMarkFXHandler>(out component2))
			{
				AdventureMarkFXHandler.PreloadFX(prefab);
			}
			else
			{
				AdventureFXPlayer.PreloadFX(prefab);
			}
			return prefab;
		}
		Debug.LogError("特效资源不存在:" + (assetPath ?? prefab.name));
		return null;
	}

	public static AdventureFXPlayer PlayFX(string assetPath, float playbackSpeed, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f, Transform source = null, Vector3 sourcePosition = default(Vector3), Transform target = null, Vector3 targetPosition = default(Vector3))
	{
		assetPath = "Assets/AssetBundles/" + assetPath + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, assetPath, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			return AdventureFXPlayer.PlayFX(gameObject, playbackSpeed, spawnPosition, spawnRotation, spawnSize, source, sourcePosition, target, targetPosition);
		}
		Debug.LogError("特效资源不存在:" + assetPath);
		return null;
	}

	public static AdventureEarlyWarningFXPlayer PlayEarlyWarningFX(string assetPath, float duration, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f)
	{
		assetPath = "Assets/AssetBundles/" + assetPath + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, assetPath, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			return AdventureEarlyWarningFXPlayer.PlayFX(gameObject, duration, spawnPosition, spawnRotation, spawnSize);
		}
		Debug.LogError("特效资源不存在:" + assetPath);
		return null;
	}

	public static AdventureBuffFXHandler PlayBuffFX(string assetPath, GameObject owner, AdventureBuffFXHandler.FXPlayMode playMode = AdventureBuffFXHandler.FXPlayMode.Default, Vector3 fxPosition = default(Vector3), Quaternion fxRotation = default(Quaternion), float fxSize = 1f, AdventureActor targetActor = null)
	{
		assetPath = "Assets/AssetBundles/" + assetPath + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, assetPath, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			return AdventureBuffFXHandler.PlayFX(gameObject, owner, playMode, fxPosition, fxRotation, fxSize, targetActor);
		}
		Debug.LogError("Buff特效资源不存在:" + assetPath);
		return null;
	}

	public static AdventureMarkFXHandler PlayMarkFX(string assetPath, AdventureActor owner, Transform syncNode, int initLevel = 1, float fxScale = 1f)
	{
		assetPath = "Assets/AssetBundles/" + assetPath + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, assetPath, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			return AdventureMarkFXHandler.PlayFX(gameObject, owner, syncNode, initLevel, fxScale);
		}
		Debug.LogError("标记特效资源不存在:" + assetPath);
		return null;
	}

	public static GameObject PreloadSkillTimeline(string assetPath = null, GameObject prefab = null)
	{
		if (!string.IsNullOrEmpty(assetPath))
		{
			assetPath = "Assets/AssetBundles/" + assetPath;
			if (!assetPath.EndsWith(".prefab"))
			{
				assetPath += ".prefab";
			}
			prefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetPath, typeof(GameObject)) as GameObject;
		}
		if (prefab != null)
		{
			AdventureSkillTimelinePlayer.PreLoad(prefab);
			return prefab;
		}
		Debug.LogError("大招演出资源不存在:" + assetPath);
		return null;
	}

	public static AdventureSkillTimelinePlayer PlaySkillTimeline(GameObject prefab, AdventureActor actor, Action onComplete)
	{
		SceneSingleton<AdventurePlayerController>.Instance?.EndCurrentWitchTime();
		IsPlayingTimeline = true;
		return AdventureSkillTimelinePlayer.Play(prefab, actor, () =>
		{
			IsPlayingTimeline = false;
			onComplete?.Invoke();
		});
	}

	public static GameObject PreloadMonsterTimeline(string assetPath = null, GameObject prefab = null)
	{
		if (!string.IsNullOrEmpty(assetPath))
		{
			assetPath = "Assets/AssetBundles/" + assetPath;
			if (!assetPath.EndsWith(".prefab"))
			{
				assetPath += ".prefab";
			}
			prefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetPath, typeof(GameObject)) as GameObject;
		}
		if (prefab != null)
		{
			AdventureMonsterTimelinePlayer.PreLoad(prefab);
			return prefab;
		}
		Debug.LogError("怪物演出资源不存在:" + assetPath);
		return null;
	}

	public static AdventureMonsterTimelinePlayer PlayMonsterTimeline(GameObject prefab, AdventureActor actor, Action onComplete)
	{
		return AdventureMonsterTimelinePlayer.Play(prefab, actor, onComplete);
	}

	protected TintEffectPair GenerateTintCueEffectPair()
	{
		TintEffectPair tintEffectPair = null;
		if (tintCueEffectPool.Count > 0)
		{
			tintEffectPair = tintCueEffectPool.get_Item(0);
			tintCueEffectPool.RemoveAt(0);
		}
		else
		{
			tintEffectPair = new TintEffectPair();
		}
		return tintEffectPair;
	}

	protected void ReleaseTintCueEffectPair(TintEffectPair pair)
	{
		pair.Clear();
		tintCueEffectPool.Add(pair);
	}

	public static void PlayTintCueEffect(CueEffectType effectType, HotfixEnum.hurtFlashTintType hurtFlashType, GameObject source, GameObject target, RendererMaterialStackComponent targetMaterialController, CustomModelMaterialVariantComponent customMaterialVariant = null, GameObject effectPrefab = null, bool isEffectScale = false, float effectPlaybackSpeed = 1f, Bounds targetBounds = default(Bounds), FP targetBodySize = default(FP), Vector3 spawnPoint = default(Vector3), Quaternion spawnRotation = default(Quaternion), bool effectIgnoreTimeScale = true)
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return;
		}
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		Transform transform = ((source != null) ? source.transform : null);
		Transform transform2 = ((target != null) ? target.transform : null);
		if (effectPrefab != null)
		{
			float sizeScale = 1f;
			if (isEffectScale)
			{
				sizeScale = CalcFXScaleWithBody(in targetBounds, config.FX_HurtCueEffectScaleFactor, config.FX_HurtCueEffectScaleFactorRange.x, config.FX_HurtCueEffectScaleFactorRange.y);
			}
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(effectPrefab, effectPlaybackSpeed, spawnPoint, spawnRotation, 1f, transform, (transform != null) ? transform.position : default(Vector3), transform2, (transform2 != null) ? transform2.position : default(Vector3));
			adventureFXPlayer.sizeScale = sizeScale;
			if (!effectIgnoreTimeScale && target != null)
			{
				adventureFXPlayer.Bind(target);
			}
		}
		if (effectType == CueEffectType.None || !(targetMaterialController != null))
		{
			return;
		}
		bool isLoop = false;
		float duration = 0f;
		int priority = 0;
		GameRenderUtils.TintCueEffectStyle tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.None;
		switch (effectType)
		{
		case CueEffectType.Hurt:
			isLoop = false;
			duration = config.FX_HurtCueEffectDuration;
			priority = 90;
			switch (hurtFlashType)
			{
			case HotfixEnum.hurtFlashTintType.NONE:
				tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.None;
				break;
			case HotfixEnum.hurtFlashTintType.EDGE:
				tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.InnerGlow;
				break;
			case HotfixEnum.hurtFlashTintType.WHOLE:
				tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.PureColor;
				break;
			}
			break;
		case CueEffectType.SuperArmor:
			isLoop = true;
			duration = config.FX_SuperArmorCueEffectDuration;
			priority = 1;
			tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.InnerStroke;
			break;
		case CueEffectType.ImmuneControl:
			isLoop = true;
			duration = config.FX_ImmuneControlCueEffectDuration;
			priority = 2;
			tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.InnerStroke;
			break;
		case CueEffectType.Invincible:
			isLoop = true;
			duration = config.FX_InvincibleCueEffectDuration;
			priority = 3;
			tintCueEffectStyle = GameRenderUtils.TintCueEffectStyle.InnerStroke;
			break;
		}
		if (tintCueEffectStyle != GameRenderUtils.TintCueEffectStyle.None)
		{
			TintEffectPair tintEffectPair = SceneSingleton<AdventureFXManager>.Instance.GenerateTintCueEffectPair();
			tintEffectPair.type = effectType;
			tintEffectPair.component = targetMaterialController;
			tintEffectPair.customMaterialVariant = customMaterialVariant;
			tintEffectPair.isLoop = isLoop;
			tintEffectPair.timer = 0f;
			tintEffectPair.duration = duration;
			tintEffectPair.style = tintCueEffectStyle;
			tintEffectPair.priority = priority;
			tintEffectPair.bodySize = ((!(targetBodySize < config.dtRadius)) ? CueEffectTargetBodySize.Large : CueEffectTargetBodySize.Normal);
			SceneSingleton<AdventureFXManager>.Instance.tintCueEffects.Add(tintEffectPair);
			SceneSingleton<AdventureFXManager>.Instance.tintCueEffectsDirty = true;
		}
	}

	public static void StopTintCueEffect(CueEffectType effectType, GameObject source, GameObject target, RendererMaterialStackComponent targetMaterialController)
	{
		if (!(targetMaterialController != null))
		{
			return;
		}
		for (int num = SceneSingleton<AdventureFXManager>.Instance.tintCueEffects.Count - 1; num >= 0; num--)
		{
			TintEffectPair tintEffectPair = SceneSingleton<AdventureFXManager>.Instance.tintCueEffects.get_Item(num);
			if (tintEffectPair.type == effectType && tintEffectPair.component == targetMaterialController)
			{
				GameRenderUtils.ResetTintCueEffect(tintEffectPair.component, tintEffectPair.GetCueIndex());
				SceneSingleton<AdventureFXManager>.Instance.tintCueEffects.RemoveAt(num);
				SceneSingleton<AdventureFXManager>.Instance.ReleaseTintCueEffectPair(tintEffectPair);
			}
		}
	}

	protected void UpdateTintCueEffects()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		if (tintCueEffectsDirty)
		{
			tintCueEffects.Sort((TintEffectPair a, TintEffectPair b) =>
			{
				if (a.priority == b.priority)
				{
					return 0;
				}
				return (a.priority <= b.priority) ? 1 : (-1);
			});
			tintCueEffectsDirty = false;
		}
		for (int num = tintCueEffects.Count - 1; num >= 0; num--)
		{
			TintEffectPair tintEffectPair = tintCueEffects.get_Item(num);
			if (tintEffectPair.component == null)
			{
				tintCueEffects.RemoveAt(num);
				ReleaseTintCueEffectPair(tintEffectPair);
				continue;
			}
			tintEffectPair.timer += deltaTime;
			bool flag = tintEffectPair.timer > tintEffectPair.duration;
			if (tintEffectPair.isLoop)
			{
				if (flag)
				{
					tintEffectPair.timer -= tintEffectPair.duration;
				}
			}
			else if (flag)
			{
				GameRenderUtils.ResetTintCueEffect(tintEffectPair.component, tintEffectPair.GetCueIndex());
				tintCueEffects.RemoveAt(num);
				ReleaseTintCueEffectPair(tintEffectPair);
				continue;
			}
			Gradient gradient = null;
			float exposure = 0f;
			float effectWidth = 0f;
			float effectSmoothness = 0f;
			CustomModelMaterialVariantComponent customMaterialVariant = tintEffectPair.customMaterialVariant;
			switch (tintEffectPair.type)
			{
			case CueEffectType.Hurt:
				gradient = config.FX_HurtCueEffectGradient;
				exposure = config.FX_HurtCueEffectExposure;
				effectWidth = config.FX_HurtCueEffectStrokeWidth;
				effectSmoothness = config.FX_HurtCueEffectStrokeSmoothness;
				if (customMaterialVariant != null && customMaterialVariant.enableCustomHurtCueEffect)
				{
					effectWidth = customMaterialVariant.customHurtCueEffectStrokeWidth;
					effectSmoothness = customMaterialVariant.customHurtCueEffectStrokeSmoothness;
				}
				break;
			case CueEffectType.SuperArmor:
				gradient = config.FX_SuperArmorCueEffectGradient;
				exposure = config.FX_SuperArmorCueEffectExposure;
				effectWidth = config.FX_SuperArmorCueEffectStrokeWidth;
				break;
			case CueEffectType.ImmuneControl:
				gradient = config.FX_ImmuneControlCueEffectGradient;
				exposure = config.FX_ImmuneControlCueEffectExposure;
				effectWidth = config.FX_ImmuneControlCueEffectStrokeWidth;
				break;
			case CueEffectType.Invincible:
				gradient = config.FX_InvincibleCueEffectGradient;
				exposure = config.FX_InvincibleCueEffectExposure;
				effectWidth = config.FX_InvincibleCueEffectStrokeWidth;
				break;
			}
			if (gradient != null)
			{
				Color effectColor = EvaluateTint(tintEffectPair, gradient, exposure, tintEffectPair.timer / tintEffectPair.duration);
				GameRenderUtils.SetTintCueEffect(tintEffectPair.component, tintEffectPair.GetCueIndex(), effectColor, tintEffectPair.style, effectWidth, effectSmoothness);
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private static Color EvaluateTint(TintEffectPair pair, Gradient gradient, float exposure, float t)
	{
		Color result = gradient.Evaluate(t);
		if (exposure > float.Epsilon)
		{
			float num = Mathf.Pow(2f, exposure);
			result.r *= num;
			result.g *= num;
			result.b *= num;
		}
		return result;
	}

	public static void ClearFXInstancePool()
	{
		if (PoolManager.Pools.TryGetValue("FX", out var spawnPool))
		{
			spawnPool.Clear();
		}
	}

	public static float CalcFXScaleWithBody(in Bounds bodyBounds, float scaleFactor, float minScale, float maxScale)
	{
		return Mathf.Clamp(bodyBounds.size.magnitude * scaleFactor, minScale, maxScale);
	}

	protected void UpdateExtensions()
	{
		UpdateTintCueEffects();
	}
}
