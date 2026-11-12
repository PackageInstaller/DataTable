using System;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/FX/Self FX Handler")]
[DisallowMultipleComponent]
public class AdventureSelfFXHandler : AdventureFXHandler
{
	[Serializable]
	public class AnimationEffectDataPair
	{
		public string name;

		[Space]
		public GameObject fxInstance;

		public float playbackSpeed = 1f;

		public bool playOnAwake;

		public bool stopOnDied;

		[Space]
		[Obsolete]
		public Transform syncNode;

		[Obsolete]
		public ParticleSystem particleSystem;

		internal AdventureFXPlayer _fxPlayer;
	}

	public AnimationEffectDataPair[] dataPairs;

	protected Dictionary<string, List<AnimationEffectDataPair>> _dataPairsTable;

	public static bool ManualInitialize
	{
		get
		{
			return AdventureGlobalState.ManualFXInitialize;
		}
		set
		{
			AdventureGlobalState.ManualFXInitialize = value;
		}
	}

	protected void Awake()
	{
		if (dataPairs == null || dataPairs.Length == 0)
		{
			return;
		}
		_dataPairsTable = new Dictionary<string, List<AnimationEffectDataPair>>(dataPairs.Length);
		for (int i = 0; i < dataPairs.Length; i++)
		{
			AnimationEffectDataPair animationEffectDataPair = dataPairs[i];
			if (_dataPairsTable.TryGetValue(animationEffectDataPair.name, out var value))
			{
				value.Add(animationEffectDataPair);
			}
			else
			{
				value = new List<AnimationEffectDataPair>();
				value.Add(animationEffectDataPair);
				_dataPairsTable.Add(animationEffectDataPair.name, value);
			}
			GameObject fxInstance = animationEffectDataPair.fxInstance;
			if (fxInstance == null && animationEffectDataPair.particleSystem != null)
			{
				fxInstance = animationEffectDataPair.particleSystem.gameObject;
			}
			if (fxInstance != null)
			{
				AdventureFXPlayer fxPlayer = AdventureFXPlayer.Setup(fxInstance);
				animationEffectDataPair._fxPlayer = fxPlayer;
			}
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (!ManualInitialize)
		{
			Initialize();
		}
	}

	public void Initialize()
	{
		for (int i = 0; i < dataPairs.Length; i++)
		{
			AnimationEffectDataPair animationEffectDataPair = dataPairs[i];
			if (animationEffectDataPair._fxPlayer != null)
			{
				if (animationEffectDataPair.playOnAwake)
				{
					PlayFX_Internal(animationEffectDataPair._fxPlayer, animationEffectDataPair.playbackSpeed, animationEffectDataPair.syncNode);
				}
				else
				{
					animationEffectDataPair._fxPlayer.gameObject.SetActive(value: false);
				}
			}
		}
	}

	public void PlayFX(string effectName, float? playbackSpeed = null, ActorState actorState = ActorState.Null, Combo combo = null, Combo.Phase comboPhase = Combo.Phase.All, bool cancelOnInterrupt = false)
	{
		if (_dataPairsTable == null || !_dataPairsTable.TryGetValue(effectName, out var value))
		{
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			AnimationEffectDataPair animationEffectDataPair = value.get_Item(i);
			if (animationEffectDataPair._fxPlayer != null)
			{
				PlayFX_Internal(animationEffectDataPair._fxPlayer, playbackSpeed.HasValue ? playbackSpeed.Value : animationEffectDataPair.playbackSpeed, animationEffectDataPair.syncNode, actorState, combo, comboPhase, cancelOnInterrupt);
			}
		}
	}

	public void StopFX(string effectName)
	{
		if (_dataPairsTable == null || !_dataPairsTable.TryGetValue(effectName, out var value))
		{
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			AnimationEffectDataPair animationEffectDataPair = value.get_Item(i);
			if (animationEffectDataPair._fxPlayer != null && animationEffectDataPair._fxPlayer.isPlaying)
			{
				animationEffectDataPair._fxPlayer.Stop();
			}
		}
	}

	protected void PlayFX_Internal(AdventureFXPlayer fxPlayer, float playbackSpeed, Transform syncNode, ActorState actorState = ActorState.Null, Combo combo = null, Combo.Phase comboPhase = Combo.Phase.All, bool cancelOnInterrupt = false)
	{
		fxPlayer.Play(playbackSpeed);
		fxPlayer.bindVisible = true;
		fxPlayer.Bind(gameObject, null, actorState, combo, comboPhase, cancelOnInterrupt);
		if (syncNode != null)
		{
			fxPlayer.syncSlotRotation = true;
			fxPlayer.syncSlotScale = false;
			fxPlayer.syncNode = syncNode;
		}
	}

	internal void StopFXOnDied()
	{
		for (int i = 0; i < dataPairs.Length; i++)
		{
			AnimationEffectDataPair animationEffectDataPair = dataPairs[i];
			if (animationEffectDataPair.stopOnDied && animationEffectDataPair._fxPlayer != null && animationEffectDataPair._fxPlayer.isPlaying)
			{
				animationEffectDataPair._fxPlayer.Stop();
			}
		}
	}

	public void Play_FX(AnimationEvent animEvt)
	{
		if (!string.IsNullOrEmpty(animEvt.stringParameter))
		{
			PlayFX(animEvt.stringParameter, animEvt.floatParameter, ActorState.Null, null, Combo.Phase.All, cancelOnInterrupt: true);
		}
	}

	public void Stop_FX(AnimationEvent animEvt)
	{
		if (!string.IsNullOrEmpty(animEvt.stringParameter))
		{
			StopFX(animEvt.stringParameter);
		}
	}
}
