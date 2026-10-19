using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.UI;

public class CharacterSkinEffectDressCueReceiver : MonoBehaviour
{
	private struct MotionCueRuntimeSample
	{
		public EffectDressRuntime runtime;

		public int stateHash;

		public float normalizedTime;

		public bool hasSample;
	}

	private CharacterSkinViewScene _scene;

	private Animator _animator;

	private EffectDressRuntimeState _state;

	private int _runtimeVersion = -1;

	private readonly List<MotionCueRuntimeSample> _motionCueSamples = new List<MotionCueRuntimeSample>();

	public void Bind(CharacterSkinViewScene scene, Animator animator, EffectDressRuntimeState state)
	{
		_scene = scene;
		_animator = animator;
		_state = state;
		ResetCueState();
	}

	private void Update()
	{
		if (_scene == null || _animator == null || _state == null)
		{
			return;
		}
		if (_state.runtimeVersion != _runtimeVersion)
		{
			RebuildMotionRuntimes();
		}
		if (_motionCueSamples.Count != 0)
		{
			for (int i = 0; i < _motionCueSamples.Count; i++)
			{
				TryFireRuntimeCue(i);
			}
		}
	}

	private void TryFireRuntimeCue(int sampleIndex)
	{
		MotionCueRuntimeSample value = _motionCueSamples[sampleIndex];
		EffectDressRuntime runtime = value.runtime;
		if (runtime == null || runtime.runtimeType != EffectDressRuntimeType.MotionFootprint || runtime.systemAnimatorStateHash == 0 || string.IsNullOrEmpty(runtime.cueKey))
		{
			return;
		}
		int systemCueLayerIndex = runtime.systemCueLayerIndex;
		if (systemCueLayerIndex < 0 || systemCueLayerIndex >= _animator.layerCount || _animator.IsInTransition(systemCueLayerIndex))
		{
			return;
		}
		AnimatorStateInfo currentAnimatorStateInfo = _animator.GetCurrentAnimatorStateInfo(systemCueLayerIndex);
		if (TryMatchState(currentAnimatorStateInfo, runtime.systemAnimatorStateHash, out var sampleStateHash))
		{
			float normalizedTime = currentAnimatorStateInfo.normalizedTime;
			if (!value.hasSample || value.stateHash != sampleStateHash)
			{
				value.hasSample = true;
				value.stateHash = sampleStateHash;
				value.normalizedTime = normalizedTime;
				_motionCueSamples[sampleIndex] = value;
				FireInitialCues(runtime);
			}
			else
			{
				FireCrossedCues(runtime, value.normalizedTime, normalizedTime);
				value.normalizedTime = normalizedTime;
				_motionCueSamples[sampleIndex] = value;
			}
		}
	}

	private void FireInitialCues(EffectDressRuntime runtime)
	{
		float[] systemCueNormalizedTimes = runtime.systemCueNormalizedTimes;
		if (systemCueNormalizedTimes != null)
		{
			for (int i = 0; i < systemCueNormalizedTimes.Length && !(systemCueNormalizedTimes[i] > 0f); i++)
			{
				_scene.FireEffectDressCue(runtime.cueKey);
			}
		}
	}

	private void FireCrossedCues(EffectDressRuntime runtime, float lastNormalizedTime, float normalizedTime)
	{
		float[] systemCueNormalizedTimes = runtime.systemCueNormalizedTimes;
		if (systemCueNormalizedTimes == null)
		{
			return;
		}
		for (int i = 0; i < systemCueNormalizedTimes.Length; i++)
		{
			if (DidCrossCueTime(lastNormalizedTime, normalizedTime, systemCueNormalizedTimes[i]))
			{
				_scene.FireEffectDressCue(runtime.cueKey);
			}
		}
	}

	private void ResetCueState()
	{
		_runtimeVersion = -1;
		_motionCueSamples.Clear();
	}

	private void RebuildMotionRuntimes()
	{
		_runtimeVersion = _state.runtimeVersion;
		_motionCueSamples.Clear();
		foreach (EffectDressRuntime value in _state.activeRuntimes.Values)
		{
			if (value.runtimeType == EffectDressRuntimeType.MotionFootprint && value.systemAnimatorStateHash != 0 && !string.IsNullOrEmpty(value.cueKey) && value.systemCueNormalizedTimes != null && value.systemCueNormalizedTimes.Length != 0)
			{
				_motionCueSamples.Add(new MotionCueRuntimeSample
				{
					runtime = value
				});
			}
		}
	}

	private static bool TryMatchState(AnimatorStateInfo stateInfo, int stateHash, out int sampleStateHash)
	{
		sampleStateHash = stateInfo.fullPathHash;
		if (stateInfo.fullPathHash != stateHash)
		{
			return stateInfo.shortNameHash == stateHash;
		}
		return true;
	}

	private static bool DidCrossCueTime(float previousNormalizedTime, float currentNormalizedTime, float cueNormalizedTime)
	{
		int num = Mathf.FloorToInt(previousNormalizedTime);
		int num2 = Mathf.FloorToInt(currentNormalizedTime);
		float num3 = previousNormalizedTime - (float)num;
		float num4 = currentNormalizedTime - (float)num2;
		if (currentNormalizedTime < previousNormalizedTime)
		{
			return num4 >= cueNormalizedTime;
		}
		if (num2 == num)
		{
			if (num3 < cueNormalizedTime)
			{
				return num4 >= cueNormalizedTime;
			}
			return false;
		}
		if (num3 < cueNormalizedTime)
		{
			return true;
		}
		return num4 >= cueNormalizedTime;
	}
}
