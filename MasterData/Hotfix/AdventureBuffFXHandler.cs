using System;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/FX/Buff FX Handler")]
[DisallowMultipleComponent]
public class AdventureBuffFXHandler : AdventureFXHandler
{
	[Serializable]
	public class AnimationEffectDataPair
	{
		public AnimationSlotConfigComponent.SlotType syncSlot;

		public bool syncSlotRotation;

		public bool syncSlotScale = true;

		[Space]
		public GameObject fxPrefab;

		public GameObject fxPrefabForLargeSize;

		[Space]
		public float playbackSpeed = 1f;
	}

	public enum StackFXMode
	{
		[InspectorName("每层播放相同的特效")]
		SameFXEachStack,
		[InspectorName("一层播放一种特效")]
		OneFXOneStack
	}

	public enum StackFXAdditionalMethod
	{
		[InspectorName("叠加")]
		Additional,
		[InspectorName("替换")]
		Replace
	}

	public enum FXPlayMode
	{
		Default,
		Instant,
		HurtInstant
	}

	public AnimationEffectDataPair[] startEffects;

	public float loopDelayTime;

	public AnimationEffectDataPair[] loopEffects;

	public AnimationEffectDataPair[] endEffects;

	public AnimationEffectDataPair[] endEffectsIfFullStack;

	public StackFXMode stackFXMode;

	public StackFXAdditionalMethod stackFXAdditionalMethod;

	public AnimationEffectDataPair[] stackEffects;

	public AnimationEffectDataPair[] stackFullEffects;

	public AnimationEffectDataPair[] hurtEffects;

	[Tooltip("例如用于实现箭矢随机角度插在物体表面")]
	public Vector3 stackEffectRotationRandomAngle;

	[Space]
	public bool enableFXForLargeSize;

	[MinMaxSlider(0f, 10f)]
	public Vector2 largeSizeScaleRange = new Vector2(0f, 10f);

	[Space]
	public bool ignoreBodySizeAdaptiveScale;

	protected float _fxSize = 1f;

	protected float _playbackTimer;

	protected bool _loopEffectsPlayed;

	protected List<AdventureFXPlayer> _loopPlayers;

	protected int _currentStackCount;

	protected int _maxStackCount;

	protected List<AdventureFXPlayer> _stackPlayers;

	protected List<AdventureFXPlayer> _stackFullPlayers;

	protected GameObject _owner;

	protected AdventureActor _targetActor;

	public GameObject owner => _owner;

	public AdventureActor targetActor => _targetActor;

	protected override void OnDisable()
	{
		StopFX_Loop(dontPlaySubFX: true);
		StopBuffStackFX_Stack(interrupt: true);
		StopBuffStackFX_FullStack(interrupt: true);
		_owner = null;
		_currentStackCount = 0;
		_maxStackCount = 0;
		base.OnDisable();
	}

	public override void DoUpdate()
	{
		float num = deltaTime;
		_playbackTimer += num;
		if (!_loopEffectsPlayed && _playbackTimer >= loopDelayTime)
		{
			PlayFX_Internal(loopEffects, isLoopEffects: true);
		}
	}

	protected static AdventureBuffFXHandler Spawn(GameObject fxPrefab, bool isPreloadSpawn = false)
	{
		AdventureBuffFXHandler component = AdventureFXHandler.SpawnInstance(fxPrefab, Vector3.zero, Quaternion.identity, Vector3.one, isPreloadSpawn, out var destroyMode).GetComponent<AdventureBuffFXHandler>();
		component.destroyMode = destroyMode;
		return component;
	}

	protected static void Despawn(AdventureBuffFXHandler fxHandler)
	{
		AdventureFXHandler.DestroyInstance(fxHandler);
	}

	internal static void PreloadFX(GameObject fxPrefab)
	{
		if (!(fxPrefab == null))
		{
			AdventureBuffFXHandler adventureBuffFXHandler = Spawn(fxPrefab, isPreloadSpawn: true);
			if (adventureBuffFXHandler.startEffects != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.startEffects);
			}
			if (adventureBuffFXHandler.loopEffects != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.loopEffects);
			}
			if (adventureBuffFXHandler.endEffects != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.endEffects);
			}
			if (adventureBuffFXHandler.endEffectsIfFullStack != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.endEffectsIfFullStack);
			}
			if (adventureBuffFXHandler.stackEffects != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.stackEffects);
			}
			if (adventureBuffFXHandler.stackFullEffects != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.stackFullEffects);
			}
			if (adventureBuffFXHandler.hurtEffects != null)
			{
				PreloadFX_Internal(adventureBuffFXHandler.hurtEffects);
			}
			Despawn(adventureBuffFXHandler);
		}
		static void PreloadFX_Internal(AnimationEffectDataPair[] effects)
		{
			for (int i = 0; i < effects.Length; i++)
			{
				if (effects[i].fxPrefab != null)
				{
					AdventureFXPlayer.PreloadFX(effects[i].fxPrefab);
				}
				if (effects[i].fxPrefabForLargeSize != null)
				{
					AdventureFXPlayer.PreloadFX(effects[i].fxPrefabForLargeSize);
				}
			}
		}
	}

	public static AdventureBuffFXHandler PlayFX(GameObject fxPrefab, GameObject owner, FXPlayMode playMode, Vector3 fxPosition = default(Vector3), Quaternion fxRotation = default(Quaternion), float fxScale = 1f, AdventureActor targetActor = null)
	{
		if (fxPrefab == null)
		{
			return null;
		}
		AdventureBuffFXHandler adventureBuffFXHandler = null;
		switch (playMode)
		{
		case FXPlayMode.Default:
			adventureBuffFXHandler = Spawn(fxPrefab);
			if (adventureBuffFXHandler != null)
			{
				adventureBuffFXHandler.PlayFX(owner, fxScale, targetActor);
			}
			break;
		case FXPlayMode.Instant:
		{
			AdventureBuffFXHandler component2 = fxPrefab.GetComponent<AdventureBuffFXHandler>();
			if (component2 != null)
			{
				component2.PlayInstantFX(owner, fxPosition, fxRotation, fxScale, targetActor);
			}
			break;
		}
		case FXPlayMode.HurtInstant:
		{
			AdventureBuffFXHandler component = fxPrefab.GetComponent<AdventureBuffFXHandler>();
			if (component != null)
			{
				component.PlayHurtInstantFX(owner, fxPosition, fxRotation, fxScale, targetActor);
			}
			break;
		}
		}
		return adventureBuffFXHandler;
	}

	public void PlayFX(GameObject owner, float fxSize = 1f, AdventureActor targetActor = null)
	{
		_owner = owner;
		_targetActor = ((targetActor != null) ? targetActor : owner.GetComponent<AdventureActor>());
		_fxSize = fxSize;
		_playbackTimer = 0f;
		_loopEffectsPlayed = false;
		SetIndependentUpdate(value: false);
		PlayFX_Internal(startEffects, isLoopEffects: false);
	}

	protected void PlayFX_Internal(AnimationEffectDataPair[] effects, bool isLoopEffects)
	{
		if (effects == null)
		{
			return;
		}
		if (isLoopEffects)
		{
			if (_loopPlayers == null)
			{
				_loopPlayers = new List<AdventureFXPlayer>(effects.Length);
			}
			_loopEffectsPlayed = true;
		}
		foreach (AnimationEffectDataPair effectSetting in effects)
		{
			GameObject gameObject = _owner;
			AdventureActor adventureActor = _targetActor;
			float fxSize = _fxSize;
			AdventureFXPlayer adventureFXPlayer = DoPlayFXInstance(gameObject, adventureActor, effectSetting, default, default, fxSize);
			if (isLoopEffects && adventureFXPlayer != null)
			{
				_loopPlayers.Add(adventureFXPlayer);
			}
		}
		if (isLoopEffects && _currentStackCount > 0 && _maxStackCount > 0)
		{
			for (int j = 0; j < _loopPlayers.Count; j++)
			{
				_loopPlayers.get_Item(j).UpdateBuffStack(_currentStackCount, _maxStackCount);
			}
		}
	}

	public void PlayInstantFX(GameObject owner = null, Vector3 fxPosition = default(Vector3), Quaternion fxRotation = default(Quaternion), float fxSize = 1f, AdventureActor targetActor = null)
	{
		if (owner == null)
		{
			owner = _owner;
		}
		if (targetActor == null)
		{
			targetActor = _targetActor;
		}
		_fxSize = fxSize;
		for (int i = 0; i < startEffects.Length; i++)
		{
			AnimationEffectDataPair effectSetting = startEffects[i];
			DoPlayFXInstance(owner, targetActor, effectSetting, fxPosition, fxRotation, _fxSize);
		}
	}

	public void PlayHurtInstantFX(GameObject owner = null, Vector3 fxPosition = default(Vector3), Quaternion fxRotation = default(Quaternion), float fxSize = 1f, AdventureActor targetActor = null)
	{
		if (owner == null)
		{
			owner = _owner;
		}
		if (targetActor == null)
		{
			targetActor = _targetActor;
		}
		_fxSize = fxSize;
		for (int i = 0; i < hurtEffects.Length; i++)
		{
			AnimationEffectDataPair effectSetting = hurtEffects[i];
			DoPlayFXInstance(owner, targetActor, effectSetting, fxPosition, fxRotation, _fxSize);
		}
	}

	public void PlayBuffStackFX(int currentStackCount, int maxStackCount)
	{
		if (currentStackCount < 0 || currentStackCount > maxStackCount)
		{
			throw new ArgumentException("PlayBuffStackFX Argument Error", "currentStackCount");
		}
		if (maxStackCount <= 0)
		{
			throw new ArgumentException("PlayBuffStackFX Argument Error", "maxStackCount");
		}
		int currentStackCount2 = _currentStackCount;
		_currentStackCount = currentStackCount;
		_maxStackCount = maxStackCount;
		if (_loopEffectsPlayed)
		{
			for (int i = 0; i < _loopPlayers.Count; i++)
			{
				_loopPlayers.get_Item(i).UpdateBuffStack(_currentStackCount, _maxStackCount);
			}
		}
		if (stackEffects != null && stackEffects.Length != 0)
		{
			PlayBuffStackFX_Stack(currentStackCount2, currentStackCount);
		}
		if (_currentStackCount >= _maxStackCount)
		{
			PlayBuffStackFX_FullStack();
		}
		else
		{
			StopBuffStackFX_FullStack(interrupt: false);
		}
	}

	private void PlayBuffStackFX_Stack(int fromStackCount, int toStackCount)
	{
		if (_stackPlayers == null)
		{
			_stackPlayers = new List<AdventureFXPlayer>();
		}
		if (toStackCount > fromStackCount)
		{
			switch (stackFXAdditionalMethod)
			{
			case StackFXAdditionalMethod.Additional:
			{
				for (int i = fromStackCount; i < toStackCount; i++)
				{
					PlayBuffStackFX_OneStack(i);
				}
				break;
			}
			case StackFXAdditionalMethod.Replace:
				StopBuffStackFX_OneStack(interrupt: true);
				PlayBuffStackFX_OneStack(toStackCount - 1);
				break;
			}
		}
		else
		{
			if (toStackCount >= fromStackCount)
			{
				return;
			}
			switch (stackFXAdditionalMethod)
			{
			case StackFXAdditionalMethod.Additional:
			{
				for (int num = fromStackCount; num > toStackCount; num--)
				{
					StopBuffStackFX_OneStack(interrupt: false);
				}
				break;
			}
			case StackFXAdditionalMethod.Replace:
				StopBuffStackFX_OneStack(interrupt: true);
				PlayBuffStackFX_OneStack(toStackCount - 1);
				break;
			}
		}
	}

	private void StopBuffStackFX_Stack(bool interrupt)
	{
		if (_stackPlayers != null && _stackPlayers.Count != 0)
		{
			for (int num = _currentStackCount; num > 0; num--)
			{
				StopBuffStackFX_OneStack(interrupt);
			}
		}
	}

	private void PlayBuffStackFX_OneStack(int stackFXIndex)
	{
		if (stackFXIndex < 0)
		{
			return;
		}
		switch (stackFXMode)
		{
		case StackFXMode.SameFXEachStack:
		{
			for (int i = 0; i < stackEffects.Length; i++)
			{
				GameObject gameObject2 = _owner;
				AdventureActor adventureActor2 = _targetActor;
				AnimationEffectDataPair effectSetting2 = stackEffects[i];
				float fxSize = _fxSize;
				Vector3 fxLocalRotationRandomAngle = stackEffectRotationRandomAngle;
				AdventureFXPlayer adventureFXPlayer2 = DoPlayFXInstance(gameObject2, adventureActor2, effectSetting2, default, default, fxSize, fxLocalRotationRandomAngle);
				if (adventureFXPlayer2 != null && adventureFXPlayer2.isLoop)
				{
					_stackPlayers.Add(adventureFXPlayer2);
				}
			}
			break;
		}
		case StackFXMode.OneFXOneStack:
		{
			stackFXIndex %= stackEffects.Length;
			GameObject gameObject = _owner;
			AdventureActor adventureActor = _targetActor;
			AnimationEffectDataPair effectSetting = stackEffects[stackFXIndex];
			float fxSize = _fxSize;
			Vector3 fxLocalRotationRandomAngle = stackEffectRotationRandomAngle;
			AdventureFXPlayer adventureFXPlayer = DoPlayFXInstance(gameObject, adventureActor, effectSetting, default, default, fxSize, fxLocalRotationRandomAngle);
			if (adventureFXPlayer != null && adventureFXPlayer.isLoop)
			{
				_stackPlayers.Add(adventureFXPlayer);
			}
			break;
		}
		}
	}

	private void StopBuffStackFX_OneStack(bool interrupt)
	{
		if (_stackPlayers == null || _stackPlayers.Count == 0)
		{
			return;
		}
		switch (stackFXMode)
		{
		case StackFXMode.SameFXEachStack:
		{
			for (int i = 0; i < stackEffects.Length; i++)
			{
				StopLastBuffStackFX();
			}
			break;
		}
		case StackFXMode.OneFXOneStack:
			StopLastBuffStackFX();
			break;
		}
		void StopLastBuffStackFX()
		{
			if (_stackPlayers.Count > 0)
			{
				_stackPlayers.get_Item(_stackPlayers.Count - 1).Stop(interrupt);
				_stackPlayers.RemoveAt(_stackPlayers.Count - 1);
			}
		}
	}

	private void PlayBuffStackFX_FullStack()
	{
		StopBuffStackFX_FullStack(interrupt: true);
		if (_stackFullPlayers == null && stackFullEffects.Length != 0)
		{
			_stackFullPlayers = new List<AdventureFXPlayer>(stackFullEffects.Length);
		}
		for (int i = 0; i < stackFullEffects.Length; i++)
		{
			GameObject gameObject = _owner;
			AdventureActor adventureActor = _targetActor;
			AnimationEffectDataPair effectSetting = stackFullEffects[i];
			float fxSize = _fxSize;
			AdventureFXPlayer adventureFXPlayer = DoPlayFXInstance(gameObject, adventureActor, effectSetting, default, default, fxSize);
			if (adventureFXPlayer != null && adventureFXPlayer.isLoop)
			{
				_stackFullPlayers.Add(adventureFXPlayer);
			}
		}
	}

	private void StopBuffStackFX_FullStack(bool interrupt)
	{
		if (_stackFullPlayers != null && _stackFullPlayers.Count != 0)
		{
			for (int i = 0; i < _stackFullPlayers.Count; i++)
			{
				_stackFullPlayers.get_Item(i).Stop(interrupt);
			}
			_stackFullPlayers.Clear();
		}
	}

	public void StopFX(bool interrupt = false)
	{
		StopFX_Loop(interrupt);
		StopBuffStackFX_Stack(interrupt);
		StopBuffStackFX_FullStack(interrupt);
		if (!interrupt)
		{
			if (endEffectsIfFullStack != null && endEffectsIfFullStack.Length != 0 && _currentStackCount > 0 && _maxStackCount > 0 && _currentStackCount >= _maxStackCount)
			{
				PlayFX_Internal(endEffectsIfFullStack, isLoopEffects: false);
			}
			else
			{
				PlayFX_Internal(endEffects, isLoopEffects: false);
			}
		}
		Despawn(this);
	}

	protected void StopFX_Loop(bool dontPlaySubFX)
	{
		if (_loopEffectsPlayed)
		{
			for (int i = 0; i < _loopPlayers.Count; i++)
			{
				_loopPlayers.get_Item(i).Stop(dontPlaySubFX);
			}
			_loopPlayers.Clear();
			_loopEffectsPlayed = false;
		}
	}

	protected AdventureFXPlayer DoPlayFXInstance(GameObject owner, AdventureActor targetActor, AnimationEffectDataPair effectSetting, Vector3 fxPosition = default(Vector3), Quaternion fxRotation = default(Quaternion), float fxSize = 1f, Vector3 fxLocalRotationRandomAngle = default(Vector3))
	{
		if (owner != null)
		{
			if (effectSetting.syncSlot == AnimationSlotConfigComponent.SlotType.None)
			{
				effectSetting.syncSlot = AnimationSlotConfigComponent.SlotType.Base;
			}
			if (effectSetting.syncSlot != AnimationSlotConfigComponent.SlotType.Base)
			{
				AnimationSlotConfigComponent component = owner.GetComponent<AnimationSlotConfigComponent>();
				if (component == null || component.GetSlotNode(effectSetting.syncSlot) == null)
				{
					return null;
				}
			}
			var (num, gameObject) = CalcFXScaleWithTargetBody(targetActor, effectSetting);
			if (gameObject == null)
			{
				return null;
			}
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(gameObject, effectSetting.playbackSpeed, fxPosition, fxRotation, fxSize * num);
			adventureFXPlayer.syncSlot = effectSetting.syncSlot;
			adventureFXPlayer.syncSlotRotation = effectSetting.syncSlotRotation;
			adventureFXPlayer.syncSlotScale = effectSetting.syncSlotScale;
			adventureFXPlayer.bindVisible = true;
			if (fxLocalRotationRandomAngle.x > float.Epsilon || fxLocalRotationRandomAngle.y > float.Epsilon || fxLocalRotationRandomAngle.z > float.Epsilon)
			{
				adventureFXPlayer.syncLocalOffsetRotation = AdventureFXPlayer.RandomLocalRotation(fxLocalRotationRandomAngle);
			}
			adventureFXPlayer.Bind(owner);
			return adventureFXPlayer;
		}
		if (effectSetting.fxPrefab == null)
		{
			return null;
		}
		return AdventureFXPlayer.PlayFX(effectSetting.fxPrefab, effectSetting.playbackSpeed, fxPosition, fxRotation, fxSize);
	}

	protected (float, GameObject) CalcFXScaleWithTargetBody(AdventureActor targetActor, AnimationEffectDataPair effectSetting)
	{
		float num = 1f;
		GameObject item = effectSetting.fxPrefab;
		if (targetActor != null)
		{
			bool flag = enableFXForLargeSize && effectSetting.fxPrefabForLargeSize != null;
			if (ignoreBodySizeAdaptiveScale)
			{
				num = (float)targetActor.actorScaleInfo.modelScale;
			}
			else if (targetActor.actorScaleInfo.overrideEffectScale > float.Epsilon)
			{
				num = (float)targetActor.actorScaleInfo.modelScale * targetActor.actorScaleInfo.overrideEffectScale;
			}
			else
			{
				AdventureModuleConfigureData config = AdventureModuleController.Config;
				float minScale;
				float maxScale;
				if (flag)
				{
					minScale = float.MinValue;
					maxScale = float.MaxValue;
				}
				else
				{
					minScale = config.FX_BuffEffectAutoScaleFactorRange.x;
					maxScale = config.FX_BuffEffectAutoScaleFactorRange.y;
				}
				num = AdventureFXManager.CalcFXScaleWithBody(targetActor.dtCollider.colliderBounds, config.FX_BuffEffectAutoScaleFactor, minScale, maxScale);
			}
			if (flag && num >= largeSizeScaleRange.x && num < largeSizeScaleRange.y)
			{
				item = effectSetting.fxPrefabForLargeSize;
			}
			if (effectSetting.syncSlotScale)
			{
				num /= (float)targetActor.actorScaleInfo.modelScale;
			}
		}
		return (num, item);
	}
}
