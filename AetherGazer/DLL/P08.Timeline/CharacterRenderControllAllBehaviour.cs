using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class CharacterRenderControllAllBehaviour : PlayableBehaviour
{
	public GameObject controlObject;

	public bool active;

	public ActivationControlPlayable.PostPlaybackState postPlayback;

	public int controlCfg;

	private CharacterRenderController _controller;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		_controller = controlObject.GetComponentInChildren<CharacterRenderController>();
		if (_controller == null)
		{
			Debug.LogError("无法在" + controlObject.name + "上找到CharacterRenderController!");
		}
		else if (_controller.m_Renders.Count != 0)
		{
			_controller.SetAllRendersActiveDirectly(active ? uint.MaxValue : 0u, controlCfg);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (!(_controller == null) && _controller.m_Renders.Count != 0)
		{
			switch (postPlayback)
			{
			case ActivationControlPlayable.PostPlaybackState.Active:
				_controller.SetAllRendersActiveDirectly(uint.MaxValue, controlCfg);
				break;
			case ActivationControlPlayable.PostPlaybackState.Inactive:
				_controller.SetAllRendersActiveDirectly(0u, controlCfg);
				break;
			case ActivationControlPlayable.PostPlaybackState.Revert:
				_controller.SetAllRendersActiveDirectly(_controller.m_baseActive, controlCfg);
				break;
			}
		}
	}
}
