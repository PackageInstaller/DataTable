using System.Collections.Generic;
using ACT.Timeline;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Drama;

public class ConversationController : LuminSerializedMonoBehaviour
{
	[SerializeField]
	private List<CharacterInfo> m_CharacterInfos = new List<CharacterInfo>();

	private PlayableDirector m_PlayableDirector;

	private List<JumpMarker> m_JumpMarkers;

	private Dictionary<int, CharacterInfo> m_CharacterDict;

	public PlayableDirector PlayableDirector => m_PlayableDirector;

	public IReadOnlyList<CharacterInfo> CharacterInfos => m_CharacterInfos;

	private void Awake()
	{
		m_JumpMarkers = ListPool<JumpMarker>.Get();
		m_PlayableDirector = GetComponent<PlayableDirector>();
		m_JumpMarkers.AddRange(GetAllMarker(m_PlayableDirector.playableAsset as TimelineAsset));
		m_CharacterDict = new Dictionary<int, CharacterInfo>();
		foreach (CharacterInfo characterInfo in m_CharacterInfos)
		{
			m_CharacterDict[characterInfo.id] = characterInfo;
		}
	}

	private void OnDestroy()
	{
		if (m_JumpMarkers != null)
		{
			ListPool<JumpMarker>.Release(m_JumpMarkers);
		}
	}

	public void JumpToMarker(string markerName)
	{
		if (string.IsNullOrEmpty(markerName))
		{
			return;
		}
		bool flag = false;
		foreach (JumpMarker jumpMarker in m_JumpMarkers)
		{
			if (!(new PropertyName(markerName) != jumpMarker.id))
			{
				PlayableDirector.Pause();
				PlayableDirector.time = jumpMarker.time;
				PlayableDirector.Play();
				flag = true;
				if (!LuminApplication.LogEnabled)
				{
				}
				break;
			}
		}
		if (!flag && LuminApplication.LogEnabled)
		{
			Debug.LogError("错误的JumpMarker！！！timeline ： " + gameObject.name + "  名字 ：" + markerName + " ");
		}
	}

	public static IEnumerable<JumpMarker> GetAllMarker(TimelineAsset timelineAsset)
	{
		foreach (TrackAsset item in GetAllTrack(timelineAsset))
		{
			foreach (IMarker marker in item.GetMarkers())
			{
				if (marker is JumpMarker jumpMarker)
				{
					yield return jumpMarker;
				}
			}
		}
	}

	private static IEnumerable<TrackAsset> GetAllTrack(TimelineAsset timelineAsset)
	{
		foreach (TrackAsset rootTrack in timelineAsset.GetRootTracks())
		{
			yield return rootTrack;
			foreach (TrackAsset subTrack in GetSubTracks(rootTrack))
			{
				yield return subTrack;
			}
		}
		static IEnumerable<TrackAsset> GetSubTracks(TrackAsset parentTrack)
		{
			foreach (TrackAsset childTrack in parentTrack.GetChildTracks())
			{
				yield return childTrack;
				foreach (TrackAsset subTrack2 in GetSubTracks(childTrack))
				{
					yield return subTrack2;
				}
			}
		}
	}
}
