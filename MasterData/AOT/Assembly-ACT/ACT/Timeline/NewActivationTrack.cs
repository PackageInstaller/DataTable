using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
[TrackClipType(typeof(NewActivationPlayableAsset))]
[TrackBindingType(typeof(GameObject))]
[ExcludeFromPreset]
public class NewActivationTrack : TrackAsset
{
	public enum PostPlaybackState
	{
		Active,
		Inactive,
		Revert,
		LeaveAsIs
	}

	[SerializeField]
	private PostPlaybackState m_PostPlaybackState = PostPlaybackState.LeaveAsIs;

	private NewActivationMixerPlayable m_ActivationMixer;

	public PostPlaybackState postPlaybackState
	{
		get
		{
			return m_PostPlaybackState;
		}
		set
		{
			m_PostPlaybackState = value;
			UpdateTrackMode();
		}
	}

	public override bool CanCreateTrackMixer()
	{
		return true;
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<NewActivationMixerPlayable> scriptPlayable = NewActivationMixerPlayable.Create(graph, inputCount);
		m_ActivationMixer = scriptPlayable.GetBehaviour();
		UpdateTrackMode();
		return scriptPlayable;
	}

	internal void UpdateTrackMode()
	{
		if (m_ActivationMixer != null)
		{
			m_ActivationMixer.postPlaybackState = m_PostPlaybackState;
		}
	}

	public override void GatherProperties(PlayableDirector director, IPropertyCollector driver)
	{
		GameObject gameObject = NewGetGameObjectBinding(director);
		if (gameObject != null)
		{
			driver.AddFromName(gameObject, "m_IsActive");
		}
	}

	protected override void OnCreateClip(TimelineClip clip)
	{
		clip.displayName = "Active";
		base.OnCreateClip(clip);
	}

	internal GameObject NewGetGameObjectBinding(PlayableDirector director)
	{
		if (director == null)
		{
			return null;
		}
		UnityEngine.Object genericBinding = director.GetGenericBinding(this);
		GameObject gameObject = genericBinding as GameObject;
		if (gameObject != null)
		{
			return gameObject;
		}
		Component component = genericBinding as Component;
		if (component != null)
		{
			return component.gameObject;
		}
		return null;
	}
}
