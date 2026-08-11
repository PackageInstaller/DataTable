#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using FMOD.Studio;
using FMODUnity;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class AudioTempComponent
{
	private Dictionary<AudioInfo, List<EventInstance>> cacheEventInstance = new Dictionary<AudioInfo, List<EventInstance>>();

	private Dictionary<int, LanguageFix> cacheLanguageFix = new Dictionary<int, LanguageFix>();

	private Dictionary<int, SnapshotGroup> cacheSnapshotGroups = new Dictionary<int, SnapshotGroup>();

	private int curLanguageType;

	private string curLanguageSuffix = "";

	public void SetLanguage(int language, string languageSuffix)
	{
		if (curLanguageType != language)
		{
			curLanguageType = language;
			curLanguageSuffix = languageSuffix;
		}
	}

	public bool PlayGlobalSnapshot(int id, string path, float volume = 1f, List<AudioParameter> audioParameters = null)
	{
		return PlaySnapshot(AudioDef.GLOBAL_SNAPSHOTGROUP_ID, null, id, path, volume, audioParameters);
	}

	public bool StopGlobalSnapshot(int id, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		return StopSnapshot(AudioDef.GLOBAL_SNAPSHOTGROUP_ID, id, stopMode);
	}

	public bool ClearGlobalSnapshot()
	{
		if (!cacheSnapshotGroups.TryGetValue(AudioDef.GLOBAL_SNAPSHOTGROUP_ID, out var value))
		{
			return false;
		}
		return value.ClearSnapshot();
	}

	public bool PlayLocalSnapshot(Transform parent, int id, string path, float volume = 1f, List<AudioParameter> audioParameters = null)
	{
		if (parent == null)
		{
			return false;
		}
		return PlaySnapshot(parent.GetInstanceID(), parent, id, path, volume, audioParameters);
	}

	private bool PlaySnapshot(int groupKey, Transform parent, int id, string path, float volume = 1f, List<AudioParameter> audioParameters = null)
	{
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheSnapshotGroups.TryGetValue(groupKey, out var value))
		{
			value = new SnapshotGroup(parent);
			cacheSnapshotGroups[groupKey] = value;
		}
		AudioInfo audioInfo = GetAudioInfo(id, path, 0, curLanguageType);
		EventInstance eventInstance = GetEventInstance(audioInfo);
		return value.PlaySnapshot(id, audioInfo, eventInstance, volume, audioParameters);
	}

	public bool StopLocalSnapshot(Transform parent, int id, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		if (parent == null)
		{
			return false;
		}
		bool result = StopSnapshot(parent.GetInstanceID(), id, stopMode);
		TryDisposeEmptyLocalSnapshotGroup(parent.GetInstanceID());
		return result;
	}

	private bool StopSnapshot(int groupKey, int id, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheSnapshotGroups.TryGetValue(groupKey, out var value))
		{
			return false;
		}
		return value.StopSnapshot(id, stopMode);
	}

	private void TryDisposeEmptyLocalSnapshotGroup(int groupKey)
	{
		if (cacheSnapshotGroups.TryGetValue(groupKey, out var value) && value.GetCount() <= 0)
		{
			value.Dispose();
			cacheSnapshotGroups.Remove(groupKey);
		}
	}

	private AudioInfo GetAudioInfo(int id, string path, int eventType, int languageType)
	{
		Dictionary<AudioInfo, List<EventInstance>>.KeyCollection.Enumerator enumerator = cacheEventInstance.Keys.GetEnumerator();
		AudioInfo audioInfo = AudioInfo.EmptyInfo;
		while (enumerator.MoveNext())
		{
			if (enumerator.Current.id == id && enumerator.Current.languageType == languageType && enumerator.Current.oriPath == path && enumerator.Current.eventType == eventType)
			{
				audioInfo = enumerator.Current;
				break;
			}
		}
		enumerator.Dispose();
		if (audioInfo != AudioInfo.EmptyInfo)
		{
			return audioInfo;
		}
		audioInfo.id = id;
		audioInfo.oriPath = path;
		audioInfo.languageType = languageType;
		audioInfo.audioPath = path;
		audioInfo.languageType = languageType;
		audioInfo.eventType = eventType;
		if (eventType == 1)
		{
			LanguageFix fix = GetFix(languageType);
			audioInfo.audioPath = string.Intern(path.Replace(AudioDef.EventPathPrefix, string.Intern(AudioDef.EventPathPrefix + fix.prefix)) + fix.suffix);
		}
		cacheEventInstance[audioInfo] = CollectionPool<List<EventInstance>, EventInstance>.Get();
		return audioInfo;
	}

	private EventInstance GetEventInstance(AudioInfo audioInfo)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Invalid comparison between Unknown and I4
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		List<EventInstance> list = cacheEventInstance[audioInfo];
		EventInstance val;
		if (list.Count <= 0)
		{
			val = CreateNewEventInstance(audioInfo);
			list.Add(val);
			return val;
		}
		PLAYBACK_STATE val2 = default(PLAYBACK_STATE);
		foreach (EventInstance item in list)
		{
			EventInstance current = item;
			if (((EventInstance)(ref current)).isValid())
			{
				((EventInstance)(ref current)).getPlaybackState(ref val2);
				if ((int)val2 == 2)
				{
					return current;
				}
			}
		}
		val = CreateNewEventInstance(audioInfo);
		list.Add(val);
		return val;
	}

	private LanguageFix GetFix(int languageType)
	{
		if (languageType == 0)
		{
			return AudioDef.DefaultFix;
		}
		if (cacheLanguageFix.ContainsKey(languageType))
		{
			return cacheLanguageFix[languageType];
		}
		LanguageFix languageFix = default(LanguageFix);
		string text = (languageFix.prefix = curLanguageSuffix);
		languageFix.prefix = ((string.IsNullOrEmpty(text) || text.Length < 2) ? string.Intern(AudioDef.DefaultFix.prefix) : string.Intern(text.Substring(0, 1).ToUpper() + text.Substring(1) + "/"));
		languageFix.suffix = (string.IsNullOrEmpty(text) ? "" : string.Intern("_" + text));
		cacheLanguageFix[languageType] = languageFix;
		return languageFix;
	}

	private EventInstance CreateNewEventInstance(AudioInfo audioInfo)
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		EventInstance result = default(EventInstance);
		((EventInstance)(ref result))._002Ector(IntPtr.Zero);
		try
		{
			EventDescription eventDescription = RuntimeManager.GetEventDescription(audioInfo.audioPath);
			((EventDescription)(ref eventDescription)).createInstance(ref result);
		}
		catch (Exception ex)
		{
			Log.Error("创建音乐事件实例失败，路径:" + audioInfo.audioPath + "," + ex);
		}
		return result;
	}

	public void Shutdown()
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		foreach (KeyValuePair<AudioInfo, List<EventInstance>> item in cacheEventInstance)
		{
			if (item.Value == null)
			{
				continue;
			}
			foreach (EventInstance item2 in item.Value)
			{
				EventInstance current2 = item2;
				((EventInstance)(ref current2)).release();
				((EventInstance)(ref current2)).clearHandle();
			}
			item.Value.Clear();
			CollectionPool<List<EventInstance>, EventInstance>.Release(item.Value);
		}
		cacheEventInstance.Clear();
		cacheLanguageFix.Clear();
		foreach (KeyValuePair<int, SnapshotGroup> cacheSnapshotGroup in cacheSnapshotGroups)
		{
			cacheSnapshotGroup.Value.Dispose();
		}
		cacheSnapshotGroups.Clear();
	}
}
