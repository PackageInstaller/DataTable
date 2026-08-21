using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Dorm;

public class DormStoryManager
{
	private static DormStoryManager m_instance;

	private GameObject m_timeline;

	private int[] m_actors_index;

	private Dictionary<int, GameObject> m_actors;

	private Dictionary<string, GameObject> m_action_timelines;

	public static DormStoryManager instance
	{
		get
		{
			if (m_instance == null)
			{
				m_instance = new DormStoryManager();
			}
			return m_instance;
		}
	}

	public bool hasInited { get; private set; }

	public void Play(string path, int[] actors)
	{
		m_actors_index = actors;
		if (!string.IsNullOrEmpty(path))
		{
			m_timeline = Asset.Instantiate(path);
		}
		for (int i = 0; i < actors.Length; i++)
		{
			CreateActor(actors[i], $"CharDorm/{actors[i]}_tpose");
		}
		hasInited = true;
	}

	public void Play(string path, int[] actorIDs, string[] actorPath)
	{
		m_actors_index = actorIDs;
		if (!string.IsNullOrEmpty(path))
		{
			m_timeline = Asset.Instantiate(path);
		}
		for (int i = 0; i < actorIDs.Length; i++)
		{
			CreateActor(actorIDs[i], actorPath[i]);
		}
		hasInited = true;
	}

	public void SetActor(int actorID, GameObject actorObj)
	{
		actorObj.SetActive(value: false);
		if (m_timeline != null)
		{
			actorObj.transform.SetParent(m_timeline.transform);
		}
		if (m_actors == null)
		{
			m_actors = new Dictionary<int, GameObject>();
		}
		m_actors[actorID] = actorObj;
	}

	private void CreateActor(int actorId, string actorPath)
	{
		if (actorId > 0)
		{
			GameObject gameObject = Asset.InstantiateWithoutCache(actorPath);
			if (!(gameObject == null))
			{
				SetActor(actorId, gameObject);
			}
		}
	}

	public GameObject PlayTimeline(int actor_index, string action_prefab, bool appleRootMotion)
	{
		GameObject actorGoByIndex = GetActorGoByIndex(actor_index);
		if (actorGoByIndex == null)
		{
			return null;
		}
		Animator component = actorGoByIndex.GetComponent<Animator>();
		component.enabled = true;
		component.applyRootMotion = appleRootMotion;
		GameObject gameObject = Asset.InstantiateWithoutCache(action_prefab);
		if (gameObject == null)
		{
			return null;
		}
		PlayableDirector component2 = gameObject.transform.Find("Timeline").gameObject.GetComponent<PlayableDirector>();
		TimelineAsset timelineAsset = component2.playableAsset as TimelineAsset;
		int outputTrackCount = timelineAsset.outputTrackCount;
		string key = $"{actor_index}_action";
		for (int i = 0; i < outputTrackCount; i++)
		{
			if (timelineAsset.GetOutputTrack(i) is AnimationTrack animationTrack)
			{
				component2.SetGenericBinding(animationTrack, component);
				key = ((animationTrack.avatarMask != null) ? $"{actor_index}_face" : $"{actor_index}_action");
			}
		}
		if (m_timeline != null)
		{
			gameObject.transform.SetParent(m_timeline.transform);
		}
		component2.time = 0.0;
		component2.Play();
		if (m_action_timelines == null)
		{
			m_action_timelines = new Dictionary<string, GameObject>();
		}
		if (m_action_timelines.ContainsKey(key) && m_action_timelines[key] != null)
		{
			DestroyGo(m_action_timelines[key], 0.1f);
		}
		m_action_timelines[key] = gameObject;
		return gameObject;
	}

	public GameObject GetActorGoByIndex(int index)
	{
		if (index >= m_actors_index.Length || index < 0)
		{
			return null;
		}
		int key = m_actors_index[index];
		if (!m_actors.ContainsKey(key))
		{
			return null;
		}
		return m_actors[key];
	}

	public void Dispose()
	{
		if (m_timeline != null)
		{
			Object.Destroy(m_timeline);
		}
		if (m_actors != null)
		{
			foreach (GameObject value in m_actors.Values)
			{
				DestroyGo(value);
			}
			m_actors.Clear();
		}
		if (m_action_timelines != null)
		{
			foreach (GameObject value2 in m_action_timelines.Values)
			{
				DestroyGo(value2);
			}
			m_action_timelines.Clear();
		}
		m_timeline = null;
		m_actors = null;
		m_action_timelines = null;
		hasInited = false;
	}

	public void DestroyGo(GameObject go, float delay = 0f)
	{
		if (Application.isPlaying)
		{
			Object.Destroy(go, delay);
		}
		else
		{
			Object.DestroyImmediate(go);
		}
	}
}
