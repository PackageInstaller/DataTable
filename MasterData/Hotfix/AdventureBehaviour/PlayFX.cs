using System;
using TrueSync;
using UnityEngine;

namespace AdventureBehaviour;

public class PlayFX
{
	protected AdventureFXPlayer _fxInstanceOutput;

	protected long _lastInstanceToken;

	protected AdventureActor _actor;

	protected AdventureActor _bindActor;

	protected AdventureSkill _skill;

	protected float _fxPlaybackSpeed;

	protected float _fxDuration;

	protected float _fxScale;

	protected bool _actorScale;

	protected AdventurePlayerFeedbackEffectConfigureData _playerFeedbackEffectConfigureData;

	protected Transform _target;

	protected bool _useCustomSource;

	public GameObject linkSource;

	protected TSVector _sourcePosition;

	public GameObject linkTarget;

	protected TSVector _targetPosition;

	public bool autoCheckLinkFXStop;

	public AdventureFXPlayer fxInstance => _fxInstanceOutput;

	public bool isPause
	{
		get
		{
			if (_fxInstanceOutput != null)
			{
				return _fxInstanceOutput.paused;
			}
			return false;
		}
	}

	public bool isPlaying
	{
		get
		{
			if (_fxInstanceOutput != null)
			{
				return _fxInstanceOutput.isPlaying;
			}
			return false;
		}
	}

	public bool isLoop
	{
		get
		{
			if (_fxInstanceOutput != null)
			{
				return _fxInstanceOutput.isLoop;
			}
			return false;
		}
	}

	public long GetFxPlayerToken()
	{
		return _lastInstanceToken;
	}

	public void Play(AdventureActor actor, AdventureSkill skill, string fxAlias, FP fxPositionY, TSVector2 position, TSVector2 direction, Action<long, AdventureFXPlayer> callback = null, float fxPlaybackSpeed = 1f, float fxScale = 1f, bool actorScale = false, AdventurePlayerFeedbackEffectConfigureData playerFeedbackEffectConfigureData = null, Transform target = null)
	{
		_actor = actor;
		_skill = skill;
		_fxPlaybackSpeed = fxPlaybackSpeed;
		_fxScale = fxScale;
		_actorScale = actorScale;
		_playerFeedbackEffectConfigureData = playerFeedbackEffectConfigureData;
		_target = target;
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		Vector3 pos = new Vector3((float)position.x, (float)(fxPositionY + actor.tsTransform.PositionY), (float)position.y);
		Quaternion rot = Quaternion.identity;
		if (direction != TSVector2.zero)
		{
			rot = Quaternion.LookRotation(new Vector3((float)direction.x, 0f, (float)direction.y), Vector3.up);
		}
		if (fxPrefab != null)
		{
			_fxInstanceOutput = GenerateFXInstance(fxPrefab, pos, rot);
			if (_fxInstanceOutput != null)
			{
				_fxInstanceOutput.ownerActor = actor;
				_lastInstanceToken = _fxInstanceOutput.token;
				callback?.Invoke(_lastInstanceToken, _fxInstanceOutput);
			}
		}
		if (playerFeedbackEffectConfigureData != null)
		{
			PlayFeedbackEffect(pos, rot);
		}
	}

	public void Play(AdventureActor actor, AdventureActor bindActor, string fxAlias, TSVector2 position, FP fxPositionY, TSVector2 direction, Action<long, AdventureFXPlayer> callback = null, float fxPlaybackSpeed = 1f, float fxScale = 1f, bool actorScale = false, AdventurePlayerFeedbackEffectConfigureData playerFeedbackEffectConfigureData = null, Transform target = null)
	{
		_actor = actor;
		_bindActor = bindActor;
		_fxPlaybackSpeed = fxPlaybackSpeed;
		_fxScale = fxScale;
		_actorScale = actorScale;
		_playerFeedbackEffectConfigureData = playerFeedbackEffectConfigureData;
		_target = target;
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		Vector3 pos = new Vector3((float)position.x, (float)(fxPositionY + actor.tsTransform.PositionY), (float)position.y);
		Quaternion rot = Quaternion.identity;
		if (direction != TSVector2.zero)
		{
			rot = Quaternion.LookRotation(new Vector3((float)direction.x, 0f, (float)direction.y), Vector3.up);
		}
		if (fxPrefab != null)
		{
			_fxInstanceOutput = GenerateFXInstance(fxPrefab, pos, rot);
			if (_fxInstanceOutput != null)
			{
				_fxInstanceOutput.ownerActor = actor;
				_lastInstanceToken = _fxInstanceOutput.token;
				callback?.Invoke(_lastInstanceToken, _fxInstanceOutput);
			}
		}
		if (playerFeedbackEffectConfigureData != null)
		{
			PlayFeedbackEffect(pos, rot);
		}
	}

	public AdventureFXPlayer PlayLinFx(AdventureActor actor, string fxAlias, float playbackSpeed, bool useCustSource, GameObject source, TSVector sourcePosition, FP sourcePositionY, GameObject targetObj, TSVector targetPosition, FP targetPositionY, float spawnSize = 1f, bool actorScale = false, bool breakWhenLostSourceOrTarget = false, Transform parent = null, Action<long, AdventureFXPlayer> callback = null)
	{
		_actor = actor;
		_fxPlaybackSpeed = playbackSpeed;
		_fxScale = spawnSize;
		_actorScale = actorScale;
		_useCustomSource = useCustSource;
		linkSource = source;
		_sourcePosition = sourcePosition;
		linkTarget = targetObj;
		_targetPosition = targetPosition;
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		if (fxPrefab == null)
		{
			return null;
		}
		_fxInstanceOutput = GenerateLineFXInstance(fxPrefab, sourcePositionY, targetPositionY, breakWhenLostSourceOrTarget);
		if (_fxInstanceOutput == null)
		{
			return null;
		}
		if ((bool)parent)
		{
			_fxInstanceOutput.transform.SetParent(parent);
		}
		_fxInstanceOutput.ownerActor = actor;
		_lastInstanceToken = _fxInstanceOutput.token;
		callback?.Invoke(_lastInstanceToken, _fxInstanceOutput);
		return _fxInstanceOutput;
	}

	public void PlayEarlyWarningFx(AdventureActor actor, AdventureSkill skill, string fxAlias, float fxDuration, FP fxPositionY, TSVector2 position, Quaternion spawnRotation, float spawnSize = 1f, bool actorScale = false)
	{
		_actor = actor;
		_skill = skill;
		_fxDuration = fxDuration;
		_fxScale = spawnSize;
		_actorScale = actorScale;
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		Vector3 pos = new Vector3((float)position.x, (float)(fxPositionY + actor.tsTransform.PositionY), (float)position.y);
		if (!(fxPrefab == null))
		{
			_fxInstanceOutput = GenerateEarlyWarningFXPlayer(fxPrefab, pos, spawnRotation);
			if (_fxInstanceOutput != null)
			{
				_fxInstanceOutput.ownerActor = actor;
				_lastInstanceToken = _fxInstanceOutput.token;
			}
		}
	}

	public AdventureFXPlayer Play(AdventureActor actor, string fxAlias, float playbackSpeed, FP fxPositionY, TSVector2 position, Quaternion spawnRotation, Transform parent = null, float spawnSize = 1f, bool actorScale = false, Action<long, AdventureFXPlayer> callback = null)
	{
		_actor = actor;
		_fxPlaybackSpeed = playbackSpeed;
		_fxScale = spawnSize;
		_actorScale = actorScale;
		Vector3 pos = new Vector3((float)position.x, (float)(fxPositionY + actor.tsTransform.PositionY), (float)position.y);
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		if (fxPrefab == null)
		{
			return null;
		}
		_fxInstanceOutput = GenerateFXInstance(fxPrefab, pos, spawnRotation);
		if (_fxInstanceOutput == null)
		{
			return null;
		}
		if ((bool)parent)
		{
			_fxInstanceOutput.transform.SetParent(parent);
		}
		_fxInstanceOutput.ownerActor = actor;
		_lastInstanceToken = _fxInstanceOutput.token;
		callback?.Invoke(_lastInstanceToken, _fxInstanceOutput);
		return _fxInstanceOutput;
	}

	public AdventureFXPlayer Play(AdventureActor actor, string fxAlias, float playbackSpeed, Vector3 spawnPosition, Quaternion spawnRotation, Transform parent = null, float spawnSize = 1f, Action<long, AdventureFXPlayer> callback = null, bool actorScale = false)
	{
		_actor = actor;
		_fxPlaybackSpeed = playbackSpeed;
		_fxScale = spawnSize;
		_actorScale = actorScale;
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		if (fxPrefab == null)
		{
			return null;
		}
		_fxInstanceOutput = GenerateFXInstance(fxPrefab, spawnPosition, spawnRotation);
		if (_fxInstanceOutput == null)
		{
			return null;
		}
		if ((bool)parent)
		{
			_fxInstanceOutput.transform.SetParent(parent);
		}
		_fxInstanceOutput.ownerActor = actor;
		_lastInstanceToken = _fxInstanceOutput.token;
		callback?.Invoke(_lastInstanceToken, _fxInstanceOutput);
		return _fxInstanceOutput;
	}

	public void Play(AdventureActor actor, string fxAlias, float playbackSpeed, Transform parent, Vector3 localPosition, Vector3 localRotation, float spawnSize = 1f, Action<long, AdventureFXPlayer> callback = null)
	{
		GameObject fxPrefab = GetFxPrefab(actor, fxAlias);
		if (fxPrefab == null)
		{
			return;
		}
		_fxInstanceOutput = AdventureFXPlayer.PlayFX(fxPrefab, playbackSpeed, Vector3.zero, Quaternion.identity, spawnSize);
		if (!(_fxInstanceOutput == null))
		{
			if ((bool)parent)
			{
				_fxInstanceOutput.transform.SetParent(parent);
				_fxInstanceOutput.transform.localPosition = localPosition;
				_fxInstanceOutput.transform.localRotation = Quaternion.Euler(localRotation);
			}
			_fxInstanceOutput.ownerActor = actor;
			_lastInstanceToken = _fxInstanceOutput.token;
			callback?.Invoke(_lastInstanceToken, _fxInstanceOutput);
		}
	}

	protected GameObject GetFxPrefab(AdventureActor actor, string fxAliasOrPath)
	{
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, fxAliasOrPath);
		if (gameObject == null)
		{
			fxAliasOrPath = "Assets/AssetBundles/" + fxAliasOrPath + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, fxAliasOrPath, typeof(GameObject)) as GameObject;
		}
		if (gameObject == null)
		{
			Debug.LogError("play fx,path :" + fxAliasOrPath + " not exit");
		}
		return gameObject;
	}

	protected AdventureFXPlayer GenerateFXInstance(GameObject fxPrefab, Vector3 pos, Quaternion rot)
	{
		GameObject gameObject = _bindActor?.gameObject;
		if (gameObject == null)
		{
			gameObject = ((_skill != null) ? _skill.gameObject : _actor.gameObject);
		}
		GameObject callerEntity = gameObject;
		bool actorScale = _actorScale;
		float fxPlaybackSpeed = _fxPlaybackSpeed;
		float fxScale = _fxScale;
		Transform transform = _actor.transform;
		Transform target = _target;
		return AdventureFXPlayer.PlayFX(callerEntity, actorScale, useTransformSync: true, fxPrefab, fxPlaybackSpeed, pos, rot, fxScale, transform, default, target);
	}

	protected AdventureFXPlayer GenerateLineFXInstance(GameObject fxPrefab, FP sPosY, FP tPosY, bool breakWhenLostSourceOrTarget)
	{
		Vector3 sourcePosition = new Vector3((float)_sourcePosition.x, (float)_sourcePosition.y + (float)sPosY, (float)_sourcePosition.z);
		if (!_useCustomSource)
		{
			linkSource = _actor.gameObject;
			sourcePosition = linkSource.transform.position;
		}
		Vector3 targetPosition = new Vector3((float)_targetPosition.x, (float)_targetPosition.y + (float)tPosY, (float)_targetPosition.z);
		autoCheckLinkFXStop = false;
		if (breakWhenLostSourceOrTarget && (linkSource != null || linkTarget != null))
		{
			autoCheckLinkFXStop = true;
		}
		return AdventureFXPlayer.PlayFX(linkSource, _actorScale, useTransformSync: true, fxPrefab, _fxPlaybackSpeed, default, Quaternion.identity, _fxScale, (linkSource != null) ? linkSource.transform : null, sourcePosition, (linkTarget != null) ? linkTarget.transform : null, targetPosition);
	}

	protected AdventureEarlyWarningFXPlayer GenerateEarlyWarningFXPlayer(GameObject fxPrefab, Vector3 pos, Quaternion rot)
	{
		return AdventureEarlyWarningFXPlayer.PlayFX((_skill != null) ? _skill.gameObject : _actor.gameObject, _actorScale, useTransformSync: true, fxPrefab, _fxDuration, pos, rot, _fxScale);
	}

	protected void PlayFeedbackEffect(Vector3 pos, Quaternion rot)
	{
		GameObject effectTarget = ((_skill != null) ? _skill.gameObject : _actor.gameObject);
		_playerFeedbackEffectConfigureData.Play(pos, effectTarget, GetCameraShakeSort());
	}

	private int GetCameraShakeSort()
	{
		if (_actor == null)
		{
			return 0;
		}
		if (!(_actor is PlayerAdventureActor playerAdventureActor))
		{
			return 2;
		}
		if (!playerAdventureActor.isAssist)
		{
			return 1;
		}
		return -1;
	}

	public void Complete()
	{
		if (_fxInstanceOutput != null && _fxInstanceOutput is AdventureEarlyWarningFXPlayer adventureEarlyWarningFXPlayer)
		{
			adventureEarlyWarningFXPlayer.Complete();
		}
	}

	public void Stop(bool dontPlaySubFX = false)
	{
		if (_fxInstanceOutput != null && _fxInstanceOutput.token == _lastInstanceToken)
		{
			_fxInstanceOutput.Stop(dontPlaySubFX);
		}
	}

	public void StopSubFx()
	{
		if (_lastInstanceToken != 0L)
		{
			SceneSingleton<AdventureFXManager>.Instance.StopSubFXPlayers(_lastInstanceToken);
		}
	}

	public void Pause()
	{
		if (_fxInstanceOutput != null && _fxInstanceOutput.token == _lastInstanceToken)
		{
			_fxInstanceOutput.Pause();
		}
	}

	public void Resume()
	{
		if (_fxInstanceOutput != null && _fxInstanceOutput.token == _lastInstanceToken)
		{
			_fxInstanceOutput.Resume();
		}
	}

	public void Clear()
	{
		_actor = null;
		_skill = null;
		_bindActor = null;
		_fxPlaybackSpeed = 0f;
		_fxDuration = 0f;
		_playerFeedbackEffectConfigureData = null;
		_fxInstanceOutput = null;
		_lastInstanceToken = 0L;
		_target = null;
		autoCheckLinkFXStop = false;
	}
}
