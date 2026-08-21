using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCameraCutTypeNodeBehaviour : PlayableBehaviour
{
	public CinemachineBlendDefinition cameraBlend;

	private CinemachineBrain brain;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		if (brain == null)
		{
			brain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		}
		if (brain != null)
		{
			if (brain.IsBlending)
			{
				brain.enabled = false;
				brain.enabled = true;
			}
			brain.m_DefaultBlend = cameraBlend;
		}
	}
}
