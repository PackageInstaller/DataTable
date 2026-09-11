using System.Collections.Generic;
using Config;
using LitJson;
using P08.CriLipsEx;
using UnityEngine;

public class AudioManager : MonoBehaviour
{
	public const string MUSIC_KEY_NAME = "music";

	public const string VOICE_KEY_NAME = "voice";

	public const string EFFECT_KEY_NAME = "effect";

	public const string VICTORY_SELECTOR_NAME = "Count";

	public const string VICTORY_SELECTOR_LAEBL_SINGLE = "single";

	public const string VICTORY_SELECTOR_LAEBL_DOUBLE = "double";

	public const string VICTORY_SELECTOR_LAEBL_TRIPLE = "triple";

	public const string VICTORY_SELECTOR_LABEL_NONE = "nocount";

	public const string MUSIC_CATEGORY_NAME = "music";

	public const string JINGLE_CATEGORY_NAME = "jingle";

	public const string VOICE_CATEGORY_NAME = "vocal";

	public const string EFFECT_CATEGORY_NAME = "sfx";

	public const string VOICE_LANGUAGE_KEY = "voice_language";

	public static bool BattleTeammateVoiceSwitch = true;

	private static GameObject go;

	private SoundVolumeConfig m_volumeConfig;

	public static AudioManager mInstance;

	public CriAtomListener mListener;

	public CriAtom mCriAtom;

	public string mAcfFile = "Eyes_of_deep_space.acf";

	private Dictionary<string, CriAtomSource> mPlayers = new Dictionary<string, CriAtomSource>();

	private bool _audioMasterMute;

	private Dictionary<string, bool> m_hasVoiceFile = new Dictionary<string, bool>();

	private LinkedList<string> m_usedBGMList = new LinkedList<string>();

	private LinkedList<string> m_useEffectList = new LinkedList<string>();

	private LinkedList<string> m_useVoiceList = new LinkedList<string>();

	public static AudioManager Instance
	{
		get
		{
			if (mInstance == null)
			{
				Create();
				mInstance.GetPlayer("music");
				mInstance.GetPlayer("voice");
				mInstance.GetPlayer("effect");
			}
			return mInstance;
		}
	}

	public float MusicVolume
	{
		get
		{
			if (m_volumeConfig == null)
			{
				LoadSoundPlayerConfig();
			}
			if (m_volumeConfig == null)
			{
				return 0.5f;
			}
			return m_volumeConfig.sound_music;
		}
		set
		{
			if (m_volumeConfig == null)
			{
				LoadSoundPlayerConfig();
			}
			m_volumeConfig.sound_music = value;
		}
	}

	public float EffectVolume
	{
		get
		{
			if (m_volumeConfig == null)
			{
				LoadSoundPlayerConfig();
			}
			if (m_volumeConfig == null)
			{
				return 0.5f;
			}
			return m_volumeConfig.sound_effect;
		}
		set
		{
			if (m_volumeConfig == null)
			{
				LoadSoundPlayerConfig();
			}
			m_volumeConfig.sound_effect = value;
		}
	}

	public float VoiceVolume
	{
		get
		{
			if (m_volumeConfig == null)
			{
				LoadSoundPlayerConfig();
			}
			if (m_volumeConfig == null)
			{
				return 0.5f;
			}
			return m_volumeConfig.sound_voice;
		}
		set
		{
			if (m_volumeConfig == null)
			{
				LoadSoundPlayerConfig();
			}
			m_volumeConfig.sound_voice = value;
		}
	}

	private void ClearUsedList()
	{
		m_usedBGMList.Clear();
		m_useEffectList.Clear();
		m_useVoiceList.Clear();
	}

	private LinkedList<string> GetUsedSheetList(string key, out int limitCount)
	{
		limitCount = 0;
		switch (key)
		{
		case "music":
			limitCount = 6;
			return m_usedBGMList;
		case "voice":
			limitCount = 10;
			return m_useVoiceList;
		case "effect":
			limitCount = 15;
			return m_useEffectList;
		default:
			Debug.LogError("=====>>>> 未定义声音操作类型:" + key);
			return null;
		}
	}

	public void UpdateUsedSheetList(string key, string sheetName)
	{
		LinkedList<string> usedSheetList = GetUsedSheetList(key, out var limitCount);
		if (usedSheetList != null && (usedSheetList.Count <= 0 || !(usedSheetList.Last.Value == sheetName)))
		{
			usedSheetList.Remove(sheetName);
			if (usedSheetList.Count >= limitCount)
			{
				string value = usedSheetList.First.Value;
				RemoveCue(value);
				usedSheetList.RemoveFirst();
			}
			usedSheetList.AddLast(sheetName);
		}
	}

	public void RemoveUsedSheetList(string key)
	{
		if (mPlayers.ContainsKey(key))
		{
			mPlayers[key].cueName = string.Empty;
			mPlayers[key].Stop();
		}
		LinkedList<string> usedSheetList = GetUsedSheetList(key, out var _);
		LinkedList<string>.Enumerator enumerator = usedSheetList.GetEnumerator();
		while (enumerator.MoveNext())
		{
			RemoveCue(enumerator.Current);
		}
		usedSheetList.Clear();
	}

	public static void Create()
	{
		if (go == null)
		{
			go = GameObject.Find("CriWareLibraryInitializer");
			if (go == null)
			{
				go = Object.Instantiate(Resources.Load<GameObject>("CriWareLibraryInitializer"));
				go.name = "CriWareLibraryInitializer";
			}
			mInstance = U3DUtil.Get<AudioManager>(go);
		}
	}

	public void SetListener(GameObject listener, bool isActive = true)
	{
		if (mListener != null)
		{
			Object.DestroyImmediate(mListener);
		}
		if (listener == null)
		{
			listener = Camera.main.gameObject;
			if (listener == null)
			{
				Debug.LogError("SetListener listener gameObject is null");
			}
		}
		mListener = U3DUtil.Get<CriAtomListener>(listener);
		mListener.activateListenerOnEnable = isActive;
	}

	public void SetVolume(string key, float volume)
	{
		switch (key)
		{
		case "music":
			MusicVolume = volume;
			SetVolumeOfCategory("music", volume);
			SetVolumeOfCategory("jingle", volume);
			break;
		case "effect":
			EffectVolume = volume;
			SetVolumeOfCategory("sfx", volume);
			break;
		case "voice":
			VoiceVolume = volume;
			SetVolumeOfCategory("vocal", volume);
			break;
		default:
			Debug.LogError("=====>>>>> 未定义声音操作类型:" + key);
			break;
		}
	}

	public float GetVolume(string key)
	{
		if (_audioMasterMute)
		{
			return 0f;
		}
		switch (key)
		{
		case "music":
			return MusicVolume;
		case "effect":
			return EffectVolume;
		case "voice":
			return VoiceVolume;
		default:
			Debug.LogError("=====>>>>> 未定义声音操作类型:" + key);
			return 0.5f;
		}
	}

	public void AddCue(string key, string name, bool useStream)
	{
		UpdateUsedSheetList(key, name);
		if (CriAtom.GetCueSheet(name) == null)
		{
			CriAtom.AddCueSheet(name, name + ".acb", useStream ? (name + ".awb") : string.Empty);
		}
		CriLipsExAtom.AddCueSheet(name);
	}

	public void RemoveCue(string name)
	{
		if (CriAtom.GetCueSheet(name) != null)
		{
			CriAtom.RemoveCueSheet(name);
		}
		CriLipsExAtom.RemoveCueSheet(name);
	}

	public bool HasVoiceFile(string cueSheetName)
	{
		if (!m_hasVoiceFile.ContainsKey(cueSheetName))
		{
			m_hasVoiceFile[cueSheetName] = CriWareExtension.HasVoiceFileInPersistentData(cueSheetName + ".acb");
		}
		if (!m_hasVoiceFile[cueSheetName])
		{
			return false;
		}
		return true;
	}

	public CriAtomExPlayback Play(string key, string cueSheetName, string cueName, bool useStream)
	{
		if (mListener == null)
		{
			SetListener(null);
			if (mListener == null)
			{
				Debug.LogError("set CriAtomListener before playing please!");
				return new CriAtomExPlayback(uint.MaxValue);
			}
		}
		if (string.IsNullOrEmpty(cueSheetName) || string.IsNullOrEmpty(cueName))
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		if (key == "voice" && !HasVoiceFile(cueSheetName))
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		AddCue(key, cueSheetName, useStream);
		CriAtomSource player = GetPlayer(key);
		if (player == null)
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		if (key == "music" && cueName == player.cueName)
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		player.cueSheet = cueSheetName;
		player.cueName = cueName;
		return player.Play();
	}

	public void SetStartTime(string key, long time)
	{
		CriAtomSource player = GetPlayer(key);
		if (!(player == null))
		{
			player.startTime = (int)time;
		}
	}

	public void PlayUIAudio(int id)
	{
		if (ConfigHelper.GetInstance().TryGetConfig<UIAudio>(id, out var config) && ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(config.AudioID, out var config2))
		{
			Play(config.SourceKey, config2.CueSheet, config2.CueName, config2.UseStream);
		}
	}

	public void Pause(string key, bool isPaused)
	{
		if (mListener == null)
		{
			Debug.LogError("set CriAtomListener before playing please!");
			return;
		}
		CriAtomSource player = GetPlayer(key);
		if (player != null)
		{
			player.Pause(isPaused);
		}
	}

	public void PauseAll(bool isPaused)
	{
		if (mListener == null)
		{
			Debug.LogError("set CriAtomListener before playing please!");
			return;
		}
		foreach (KeyValuePair<string, CriAtomSource> mPlayer in mPlayers)
		{
			mPlayer.Value.Pause(isPaused);
		}
	}

	public void Stop(string key)
	{
		if (mListener == null)
		{
			Debug.LogError("set CriAtomListener before playing please!");
		}
		else if (mPlayers.ContainsKey(key))
		{
			mPlayers[key].cueName = string.Empty;
			mPlayers[key].Stop();
		}
	}

	public void StopImmediate(string key)
	{
		if (mListener == null)
		{
			Debug.LogError("set CriAtomListener before playing please!");
		}
		else if (mPlayers.ContainsKey(key))
		{
			mPlayers[key].cueName = string.Empty;
			mPlayers[key].player.StopWithoutReleaseTime();
		}
	}

	public void StopAll()
	{
		if (mListener == null)
		{
			Debug.LogError("set CriAtomListener before playing please!");
			return;
		}
		foreach (KeyValuePair<string, CriAtomSource> mPlayer in mPlayers)
		{
			mPlayer.Value.cueName = string.Empty;
			mPlayer.Value.Stop();
		}
	}

	public bool IsStopped(string key)
	{
		if (mListener == null)
		{
			Debug.LogError("set CriAtomListener before playing please!");
			return true;
		}
		if (mPlayers.ContainsKey(key))
		{
			return mPlayers[key].player.GetStatus() == CriAtomExPlayer.Status.Stop;
		}
		return true;
	}

	public void CleanCriAtom()
	{
		for (int i = 0; i < mCriAtom.cueSheets.Length; i++)
		{
			CriAtomCueSheet criAtomCueSheet = mCriAtom.cueSheets[i];
			if (criAtomCueSheet.acb != null)
			{
				criAtomCueSheet.acb.Dispose();
				criAtomCueSheet.acb = null;
			}
		}
		mCriAtom.cueSheets = new CriAtomCueSheet[0];
		ClearUsedList();
	}

	public void DestoryCriAtom()
	{
		StopAll();
		CleanCriAtom();
		Object.DestroyImmediate(mCriAtom);
		CreateCriAtom();
	}

	public void DestoryPlayer(string key)
	{
		if (mPlayers.ContainsKey(key))
		{
			Object.DestroyImmediate(mPlayers[key].gameObject);
			mPlayers.Remove(key);
		}
	}

	public void CreateCriAtom()
	{
		if (mCriAtom == null)
		{
			mCriAtom = U3DUtil.Get<CriAtom>(go);
			mCriAtom.acfFile = mAcfFile;
		}
	}

	public void CreateCriAtom(string acf)
	{
		if (mCriAtom == null)
		{
			mCriAtom = U3DUtil.Get<CriAtom>(go);
			mCriAtom.acfFile = acf;
		}
	}

	public bool TryGetCueInfo(string key, string cueSheetName, string cueName, bool useStream, out CriAtomEx.CueInfo cueInfo)
	{
		AddCue(key, cueSheetName, useStream);
		CriAtomExAcb acb = CriAtom.GetAcb(cueSheetName);
		if (acb != null && acb.GetCueInfo(cueName, out cueInfo))
		{
			return true;
		}
		cueInfo = default(CriAtomEx.CueInfo);
		return false;
	}

	public int GetCueInfoLength(string key, string cueSheetName, string cueName, bool useStream)
	{
		if (key == "voice" && CriLipsExAtom.TryGetCueLength(cueSheetName, cueName, out var pMilliLength))
		{
			return pMilliLength;
		}
		if (TryGetCueInfo(key, cueSheetName, cueName, useStream, out var cueInfo))
		{
			return (int)cueInfo.length;
		}
		return 0;
	}

	private void Awake()
	{
		CreateCriAtom();
	}

	public void LoadSoundPlayerConfig()
	{
		string json = PlayerPrefs.GetString("userSetting");
		m_volumeConfig = JsonMapper.ToObject<SoundVolumeConfig>(json);
		if (m_volumeConfig != null)
		{
			m_volumeConfig.sound_music /= 100f;
			m_volumeConfig.sound_effect /= 100f;
			m_volumeConfig.sound_voice /= 100f;
		}
		else
		{
			m_volumeConfig = new SoundVolumeConfig();
		}
	}

	public CriAtomSource GetPlayer(string key)
	{
		if (!mPlayers.TryGetValue(key, out var value) || value == null)
		{
			GameObject gameObject = new GameObject(key);
			gameObject.transform.SetParent(base.transform, worldPositionStays: false);
			value = gameObject.AddComponent<CriAtomSource>();
			if ("music" == key && PlayerPrefs.GetInt("SPECTRUM") == 0)
			{
				gameObject.AddComponent<CriwareSpectrum>().initialize(value);
			}
			if (!mPlayers.ContainsKey(key))
			{
				mPlayers.Add(key, value);
			}
			else
			{
				mPlayers[key] = value;
			}
			SetVolume(key, GetVolume(key));
		}
		return value;
	}

	public void SetVolumeOfCategory(string pName, float pValue)
	{
		if (_audioMasterMute)
		{
			pValue = 0f;
		}
		CriAtomExCategory.SetVolume(pName, pValue);
	}

	public void SetAisacControl(string pKey, string pControlName, float pValue)
	{
		CriAtomSource player = GetPlayer(pKey);
		if (player != null)
		{
			player.SetAisacControl(pControlName, pValue);
		}
	}

	public void ResetParameters(string pKey)
	{
		CriAtomSource player = GetPlayer(pKey);
		if (player != null && player.player != null)
		{
			player.player.ResetParameters();
		}
	}

	public void SetAisacControlOfCategory(string pName, string pControlName, float pValue)
	{
		CriAtomExCategory.SetAisacControl(pName, pControlName, pValue);
	}

	public void SetSelectorLabel(string pKey, string pSelector, string pLabel)
	{
		CriAtomSource player = GetPlayer(pKey);
		if (player != null)
		{
			player.player.SetSelectorLabel(pSelector, pLabel);
		}
	}

	public void ApplyDspBusSnapshot(string pSnapshotName, int pTimeMS)
	{
		CriAtomEx.ApplyDspBusSnapshot(pSnapshotName, pTimeMS);
	}

	public void OnSceneRestart()
	{
		CriAtomSource player = GetPlayer("music");
		if (player != null && player.cueName == "ui_battle_ultimate_in")
		{
			Play("music", "ui_battle", "ui_battle_ultimate_out", useStream: false);
		}
	}

	public void SetAudioMasterMute(bool enable)
	{
		if (_audioMasterMute != enable)
		{
			_audioMasterMute = enable;
			SetVolume("music", MusicVolume);
			SetVolume("effect", EffectVolume);
			SetVolume("voice", VoiceVolume);
		}
	}

	public bool GetAudioMasterMuteState()
	{
		return _audioMasterMute;
	}

	public void SetLocalizationFlag(string flag)
	{
		if (CriWareExtension.localizationFlag != flag)
		{
			RemoveUsedSheetList("voice");
		}
		CriWareExtension.localizationFlag = flag;
		CriLipsExAtom.ClearNullFileList();
		m_hasVoiceFile.Clear();
		PlayerPrefs.SetString("voice_language", flag);
	}

	public string GetLocalizationFlag()
	{
		return CriWareExtension.localizationFlag;
	}
}
