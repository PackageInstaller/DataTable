using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.InputSystem.XInput;

namespace ACT.Battle;

public static class GamepadRumbleManager
{
	private struct RumbleEntry
	{
		public float Duration;

		public float Multiplier;

		public bool Loop;

		public float LoopTime;

		public float Elapsed;

		public float TotalElapsed;

		public MotorIntensities Intensities;

		public int InsertionOrder;
	}

	private static readonly Dictionary<GamepadRumbleCurvePreset, RumbleEntry> s_ActiveRumbles = new Dictionary<GamepadRumbleCurvePreset, RumbleEntry>();

	private static CancellationTokenSource s_GlobalCts;

	private static int s_InsertionCounter;

	public static void Play(GamepadRumbleCurvePreset preset, float duration, float multiplier, bool loop = false, float loopTime = -1f, bool forceRestart = false)
	{
		if (!(preset == null))
		{
			RumbleEntry value;
			if (loop && Mathf.Approximately(loopTime, 0f))
			{
				s_ActiveRumbles.Remove(preset);
			}
			else if (!(!forceRestart & loop) || !s_ActiveRumbles.TryGetValue(preset, out value) || !value.Loop)
			{
				s_ActiveRumbles[preset] = new RumbleEntry
				{
					Duration = duration,
					Multiplier = multiplier,
					Loop = loop,
					LoopTime = loopTime,
					Elapsed = 0f,
					TotalElapsed = 0f,
					Intensities = MotorIntensities.Zero,
					InsertionOrder = ++s_InsertionCounter
				};
				EnsureUpdateLoopRunning();
			}
		}
	}

	public static void Stop(GamepadRumbleCurvePreset preset)
	{
		if (!(preset == null))
		{
			s_ActiveRumbles.Remove(preset);
		}
	}

	public static void StopAll()
	{
		s_ActiveRumbles.Clear();
		s_GlobalCts?.Cancel();
		s_GlobalCts?.Dispose();
		s_GlobalCts = null;
		Gamepad current = Gamepad.current;
		if (current != null)
		{
			StopAllMotors(current);
		}
	}

	private static void EnsureUpdateLoopRunning()
	{
		if (s_GlobalCts == null || s_GlobalCts.IsCancellationRequested)
		{
			s_GlobalCts = new CancellationTokenSource();
			UpdateLoopAsync(s_GlobalCts.Token).Forget();
		}
	}

	private static async UniTaskVoid UpdateLoopAsync(CancellationToken token)
	{
		List<GamepadRumbleCurvePreset> toRemove = new List<GamepadRumbleCurvePreset>();
		List<GamepadRumbleCurvePreset> keys = new List<GamepadRumbleCurvePreset>();
		while (s_ActiveRumbles.Count > 0 && !token.IsCancellationRequested)
		{
			await UniTask.Yield(PlayerLoopTiming.Update, token);
			if (token.IsCancellationRequested)
			{
				break;
			}
			float deltaTime = Time.deltaTime;
			toRemove.Clear();
			keys.Clear();
			keys.AddRange(s_ActiveRumbles.Keys);
			bool usePS = Gamepad.current is DualShockGamepad;
			foreach (GamepadRumbleCurvePreset item in keys)
			{
				RumbleEntry value = s_ActiveRumbles[item];
				value.Elapsed += deltaTime;
				value.TotalElapsed += deltaTime;
				if (value.Elapsed >= value.Duration)
				{
					if (!value.Loop)
					{
						toRemove.Add(item);
						continue;
					}
					value.Elapsed -= value.Duration;
				}
				if (value.Loop && value.LoopTime > 0f && value.TotalElapsed >= value.LoopTime)
				{
					toRemove.Add(item);
					continue;
				}
				float normalizedTime = value.Elapsed / value.Duration;
				value.Intensities = item.EvaluateAll(normalizedTime, usePS).Scale(value.Multiplier);
				s_ActiveRumbles[item] = value;
			}
			foreach (GamepadRumbleCurvePreset item2 in toRemove)
			{
				s_ActiveRumbles.Remove(item2);
			}
			Gamepad current3 = Gamepad.current;
			if (current3 != null)
			{
				ApplyTopPriority(current3);
			}
		}
		s_GlobalCts = null;
		Gamepad current4 = Gamepad.current;
		if (current4 != null)
		{
			StopAllMotors(current4);
		}
	}

	private static void ApplyTopPriority(Gamepad gamepad)
	{
		if (s_ActiveRumbles.Count == 0)
		{
			StopAllMotors(gamepad);
			return;
		}
		GamepadRumbleCurvePreset gamepadRumbleCurvePreset = null;
		int num = -1;
		foreach (KeyValuePair<GamepadRumbleCurvePreset, RumbleEntry> s_ActiveRumble in s_ActiveRumbles)
		{
			RumbleEntry rumbleEntry = s_ActiveRumbles[s_ActiveRumble.Key];
			if (gamepadRumbleCurvePreset == null || s_ActiveRumble.Key.priority > gamepadRumbleCurvePreset.priority || (s_ActiveRumble.Key.priority == gamepadRumbleCurvePreset.priority && rumbleEntry.InsertionOrder > num))
			{
				gamepadRumbleCurvePreset = s_ActiveRumble.Key;
				num = rumbleEntry.InsertionOrder;
			}
		}
		if (gamepadRumbleCurvePreset != null)
		{
			ApplyMotorSpeeds(gamepad, s_ActiveRumbles[gamepadRumbleCurvePreset].Intensities);
		}
	}

	private static void ApplyMotorSpeeds(Gamepad gamepad, MotorIntensities intensities)
	{
		if (gamepad is IXboxOneRumble xboxOneRumble)
		{
			xboxOneRumble.SetMotorSpeeds(Mathf.Clamp01(intensities.leftLow), Mathf.Clamp01(intensities.rightHigh), Mathf.Clamp01(intensities.leftTrigger), Mathf.Clamp01(intensities.rightTrigger));
		}
		else
		{
			gamepad.SetMotorSpeeds(Mathf.Clamp01(intensities.leftLow), Mathf.Clamp01(intensities.rightHigh));
		}
	}

	private static void StopAllMotors(Gamepad gamepad)
	{
		if (gamepad is IXboxOneRumble xboxOneRumble)
		{
			xboxOneRumble.SetMotorSpeeds(0f, 0f, 0f, 0f);
		}
		else
		{
			gamepad.SetMotorSpeeds(0f, 0f);
		}
	}
}
