using Cinemachine;
using UnityEngine;

namespace Ase;

[AddComponentMenu("")]
[ExecuteAlways]
[SaveDuringPlay]
public class CinemachineBlendAdjust : CinemachineExtension
{
	public CinemachineBlendDefinition m_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);

	private CinemachineBlendDefinition previous_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);

	protected override void OnEnable()
	{
		base.OnEnable();
		if (Application.isPlaying)
		{
			CinemachineBrain cinemachineBrain = Object.FindObjectOfType<CinemachineBrain>();
			if ((bool)cinemachineBrain)
			{
				previous_Blend = (cinemachineBrain.m_DefaultBlend = m_Blend);
				cinemachineBrain.m_DefaultBlend = m_Blend;
			}
		}
	}

	private void OnDisable()
	{
		if (Application.isPlaying)
		{
			CinemachineBrain cinemachineBrain = Object.FindObjectOfType<CinemachineBrain>();
			if ((bool)cinemachineBrain)
			{
				cinemachineBrain.m_DefaultBlend = previous_Blend;
			}
		}
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
	}
}
