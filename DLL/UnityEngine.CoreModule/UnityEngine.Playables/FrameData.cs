using System;

namespace UnityEngine.Playables;

public struct FrameData
{
	[Flags]
	internal enum Flags
	{
		Evaluate = 1,
		SeekOccured = 2,
		Loop = 4,
		Hold = 8,
		EffectivePlayStateDelayed = 0x10,
		EffectivePlayStatePlaying = 0x20
	}

	public enum EvaluationType
	{
		Evaluate,
		Playback
	}

	internal ulong m_FrameID;

	internal double m_DeltaTime;

	internal float m_Weight;

	internal float m_EffectiveWeight;

	internal double m_EffectiveParentDelay;

	internal float m_EffectiveParentSpeed;

	internal float m_EffectiveSpeed;

	internal Flags m_Flags;

	internal PlayableOutput m_Output;

	public ulong frameId => m_FrameID;

	public float deltaTime => (float)m_DeltaTime;

	public float weight => m_Weight;

	public float effectiveWeight => m_EffectiveWeight;

	[Obsolete("effectiveParentDelay is obsolete; use a custom ScriptPlayable to implement this feature", false)]
	public double effectiveParentDelay => m_EffectiveParentDelay;

	public float effectiveParentSpeed => m_EffectiveParentSpeed;

	public float effectiveSpeed => m_EffectiveSpeed;

	public EvaluationType evaluationType => (!HasFlags(Flags.Evaluate)) ? EvaluationType.Playback : EvaluationType.Evaluate;

	public bool seekOccurred => HasFlags(Flags.SeekOccured);

	public bool timeLooped => HasFlags(Flags.Loop);

	public bool timeHeld => HasFlags(Flags.Hold);

	public PlayableOutput output => m_Output;

	public PlayState effectivePlayState
	{
		get
		{
			if (HasFlags(Flags.EffectivePlayStateDelayed))
			{
				return PlayState.Delayed;
			}
			if (HasFlags(Flags.EffectivePlayStatePlaying))
			{
				return PlayState.Playing;
			}
			return PlayState.Paused;
		}
	}

	private bool HasFlags(Flags flag)
	{
		return (m_Flags & flag) == flag;
	}
}
