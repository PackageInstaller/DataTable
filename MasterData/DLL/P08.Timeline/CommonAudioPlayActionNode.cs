using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using CriWare;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("非战斗音效")]
public class CommonAudioPlayActionNode : PlayableAsset
{
	public AudioClip mAudioClip;

	public string mCueSheet;

	public string mCueName;

	public string mCueAcb;

	public string mCueAwb;

	public int mCueId;

	public int mStartTime;

	[HideInInspector]
	public double CueLength = -1.0;

	public bool mIsVoice;

	public bool mIsFootstep;

	public int mRoleVoiceID;

	public bool mUseRandomVoice;

	public List<RandomRoleVoiceItem> mRandomRoleVoiceConfig = new List<RandomRoleVoiceItem>();

	public bool mUseRandomPlay;

	public int mPercentOfPlay = 100;

	public bool m_useRandom;

	public List<int> m_weightList = new List<int>();

	public List<int> m_StartTimeList = new List<int>();

	public List<CriCueInfo> m_criCueInfoList = new List<CriCueInfo>();

	public override double duration
	{
		get
		{
			if (CueLength == -1.0 && !string.IsNullOrEmpty(mCueSheet) && !string.IsNullOrEmpty(mCueName))
			{
				CriAtomExAcb criAtomExAcb = CriAtomExAcb.LoadAcbFile(null, Path.Combine(Common.streamingAssetsPath, mCueAcb), string.IsNullOrEmpty(mCueAwb) ? null : Path.Combine(Common.streamingAssetsPath, mCueAwb));
				if (criAtomExAcb != null)
				{
					criAtomExAcb.GetCueInfo(mCueName, out var info);
					CueLength = (double)info.length / 1000.0;
				}
			}
			if (CueLength == -1.0)
			{
				return 1.0;
			}
			return CueLength;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return Playable.Create(graph);
	}

	public static void SampleRenderData(TimelineClip timelineClip, TimelineInfo timelineInfo)
	{
		CommonAudioPlayActionNode commonAudioPlayActionNode = timelineClip.asset as CommonAudioPlayActionNode;
		AudioPlayActionClip audioPlayActionClip = new AudioPlayActionClip
		{
			NormalizedBegin = (float)timelineClip.start / timelineInfo.duration,
			NormalizedEnd = (float)(timelineClip.end + timelineClip.duration) / timelineInfo.duration,
			Length = (float)timelineClip.duration,
			CueSheet = commonAudioPlayActionNode.mCueSheet,
			CueName = commonAudioPlayActionNode.mCueName,
			AwbName = commonAudioPlayActionNode.mCueAwb,
			IsVoice = commonAudioPlayActionNode.mIsVoice,
			StartTimeInMs = commonAudioPlayActionNode.mStartTime
		};
		if (commonAudioPlayActionNode.mIsVoice)
		{
			if (commonAudioPlayActionNode.mUseRandomPlay)
			{
				audioPlayActionClip.PercentOfPlay = Mathf.Clamp(commonAudioPlayActionNode.mPercentOfPlay, 1, 99);
			}
			else
			{
				audioPlayActionClip.PercentOfPlay = 100;
			}
			if (commonAudioPlayActionNode.mUseRandomVoice)
			{
				List<int> list = new List<int>();
				List<int> list2 = new List<int>();
				List<int> list3 = new List<int>();
				int num = 0;
				for (int i = 0; i < commonAudioPlayActionNode.mRandomRoleVoiceConfig.Count; i++)
				{
					RandomRoleVoiceItem randomRoleVoiceItem = commonAudioPlayActionNode.mRandomRoleVoiceConfig[i];
					if (randomRoleVoiceItem.RoleVoiceID != 0 && randomRoleVoiceItem.Weight > 0)
					{
						list.Add(randomRoleVoiceItem.RoleVoiceID);
						list2.Add(num + randomRoleVoiceItem.Weight);
						list3.Add(randomRoleVoiceItem.StartTime);
						num += randomRoleVoiceItem.Weight;
					}
				}
				audioPlayActionClip.RandomRoleVoiceIDs = list.ToArray();
				audioPlayActionClip.RandomWeight = list2.ToArray();
				audioPlayActionClip.RandomStartTimeInMs = list3.ToArray();
				audioPlayActionClip.RandomTotalWitght = num;
			}
			else if (commonAudioPlayActionNode.mRoleVoiceID != 0)
			{
				audioPlayActionClip.RandomRoleVoiceIDs = new int[1] { commonAudioPlayActionNode.mRoleVoiceID };
				audioPlayActionClip.RandomWeight = new int[1] { 1 };
				audioPlayActionClip.RandomStartTimeInMs = new int[1];
				audioPlayActionClip.RandomTotalWitght = 1;
			}
			else
			{
				audioPlayActionClip.RandomRoleVoiceIDs = new int[0];
				audioPlayActionClip.RandomWeight = new int[0];
				audioPlayActionClip.RandomStartTimeInMs = new int[0];
				audioPlayActionClip.RandomTotalWitght = 0;
			}
		}
		if (!commonAudioPlayActionNode.mUseRandomVoice && commonAudioPlayActionNode.m_useRandom)
		{
			int num2 = 0;
			List<int> list4 = new List<int>();
			for (int j = 0; j < commonAudioPlayActionNode.m_weightList.Count; j++)
			{
				int num3 = commonAudioPlayActionNode.m_weightList[j];
				list4.Add(num2 + num3);
				num2 += num3;
			}
			audioPlayActionClip.RandomTotalWitght = num2;
			audioPlayActionClip.RandomWeight = commonAudioPlayActionNode.m_weightList.ToArray();
			audioPlayActionClip.RandomStartTimeInMs = commonAudioPlayActionNode.m_StartTimeList.ToArray();
			audioPlayActionClip.CriCueInfoArr = commonAudioPlayActionNode.m_criCueInfoList.ToArray();
		}
		if (commonAudioPlayActionNode.mIsFootstep)
		{
			timelineInfo.footstepAudioClips.Add(audioPlayActionClip);
			timelineInfo.footstepAudioClips.Sort();
		}
		else
		{
			timelineInfo.audioPlayActionClips.Add(audioPlayActionClip);
			timelineInfo.audioPlayActionClips.Sort();
		}
		if (!string.IsNullOrEmpty(audioPlayActionClip.CueSheet))
		{
			new List<CriwareCueInfo>().Add(new CriwareCueInfo
			{
				mCueSheet = audioPlayActionClip.CueSheet,
				mCueName = audioPlayActionClip.CueName,
				mCueAcb = audioPlayActionClip.CueSheet + ".acb",
				mCueAwb = audioPlayActionClip.AwbName
			});
		}
	}
}
