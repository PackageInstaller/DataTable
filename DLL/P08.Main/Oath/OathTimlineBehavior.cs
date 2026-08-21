using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Playables;

namespace Oath;

public class OathTimlineBehavior : SerializedMonoBehaviour
{
	[SerializeField]
	private HeroUITimelineBrain m_brain;

	public PlayableDirector executePlayable;

	private Dictionary<string, GameObject> m_playableDirectorGos;

	public HeroUITimelineBrain brain => m_brain;

	public void CloseExcutePlayable()
	{
		if ((bool)executePlayable)
		{
			executePlayable.Stop();
			executePlayable.gameObject.SetActive(value: false);
		}
		executePlayable = null;
	}

	public bool CheckIsPlayingTargetTimeline(string timeLineName)
	{
		if ((bool)executePlayable && executePlayable.name == timeLineName)
		{
			return true;
		}
		return false;
	}

	public void Awake()
	{
		m_brain = base.transform.GetComponent<HeroUITimelineBrain>();
		if (m_brain == null)
		{
			m_brain = base.transform.gameObject.AddComponent<HeroUITimelineBrain>();
		}
	}

	public void PlayTimeline(string timeLineName, out PlayableDirector playable, DirectorWrapMode extrapolationMode = DirectorWrapMode.None)
	{
		playable = new PlayableDirector();
		GameObject gameObject = null;
		if (!CheckIsPlayingTargetTimeline(timeLineName))
		{
			if ((bool)executePlayable)
			{
				executePlayable.Stop();
				executePlayable.gameObject.SetActive(value: false);
			}
			if (m_playableDirectorGos == null)
			{
				m_playableDirectorGos = new Dictionary<string, GameObject>();
			}
			int characterID = OathSceneLoader.Scene.context.characterID;
			if (!m_playableDirectorGos.ContainsKey(timeLineName))
			{
				gameObject = Object.Instantiate(Asset.Load<GameObject>(string.Format("{0}/{1}/{2}", "UITimeLine/Charactor", characterID, timeLineName)));
				gameObject.name = timeLineName;
				m_playableDirectorGos.Add(timeLineName, gameObject);
				gameObject.transform.SetParent(base.transform);
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
				gameObject.transform.localScale = Vector3.one;
			}
			else
			{
				gameObject = m_playableDirectorGos[timeLineName];
			}
			gameObject.SetActive(value: true);
			playable = gameObject.GetComponent<PlayableDirector>();
			playable.extrapolationMode = extrapolationMode;
			brain.BindPlayableDirector(playable);
			brain.RebuildPlayableDirector(playable);
			playable.Play();
			playable.Evaluate();
			executePlayable = playable;
		}
	}

	public void BindTargetDragTimeLine(string dragAnimName, out PlayableDirector playable)
	{
		playable = new PlayableDirector();
		GameObject gameObject = executePlayable.transform.Find(dragAnimName)?.gameObject;
		playable = gameObject.GetComponent<PlayableDirector>();
		brain.BindPlayableDirector(playable);
		brain.RebuildPlayableDirector(playable);
		playable.Play();
		playable.Evaluate();
	}
}
