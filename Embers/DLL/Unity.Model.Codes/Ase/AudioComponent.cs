#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using FMODUnity;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class AudioComponent : GameFrameworkComponent
{
	private Dictionary<string, AudioBank> cacheMainBanks = new Dictionary<string, AudioBank>();

	private Dictionary<int, Dictionary<string, AudioBank>> cacheLanguageBanks = new Dictionary<int, Dictionary<string, AudioBank>>();

	private Dictionary<AudioInfo, List<EventInstance>> cacheEventInstance = new Dictionary<AudioInfo, List<EventInstance>>();

	private Dictionary<int, LanguageFix> cacheLanguageFix = new Dictionary<int, LanguageFix>();

	private int curLanguageType;

	private string curLanguageSuffix = "";

	public override void Init()
	{
		base.Init();
	}

	public async UniTask LoadBankGroups(List<BankGroupData> bankTables)
	{
		foreach (BankGroupData bankTable in bankTables)
		{
			await LoadBankByGroup(bankTable);
		}
	}

	public async UniTask LoadBankByGroup(BankGroupData bankGroup)
	{
		try
		{
			_ = string.Empty;
			foreach (string bank in bankGroup.Banks)
			{
				string path = AssetUtility.GetMusicAsset(bank);
				LoadMainBank(await GameEntry.Resource.LoadAssetAsync<TextAsset>(path, "Audio"), path, bankGroup.GroupType, loadSamples: true);
				GameEntry.Resource.UnloadAsset(path, "Audio");
			}
		}
		catch
		{
		}
	}

	public void UnloadBankByGroup(BankGroupData bankGroup)
	{
		string empty = string.Empty;
		foreach (string bank in bankGroup.Banks)
		{
			empty = AssetUtility.GetMusicAsset(bank);
			UnloadMainBank(empty, bankGroup.GroupType);
		}
	}

	public void LoadMainBank(TextAsset asset, string path, int bankType = 0, bool loadSamples = false)
	{
		//IL_0050: Expected O, but got Unknown
		try
		{
			string key = bankType + "_" + path;
			if (cacheMainBanks.TryGetValue(key, out var value))
			{
				value.AddRef();
				return;
			}
			value = new AudioBank(path, bankType);
			cacheMainBanks.Add(key, value);
			value.LoadBank(asset, loadSamples);
		}
		catch (BankLoadException ex)
		{
			Log.Error((object)ex);
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	public void UnloadMainBank(string path, int bankType = 0)
	{
		try
		{
			string key = bankType + "_" + path;
			if (cacheMainBanks.TryGetValue(key, out var value))
			{
				value.DelRef();
				if (value.RefCount <= 0)
				{
					value.UnloadBank();
					cacheMainBanks.Remove(key);
				}
			}
		}
		catch
		{
		}
	}

	public void UnloadAllBanks(bool unloadAll = false)
	{
		foreach (AudioBank value in cacheMainBanks.Values)
		{
			if (unloadAll || value.BankType != 0)
			{
				value.UnloadBank(unloadComplete: true);
			}
		}
		cacheMainBanks.Clear();
	}

	public void SetLanguage(int language, string languageSuffix)
	{
		if (curLanguageType != language)
		{
			UnloadCurLanguageBank();
			curLanguageType = language;
			curLanguageSuffix = languageSuffix;
		}
	}

	public void UnloadCurLanguageBank()
	{
		if (!cacheLanguageBanks.TryGetValue(curLanguageType, out var value))
		{
			return;
		}
		foreach (AudioBank value2 in value.Values)
		{
			if (value2.IsLoaded())
			{
				value2.UnloadBank();
			}
		}
		value.Clear();
	}

	public void LoadLanguageBank(TextAsset asset, string path, int bankType = 0, bool loadSamples = false)
	{
		if (!cacheLanguageBanks.TryGetValue(curLanguageType, out var value))
		{
			value = CollectionPool<Dictionary<string, AudioBank>, KeyValuePair<string, AudioBank>>.Get();
			cacheLanguageBanks[curLanguageType] = value;
		}
		string key = bankType + "_" + path;
		if (value.TryGetValue(key, out var value2))
		{
			value2.AddRef();
			return;
		}
		value2 = new AudioBank(path, bankType);
		value2.LoadBank(asset, loadSamples);
		value.Add(key, value2);
	}

	public void GetAudioInfoAndInstance(int id, string path, int eventType, out AudioInfo audioInfo, out EventInstance eventInstance)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		audioInfo = GetAudioInfo(id, path, eventType, curLanguageType);
		eventInstance = GetEventInstance(audioInfo);
	}

	public bool SetVCAVolume(string path, float volume)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		VCA vCA = RuntimeManager.GetVCA(path);
		if (((VCA)(ref vCA)).isValid())
		{
			((VCA)(ref vCA)).setVolume(volume);
		}
		return ((VCA)(ref vCA)).isValid();
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
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		EventInstance result = default(EventInstance);
		((EventInstance)(ref result))._002Ector(IntPtr.Zero);
		try
		{
			EventDescription eventDescription = RuntimeManager.GetEventDescription(audioInfo.audioPath);
			((EventDescription)(ref eventDescription)).createInstance(ref result);
		}
		catch (Exception)
		{
		}
		return result;
	}

	public override void Shutdown()
	{
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		foreach (AudioBank value in cacheMainBanks.Values)
		{
			value.UnloadBank();
		}
		cacheMainBanks.Clear();
		foreach (Dictionary<string, AudioBank> value2 in cacheLanguageBanks.Values)
		{
			foreach (AudioBank value3 in value2.Values)
			{
				value3.UnloadBank();
			}
			CollectionPool<Dictionary<string, AudioBank>, KeyValuePair<string, AudioBank>>.Release(value2);
		}
		cacheLanguageBanks.Clear();
		foreach (KeyValuePair<AudioInfo, List<EventInstance>> item in cacheEventInstance)
		{
			if (item.Value == null)
			{
				continue;
			}
			foreach (EventInstance item2 in item.Value)
			{
				EventInstance current3 = item2;
				((EventInstance)(ref current3)).release();
				((EventInstance)(ref current3)).clearHandle();
			}
			item.Value.Clear();
			CollectionPool<List<EventInstance>, EventInstance>.Release(item.Value);
		}
		cacheEventInstance.Clear();
		cacheLanguageFix.Clear();
	}
}
