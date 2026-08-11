using System;
using System.Collections;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

namespace Ase;

public class SpineAnimationPlayerCore : ISpineAnimationPlayer
{
	private readonly MonoBehaviour host;

	private readonly Func<SkeletonGraphic> skeletonGetter;

	private readonly Func<bool> openMixGetter;

	private readonly Func<FusionData> idleDataGetter;

	private readonly Func<List<FusionData>> fusionDatasGetter;

	private readonly Action<FusionData> playAudio;

	private readonly Action stopAllAudio;

	private readonly Action<string> logInfo;

	private bool isValid;

	private SkeletonGraphic SkeletonGraphic => skeletonGetter?.Invoke();

	public SpineAnimationPlayerCore(MonoBehaviour host, Func<SkeletonGraphic> skeletonGetter, Func<bool> openMixGetter, Func<FusionData> idleDataGetter, Func<List<FusionData>> fusionDatasGetter, Action<FusionData> playAudio, Action stopAllAudio, Action<string> logInfo)
	{
		this.host = host;
		this.skeletonGetter = skeletonGetter;
		this.openMixGetter = openMixGetter;
		this.idleDataGetter = idleDataGetter;
		this.fusionDatasGetter = fusionDatasGetter;
		this.playAudio = playAudio;
		this.stopAllAudio = stopAllAudio;
		this.logInfo = logInfo;
	}

	public bool PlayAction(string aniName, Action onActionFinish = null)
	{
		List<FusionData> list = fusionDatasGetter?.Invoke();
		if (list == null)
		{
			return false;
		}
		FusionData fusionData = list.Find((FusionData x) => x.name == aniName);
		if (fusionData == null)
		{
			logInfo?.Invoke("无效的动作索引:" + aniName);
			return false;
		}
		host.StopAllCoroutines();
		PlayAndResetIdle(fusionData, onActionFinish);
		return true;
	}

	public bool PlayLegacyAction(string aniName, Action onActionFinish = null)
	{
		List<FusionData> list = fusionDatasGetter?.Invoke();
		if (list == null)
		{
			return false;
		}
		FusionData fusionData = list.Find((FusionData x) => x.name == aniName);
		if (fusionData == null)
		{
			logInfo?.Invoke("无效的动作索引:" + aniName);
			return false;
		}
		FusionTrackEntryData fusionTrackEntryData = fusionData.mainTrack.tracks[0];
		int trackIndex = GetTrackIndex(fusionData.mainTrack, 0);
		host.StopAllCoroutines();
		stopAllAudio?.Invoke();
		playAudio?.Invoke(fusionData);
		return PlayAction(fusionTrackEntryData.aniName, trackIndex, onActionFinish);
	}

	public bool PlayLegacyAction(string aniName, int track, Action onActionFinish = null)
	{
		host.StopAllCoroutines();
		stopAllAudio?.Invoke();
		return PlayAction(aniName, track, onActionFinish);
	}

	public bool PlayAction(string aniName, int trackIndex, Action onActionFinish = null)
	{
		host.StopAllCoroutines();
		if ((UnityEngine.Object)(object)skeletonGetter?.Invoke() == null)
		{
			return false;
		}
		SkeletonGraphic val = skeletonGetter();
		if (val.AnimationState == null || val.SkeletonData.FindAnimation(aniName) == null)
		{
			return false;
		}
		if (val.AnimationState.Tracks.Items.Length > trackIndex)
		{
			TrackEntry trackEntry = val.AnimationState.Tracks.Items[trackIndex];
			if (trackEntry != null)
			{
				trackEntry.Loop = false;
				trackEntry.MixDuration = 0f;
				val.Update(0f);
			}
		}
		if (val.AnimationState.SetAnimation(trackIndex, aniName, loop: true) == null)
		{
			return false;
		}
		onActionFinish?.Invoke();
		return true;
	}

	public bool HasAction(string aniName)
	{
		if (string.IsNullOrEmpty(aniName))
		{
			return false;
		}
		List<FusionData> list = fusionDatasGetter?.Invoke();
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			FusionData fusionData = list[i];
			if (fusionData != null && string.Equals(fusionData.name, aniName, StringComparison.Ordinal))
			{
				return true;
			}
		}
		return false;
	}

	public void ResetToIdle(bool stopAudio = true)
	{
		host.StopAllCoroutines();
		FusionData fusionData = idleDataGetter?.Invoke();
		if (fusionData != null && !((UnityEngine.Object)(object)SkeletonGraphic == null))
		{
			ClearAllTracksNext(SkeletonGraphic);
			host.StopAllCoroutines();
			if (stopAudio)
			{
				stopAllAudio?.Invoke();
			}
			SetIdleMainTrack(SkeletonGraphic, fusionData, isClear: false);
			SetIdleFaceTrack(SkeletonGraphic, fusionData, isClear: false);
			SetIdleTalkTrack(SkeletonGraphic, fusionData, isClear: false);
			SetIdleExtraTrack(SkeletonGraphic, fusionData, isClear: false);
		}
	}

	public void PlayIdle(bool playAudio = true)
	{
		host.StopAllCoroutines();
		FusionData fusionData = idleDataGetter?.Invoke();
		if (fusionData != null && !((UnityEngine.Object)(object)SkeletonGraphic == null))
		{
			ClearAllTracksNext(SkeletonGraphic);
			host.StopAllCoroutines();
			stopAllAudio?.Invoke();
			if (playAudio)
			{
				this.playAudio?.Invoke(fusionData);
			}
			SetIdleMainTrack(SkeletonGraphic, fusionData, isClear: false);
			SetIdleFaceTrack(SkeletonGraphic, fusionData, isClear: false);
			SetIdleTalkTrack(SkeletonGraphic, fusionData, isClear: false);
			SetIdleExtraTrack(SkeletonGraphic, fusionData, isClear: false);
		}
	}

	private void PlayIdleFallBack()
	{
		if ((UnityEngine.Object)(object)SkeletonGraphic == null)
		{
			return;
		}
		FusionData data = idleDataGetter?.Invoke();
		if (EmptyFusionData(data))
		{
			host.StopAllCoroutines();
			ClearAllTracksNext(SkeletonGraphic);
			if (!string.IsNullOrEmpty(SkeletonGraphic.startingAnimation))
			{
				SkeletonGraphic.AnimationState.SetAnimation(0, SkeletonGraphic.startingAnimation, SkeletonGraphic.startingLoop);
			}
		}
	}

	public void StopAnimation()
	{
		host.StopAllCoroutines();
		OnAnimationEnd(SkeletonGraphic);
	}

	private void OnCheckVaild(string aniName)
	{
		List<FusionData> list = fusionDatasGetter?.Invoke();
		if (list == null)
		{
			isValid = false;
			return;
		}
		FusionData fusionData = list.Find((FusionData x) => x.name == aniName);
		isValid = fusionData != null;
	}

	private void PlayAndResetIdle(FusionData spineData, Action onActionFinish = null)
	{
		if (spineData != null && !((UnityEngine.Object)(object)SkeletonGraphic == null))
		{
			OnCheckVaild(spineData.name);
			if (isValid)
			{
				PlayFusionData(spineData, playAudio: true, isClear: false, alignTrackEnd: true);
				host.StartCoroutine(PlayAndResetIdleCoroutine(spineData, onActionFinish));
			}
		}
	}

	private void PlayFusionData(FusionData fusionData, bool playAudio, bool isClear, bool alignTrackEnd)
	{
		if (fusionData != null && !((UnityEngine.Object)(object)SkeletonGraphic == null))
		{
			ClearAllTracksNext(SkeletonGraphic);
			host.StopAllCoroutines();
			stopAllAudio?.Invoke();
			if (playAudio)
			{
				this.playAudio?.Invoke(fusionData);
			}
			AddTrackEntry2Tracks(SkeletonGraphic, fusionData, openMixGetter(), isClear, alignTrackEnd);
		}
	}

	private IEnumerator PlayAndResetIdleCoroutine(FusionData spineData, Action onActionFinish = null)
	{
		yield return new WaitForSeconds(Get2IdleMixTime(spineData));
		onActionFinish?.Invoke();
		ResetToIdle(stopAudio: false);
	}

	private IEnumerator WaitForTrackComplete(TrackEntry trackEntry, Action onComplete)
	{
		if (trackEntry == null)
		{
			onComplete?.Invoke();
			yield break;
		}
		while (!trackEntry.IsComplete)
		{
			SkeletonGraphic skeletonGraphic = SkeletonGraphic;
			if (((skeletonGraphic != null) ? skeletonGraphic.AnimationState : null) == null)
			{
				yield break;
			}
			yield return null;
		}
		onComplete?.Invoke();
	}

	private void SetIdleMainTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool isClear, bool checkSame = true)
	{
		int trackIndex = GetTrackIndex(fusionData.mainTrack, 0);
		if (isClear)
		{
			ClearTrack(skeletonAnimation, trackIndex);
		}
		if (fusionData.mainTrack.tracks != null && fusionData.mainTrack.tracks.Count > 0)
		{
			SetIdleAnimation(skeletonAnimation, trackIndex, fusionData.mainTrack.tracks[0], checkSame);
		}
	}

	private void SetIdleFaceTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool isClear, bool checkSame = true)
	{
		int trackIndex = GetTrackIndex(fusionData.faceTrack, 1);
		if (isClear)
		{
			ClearTrack(skeletonAnimation, trackIndex);
		}
		if (fusionData.faceTrack.tracks != null && fusionData.faceTrack.tracks.Count > 0)
		{
			SetIdleAnimation(skeletonAnimation, trackIndex, fusionData.faceTrack.tracks[0], checkSame);
		}
	}

	private void SetIdleTalkTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool isClear, bool checkSame = true)
	{
		int trackIndex = GetTrackIndex(fusionData.talkTrack, 2);
		if (isClear)
		{
			ClearTrack(skeletonAnimation, trackIndex);
		}
		if (fusionData.talkTrack.tracks != null && fusionData.talkTrack.tracks.Count > 0)
		{
			SetIdleAnimation(skeletonAnimation, trackIndex, fusionData.talkTrack.tracks[0], checkSame);
		}
	}

	private void SetIdleExtraTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool isClear, bool checkSame = true)
	{
		if (fusionData.extraTracks == null)
		{
			return;
		}
		for (int i = 0; i < fusionData.extraTracks.Count; i++)
		{
			TrackData trackData = fusionData.extraTracks[i];
			int trackIndex = GetTrackIndex(trackData, 3 + i);
			if (isClear)
			{
				ClearTrack(skeletonAnimation, trackIndex);
			}
			if (trackData.tracks != null && trackData.tracks.Count > 0)
			{
				SetIdleAnimation(skeletonAnimation, trackIndex, trackData.tracks[0], checkSame);
			}
		}
	}

	private void SetIdleAnimation(SkeletonGraphic skeletonAnimation, int trackIndex, FusionTrackEntryData trackEntryData, bool checkSame = false)
	{
		if (!string.IsNullOrEmpty(trackEntryData.aniName))
		{
			if (checkSame && trackIndex < skeletonAnimation.AnimationState.Tracks.Count)
			{
				TrackEntry trackEntry = skeletonAnimation.AnimationState.Tracks.Items[trackIndex];
				if (trackEntry != null && trackEntry.Loop == trackEntryData.isLoop && trackEntry.Animation != null && trackEntry.Animation.Name == trackEntryData.aniName && trackEntry.TrackEnd == float.MaxValue)
				{
					return;
				}
			}
			skeletonAnimation.AnimationState.SetAnimation(trackIndex, trackEntryData.aniName, trackEntryData.isLoop);
		}
		else
		{
			skeletonAnimation.AnimationState.SetEmptyAnimation(trackIndex, trackEntryData.transitionDuration);
		}
	}

	private TrackEntry SetAnimation(SkeletonGraphic skeletonAnimation, int trackIndex, string aniName, bool isLoop, float delay)
	{
		if (!string.IsNullOrEmpty(aniName))
		{
			return skeletonAnimation.AnimationState.SetAnimation(trackIndex, aniName, isLoop);
		}
		return skeletonAnimation.AnimationState.SetEmptyAnimation(trackIndex, 0.2f);
	}

	private TrackEntry AddTrackEntry2Tracks(SkeletonGraphic skeletonAnimation, FusionData spineData, bool openMix, bool isClear, bool alignTrackEnd)
	{
		if (spineData == null)
		{
			return null;
		}
		AddTrackEntry2MainTrack(skeletonAnimation, spineData, openMix, isClear, alignTrackEnd);
		AddTrackEntry2FaceTrack(skeletonAnimation, spineData, openMix, isClear, alignTrackEnd);
		AddTrackEntry2TalkTrack(skeletonAnimation, spineData, openMix, isClear, alignTrackEnd);
		AddTrackEntry2ExtraTrack(skeletonAnimation, spineData, openMix, isClear);
		return skeletonAnimation.AnimationState.Tracks.Items[GetTrackIndex(spineData.mainTrack, 0)];
	}

	private void ClearTrack(SkeletonGraphic skeletonAnimation, int trackIndex)
	{
		skeletonAnimation.AnimationState.SetEmptyAnimation(trackIndex, 0f);
	}

	private void AddTrackEntry2MainTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool openMix, bool isClear, bool alignTrackEnd)
	{
		FusionData fusionData2 = idleDataGetter?.Invoke();
		int trackIndex = GetTrackIndex(fusionData.mainTrack, 0);
		if (isClear)
		{
			ClearTrack(skeletonAnimation, trackIndex);
		}
		if (fusionData.mainTrack.tracks == null || fusionData.mainTrack.tracks.Count <= 0)
		{
			if (fusionData2 != null && fusionData2.mainTrack.tracks != null && fusionData2.mainTrack.tracks.Count > 0 && !MainDataFromIdle(skeletonAnimation, trackIndex))
			{
				ClearTrackNext(skeletonAnimation, trackIndex);
				SetIdleMainTrack(skeletonAnimation, fusionData2, isClear, checkSame: false);
			}
		}
		else
		{
			AddTrackEntry2Animation(skeletonAnimation, fusionData.mainTrack, openMix, fusionData.length, alignTrackEnd);
		}
	}

	private void AddTrackEntry2FaceTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool openMix, bool isClear, bool alignTrackEnd)
	{
		FusionData fusionData2 = idleDataGetter?.Invoke();
		int trackIndex = GetTrackIndex(fusionData.faceTrack, 1);
		if (isClear)
		{
			ClearTrack(skeletonAnimation, trackIndex);
		}
		if (fusionData.faceTrack.tracks == null || fusionData.faceTrack.tracks.Count <= 0)
		{
			if (fusionData2 != null && fusionData2.faceTrack.tracks != null && fusionData2.faceTrack.tracks.Count > 0 && !FaceDataFromIdle(skeletonAnimation, trackIndex))
			{
				ClearTrackNext(skeletonAnimation, trackIndex);
				SetIdleFaceTrack(skeletonAnimation, fusionData2, isClear, checkSame: false);
			}
		}
		else
		{
			AddTrackEntry2Animation(skeletonAnimation, fusionData.faceTrack, openMix, fusionData.length, alignTrackEnd);
		}
	}

	private void AddTrackEntry2TalkTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool openMix, bool isClear, bool alignTrackEnd)
	{
		FusionData fusionData2 = idleDataGetter?.Invoke();
		int trackIndex = GetTrackIndex(fusionData.talkTrack, 2);
		if (isClear)
		{
			ClearTrack(skeletonAnimation, trackIndex);
		}
		if (fusionData.talkTrack.tracks == null || fusionData.talkTrack.tracks.Count <= 0)
		{
			if (fusionData2 != null && fusionData2.talkTrack.tracks != null && fusionData2.talkTrack.tracks.Count > 0 && !TalkDataFromIdle(skeletonAnimation, trackIndex))
			{
				ClearTrackNext(skeletonAnimation, trackIndex);
				SetIdleTalkTrack(skeletonAnimation, fusionData2, isClear, checkSame: false);
			}
		}
		else
		{
			AddTrackEntry2Animation(skeletonAnimation, fusionData.talkTrack, openMix, fusionData.length, alignTrackEnd);
		}
	}

	private void AddEmptyTrackEntry2Animation(SkeletonGraphic skeletonAnimation, int trackIndex, float delay, float trackEnd)
	{
		skeletonAnimation.AnimationState.AddEmptyAnimation(trackIndex, 0f, delay).TrackEnd = trackEnd;
	}

	private void SetEmptyTrackEntry2Animation(SkeletonGraphic skeletonAnimation, int trackIndex, float delay, float trackEnd)
	{
		skeletonAnimation.AnimationState.SetEmptyAnimation(trackIndex, 0.2f).TrackEnd = trackEnd;
	}

	private void AddTrackEntry2ExtraTrack(SkeletonGraphic skeletonAnimation, FusionData fusionData, bool openMix, bool isClear)
	{
		FusionData fusionData2 = idleDataGetter?.Invoke();
		if (fusionData.extraTracks == null)
		{
			if (fusionData2 == null || fusionData2.extraTracks == null || fusionData2.extraTracks.Count <= 0)
			{
				return;
			}
			for (int i = 0; i < fusionData2.extraTracks.Count; i++)
			{
				int trackIndex = GetTrackIndex(fusionData2.extraTracks[i], 3 + i);
				if (!ExtraDataFromIdle(skeletonAnimation, trackIndex))
				{
					SetIdleExtraTrack(skeletonAnimation, fusionData2, isClear, checkSame: false);
					continue;
				}
				ClearTrackNext(skeletonAnimation, trackIndex);
				AddAnimation(skeletonAnimation, trackIndex, fusionData2.extraTracks[i].tracks[0].aniName, fusionData2.extraTracks[i].tracks[0].isLoop, 0f);
			}
			return;
		}
		for (int j = 0; j < fusionData.extraTracks.Count; j++)
		{
			TrackData trackData = fusionData.extraTracks[j];
			int trackIndex2 = GetTrackIndex(trackData, 3 + j);
			if (isClear)
			{
				ClearTrack(skeletonAnimation, trackIndex2);
			}
			if (trackData.tracks != null && trackData.tracks.Count > 0)
			{
				AddTrackEntry2Animation(skeletonAnimation, trackData, openMix);
			}
		}
	}

	private void AddTrackEntry2Animation(SkeletonGraphic skeletonAnimation, TrackData trackData, bool openMix, float trackEndTime = 0f, bool align = false)
	{
		if (trackData.tracks == null || trackData.tracks.Count == 0)
		{
			return;
		}
		int trackIndex = GetTrackIndex(trackData, 0);
		List<FusionTrackEntryData> tracks = trackData.tracks;
		float num = 0f;
		float num2 = 0f;
		float delay = 0f;
		float num3 = 1f;
		foreach (FusionTrackEntryData item in tracks)
		{
			if (item.startTime - num2 >= 0.001f)
			{
				if (num2 == 0f)
				{
					SetEmptyTrackEntry2Animation(skeletonAnimation, trackIndex, delay, item.startTime - num2);
				}
				else
				{
					AddEmptyTrackEntry2Animation(skeletonAnimation, trackIndex, delay, item.startTime - num2);
				}
				num = num2;
				delay = item.startTime - num2;
				num2 = item.startTime;
				num3 = 1f;
			}
			TrackEntry trackEntry = ((num2 != 0f) ? AddAnimation(skeletonAnimation, trackIndex, item.aniName, item.isLoop, 0f) : SetAnimation(skeletonAnimation, trackIndex, item.aniName, item.isLoop, 0f));
			trackEntry.Delay = num3 * (item.startTime - num);
			trackEntry.MixDuration = (openMix ? item.transitionDuration : 0f);
			trackEntry.AnimationStart = item.startFrame / 60f;
			trackEntry.AnimationLast = trackEntry.AnimationStart;
			trackEntry.TimeScale = item.timeScale;
			if (item.endTime >= 0f)
			{
				trackEntry.TrackEnd = (item.endTime - item.startTime) * item.timeScale;
			}
			num = item.startTime;
			delay = trackEntry.TrackEnd;
			num2 = item.endTime;
			num3 = item.timeScale;
		}
		if (align && num2 != trackEndTime)
		{
			AddEmptyTrackEntry2Animation(skeletonAnimation, trackIndex, num2 - num, trackEndTime - num2);
		}
	}

	private TrackEntry AddAnimation(SkeletonGraphic skeletonAnimation, int trackIndex, string aniName, bool isLoop, float delay)
	{
		if (!string.IsNullOrEmpty(aniName))
		{
			return skeletonAnimation.AnimationState.AddAnimation(trackIndex, aniName, isLoop, delay);
		}
		return skeletonAnimation.AnimationState.AddEmptyAnimation(trackIndex, 0.2f, delay);
	}

	private void OnAnimationEnd(SkeletonGraphic skeletonGraphic)
	{
		ClearAllTracks(skeletonGraphic);
	}

	private void ClearAllTracks(SkeletonGraphic skeletonGraphic)
	{
		if (!((UnityEngine.Object)(object)skeletonGraphic == null))
		{
			_ = skeletonGraphic.AnimationState.Tracks.Count;
			for (int num = skeletonGraphic.AnimationState.Tracks.Count - 1; num >= 0; num--)
			{
				ClearTrack(skeletonGraphic, num);
			}
		}
	}

	private void ClearAllTracksNext(SkeletonGraphic skeletonGraphic)
	{
		if (!((UnityEngine.Object)(object)skeletonGraphic == null))
		{
			_ = skeletonGraphic.AnimationState.Tracks.Count;
			for (int num = skeletonGraphic.AnimationState.Tracks.Count - 1; num >= 0; num--)
			{
				ClearTrackNext(skeletonGraphic, num);
			}
		}
	}

	private void ClearTrackNext(SkeletonGraphic skeletonAnimation, int trackIndex)
	{
		if (trackIndex < skeletonAnimation.AnimationState.Tracks.Count)
		{
			TrackEntry trackEntry = skeletonAnimation.AnimationState.Tracks.Items[trackIndex];
			if (trackEntry != null)
			{
				skeletonAnimation.AnimationState.ClearNext(trackEntry);
			}
		}
	}

	private float Get2IdleMixTime(FusionData fusionData)
	{
		if (fusionData == null)
		{
			return 0.5f;
		}
		return fusionData.length - GetIdleMix();
	}

	private float GetIdleMix()
	{
		FusionData fusionData = idleDataGetter?.Invoke();
		if (fusionData == null)
		{
			return 0.3f;
		}
		if (fusionData.mainTrack.tracks == null)
		{
			return 0.3f;
		}
		if (fusionData.mainTrack.tracks.Count <= 0)
		{
			return 0.3f;
		}
		if (!(fusionData.mainTrack.tracks[0].transitionDuration <= 0f))
		{
			return fusionData.mainTrack.tracks[0].transitionDuration;
		}
		return 0.3f;
	}

	private bool MainDataFromIdle(SkeletonGraphic skeletonAnimation, int trackIndex)
	{
		FusionData fusionData = idleDataGetter?.Invoke();
		if ((UnityEngine.Object)(object)skeletonAnimation == null || skeletonAnimation.AnimationState == null || skeletonAnimation.AnimationState.Tracks == null || trackIndex >= skeletonAnimation.AnimationState.Tracks.Count)
		{
			return false;
		}
		TrackEntry trackEntry = skeletonAnimation.AnimationState.Tracks.Items[trackIndex];
		if (trackEntry != null && fusionData != null && fusionData.mainTrack.tracks != null && fusionData.mainTrack.tracks.Count > 0)
		{
			return DataFromIdle(trackEntry, fusionData.mainTrack.tracks[0]);
		}
		return false;
	}

	private bool FaceDataFromIdle(SkeletonGraphic skeletonAnimation, int trackIndex)
	{
		FusionData fusionData = idleDataGetter?.Invoke();
		if ((UnityEngine.Object)(object)skeletonAnimation == null || skeletonAnimation.AnimationState == null || skeletonAnimation.AnimationState.Tracks == null || trackIndex >= skeletonAnimation.AnimationState.Tracks.Count)
		{
			return false;
		}
		TrackEntry trackEntry = skeletonAnimation.AnimationState.Tracks.Items[trackIndex];
		if (trackEntry != null && fusionData != null && fusionData.faceTrack.tracks != null && fusionData.faceTrack.tracks.Count > 0)
		{
			return DataFromIdle(trackEntry, fusionData.faceTrack.tracks[0]);
		}
		return false;
	}

	private bool TalkDataFromIdle(SkeletonGraphic skeletonAnimation, int trackIndex)
	{
		FusionData fusionData = idleDataGetter?.Invoke();
		if ((UnityEngine.Object)(object)skeletonAnimation == null || skeletonAnimation.AnimationState == null || skeletonAnimation.AnimationState.Tracks == null || trackIndex >= skeletonAnimation.AnimationState.Tracks.Count)
		{
			return false;
		}
		TrackEntry trackEntry = skeletonAnimation.AnimationState.Tracks.Items[trackIndex];
		if (trackEntry != null && fusionData != null && fusionData.talkTrack.tracks != null && fusionData.talkTrack.tracks.Count > 0)
		{
			return DataFromIdle(trackEntry, fusionData.talkTrack.tracks[0]);
		}
		return false;
	}

	private bool ExtraDataFromIdle(SkeletonGraphic skeletonAnimation, int trackIndex)
	{
		FusionData fusionData = idleDataGetter?.Invoke();
		if ((UnityEngine.Object)(object)skeletonAnimation == null || skeletonAnimation.AnimationState == null || skeletonAnimation.AnimationState.Tracks == null || trackIndex >= skeletonAnimation.AnimationState.Tracks.Count)
		{
			return false;
		}
		TrackEntry trackEntry = skeletonAnimation.AnimationState.Tracks.Items[trackIndex];
		if (trackEntry == null || fusionData == null || fusionData.extraTracks == null || fusionData.extraTracks.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < fusionData.extraTracks.Count; i++)
		{
			TrackData trackData = fusionData.extraTracks[i];
			if (GetTrackIndex(trackData, 3 + i) == trackIndex)
			{
				if (trackData.tracks != null && trackData.tracks.Count > 0)
				{
					return DataFromIdle(trackEntry, trackData.tracks[0]);
				}
				return false;
			}
		}
		return false;
	}

	private bool DataFromIdle(TrackEntry trackEntry, FusionTrackEntryData trackEntryData)
	{
		if (trackEntry != null && trackEntry.Animation != null && trackEntry.Animation.Name == trackEntryData.aniName && trackEntry.Loop == trackEntryData.isLoop)
		{
			return trackEntry.TrackEnd == float.MaxValue;
		}
		return false;
	}

	private int GetTrackIndex(TrackData trackData, int fallback)
	{
		if (trackData.trackIndex >= 0)
		{
			return trackData.trackIndex;
		}
		return fallback;
	}

	private bool EmptyFusionData(FusionData data)
	{
		if (data != null)
		{
			return string.IsNullOrEmpty(data.name);
		}
		return true;
	}
}
