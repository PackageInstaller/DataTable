using UnityEngine;

[AddComponentMenu("Game/FX/EarlyWarning FX Player")]
[DisallowMultipleComponent]
public class AdventureEarlyWarningFXPlayer : AdventureFXPlayer
{
	private const float kDefaultEndFXLeadTime = 0.3f;

	public GameObject startFXPrefab;

	public GameObject endFXPrefab;

	public float endFXLeadTime = -1f;

	protected AdventureFXPlayer _startFXPlayer;

	protected long _startFXToken;

	public override float sizeScale
	{
		get
		{
			return base.sizeScale;
		}
		set
		{
			base.sizeScale = value;
			if (_startFXPlayer != null && _startFXPlayer.token == _startFXToken)
			{
				_startFXPlayer.sizeScale = sizeScale;
			}
		}
	}

	protected override void OnDisable()
	{
		_startFXPlayer = null;
		base.OnDisable();
	}

	protected override void Preload_Internal()
	{
		base.Preload_Internal();
		if (startFXPrefab != null)
		{
			AdventureFXPlayer.PreloadFX(startFXPrefab);
		}
		if (endFXPrefab != null)
		{
			AdventureFXPlayer.PreloadFX(endFXPrefab);
		}
	}

	protected new static AdventureEarlyWarningFXPlayer Spawn(GameObject fxPrefab, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f, bool isPreloadSpawn = false)
	{
		AdventureEarlyWarningFXPlayer adventureEarlyWarningFXPlayer = Setup(AdventureFXHandler.SpawnInstance(fxPrefab, spawnPosition, spawnRotation, Vector3.one, isPreloadSpawn, out var destroyMode).gameObject);
		if (adventureEarlyWarningFXPlayer != null)
		{
			adventureEarlyWarningFXPlayer.destroyMode = destroyMode;
			adventureEarlyWarningFXPlayer.size = spawnSize;
		}
		return adventureEarlyWarningFXPlayer;
	}

	public new static AdventureEarlyWarningFXPlayer Setup(GameObject fxInstance)
	{
		AdventureEarlyWarningFXPlayer adventureEarlyWarningFXPlayer = fxInstance.GetComponent<AdventureEarlyWarningFXPlayer>();
		if (adventureEarlyWarningFXPlayer == null)
		{
			adventureEarlyWarningFXPlayer = fxInstance.AddComponent<AdventureEarlyWarningFXPlayer>();
		}
		return adventureEarlyWarningFXPlayer;
	}

	public static AdventureEarlyWarningFXPlayer PlayFX(GameObject fxPrefab, float duration, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f)
	{
		if (fxPrefab == null)
		{
			return null;
		}
		AdventureEarlyWarningFXPlayer adventureEarlyWarningFXPlayer = Spawn(fxPrefab, spawnPosition, spawnRotation, spawnSize);
		if (adventureEarlyWarningFXPlayer != null)
		{
			adventureEarlyWarningFXPlayer.Play(duration);
		}
		return adventureEarlyWarningFXPlayer;
	}

	public static AdventureEarlyWarningFXPlayer PlayFX(GameObject callerEntity, bool useActorSizeScale, bool useTransformSync, GameObject fxPrefab, float duration, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f)
	{
		if (fxPrefab.TryGetComponent<AdventureEarlyWarningFXPlayer>(out var component))
		{
			return AdventureFXPlayer.PlayFX(callerEntity, useActorSizeScale, useTransformSync, fxPrefab, component.ConvertDurationToPlaybackSpeed(duration), spawnPosition, spawnRotation, spawnSize) as AdventureEarlyWarningFXPlayer;
		}
		return null;
	}

	private float ConvertDurationToPlaybackSpeed(float duration)
	{
		if (endFXPrefab != null)
		{
			duration -= ((endFXLeadTime < 0f) ? 0.3f : endFXLeadTime);
		}
		duration = Mathf.Max(0.01f, duration);
		return 1f / duration;
	}

	public void Play(float duration)
	{
		Play(ConvertDurationToPlaybackSpeed(duration), null, default, null, default);
	}

	public override void Play(float playbackSpeed, Transform source, Vector3 sourcePosition, Transform target, Vector3 targetPosition)
	{
		isLoop = false;
		base.Play(playbackSpeed, source, sourcePosition, target, targetPosition);
		if (startFXPrefab != null)
		{
			_startFXPlayer = AdventureFXPlayer.PlayFX(startFXPrefab, 1f, transform.position, transform.rotation, size);
			_startFXToken = _startFXPlayer.token;
		}
	}

	public override void Bind(GameObject owner, GameObject syncTarget = null, ActorState actorState = ActorState.Null, Combo combo = null, Combo.Phase comboPhase = Combo.Phase.All, bool cancelOnInterrupt = false)
	{
		base.Bind(owner, syncTarget, actorState, combo, comboPhase, cancelOnInterrupt);
		if (_startFXPlayer != null && _startFXPlayer.token == _startFXToken)
		{
			_startFXPlayer.disableLifeCycleBind = true;
			_startFXPlayer.Bind(owner, syncTarget, actorState, combo, comboPhase, cancelOnInterrupt);
		}
	}

	public override void Stop(bool dontPlaySubFX = false)
	{
		if (isPlaying && !dontPlaySubFX && PlaybackStoped())
		{
			PlayEndFX();
		}
		base.Stop(dontPlaySubFX);
	}

	public void Complete()
	{
		if (isPlaying)
		{
			PlayEndFX();
			Stop(dontPlaySubFX: true);
		}
	}

	private void PlayEndFX()
	{
		if (!(endFXPrefab == null))
		{
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(endFXPrefab, 1f, transform.position, transform.rotation, size);
			adventureFXPlayer.sizeScale = sizeScale;
			if (_owner != null)
			{
				adventureFXPlayer.disableLifeCycleBind = true;
				adventureFXPlayer.Bind(_owner, _syncTarget, _actorState, _combo, _comboPhase);
			}
		}
	}
}
