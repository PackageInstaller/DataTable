using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public sealed class SummerRaceCombatPresentationAudioSink : MonoBehaviour, ISummerRaceCombatPresentationSink, ISummerRaceCombatAudioSink
{
	private const float DefaultCueCooldownSeconds = 0.04f;

	private const float CollisionCueCooldownSeconds = 0.16f;

	private const float DamageTextCueCooldownSeconds = 0.05f;

	private const int OneShotPlaybackPruneThreshold = 64;

	[SerializeField]
	private bool enableAudio = true;

	private readonly Dictionary<string, float> nextCueTimeByKey = new Dictionary<string, float>(32, StringComparer.Ordinal);

	private readonly Dictionary<string, CriAtomExPlayback> loopPlaybacksByKey = new Dictionary<string, CriAtomExPlayback>(8, StringComparer.Ordinal);

	private readonly List<CriAtomExPlayback> oneShotPlaybacks = new List<CriAtomExPlayback>(16);

	private readonly List<string> playbackKeyScratch = new List<string>(8);

	private static readonly List<SummerRaceCombatPresentationAudioSink> ActiveSinks = new List<SummerRaceCombatPresentationAudioSink>(4);

	public void HandleWeaponPresentation(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		SummerRaceAudioCue cue = SummerRaceCombatAudioCueRouter.ResolveWeaponCue(presentationEvent.WeaponKind, presentationEvent.Phase);
		if (cue.IsValid)
		{
			PlayOneShot(cue, BuildEventKey("weapon", presentationEvent.SourceTransform, presentationEvent.SlotIndex, cue.CueName), 0.04f);
		}
	}

	public void HandleWeaponOverloadPresentation(SummerRaceWeaponOverloadPresentationEvent presentationEvent)
	{
	}

	public void HandleEquipPresentation(SummerRaceEquipPresentationEvent presentationEvent)
	{
		SummerRaceAudioCue cue = SummerRaceCombatAudioCueRouter.ResolveEquipCue(presentationEvent.EquipKind, presentationEvent.Phase);
		if (cue.IsValid)
		{
			PlayOneShot(cue, BuildEventKey("equip", presentationEvent.SourceTransform, presentationEvent.SlotIndex, cue.CueName), 0.04f);
		}
	}

	public void HandleProjectilePresentation(SummerRaceProjectilePresentationEvent presentationEvent)
	{
	}

	public float HandleDefeatPresentation(SummerRaceDefeatPresentationEvent presentationEvent)
	{
		SummerRaceAudioCue cue = SummerRaceCombatAudioCueRouter.ResolveDefeatCue(presentationEvent.EffectPath);
		if (cue.IsValid)
		{
			Transform sourceTransform = ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform : presentationEvent.TargetTransform);
			PlayOneShot(cue, BuildEventKey("defeat", sourceTransform, 0, cue.CueName), 0.04f);
		}
		return 0f;
	}

	public void HandleCombatAudioEvent(SummerRaceCombatAudioEvent audioEvent)
	{
		switch (audioEvent.Kind)
		{
		case SummerRaceCombatAudioEventKind.VehicleCollision:
			PlayOneShot(SummerRaceCombatAudioCueRouter.VehicleCollisionCue, BuildEventKey("vehicle_collision", audioEvent.SourceTransform, 0, SummerRaceCombatAudioCueRouter.VehicleCollisionCue.CueName), 0.16f);
			break;
		case SummerRaceCombatAudioEventKind.VehicleDriveStarted:
			PlayLoop(SummerRaceCombatAudioCueRouter.VehicleDriveCue, BuildEventKey("vehicle_drive", audioEvent.SourceTransform, 0, SummerRaceCombatAudioCueRouter.VehicleDriveCue.CueName));
			break;
		case SummerRaceCombatAudioEventKind.VehicleDriveStopped:
			StopLoop(BuildEventKey("vehicle_drive", audioEvent.SourceTransform, 0, SummerRaceCombatAudioCueRouter.VehicleDriveCue.CueName));
			break;
		case SummerRaceCombatAudioEventKind.DamageText:
			PlayOneShot(SummerRaceCombatAudioCueRouter.DamageTextCue, BuildEventKey("damage_text", audioEvent.SourceTransform, 0, SummerRaceCombatAudioCueRouter.DamageTextCue.CueName), 0.05f);
			break;
		}
	}

	public static void StopAllActiveLoops()
	{
		for (int num = ActiveSinks.Count - 1; num >= 0; num--)
		{
			SummerRaceCombatPresentationAudioSink summerRaceCombatPresentationAudioSink = ActiveSinks[num];
			if (summerRaceCombatPresentationAudioSink == null)
			{
				ActiveSinks.RemoveAt(num);
			}
			else
			{
				summerRaceCombatPresentationAudioSink.StopAllLoops();
			}
		}
	}

	public static void StopAllActivePlaybacks()
	{
		for (int num = ActiveSinks.Count - 1; num >= 0; num--)
		{
			SummerRaceCombatPresentationAudioSink summerRaceCombatPresentationAudioSink = ActiveSinks[num];
			if (summerRaceCombatPresentationAudioSink == null)
			{
				ActiveSinks.RemoveAt(num);
			}
			else
			{
				summerRaceCombatPresentationAudioSink.StopAllPlaybacks();
			}
		}
	}

	private void OnEnable()
	{
		if (!ActiveSinks.Contains(this))
		{
			ActiveSinks.Add(this);
		}
	}

	private void OnDisable()
	{
		ActiveSinks.Remove(this);
		StopAllPlaybacks();
		nextCueTimeByKey.Clear();
	}

	private void OnDestroy()
	{
		ActiveSinks.Remove(this);
		StopAllPlaybacks();
		nextCueTimeByKey.Clear();
	}

	private void PlayOneShot(SummerRaceAudioCue cue, string eventKey, float cooldownSeconds)
	{
		if (!TryResolveAudioManager(cue, out var audioManager) || IsInCooldown(eventKey, cooldownSeconds))
		{
			return;
		}
		CriAtomExPlayback item = audioManager.Play("effect", cue.CueSheet, cue.CueName, cue.UseStream);
		if (item.status != CriAtomExPlayback.Status.Removed)
		{
			oneShotPlaybacks.Add(item);
			if (oneShotPlaybacks.Count > 64)
			{
				PruneRemovedOneShotPlaybacks();
			}
		}
	}

	private void PlayLoop(SummerRaceAudioCue cue, string eventKey)
	{
		if (TryResolveAudioManager(cue, out var audioManager) && (!loopPlaybacksByKey.TryGetValue(eventKey, out var value) || value.status == CriAtomExPlayback.Status.Removed))
		{
			loopPlaybacksByKey[eventKey] = audioManager.Play("effect", cue.CueSheet, cue.CueName, cue.UseStream);
		}
	}

	private bool TryResolveAudioManager(SummerRaceAudioCue cue, out AudioManager audioManager)
	{
		audioManager = null;
		if (!enableAudio || !cue.IsValid || !Application.isPlaying)
		{
			return false;
		}
		SummerRaceFightManager instance = SummerRaceFightManager.Instance;
		if (instance != null && instance.IsCombatPresentationAudioBlocked)
		{
			return false;
		}
		audioManager = AudioManager.mInstance;
		if (audioManager == null)
		{
			if (Camera.main == null)
			{
				return false;
			}
			audioManager = AudioManager.Instance;
		}
		if (audioManager == null)
		{
			return false;
		}
		if (audioManager.mListener == null && Camera.main == null)
		{
			return false;
		}
		return true;
	}

	private void StopLoop(string eventKey)
	{
		if (!string.IsNullOrEmpty(eventKey) && loopPlaybacksByKey.TryGetValue(eventKey, out var value))
		{
			if (value.status != CriAtomExPlayback.Status.Removed)
			{
				value.Stop();
			}
			loopPlaybacksByKey.Remove(eventKey);
		}
	}

	private void StopAllLoops()
	{
		playbackKeyScratch.Clear();
		foreach (KeyValuePair<string, CriAtomExPlayback> item in loopPlaybacksByKey)
		{
			playbackKeyScratch.Add(item.Key);
		}
		for (int i = 0; i < playbackKeyScratch.Count; i++)
		{
			StopLoop(playbackKeyScratch[i]);
		}
		playbackKeyScratch.Clear();
	}

	private void StopAllOneShots()
	{
		for (int i = 0; i < oneShotPlaybacks.Count; i++)
		{
			CriAtomExPlayback criAtomExPlayback = oneShotPlaybacks[i];
			if (criAtomExPlayback.status != CriAtomExPlayback.Status.Removed)
			{
				criAtomExPlayback.Stop();
			}
		}
		oneShotPlaybacks.Clear();
	}

	private void PruneRemovedOneShotPlaybacks()
	{
		for (int num = oneShotPlaybacks.Count - 1; num >= 0; num--)
		{
			if (oneShotPlaybacks[num].status == CriAtomExPlayback.Status.Removed)
			{
				oneShotPlaybacks.RemoveAt(num);
			}
		}
	}

	private void StopAllPlaybacks()
	{
		StopAllLoops();
		StopAllOneShots();
	}

	private bool IsInCooldown(string eventKey, float cooldownSeconds)
	{
		if (string.IsNullOrEmpty(eventKey) || cooldownSeconds <= 0f)
		{
			return false;
		}
		float time = Time.time;
		if (nextCueTimeByKey.TryGetValue(eventKey, out var value) && time < value)
		{
			return true;
		}
		nextCueTimeByKey[eventKey] = time + cooldownSeconds;
		return false;
	}

	private static string BuildEventKey(string channel, Transform sourceTransform, int slotIndex, string cueName)
	{
		int num = ((sourceTransform != null) ? sourceTransform.GetInstanceID() : 0);
		return channel + "|" + num + "|" + slotIndex + "|" + (cueName ?? string.Empty);
	}
}
