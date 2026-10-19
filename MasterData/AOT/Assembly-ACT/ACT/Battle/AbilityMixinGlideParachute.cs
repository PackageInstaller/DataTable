using System;
using ACT.Battle.Configs;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinGlideParachute : BaseAbilityMixin
{
	private static readonly Action<AbilityMixinGlideParachute, int> s_releaseAfterExitDelay = ReleaseAfterExitDelay;

	private readonly ConfigMixinGlideParachute _config;

	private AssetLoadHandle _handle;

	private GameObject _instance;

	private Transform _instanceTransform;

	private Animator _animator;

	private Transform _currentParent;

	private bool _useAttachPointParent;

	private int _loadVersion;

	private int _releaseDelayVersion;

	private Delayer _releaseDelayer;

	private bool _releaseWhenLoaded;

	private bool _isRemoving;

	private string openTrigger = "appear";

	private string exitTrigger = "exit";

	private int _openTriggerHash;

	private int _exitTriggerHash;

	private int ExitReleaseDelayMs = 200;

	public AbilityMixinGlideParachute(ConfigMixinGlideParachute config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
	}

	internal override void OnAdd()
	{
		ExitReleaseDelayMs = _config.exitReleaseDelayMs;
		_isRemoving = false;
		_releaseWhenLoaded = false;
		CancelDelayedRelease();
		CacheTriggerHashes();
		EnsureInstance();
	}

	internal override void OnRemove()
	{
		if (!_isRemoving)
		{
			_isRemoving = true;
			CacheTriggerHashes();
			if (_instance == null)
			{
				ReleaseInstance();
				return;
			}
			DetachFromOwnerKeepWorldTransform();
			PlayExitAnimation();
			ScheduleDelayedRelease();
		}
	}

	internal override void OnSilentRemove()
	{
		_isRemoving = true;
		CancelDelayedRelease();
		HideInstance();
		ReleaseInstance();
	}

	internal override void OnInheritRemove()
	{
		_isRemoving = false;
		CancelDelayedRelease();
	}

	internal override void OnInheritAdd()
	{
		_isRemoving = false;
		_releaseWhenLoaded = false;
		CancelDelayedRelease();
		if (_instance != null)
		{
			AttachToOwner();
			ShowInstance();
		}
		else
		{
			EnsureInstance();
		}
	}

	internal override void LateUpdate()
	{
		if (!_isRemoving && _config.refreshPositionInLateUpdate && _instanceTransform != null && owner.IsValid)
		{
			AttachToOwner();
		}
	}

	private void CacheTriggerHashes()
	{
		_openTriggerHash = ((!string.IsNullOrEmpty(openTrigger)) ? Animator.StringToHash(openTrigger) : 0);
		_exitTriggerHash = ((!string.IsNullOrEmpty(exitTrigger)) ? Animator.StringToHash(exitTrigger) : 0);
	}

	private void EnsureInstance()
	{
		if (_instance != null)
		{
			AttachToOwner();
			ShowInstance();
		}
		else if (!AssetLoadHandleExtensions.IsValid(_handle) && !(_config.parachutePrefab == null) && _config.parachutePrefab.RuntimeKeyIsValid())
		{
			int version = ++_loadVersion;
			_handle = AssetStationManager.BattleStation.InstantiateAsync(_config.parachutePrefab, (AssetLoadHandle result) =>
			{
				OnLoaded(result, version);
			});
		}
	}

	private void OnLoaded(AssetLoadHandle result, int version)
	{
		if (version != _loadVersion || _releaseWhenLoaded || _isRemoving || !owner.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(result);
			_handle = default;
			_releaseWhenLoaded = false;
			return;
		}
		_handle = result;
		_instance = result.AsGameObject();
		if (_instance == null)
		{
			AssetStationManager.BattleStation.ReleaseInstance(result);
			_handle = default;
			return;
		}
		_instanceTransform = _instance.transform;
		_animator = _instance.GetComponentInChildren<Animator>(includeInactive: true);
		AttachToOwner();
		ShowInstance();
	}

	private void AttachToOwner()
	{
		if (_instanceTransform == null || !owner.IsValid)
		{
			return;
		}
		Transform transform = ResolveParent(out var useAttachPoint);
		if (!(transform == null))
		{
			if (_currentParent != transform)
			{
				_instanceTransform.SetParent(transform, worldPositionStays: false);
				_currentParent = transform;
			}
			_useAttachPointParent = useAttachPoint;
			RefreshLocalTransform();
		}
	}

	private Transform ResolveParent(out bool useAttachPoint)
	{
		useAttachPoint = false;
		if (_config.useAttachPoint && !string.IsNullOrEmpty(_config.attachPointName))
		{
			MonoEntity mono = owner.GetMono();
			if (TryFindAttachPointNoLog(mono, _config.attachPointName, out var attachPoint))
			{
				useAttachPoint = true;
				return attachPoint;
			}
		}
		return owner.GetRootTransform();
	}

	private bool TryFindAttachPointNoLog(MonoEntity mono, string attachPointName, out Transform attachPoint)
	{
		attachPoint = null;
		if (mono == null || mono.attachPoints == null || mono.attachPoints.Length == 0)
		{
			return false;
		}
		AttachPoint[] attachPoints = mono.attachPoints;
		for (int i = 0; i < attachPoints.Length; i++)
		{
			if (attachPoints[i].key == attachPointName)
			{
				attachPoint = attachPoints[i].transform;
				return attachPoint != null;
			}
		}
		return false;
	}

	private void RefreshLocalTransform()
	{
		if (!(_instanceTransform == null))
		{
			_instanceTransform.localPosition = ResolveLocalPosition(_useAttachPointParent);
			_instanceTransform.localRotation = Quaternion.Euler(_config.localEulerAngles);
			_instanceTransform.localScale = _config.localScale;
		}
	}

	private Vector3 ResolveLocalPosition(bool useAttachPoint)
	{
		Vector3 vector = ResolveOffset();
		if (useAttachPoint || !_config.fallbackToColliderHeight)
		{
			return vector;
		}
		return Vector3.up * ResolveColliderHeight() + vector;
	}

	private Vector3 ResolveOffset()
	{
		if (_config.offsetConfig == null)
		{
			return Vector3.zero;
		}
		int characterId = -1;
		if (owner.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			characterId = component.characterSource.Id();
		}
		return _config.offsetConfig.GetOffset(characterId);
	}

	private float ResolveColliderHeight()
	{
		if (owner.TryGetCompPhysics(out CompPhysics component) && component.characterMovement != null)
		{
			return component.characterMovement.height;
		}
		if (owner.TryGetCompTransform(out CompTransform component2))
		{
			return component2.size.y;
		}
		return 0f;
	}

	private void ShowInstance()
	{
		if (!(_instance == null))
		{
			_instance.SetActive(value: true);
			if (!(_animator == null) && _openTriggerHash != 0)
			{
				_animator.SetTrigger(_openTriggerHash);
			}
		}
	}

	private void PlayExitAnimation()
	{
		if (!(_animator == null) && _exitTriggerHash != 0)
		{
			_animator.SetTrigger(_exitTriggerHash);
		}
	}

	private void DetachFromOwnerKeepWorldTransform()
	{
		if (!(_instanceTransform == null))
		{
			_instanceTransform.SetParent(null, worldPositionStays: true);
			_currentParent = null;
			_useAttachPointParent = false;
		}
	}

	private void ScheduleDelayedRelease()
	{
		CancelDelayedRelease();
		int arg = ++_releaseDelayVersion;
		_releaseDelayer = UpdateTimer.Default.DelayMs(ExitReleaseDelayMs, s_releaseAfterExitDelay, this, arg);
	}

	private void CancelDelayedRelease()
	{
		_releaseDelayVersion++;
		if (_releaseDelayer.IsValid())
		{
			_releaseDelayer.Cancel();
		}
		_releaseDelayer = default;
	}

	private static void ReleaseAfterExitDelay(AbilityMixinGlideParachute mixin, int version)
	{
		mixin.ReleaseAfterExitDelay(version);
	}

	private void ReleaseAfterExitDelay(int version)
	{
		_releaseDelayer = default;
		if (version == _releaseDelayVersion && _isRemoving)
		{
			HideInstance();
			ReleaseInstance();
		}
	}

	private void HideInstance()
	{
		if (!(_instance == null))
		{
			_instance.SetActive(value: false);
		}
	}

	private void ReleaseInstance()
	{
		_loadVersion++;
		if (_instance == null && AssetLoadHandleExtensions.IsValid(_handle))
		{
			_releaseWhenLoaded = true;
			return;
		}
		if (AssetLoadHandleExtensions.IsValid(_handle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_handle);
		}
		else if (_instance != null)
		{
			AssetStationManager.BattleStation.ReleaseInstance(_instance);
		}
		_handle = default;
		_instance = null;
		_instanceTransform = null;
		_animator = null;
		_currentParent = null;
		_releaseWhenLoaded = false;
	}
}
