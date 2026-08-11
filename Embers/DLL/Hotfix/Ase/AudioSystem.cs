using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using FMODUnity;
using GameFramework.Resource;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class AudioSystem : Singleton<AudioSystem>
{
	private const string LocalPreb = "AudioLanguage";

	private bool inited;

	private AudioLanguageEnum audioLanguage;

	private string languageSuffix = string.Empty;

	public bool BgmLog;

	private bool InStoryMode;

	private int curBgm = -1;

	private Dictionary<long, VoiceGroup> voiceGroups = new Dictionary<long, VoiceGroup>();

	private Dictionary<int, VoiceGroup> entityVoiceGroups = new Dictionary<int, VoiceGroup>();

	private Dictionary<int, SnapshotGroup> cacheSnapshotGroups = new Dictionary<int, SnapshotGroup>();

	private float totalVolume = 1f;

	private float totalMusicVolume = 1f;

	private float totalSoundVolume = 1f;

	public float otherRoleVolumeRate = -1f;

	public bool enableAudioDebug;

	private ISubscription<GameSettingConfigHelper.SettingData> mainVolumeChanged;

	private ISubscription<GameSettingConfigHelper.SettingData> musicVolumeChanged;

	private ISubscription<GameSettingConfigHelper.SettingData> soundVolumeChanged;

	private ISubscription<GameSettingConfigHelper.SettingData> voiceVolumeChanged;

	private List<EventInstance> hostingAudios = new List<EventInstance>();

	private Dictionary<AudioGroupType, AudioGroup> cacheAudioGroups = new Dictionary<AudioGroupType, AudioGroup>();

	private Dictionary<EventInstance, AudioItem> cacheAudioItems = new Dictionary<EventInstance, AudioItem>();

	public AudioLanguageEnum AudioLanguage => audioLanguage;

	public float OtherRoleVolumeRate
	{
		get
		{
			if (otherRoleVolumeRate < 0f)
			{
				otherRoleVolumeRate = GameEntry.DataTable.GetDataRow<DRConstantConfig>(Constant.ConstantConfig.OtherRoleVolumeRate)?.Value ?? (-1f);
			}
			return otherRoleVolumeRate;
		}
		private set
		{
			otherRoleVolumeRate = value;
		}
	}

	public bool EnableAudioDebug
	{
		get
		{
			return enableAudioDebug;
		}
		set
		{
			enableAudioDebug = value;
		}
	}

	public AudioSystem()
	{
		SubscribeMsg();
		InitLanguage();
	}

	public void InitLanguage()
	{
		int num = GameEntry.Setting.GetInt("语音语言", 0);
		if (Enum.IsDefined(typeof(AudioLanguageEnum), num))
		{
			SetLanguage((AudioLanguageEnum)num);
		}
		else
		{
			SetLanguage(AudioLanguageEnum.defaultLanguage, localSave: true);
		}
	}

	public async UniTask SetLanguage(AudioLanguageEnum languageEnum, bool localSave = false)
	{
		if (!inited || audioLanguage != languageEnum)
		{
			if (!inited)
			{
				inited = true;
			}
			audioLanguage = languageEnum;
			languageSuffix = ((languageEnum == AudioLanguageEnum.defaultLanguage) ? string.Empty : languageEnum.ToString());
			if (localSave)
			{
				GameEntry.Setting.SetInt("语音语言", (int)languageEnum);
				GameEntry.Setting.Save();
			}
			ClearTemp();
			GameEntry.Audio.SetLanguage((int)languageEnum, languageEnum.ToString());
			await RefreshBanksOnLanguageChanged(languageEnum);
		}
	}

	private async UniTask RefreshBanksOnLanguageChanged(AudioLanguageEnum languageEnum)
	{
		AssetData[] assetInfos = GameEntry.Resource.GetAssetInfos(languageEnum.ToString(), "Audio");
		if (assetInfos == null || assetInfos.Length == 0)
		{
			return;
		}
		bool flag = false;
		AssetData[] array = assetInfos;
		for (int i = 0; i < array.Length; i++)
		{
			AssetData assetData = array[i];
			if (assetData.AssetPath.StartsWith("Assets/Art/Audio/Voice/") && GameEntry.Resource.HasAsset(assetData.AssetPath, "Audio") == HasAssetResult.AssetOnline)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			GameEntry.Resource.DownloadAudoResources();
			return;
		}
		AssetData[] array2 = assetInfos;
		for (int j = 0; j < array2.Length; j++)
		{
			AssetData assetInfo = array2[j];
			if (assetInfo.AssetPath.StartsWith("Assets/Art/Audio/Voice/"))
			{
				TextAsset asset = await GameEntry.Resource.LoadAssetAsync<TextAsset>(assetInfo.AssetPath, "Audio");
				GameEntry.Audio.LoadLanguageBank(asset, assetInfo.AssetPath, 0, loadSamples: true);
				GameEntry.Resource.UnloadAsset(assetInfo.AssetPath, "Audio");
			}
		}
		DebugLoadedBanks();
		Context.GetApplicationContext().GetService<IMessenger>().Publish("AudioLanguageInfoChannel", audioLanguage);
	}

	private string GetUserIdTag()
	{
		string result = string.Empty;
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null && service.GetRoleData() != null && service.GetRoleData().PlayerInfo != null)
		{
			result = service.GetRoleData().PlayerInfo.Uid.ToString();
		}
		return result;
	}

	public void DebugLoadedBanks()
	{
	}

	public async UniTask HasBanksLoaded(List<string> banks, CancellationTokenSource cts = null)
	{
		if (banks == null || banks.Count == 0)
		{
			return;
		}
		while (true)
		{
			cts.Token.ThrowIfCancellationRequested();
			bool flag = true;
			foreach (string bank in banks)
			{
				if (!RuntimeManager.HasBankLoaded(bank))
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				break;
			}
			await UniTask.Yield();
		}
	}

	private DRAudio GetAudio(int id)
	{
		return GameEntry.DataTable.GetDataRow<DRAudio>(id);
	}

	public EventInstance CreateInstance(int id, bool hosting = false)
	{
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			DRAudio audio = GetAudio(id);
			if (audio == null)
			{
				return new EventInstance(IntPtr.Zero);
			}
			return CreateInstance(id, audio.EventPath, audio.EventType, hosting);
		}
		catch (Exception)
		{
			return default(EventInstance);
		}
	}

	private EventInstance CreateInstance(int id, string eventPath, int eventType, bool hosting = false)
	{
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		EventInstance eventInstance = GetEventInstance(id, eventPath, eventType);
		if (hosting && ((EventInstance)(ref eventInstance)).isValid())
		{
			RegisterHostingAudio(eventInstance);
		}
		return eventInstance;
	}

	public EventInstance CreateInstance(int id, float volume, List<AudioParameterSerializable> pars = null, bool hosting = false)
	{
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		EventInstance val = CreateInstance(id, hosting);
		List<AudioParameter> list = CollectionPool<List<AudioParameter>, AudioParameter>.Get();
		if (pars != null)
		{
			foreach (AudioParameterSerializable par in pars)
			{
				list.Add(new AudioParameter
				{
					key = par.Key,
					targetVal = par.Value,
					duration = par.Duration
				});
			}
		}
		SetInstanceParams(val, volume, list);
		return val;
	}

	public EventDescription GetEventDescription(int id)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			DRAudio dataRow = GameEntry.DataTable.GetDataRow<DRAudio>(id);
			if (dataRow == null)
			{
				return default(EventDescription);
			}
			return RuntimeManager.GetEventDescription(dataRow.EventPath);
		}
		catch (Exception)
		{
			return default(EventDescription);
		}
	}

	public EventInstance Play(int id, string path, int eventType, float volume = 1f, List<AudioParameter> pars = null)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		EventInstance eventInstance = GetEventInstance(id, path, eventType, volume, pars);
		if (!((EventInstance)(ref eventInstance)).isValid())
		{
			return eventInstance;
		}
		cacheAudioItems[eventInstance].PlayItem();
		return eventInstance;
	}

	public void Stop(EventInstance eventInstance)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		if (cacheAudioItems.TryGetValue(eventInstance, out var value))
		{
			value.Stop(value.StopMode);
			value.Dispose();
			cacheAudioItems.Remove(eventInstance);
		}
	}

	public EventInstance PlayStoryBGM(int id, string path, int eventType, float volume = -1f, List<AudioParameter> pars = null, bool canReturn = true, STOP_MODE stopMode = (STOP_MODE)0, float fadeInTime = 3f)
	{
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		GetAudioInfoAndInstance(AudioGroupType.StoryBGM, id, path, eventType, out var audioGroup, out var audioInfo, out var eventInstance);
		List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, AudioDef.DefaultFadeOutParams.y);
		AudioGroup audioGroup2 = audioGroup;
		if (cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value) && !InStoryMode && value.GetPeek().Info.id == id)
		{
			audioGroup2 = value;
		}
		if (audioGroup2 != value)
		{
			FadeOutDefaultBGM(id, fadeOutParameters);
		}
		InStoryMode = true;
		List<AudioParameter> fadeInParameters = AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, fadeInTime);
		audioGroup2.PlayAndReplaceIfSame(audioInfo, eventInstance, volume, pars, null, canReturn, stopMode, fadeInParameters, fadeOutParameters);
		CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeInParameters);
		CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeOutParameters);
		return eventInstance;
	}

	private void FadeOutDefaultBGM(int id, List<AudioParameter> fadeOutParams)
	{
		if (cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			AudioItem peek = value.GetPeek();
			peek.GetPlaying(out var isPlaying);
			if (peek != AudioItem.EmptyAudioItem && isPlaying && peek.Info.id != id)
			{
				peek.SetParameters(fadeOutParams, replace: false, temporary: true);
				peek.SetPaused(pause: true, fading: true);
			}
		}
	}

	public void StopStoryBGM(float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheAudioGroups.TryGetValue(AudioGroupType.StoryBGM, out var value) || value.Count() <= 0)
		{
			return;
		}
		AudioItem peek = value.GetPeek();
		if (peek != AudioItem.EmptyAudioItem)
		{
			bool num = value.Count() >= 2;
			List<AudioParameter> fadeInParameters = AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, fadeInTime);
			List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, fadeOutTime);
			value.Stop(peek.StopMode, fadeInParameters, fadeOutParameters, peek.ClearStack, forcePlay: true, playback: false);
			if (num)
			{
				value.Playback(fadeInParameters, forcePlay: false);
			}
			CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeInParameters);
			CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeOutParameters);
		}
	}

	public void ClearStoryBGM()
	{
		int num = 0;
		if (cacheAudioGroups.TryGetValue(AudioGroupType.StoryBGM, out var value) && value.Count() > 0)
		{
			num = value.GetPeek().Info.id;
			List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, AudioDef.DefaultFadeOutParams.y);
			value.Dispose(fadeOutParameters);
			CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeOutParameters);
		}
		if (cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value2) && value2.Count() > 0)
		{
			value2.GetPeek().GetPlaying(out var isPlaying);
			if ((num != 0 && num != value2.GetPeek().Info.id) || !isPlaying)
			{
				List<AudioParameter> fadeInParameters = AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, AudioDef.DefaultFadeInParams.y);
				value2.GetPeek().SetParameters(fadeInParameters, replace: false, temporary: true);
				CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeInParameters);
			}
			value2.SetPause(pause: false);
		}
		InStoryMode = false;
	}

	public bool Stop(AudioGroupType audioGroupType, bool playback = false, STOP_MODE stopMode = (STOP_MODE)0, List<AudioParameter> fadeParams = null)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheAudioGroups.TryGetValue(audioGroupType, out var value))
		{
			return false;
		}
		return value.Stop(stopMode, null, fadeParams, clearStack: false, forcePlay: true, playback);
	}

	public bool SetBgmParameter(int id, string path, int eventType, float volume, bool canReturn, STOP_MODE stopMode, List<AudioParameter> parameters)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			return false;
		}
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, eventType, out var audioInfo, out var _);
		if (!value.GetPeek().SameAudio(audioInfo))
		{
			return false;
		}
		value.GetPeek().SetVolume(volume).SetClearStack(!canReturn)
			.SetStopMode(stopMode)
			.SetParameters(parameters);
		return true;
	}

	public bool SetBgmParameter(float volume, List<AudioParameter> parameters)
	{
		if (!cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			return false;
		}
		value.GetPeek().SetVolume(volume).SetParameters(parameters);
		return true;
	}

	public bool StopBGM(int id, string path, int eventType, STOP_MODE stopMode, bool clearStack = false, float fadeInTime = 10f, float fadeOutTime = 10f)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			return false;
		}
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, eventType, out var audioInfo, out var _);
		List<AudioParameter> fadeInParameters = AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, fadeInTime);
		List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, fadeOutTime);
		return value.Stop(audioInfo, stopMode, clearStack, fadeInParameters, fadeOutParameters, forcePlay: false, playback: true);
	}

	public int GetCurBgmId()
	{
		return curBgm;
	}

	public void PlayBgm(int id, FMOD_Define.BgmParameter parameter)
	{
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			DRAudio audio = GetAudio(id);
			List<AudioParameter> pars = parameter.Params.TransParameters();
			EventInstance val = InternalPlayBGM(id, (audio == null) ? string.Empty : audio.EventPath, audio?.EventType ?? 0, parameter.Volume, pars, parameter.CanReturn, parameter.StopMode, parameter.FadeInTime, parameter.FadeOutTime);
			if (!((EventInstance)(ref val)).isValid())
			{
				if (EnableAudioDebug)
				{
					Toast.ShowError($"播放id为{id}的bgm失败");
				}
			}
			else
			{
				curBgm = id;
			}
		}
		catch (Exception)
		{
		}
	}

	public void PlayBgmWithIdCheck(int id, FMOD_Define.BgmParameter parameter)
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			DRAudio audio = GetAudio(id);
			if (audio != null)
			{
				List<AudioParameter> pars = parameter.Params.TransParameters();
				EventInstance val = InternalPlayBGM(id, audio.EventPath, audio.EventType, parameter.Volume, pars, parameter.CanReturn, parameter.StopMode, parameter.FadeInTime, parameter.FadeOutTime, replaceIfSame: true);
				if (((EventInstance)(ref val)).isValid())
				{
					curBgm = id;
				}
			}
		}
		catch (Exception)
		{
		}
	}

	public void SetBgmParameter(int id, FMOD_Define.BgmParameter parameter)
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		DRAudio audio = GetAudio(id);
		List<AudioParameter> parameters = parameter.Params.TransParameters();
		SetBgmParameter(id, (audio == null) ? string.Empty : audio.EventPath, audio?.EventType ?? 0, parameter.Volume, parameter.CanReturn, parameter.StopMode, parameters);
	}

	public void SetCurBgmParameter(FMOD_Define.BgmParameter parameter)
	{
		List<AudioParameter> parameters = parameter.Params.TransParameters();
		SetBgmParameter(parameter.Volume, parameters);
	}

	public void SetCurBgmParameter(List<AudioParameterSerializable> parameters)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		EventInstance val = InternalGetCurrentBgmEventInstance();
		float volume = default(float);
		((EventInstance)(ref val)).getVolume(ref volume);
		SetBgmParameter(volume, parameters.TransParameters());
	}

	public void StopBgm(int id, STOP_MODE stopMode = (STOP_MODE)0, bool clearCache = false, float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		if (curBgm == id)
		{
			DRAudio audio = GetAudio(id);
			if (StopBGM(id, (audio == null) ? string.Empty : audio.EventPath, audio?.EventType ?? 0, stopMode, clearCache, fadeInTime, fadeOutTime))
			{
				curBgm = -1;
			}
		}
	}

	public void StopCurBgm(STOP_MODE stopMode = (STOP_MODE)0, bool clearCache = false, float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		if (curBgm != -1)
		{
			InternalStopCurBgm(stopMode, clearCache, fadeInTime, fadeOutTime);
			_ = curBgm;
			InternalGetCurrentBgmID();
			curBgm = InternalGetCurrentBgmID();
		}
	}

	public void SetBgmPause(bool state, float fadeTime = 3f)
	{
		if (curBgm != -1)
		{
			InternalSetBgmPause(state, fadeTime);
		}
	}

	public void PlayStoryBGM(int id, FMOD_Define.BgmParameter parameter)
	{
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			DRAudio audio = GetAudio(id);
			List<AudioParameter> pars = parameter.Params.TransParameters();
			GetAudioInfoAndInstance(AudioGroupType.StoryBGM, id, audio.EventPath, audio.EventType, out var audioGroup, out var audioInfo, out var eventInstance);
			if (id == audioInfo.id && audioGroup != null && ((EventInstance)(ref eventInstance)).isValid())
			{
				((EventInstance)(ref eventInstance)).setTimelinePosition(0);
			}
			EventInstance val = PlayStoryBGM(id, (audio == null) ? string.Empty : audio.EventPath, audio?.EventType ?? 0, parameter.Volume, pars, parameter.CanReturn, parameter.StopMode, parameter.FadeInTime);
			if (!((EventInstance)(ref val)).isValid() && EnableAudioDebug)
			{
				Toast.ShowError($"播放id为{id}的剧情bgm失败");
			}
		}
		catch (Exception)
		{
		}
	}

	public void PlayStoryBgmWithIdCheck(int id, FMOD_Define.BgmParameter parameter)
	{
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			DRAudio audio = GetAudio(id);
			List<AudioParameter> pars = parameter.Params.TransParameters();
			EventInstance val = PlayStoryBGM(id, (audio == null) ? string.Empty : audio.EventPath, audio?.EventType ?? 0, parameter.Volume, pars, parameter.CanReturn, parameter.StopMode, parameter.FadeInTime);
			if (!((EventInstance)(ref val)).isValid() && EnableAudioDebug)
			{
				Toast.ShowError($"播放id为{id}的剧情bgm失败");
			}
		}
		catch (Exception)
		{
		}
	}

	public void StopStoryBGM(int id, STOP_MODE stopMode = (STOP_MODE)0, bool clearCache = false, float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		try
		{
			DRAudio audio = GetAudio(id);
			GetAudioInfoAndInstance(AudioGroupType.StoryBGM, id, audio.EventPath, audio.EventType, out var audioGroup, out var _, out var _);
			if (audioGroup != null && audioGroup.GetPeek().Info.id == id)
			{
				StopStoryBGM(fadeInTime, fadeOutTime);
			}
		}
		catch (Exception)
		{
		}
	}

	public void StopCurStoryBgm(STOP_MODE stopMode = (STOP_MODE)0, bool clearCache = false, float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		try
		{
			StopStoryBGM(fadeInTime, fadeOutTime);
		}
		catch (Exception)
		{
		}
	}

	public void SetStoryBgmParameter(int id, FMOD_Define.BgmParameter parameter)
	{
		try
		{
			DRAudio audio = GetAudio(id);
			GetAudioInfoAndInstance(AudioGroupType.StoryBGM, id, audio.EventPath, audio.EventType, out var audioGroup, out var _, out var _);
			if (audioGroup != null && audioGroup.GetPeek().Info.id == id)
			{
				List<AudioParameter> audioParams = parameter.Params.TransParameters();
				audioGroup.GetPeek().SetParameters(audioParams, replace: true);
			}
		}
		catch (Exception)
		{
		}
	}

	public void SetCurStoryBgmParameter(FMOD_Define.BgmParameter parameter)
	{
		try
		{
			List<AudioParameter> audioParams = parameter.Params.TransParameters();
			GetAudioInfoAndInstance(AudioGroupType.StoryBGM, 0, string.Empty, 0, out var audioGroup, out var _, out var _);
			audioGroup.GetPeek().SetParameters(audioParams, replace: true);
		}
		catch (Exception)
		{
		}
	}

	public void SetStoryBgmPause(bool state, float fadeTime = 3f)
	{
		try
		{
			List<AudioParameter> audioParams = (state ? AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, fadeTime) : AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, fadeTime));
			GetAudioInfoAndInstance(AudioGroupType.StoryBGM, 0, string.Empty, 0, out var audioGroup, out var _, out var _);
			audioGroup.GetPeek().SetParameters(audioParams, replace: false, temporary: true);
			audioGroup.GetPeek().SetPaused(state);
		}
		catch (Exception)
		{
		}
	}

	public void ClearBGM(List<AudioParameter> fadeOutParams = null)
	{
		if (cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			value.Dispose(fadeOutParams);
		}
	}

	public void ClearTemp(List<AudioParameter> fadeOutParams = null)
	{
		foreach (KeyValuePair<EventInstance, AudioItem> cacheAudioItem in cacheAudioItems)
		{
			cacheAudioItem.Value.SetParameters(fadeOutParams, replace: false, temporary: true);
			cacheAudioItem.Value.Stop((STOP_MODE)0);
			cacheAudioItem.Value.Dispose();
		}
		cacheAudioItems.Clear();
	}

	public VoiceGroup RegisterGroup(VoiceGroupEnum groupEnum)
	{
		return RegisterGroup((long)groupEnum);
	}

	public VoiceGroup RegisterGroup(long groupUid)
	{
		if (voiceGroups.ContainsKey(groupUid))
		{
			return voiceGroups[groupUid];
		}
		VoiceGroup voiceGroup = VoiceGroup.Create(groupUid);
		voiceGroups.Add(groupUid, voiceGroup);
		return voiceGroup;
	}

	public bool UnRegisterGroup(VoiceGroupEnum groupEnum, bool stopVoice = false, List<AudioParameter> fadeOutParams = null)
	{
		return UnRegisterGroup((long)groupEnum, stopVoice, fadeOutParams);
	}

	public bool UnRegisterGroup(long groupUid, bool stopVoice = false, List<AudioParameter> fadeOutParams = null)
	{
		if (voiceGroups.ContainsKey(groupUid))
		{
			voiceGroups[groupUid]?.Dispose(stopVoice, fadeOutParams);
			voiceGroups[groupUid] = null;
			voiceGroups.Remove(groupUid);
			return true;
		}
		return false;
	}

	public void Play(long groupUid, int id, int priority = 0, float volume = 1f, List<AudioParameterSerializable> pars = null)
	{
		if (!voiceGroups.TryGetValue(groupUid, out var value))
		{
			return;
		}
		DRAudio audio = GetAudio(id);
		if (audio == null)
		{
			return;
		}
		List<AudioParameter> pars2 = pars.TransParameters();
		try
		{
			InternalPlayInGroup(value.Group, id, audio.EventPath, audio.EventType, priority, volume, pars2, checkPriority: true);
		}
		catch (Exception)
		{
		}
	}

	public void Play(long groupUid, int id, Transform followTransform, int priority = 0, float volume = 1f, List<AudioParameterSerializable> pars = null)
	{
		if (!voiceGroups.TryGetValue(groupUid, out var value))
		{
			return;
		}
		DRAudio audio = GetAudio(id);
		if (audio == null)
		{
			return;
		}
		List<AudioParameter> pars2 = pars.TransParameters();
		try
		{
			InternalPlayInGroup(value.Group, id, audio.EventPath, audio.EventType, priority, volume, pars2, followTransform, checkPriority: true);
		}
		catch (Exception)
		{
		}
	}

	public void StopAllVoice()
	{
		if (voiceGroups == null)
		{
			return;
		}
		foreach (VoiceGroup value in voiceGroups.Values)
		{
			value.Stop();
		}
	}

	public VoiceGroup RegisterEntityGroup(int groupUid)
	{
		if (entityVoiceGroups.ContainsKey(groupUid))
		{
			return entityVoiceGroups[groupUid];
		}
		VoiceGroup voiceGroup = VoiceGroup.Create(groupUid);
		entityVoiceGroups.Add(groupUid, voiceGroup);
		return voiceGroup;
	}

	public bool UnRegisterEntityGroup(int groupUid, bool stopVoice = false)
	{
		if (entityVoiceGroups.ContainsKey(groupUid))
		{
			entityVoiceGroups[groupUid]?.Dispose(stopVoice);
			entityVoiceGroups[groupUid] = null;
			entityVoiceGroups.Remove(groupUid);
			return true;
		}
		return false;
	}

	public void PlayEntityVoice(int groupUid, int id, int priority = 0, float volume = 1f, List<AudioParameterSerializable> pars = null)
	{
		if (!entityVoiceGroups.TryGetValue(groupUid, out var value))
		{
			return;
		}
		DRAudio audio = GetAudio(id);
		if (audio == null)
		{
			return;
		}
		List<AudioParameter> pars2 = pars.TransParameters();
		try
		{
			InternalPlayInGroup(value.Group, id, audio.EventPath, audio.EventType, priority, volume, pars2, checkPriority: true);
		}
		catch (Exception)
		{
		}
	}

	public bool PlayGlobalSnapshot(int id, FMOD_Define.SoundEffectParameter parameter = default(FMOD_Define.SoundEffectParameter))
	{
		DRAudio audio = GetAudio(id);
		List<AudioParameter> audioParameters = parameter.Params.TransParameters();
		return PlaySnapshot(AudioDef.GLOBAL_SNAPSHOTGROUP_ID, null, id, (audio == null) ? string.Empty : audio.EventPath, parameter.Volume, audioParameters);
	}

	public bool StopGlobalSnapshot(int id, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		return StopSnapshot(AudioDef.GLOBAL_SNAPSHOTGROUP_ID, id, stopMode);
	}

	public bool ClearGlobalSnapshot()
	{
		return false;
	}

	public bool ResetGlobalSnapshotRef(int id)
	{
		return ResetGlobalSnapshotRef(id);
	}

	public bool ResetAllGlobalSnapshotRef()
	{
		return ResetAllGlobalSnapshotRef();
	}

	public bool PlayLocalSnapshot(Transform parent, int id, FMOD_Define.SoundEffectParameter parameter = default(FMOD_Define.SoundEffectParameter))
	{
		DRAudio audio = GetAudio(id);
		if (audio == null)
		{
			return false;
		}
		if (parent == null)
		{
			return false;
		}
		return PlaySnapshot(parent.GetInstanceID(), parent, id, audio.EventPath, parameter.Volume, parameter.Params.TransParameters());
	}

	public bool StopLocalSnapshot(Transform parent, int id, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		if (GetAudio(id) == null)
		{
			return false;
		}
		if (parent == null)
		{
			return false;
		}
		bool result = StopSnapshot(parent.GetInstanceID(), id, stopMode);
		TryDisposeEmptyLocalSnapshotGroup(parent.GetInstanceID());
		return result;
	}

	private bool PlaySnapshot(int groupKey, Transform parent, int id, string path, float volume = 1f, List<AudioParameter> audioParameters = null)
	{
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheSnapshotGroups.TryGetValue(groupKey, out var value))
		{
			value = new SnapshotGroup(parent);
			cacheSnapshotGroups[groupKey] = value;
		}
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, 0, out var audioInfo, out var eventInstance);
		return value.PlaySnapshot(id, audioInfo, eventInstance, volume, audioParameters);
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

	private void SubscribeMsg()
	{
		IMessenger service = Context.GetApplicationContext().GetService<IMessenger>();
		SetVCAVolume(FMOD_Define.VCA_MAIN, GameEntry.Setting.GetFloat("主声音"));
		SetVCAVolume(FMOD_Define.VCA_MUSIC, GameEntry.Setting.GetFloat("音乐音量"));
		SetVCAVolume(FMOD_Define.VCA_VOICE, GameEntry.Setting.GetFloat("语音音量"));
		SetVCAVolume(FMOD_Define.VCA_SFX, GameEntry.Setting.GetFloat("音效音量"));
		mainVolumeChanged = service.Subscribe("GameSetting_主声音", delegate(GameSettingConfigHelper.SettingData setting)
		{
			SetVCAVolume(FMOD_Define.VCA_MAIN, setting.Value);
		});
		musicVolumeChanged = service.Subscribe("GameSetting_音乐音量", delegate(GameSettingConfigHelper.SettingData setting)
		{
			SetVCAVolume(FMOD_Define.VCA_MUSIC, setting.Value);
		});
		soundVolumeChanged = service.Subscribe("GameSetting_音效音量", delegate(GameSettingConfigHelper.SettingData setting)
		{
			SetVCAVolume(FMOD_Define.VCA_SFX, setting.Value);
		});
		voiceVolumeChanged = service.Subscribe("GameSetting_语音音量", delegate(GameSettingConfigHelper.SettingData setting)
		{
			SetVCAVolume(FMOD_Define.VCA_VOICE, setting.Value);
		});
	}

	public bool SetVCAVolume(string path, float volume)
	{
		try
		{
			return GameEntry.Audio.SetVCAVolume(path, volume);
		}
		catch (Exception)
		{
			return false;
		}
	}

	public async UniTask LoadingClear()
	{
		await UniTask.WaitForSeconds(AudioDef.DefaultWaitTime);
		List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, 1f);
		List<VoiceGroup> list = entityVoiceGroups.Values.ToList();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			list[num]?.Dispose(stopVoice: true, fadeOutParameters);
			list[num] = null;
		}
		entityVoiceGroups.Clear();
		ClearTemp(fadeOutParameters);
		ClearBGM(fadeOutParameters);
		CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeOutParameters);
		GameEntry.Audio.UnloadAllBanks();
	}

	public override void Dispose()
	{
		base.Dispose();
		List<VoiceGroup> list = voiceGroups.Values.ToList();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			list[num]?.Dispose();
			list[num] = null;
		}
		voiceGroups.Clear();
		voiceGroups = null;
		List<VoiceGroup> list2 = entityVoiceGroups.Values.ToList();
		for (int num2 = list2.Count - 1; num2 >= 0; num2--)
		{
			list2[num2]?.Dispose();
			list2[num2] = null;
		}
		entityVoiceGroups.Clear();
		entityVoiceGroups = null;
		foreach (KeyValuePair<int, SnapshotGroup> cacheSnapshotGroup in cacheSnapshotGroups)
		{
			cacheSnapshotGroup.Value.Dispose();
		}
		cacheSnapshotGroups.Clear();
		foreach (KeyValuePair<AudioGroupType, AudioGroup> cacheAudioGroup in cacheAudioGroups)
		{
			cacheAudioGroup.Value.Dispose();
		}
		cacheAudioGroups.Clear();
		foreach (KeyValuePair<EventInstance, AudioItem> cacheAudioItem in cacheAudioItems)
		{
			cacheAudioItem.Value.Dispose();
		}
		cacheAudioItems.Clear();
		ClearTemp();
	}

	public void DebugBgmList(string title = "")
	{
		_ = BgmLog;
	}

	public void RegisterHostingAudio(EventInstance eventInstance)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		hostingAudios.Add(eventInstance);
	}

	public void SetHostingAudioPause(bool pause)
	{
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		if (hostingAudios == null)
		{
			return;
		}
		float num2 = default(float);
		float num3 = default(float);
		for (int num = hostingAudios.Count - 1; num >= 0; num--)
		{
			EventInstance val = hostingAudios[num];
			if (!((EventInstance)(ref val)).isValid())
			{
				hostingAudios.RemoveAt(num);
			}
			else
			{
				val = hostingAudios[num];
				((EventInstance)(ref val)).getVolume(ref num2, ref num3);
				val = hostingAudios[num];
				((EventInstance)(ref val)).setPaused(pause);
			}
		}
	}

	private void GetAudioInfoAndInstance(AudioGroupType audioGroupType, int id, string path, int eventType, out AudioGroup audioGroup, out AudioInfo audioInfo, out EventInstance eventInstance)
	{
		if (!cacheAudioGroups.TryGetValue(audioGroupType, out audioGroup))
		{
			audioGroup = new AudioGroup();
			cacheAudioGroups[audioGroupType] = audioGroup;
		}
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, eventType, out audioInfo, out eventInstance);
	}

	private EventInstance GetEventInstance(int id, string path, int eventType, float volume = 1f, List<AudioParameter> pars = null)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		if (string.IsNullOrEmpty(path))
		{
			return new EventInstance(IntPtr.Zero);
		}
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, eventType, out var audioInfo, out var eventInstance);
		if (!((EventInstance)(ref eventInstance)).isValid())
		{
			return eventInstance;
		}
		AudioItem value = AudioItem.Create(audioInfo, eventInstance, int.MaxValue, volume, pars, GameEntry.Audio.transform, clearStack: false, (STOP_MODE)0);
		if (cacheAudioItems.TryGetValue(eventInstance, out var value2))
		{
			value2.Stop(value2.StopMode);
			value2.Dispose();
		}
		cacheAudioItems[eventInstance] = value;
		return eventInstance;
	}

	private void SetInstanceParams(EventInstance eventInstance, float volume = 1f, List<AudioParameter> pars = null)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		if (cacheAudioItems.TryGetValue(eventInstance, out var value))
		{
			value.SetVolume(volume).SetParameters(pars);
		}
	}

	private EventInstance InternalPlay(int id, string path, int eventType, AudioGroupType audioGroupType, int priority = 0, float volume = 1f, List<AudioParameter> pars = null, bool checkPriority = true)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		GetAudioInfoAndInstance(audioGroupType, id, path, eventType, out var audioGroup, out var audioInfo, out var eventInstance);
		if (checkPriority)
		{
			audioGroup.PlayHighPriorityAndStopCurrent(audioInfo, eventInstance, priority, volume, pars, null, canReturn: false, (STOP_MODE)0, null, null);
		}
		else
		{
			audioGroup.Play(audioInfo, eventInstance, priority, volume, pars, null, canReturn: false, (STOP_MODE)0, null, null);
		}
		return eventInstance;
	}

	private void InternalPlayInGroup(AudioGroup audioGroup, int id, string path, int eventType, int priority, float volume, List<AudioParameter> pars, bool checkPriority)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, eventType, out var audioInfo, out var eventInstance);
		if (checkPriority)
		{
			audioGroup.PlayHighPriorityAndStopCurrent(audioInfo, eventInstance, priority, volume, pars, null, canReturn: false, (STOP_MODE)0, null, null);
		}
		else
		{
			audioGroup.Play(audioInfo, eventInstance, priority, volume, pars, null, canReturn: false, (STOP_MODE)0, null, null);
		}
	}

	private void InternalPlayInGroup(AudioGroup audioGroup, int id, string path, int eventType, int priority, float volume, List<AudioParameter> pars, Transform transform, bool checkPriority)
	{
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		GameEntry.Audio.GetAudioInfoAndInstance(id, path, eventType, out var audioInfo, out var eventInstance);
		if (checkPriority)
		{
			audioGroup.PlayHighPriorityAndStopCurrent(audioInfo, eventInstance, priority, volume, pars, transform, canReturn: false, (STOP_MODE)0, null, null);
		}
		else
		{
			audioGroup.Play(audioInfo, eventInstance, priority, volume, pars, transform, canReturn: false, (STOP_MODE)0, null, null);
		}
	}

	private EventInstance InternalPlayBGM(int id, string path, int eventType, float volume = -1f, List<AudioParameter> pars = null, bool canReturn = true, STOP_MODE stopMode = (STOP_MODE)0, float fadeInTime = 3f, float fadeOutTime = 3f, bool replaceIfSame = false)
	{
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		GetAudioInfoAndInstance(AudioGroupType.BGM, id, path, eventType, out var audioGroup, out var audioInfo, out var eventInstance);
		List<AudioParameter> fadeInParameters = AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, fadeInTime);
		List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, fadeOutTime);
		if (!replaceIfSame)
		{
			audioGroup.PlayAndStopCurrent(audioInfo, eventInstance, volume, pars, null, canReturn, stopMode, fadeInParameters, fadeOutParameters);
		}
		else
		{
			audioGroup.PlayAndReplaceIfSame(audioInfo, eventInstance, volume, pars, null, canReturn, stopMode, fadeInParameters, fadeOutParameters);
		}
		CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeInParameters);
		CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeOutParameters);
		if (InStoryMode)
		{
			((EventInstance)(ref eventInstance)).setPaused(true);
		}
		return eventInstance;
	}

	private void InternalStopCurBgm(STOP_MODE stopMode, bool clearStack, float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		List<AudioParameter> fadeInParameters = AudioManagerExtension.GetFadeInParameters(AudioDef.DefaultFadeInParams.x, fadeInTime);
		List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, fadeOutTime);
		if (cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			value.Stop(stopMode, fadeInParameters, fadeOutParameters, clearStack, forcePlay: false, playback: true);
		}
	}

	private int InternalGetCurrentBgmID()
	{
		if (!cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			return -1;
		}
		return value.GetPeek().Info.id;
	}

	private EventInstance InternalGetCurrentBgmEventInstance()
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		if (!cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			return new EventInstance(IntPtr.Zero);
		}
		return value.GetPeek().EventInstance;
	}

	private void InternalSetBgmPause(bool state, float fadeTime = 3f)
	{
		if (cacheAudioGroups.TryGetValue(AudioGroupType.BGM, out var value))
		{
			List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, fadeTime);
			value.GetPeek().SetParameters(fadeOutParameters, replace: false, temporary: true);
			value.GetPeek().SetPaused(state, fading: true);
			CollectionPool<List<AudioParameter>, AudioParameter>.Release(fadeOutParameters);
		}
	}
}
