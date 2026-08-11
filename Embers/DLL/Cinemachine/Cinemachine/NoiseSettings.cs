using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineNoiseProfiles.html")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public sealed class NoiseSettings : SignalSourceAsset
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct NoiseParams
	{
		[Tooltip("The frequency of noise for this channel.  Higher magnitudes vibrate faster.")]
		public float Frequency;

		[Tooltip("The amplitude of the noise for this channel.  Larger numbers vibrate higher.")]
		public float Amplitude;

		[Tooltip("If checked, then the amplitude and frequency will not be randomized.")]
		public bool Constant;

		public float GetValueAt(float time, float timeOffset)
		{
			float num = Frequency * time + timeOffset;
			if (Constant)
			{
				return Mathf.Cos(num * 2f * MathF.PI) * Amplitude * 0.5f;
			}
			return (Mathf.PerlinNoise(num, 0f) - 0.5f) * Amplitude;
		}
	}

	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct TransformNoiseParams
	{
		[Tooltip("Noise definition for X-axis")]
		public NoiseParams X;

		[Tooltip("Noise definition for Y-axis")]
		public NoiseParams Y;

		[Tooltip("Noise definition for Z-axis")]
		public NoiseParams Z;

		public Vector3 GetValueAt(float time, Vector3 timeOffsets)
		{
			return new Vector3(X.GetValueAt(time, timeOffsets.x), Y.GetValueAt(time, timeOffsets.y), Z.GetValueAt(time, timeOffsets.z));
		}
	}

	[Tooltip("These are the noise channels for the virtual camera's position. Convincing noise setups typically mix low, medium and high frequencies together, so start with a size of 3")]
	[FormerlySerializedAs("m_Position")]
	public TransformNoiseParams[] PositionNoise = Array.Empty<TransformNoiseParams>();

	[Tooltip("These are the noise channels for the virtual camera's orientation. Convincing noise setups typically mix low, medium and high frequencies together, so start with a size of 3")]
	[FormerlySerializedAs("m_Orientation")]
	public TransformNoiseParams[] OrientationNoise = Array.Empty<TransformNoiseParams>();

	public override float SignalDuration => 0f;

	public static Vector3 GetCombinedFilterResults(TransformNoiseParams[] noiseParams, float time, Vector3 timeOffsets)
	{
		Vector3 zero = Vector3.zero;
		if (noiseParams != null)
		{
			for (int i = 0; i < noiseParams.Length; i++)
			{
				zero += noiseParams[i].GetValueAt(time, timeOffsets);
			}
		}
		return zero;
	}

	public override void GetSignal(float timeSinceSignalStart, out Vector3 pos, out Quaternion rot)
	{
		pos = GetCombinedFilterResults(PositionNoise, timeSinceSignalStart, Vector3.zero);
		rot = Quaternion.Euler(GetCombinedFilterResults(OrientationNoise, timeSinceSignalStart, Vector3.zero));
	}
}
