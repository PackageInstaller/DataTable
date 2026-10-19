using System;
using System.Collections.Generic;
using ACT.Sound;
using FMODUnity;
using UnityEngine;

namespace ACT.Drama.Video;

public class VideoContentConfig : ScriptableObject
{
	[Serializable]
	public class ContentInfo
	{
		public float startTime;

		public float endTime;

		public int characterId;

		public int contentId;

		public EmotionPitch emotionPitch = EmotionPitch.Mid;
	}

	public string videoPath = string.Empty;

	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public List<ContentInfo> contentInfos = new List<ContentInfo>();
}
