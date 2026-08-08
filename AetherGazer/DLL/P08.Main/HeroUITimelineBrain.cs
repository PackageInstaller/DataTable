using System;
using System.Collections.Generic;
using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;
using UnityEngine.Timeline;

public class HeroUITimelineBrain : MonoBehaviour
{
	public bool isPoseLooping;

	public string talking;

	private GameObject _charGo;

	private static List<GameObject> _cacheList = new List<GameObject>();

	private bool isDlc
	{
		get
		{
			if (!base.gameObject.name.Contains("custom"))
			{
				return base.gameObject.tag.Equals("DLCCharacter");
			}
			return true;
		}
	}

	public GameObject GetCharModelGo()
	{
		if (_charGo == null)
		{
			Animator componentInChildren = base.gameObject.GetComponentInChildren<Animator>();
			if (componentInChildren == null)
			{
				Debug.LogError(base.gameObject.name + "无法找到角色模型GameObject");
			}
			_charGo = componentInChildren.gameObject;
		}
		return _charGo;
	}

	public void BindPlayableDirector(PlayableDirector pd)
	{
		TimelineAsset timelineAsset = pd.playableAsset as TimelineAsset;
		if (timelineAsset == null)
		{
			Debug.LogError(base.gameObject.name + " could not bind timeline for " + pd.gameObject.name);
			return;
		}
		for (int i = 0; i < timelineAsset.outputTrackCount; i++)
		{
			TrackAsset outputTrack = timelineAsset.GetOutputTrack(i);
			if (outputTrack.mutedInHierarchy)
			{
				continue;
			}
			Type type = outputTrack.GetType();
			TrackBindingTypeAttribute trackBindingTypeAttribute = (TrackBindingTypeAttribute)Attribute.GetCustomAttribute(type, typeof(TrackBindingTypeAttribute));
			if (trackBindingTypeAttribute == null)
			{
				continue;
			}
			_ = type.Name;
			Type type2 = trackBindingTypeAttribute.type;
			if (type2 == typeof(HeroUITimelineBrain))
			{
				pd.SetGenericBinding(outputTrack, this);
			}
			else if (type2 == typeof(Animator))
			{
				BindAnimator(pd, outputTrack);
			}
			else if (type2 == typeof(CharacterEffect))
			{
				BindCharacterEffect(pd, outputTrack);
			}
			else if (type2 == typeof(CharacterEffectOverrider))
			{
				BindCharacterEffectOverrider(pd, outputTrack);
			}
			else if (type2 == typeof(CriLipsExPlayer))
			{
				BindCriLipsExPlayer(pd, outputTrack);
			}
			else if (type2 == typeof(SceneSetting))
			{
				BindSceneSeting(pd, outputTrack);
			}
			if (outputTrack.GetMarkerCount() <= 0)
			{
				continue;
			}
			U3DUtil.Get<HeroUITimelineSignalReceiver>(pd.gameObject).brain = this;
			foreach (IMarker marker in outputTrack.GetMarkers())
			{
				if (marker is IHeroUITimelineMarker heroUITimelineMarker)
				{
					heroUITimelineMarker.OnBindingTrack(new HeroUITimelineMarkerContext
					{
						brain = this,
						track = outputTrack
					});
				}
			}
		}
	}

	public void RebuildPlayableDirector(PlayableDirector pd)
	{
		pd.RebuildGraph();
		HeroUITimelineSignalReceiver component = pd.gameObject.GetComponent<HeroUITimelineSignalReceiver>();
		if (!(component != null))
		{
			return;
		}
		PlayableGraph playableGraph = pd.playableGraph;
		int outputCount = playableGraph.GetOutputCount();
		for (int i = 0; i < outputCount; i++)
		{
			PlayableOutput output = playableGraph.GetOutput(i);
			output.AddNotificationReceiver(component);
			TrackAsset trackAsset = output.GetReferenceObject() as TrackAsset;
			if (!(trackAsset != null))
			{
				continue;
			}
			component.trackOutputIndex[trackAsset] = i;
			if (trackAsset.GetMarkerCount() <= 0)
			{
				continue;
			}
			foreach (IMarker marker in trackAsset.GetMarkers())
			{
				if (marker is IHeroUITimelineMarker heroUITimelineMarker)
				{
					heroUITimelineMarker.AfterBuildGraph(new HeroUITimelineMarkerContext
					{
						brain = this,
						track = trackAsset,
						output = output
					});
				}
			}
		}
		playableGraph.Evaluate(0f);
	}

	public GameObject FindTarget(string targetPath, Transform extraTrans = null)
	{
		if (string.IsNullOrEmpty(targetPath))
		{
			return null;
		}
		Transform transform = null;
		transform = base.transform.Find(targetPath);
		if (transform != null)
		{
			return transform.gameObject;
		}
		transform = ((extraTrans != null) ? extraTrans.Find(targetPath) : null);
		if (transform != null)
		{
			return transform.gameObject;
		}
		GameObject gameObject = GameObject.Find(targetPath);
		if (gameObject != null)
		{
			return gameObject;
		}
		int sceneCount = SceneManager.sceneCount;
		for (int i = 1; i < sceneCount; i++)
		{
			SceneManager.GetSceneAt(i).GetRootGameObjects(_cacheList);
			foreach (GameObject cache in _cacheList)
			{
				transform = cache.transform.Find(targetPath);
				if (transform != null)
				{
					return transform.gameObject;
				}
			}
		}
		return null;
	}

	private void BindAnimator(PlayableDirector pd, TrackAsset track)
	{
		GameObject gameObject = FindBindTarget(pd, track);
		if (!(gameObject == null))
		{
			Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
			BindTrack(pd, track, componentInChildren);
		}
	}

	private void BindCharacterEffect(PlayableDirector pd, TrackAsset track)
	{
		GameObject gameObject = FindBindTarget(pd, track);
		if (!(gameObject == null))
		{
			CharacterEffect componentInChildren = gameObject.GetComponentInChildren<CharacterEffect>();
			BindTrack(pd, track, componentInChildren);
		}
	}

	private void BindCharacterEffectOverrider(PlayableDirector pd, TrackAsset track)
	{
		GameObject gameObject = FindBindTarget(pd, track);
		if (!(gameObject == null))
		{
			CharacterEffectOverrider characterEffectOverrider = gameObject.GetComponentInChildren<CharacterEffectOverrider>();
			if (characterEffectOverrider == null)
			{
				characterEffectOverrider = gameObject.AddComponent<CharacterEffectOverrider>();
			}
			BindTrack(pd, track, characterEffectOverrider);
		}
	}

	private void BindCriLipsExPlayer(PlayableDirector pd, TrackAsset track)
	{
		GameObject gameObject = FindBindTarget(pd, track);
		if (!(gameObject == null))
		{
			CriLipsExPlayer componentInChildren = gameObject.GetComponentInChildren<CriLipsExPlayer>();
			BindTrack(pd, track, componentInChildren);
		}
	}

	private void BindSceneSeting(PlayableDirector pd, TrackAsset track)
	{
		GameObject gameObject = FindBindTarget(pd, track);
		if (!(gameObject == null))
		{
			SceneSetting componentInChildren = gameObject.GetComponentInChildren<SceneSetting>();
			BindTrack(pd, track, componentInChildren);
		}
	}

	private void BindTrack(PlayableDirector pd, TrackAsset track, UnityEngine.Object obj)
	{
		if (obj != null)
		{
			pd.SetGenericBinding(track, obj);
		}
	}

	private GameObject FindBindTarget(PlayableDirector pd, TrackAsset track)
	{
		string text = track.name;
		bool flag = text.StartsWith('@') || text.StartsWith('#') || text.StartsWith('&');
		if (!flag && pd.GetGenericBinding(track) != null)
		{
			return null;
		}
		if (flag)
		{
			string targetPath = text.Substring(1);
			GameObject gameObject = FindTarget(targetPath, pd.transform);
			if (gameObject != null)
			{
				return gameObject;
			}
			Debug.LogError("无法找到绑定对象: " + pd.gameObject.name + "的轨道" + track.GetType().Name + "(" + track.name + ")");
			return null;
		}
		if (!isDlc)
		{
			return base.gameObject;
		}
		return null;
	}

	public GameObject PlayEffect(string efxPath, string point, float duration)
	{
		GameObject gameObject = Asset.Instantiate(efxPath);
		Transform constraintTransform = base.gameObject.GetComponentInChildren<ConstraintPointGroup>().GetConstraintTransform(point);
		if ((bool)constraintTransform)
		{
			ParentConstraint parentConstraint = U3DUtil.Get<ParentConstraint>(gameObject);
			parentConstraint.SetSources(new List<ConstraintSource>
			{
				new ConstraintSource
				{
					sourceTransform = constraintTransform,
					weight = 1f
				}
			});
			parentConstraint.weight = 1f;
			parentConstraint.constraintActive = true;
		}
		EffectController component = gameObject.GetComponent<EffectController>();
		if ((bool)component)
		{
			component.Initialize(isLoop: true, duration, 1f, EEffectQuality.Low, null);
			component.Simulator(0f);
		}
		return gameObject;
	}

	public void StopEffect(GameObject efxGo)
	{
		EffectController component = efxGo.GetComponent<EffectController>();
		if ((bool)component)
		{
			component.Stop();
		}
	}
}
