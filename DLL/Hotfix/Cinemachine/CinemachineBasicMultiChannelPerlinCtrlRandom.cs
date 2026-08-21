using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineBasicMultiChannelPerlinCtrlRandom : CinemachineComponentBase
{
	[Tooltip("The asset containing the Noise Profile.  Define the frequencies and amplitudes there to make a characteristic noise profile.  Make your own or just use one of the many presets.")]
	[FormerlySerializedAs("m_Definition")]
	[NoiseSettingsProperty]
	public NoiseSettings m_NoiseProfile;

	[Tooltip("When rotating the camera, offset the camera's pivot position by this much (camera space)")]
	public Vector3 m_PivotOffset = Vector3.zero;

	[Tooltip("Gain to apply to the amplitudes defined in the NoiseSettings asset.  1 is normal.  Setting this to 0 completely mutes the noise.")]
	public float m_AmplitudeGain = 1f;

	[Tooltip("Scale factor to apply to the frequencies defined in the NoiseSettings asset.  1 is normal.  Larger magnitudes will make the noise shake more rapidly.")]
	public float m_FrequencyGain = 1f;

	public bool UseRandomNoise;

	private bool mInitialized;

	private float mNoiseTime;

	[SerializeField]
	[HideInInspector]
	private Vector3 mNoiseOffsets = Vector3.zero;

	public override bool IsValid
	{
		get
		{
			if (base.enabled)
			{
				return m_NoiseProfile != null;
			}
			return false;
		}
	}

	public override CinemachineCore.Stage Stage => CinemachineCore.Stage.Noise;

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (!IsValid || deltaTime < 0f)
		{
			mInitialized = false;
			return;
		}
		if (!mInitialized)
		{
			Initialize();
		}
		mNoiseTime += deltaTime * m_FrequencyGain;
		Vector3 combinedFilterResults = NoiseSettings.GetCombinedFilterResults(m_NoiseProfile.PositionNoise, mNoiseTime, mNoiseOffsets);
		curState.PositionCorrection += curState.CorrectedOrientation * combinedFilterResults * m_AmplitudeGain;
		Quaternion quaternion = Quaternion.Euler(NoiseSettings.GetCombinedFilterResults(m_NoiseProfile.OrientationNoise, mNoiseTime, mNoiseOffsets) * m_AmplitudeGain);
		if (m_PivotOffset != Vector3.zero)
		{
			Matrix4x4 matrix4x = Matrix4x4.Translate(-m_PivotOffset);
			matrix4x = Matrix4x4.Rotate(quaternion) * matrix4x;
			matrix4x = Matrix4x4.Translate(m_PivotOffset) * matrix4x;
			curState.PositionCorrection += curState.CorrectedOrientation * matrix4x.MultiplyPoint(Vector3.zero);
		}
		curState.OrientationCorrection *= quaternion;
	}

	public void ReSeed()
	{
		if (UseRandomNoise)
		{
			mNoiseOffsets = new Vector3(Random.Range(-1000f, 1000f), Random.Range(-1000f, 1000f), Random.Range(-1000f, 1000f));
			mNoiseTime = CinemachineCore.CurrentTime * m_FrequencyGain;
		}
		else
		{
			mNoiseOffsets = Vector3.zero;
			mNoiseTime = 1f;
		}
	}

	private void Initialize()
	{
		mInitialized = true;
		ReSeed();
	}
}
