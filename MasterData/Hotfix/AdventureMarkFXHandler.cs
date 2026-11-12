using System;
using UnityEngine;

[AddComponentMenu("Game/FX/Mark FX Handler")]
[DisallowMultipleComponent]
public class AdventureMarkFXHandler : AdventureFXHandler
{
	[Serializable]
	public class AnimationEffectDataPair
	{
		public GameObject fxPrefab;

		public float playbackSpeed = 1f;
	}

	public AnimationEffectDataPair[] markEffects;

	protected float _fxSize = 1f;

	protected int _currentMarkLevel;

	protected AdventureFXPlayer _currentMarkPlayer;

	protected long _currentMarkPlayerToken;

	protected AdventureActor _owner;

	protected Transform _syncNode;

	public int maxLevel => markEffects.Length;

	public AdventureActor owner => _owner;

	public Transform syncNode
	{
		get
		{
			return _syncNode;
		}
		set
		{
			_syncNode = value;
			if (_currentMarkPlayer != null && _currentMarkPlayer.isPlaying && _currentMarkPlayer.token == _currentMarkPlayerToken)
			{
				_currentMarkPlayer.syncNode = syncNode;
			}
		}
	}

	protected override void OnDisable()
	{
		StopFX_Mark(interrupt: true);
		_owner = null;
		_syncNode = null;
		_fxSize = 1f;
		_currentMarkLevel = 0;
		base.OnDisable();
	}

	protected static AdventureMarkFXHandler Spawn(GameObject fxPrefab, bool isPreloadSpawn = false)
	{
		AdventureMarkFXHandler component = AdventureFXHandler.SpawnInstance(fxPrefab, Vector3.zero, Quaternion.identity, Vector3.one, isPreloadSpawn, out var destroyMode).GetComponent<AdventureMarkFXHandler>();
		component.destroyMode = destroyMode;
		return component;
	}

	protected static void Despawn(AdventureMarkFXHandler fxHandler)
	{
		AdventureFXHandler.DestroyInstance(fxHandler);
	}

	internal static void PreloadFX(GameObject fxPrefab)
	{
		if (fxPrefab == null)
		{
			return;
		}
		AdventureMarkFXHandler adventureMarkFXHandler = Spawn(fxPrefab, isPreloadSpawn: true);
		if (adventureMarkFXHandler.markEffects != null)
		{
			for (int i = 0; i < adventureMarkFXHandler.markEffects.Length; i++)
			{
				AdventureFXPlayer.PreloadFX(adventureMarkFXHandler.markEffects[i].fxPrefab);
			}
		}
		Despawn(adventureMarkFXHandler);
	}

	public static AdventureMarkFXHandler PlayFX(GameObject fxPrefab, AdventureActor owner, Transform syncNode, int initLevel = 1, float fxScale = 1f)
	{
		if (fxPrefab == null)
		{
			return null;
		}
		AdventureMarkFXHandler adventureMarkFXHandler = Spawn(fxPrefab);
		if (adventureMarkFXHandler != null)
		{
			adventureMarkFXHandler.PlayFX(owner, syncNode, initLevel, fxScale);
		}
		return adventureMarkFXHandler;
	}

	public void PlayFX(AdventureActor owner, Transform syncNode, int initLevel = 1, float fxSize = 1f)
	{
		_owner = owner;
		_syncNode = syncNode;
		_fxSize = fxSize;
		SetIndependentUpdate(value: false);
		if (initLevel > 0)
		{
			PlayFX_Mark(initLevel);
		}
	}

	protected void PlayFX_Mark(int level)
	{
		if (level < 1 || level > maxLevel)
		{
			throw new ArgumentException("PlayFX_Mark Argument Error", "level");
		}
		AnimationEffectDataPair effectSetting = markEffects[level - 1];
		_currentMarkPlayer = DoPlayFXInstance(_owner, _syncNode, effectSetting, _fxSize);
		_currentMarkPlayerToken = _currentMarkPlayer.token;
		_currentMarkLevel = level;
	}

	public void UpdateMark(int level)
	{
		if (_currentMarkLevel != level)
		{
			StopFX_Mark(interrupt: true);
			PlayFX_Mark(level);
		}
	}

	public void StopFX(bool interrupt = false)
	{
		StopFX_Mark(interrupt);
		Despawn(this);
	}

	protected void StopFX_Mark(bool interrupt)
	{
		if (_currentMarkPlayer != null)
		{
			if (_currentMarkPlayer.isPlaying && _currentMarkPlayer.token == _currentMarkPlayerToken)
			{
				_currentMarkPlayer.Stop(interrupt);
			}
			_currentMarkPlayer = null;
			_currentMarkPlayerToken = 0L;
		}
	}

	protected override void OnHide()
	{
		if (_currentMarkPlayer != null && _currentMarkPlayer.token == _currentMarkPlayerToken)
		{
			_currentMarkPlayer.Hide();
		}
	}

	protected override void OnVisible()
	{
		if (_currentMarkPlayer != null && _currentMarkPlayer.token == _currentMarkPlayerToken)
		{
			_currentMarkPlayer.Visible();
		}
	}

	public override void SetRenderLayer(int layer)
	{
		if (_currentMarkPlayer != null && _currentMarkPlayer.token == _currentMarkPlayerToken)
		{
			_currentMarkPlayer.SetRenderLayer(layer);
		}
	}

	public override void ResetRenderLayer()
	{
		if (_currentMarkPlayer != null && _currentMarkPlayer.token == _currentMarkPlayerToken)
		{
			_currentMarkPlayer.ResetRenderLayer();
		}
	}

	protected static AdventureFXPlayer DoPlayFXInstance(AdventureActor owner, Transform syncNode, AnimationEffectDataPair effectSetting, float fxSize = 1f)
	{
		if (effectSetting.fxPrefab == null)
		{
			return null;
		}
		float num = CalcFXScaleWithTargetBody(owner, effectSetting);
		AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(effectSetting.fxPrefab, effectSetting.playbackSpeed, syncNode.position, syncNode.rotation, fxSize * num);
		adventureFXPlayer.syncSlot = AnimationSlotConfigComponent.SlotType.None;
		adventureFXPlayer.syncSlotRotation = false;
		adventureFXPlayer.syncSlotScale = false;
		adventureFXPlayer.bindVisible = true;
		adventureFXPlayer.Bind(owner.gameObject);
		adventureFXPlayer.syncNode = syncNode;
		return adventureFXPlayer;
	}

	protected static float CalcFXScaleWithTargetBody(AdventureActor targetActor, AnimationEffectDataPair effectSetting)
	{
		float result = 1f;
		if (targetActor != null)
		{
			if (targetActor.actorScaleInfo.overrideTagEffectScale > float.Epsilon)
			{
				result = (float)targetActor.actorScaleInfo.modelScale * targetActor.actorScaleInfo.overrideTagEffectScale;
			}
			else
			{
				AdventureModuleConfigureData config = AdventureModuleController.Config;
				result = AdventureFXManager.CalcFXScaleWithBody(targetActor.dtCollider.colliderBounds, config.FX_TagEffectAutoScaleFactor, config.FX_TagEffectAutoScaleFactorRange.x, config.FX_TagEffectAutoScaleFactorRange.y);
			}
		}
		return result;
	}
}
