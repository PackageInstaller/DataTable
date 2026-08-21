#define ENABLE_FATAL_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework.Resource;
using GameFramework.Sound;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.SceneManagement;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
public sealed class SoundComponent : GameFrameworkComponent
{
	[Serializable]
	private sealed class SoundGroup
	{
		[SerializeField]
		private string m_Name = null;

		[SerializeField]
		private bool m_AvoidBeingReplacedBySamePriority = false;

		[SerializeField]
		private bool m_Mute = false;

		[SerializeField]
		[Range(0f, 1f)]
		private float m_Volume = 1f;

		[SerializeField]
		private int m_AgentHelperCount = 1;

		public string Name => m_Name;

		public bool AvoidBeingReplacedBySamePriority => m_AvoidBeingReplacedBySamePriority;

		public bool Mute => m_Mute;

		public float Volume => m_Volume;

		public int AgentHelperCount => m_AgentHelperCount;
	}

	private const int DefaultPriority = 0;

	private ISoundManager m_SoundManager = null;

	private AudioListener m_AudioListener = null;

	[SerializeField]
	private bool m_EnablePlaySoundUpdateEvent = false;

	[SerializeField]
	private bool m_EnablePlaySoundDependencyAssetEvent = false;

	[SerializeField]
	private Transform m_InstanceRoot = null;

	[SerializeField]
	private AudioMixer m_AudioMixer = null;

	[SerializeField]
	private string m_SoundHelperTypeName = "UnityGameFramework.Runtime.DefaultSoundHelper";

	[SerializeField]
	private SoundHelperBase m_CustomSoundHelper = null;

	[SerializeField]
	private string m_SoundGroupHelperTypeName = "UnityGameFramework.Runtime.DefaultSoundGroupHelper";

	[SerializeField]
	private SoundGroupHelperBase m_CustomSoundGroupHelper = null;

	[SerializeField]
	private string m_SoundAgentHelperTypeName = "UnityGameFramework.Runtime.DefaultSoundAgentHelper";

	[SerializeField]
	private SoundAgentHelperBase m_CustomSoundAgentHelper = null;

	[SerializeField]
	private SoundGroup[] m_SoundGroups = null;

	public int SoundGroupCount => m_SoundManager.SoundGroupCount;

	public AudioMixer AudioMixer => m_AudioMixer;

	protected override void Awake()
	{
		base.Awake();
		m_SoundManager = GameFrameworkEntry.GetModule<ISoundManager>();
		if (m_SoundManager == null)
		{
			Log.Fatal("Sound manager is invalid.");
			return;
		}
		m_AudioListener = base.gameObject.GetOrAddComponent<AudioListener>();
		SceneManager.sceneLoaded += OnSceneLoaded;
		SceneManager.sceneUnloaded += OnSceneUnloaded;
	}

	public override void Init()
	{
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Fatal("Base component is invalid.");
			return;
		}
		m_SoundManager.SetResourceManager(GameFrameworkEntry.GetModule<IResourceManager>());
		SoundHelperBase soundHelperBase = Helper.CreateHelper(m_SoundHelperTypeName, m_CustomSoundHelper);
		if (soundHelperBase == null)
		{
			Log.Error("Can not create sound helper.");
			return;
		}
		soundHelperBase.name = "Sound Helper";
		Transform transform = soundHelperBase.transform;
		transform.SetParent(base.transform);
		transform.localScale = Vector3.one;
		m_SoundManager.SetSoundHelper(soundHelperBase);
		if (m_InstanceRoot == null)
		{
			m_InstanceRoot = new GameObject("Sound Instances").transform;
			m_InstanceRoot.SetParent(base.gameObject.transform);
			m_InstanceRoot.localScale = Vector3.one;
		}
		for (int i = 0; i < m_SoundGroups.Length; i++)
		{
			if (!AddSoundGroup(m_SoundGroups[i].Name, m_SoundGroups[i].AvoidBeingReplacedBySamePriority, m_SoundGroups[i].Mute, m_SoundGroups[i].Volume, m_SoundGroups[i].AgentHelperCount))
			{
				Log.Warning("Add sound group '{0}' failure.", m_SoundGroups[i].Name);
			}
		}
	}

	public override void Shutdown()
	{
		SceneManager.sceneLoaded -= OnSceneLoaded;
		SceneManager.sceneUnloaded -= OnSceneUnloaded;
	}

	public bool HasSoundGroup(string soundGroupName)
	{
		return m_SoundManager.HasSoundGroup(soundGroupName);
	}

	public ISoundGroup GetSoundGroup(string soundGroupName)
	{
		return m_SoundManager.GetSoundGroup(soundGroupName);
	}

	public ISoundGroup[] GetAllSoundGroups()
	{
		return m_SoundManager.GetAllSoundGroups();
	}

	public void GetAllSoundGroups(List<ISoundGroup> results)
	{
		m_SoundManager.GetAllSoundGroups(results);
	}

	public bool AddSoundGroup(string soundGroupName, int soundAgentHelperCount)
	{
		return AddSoundGroup(soundGroupName, soundGroupAvoidBeingReplacedBySamePriority: false, soundGroupMute: false, 1f, soundAgentHelperCount);
	}

	public bool AddSoundGroup(string soundGroupName, bool soundGroupAvoidBeingReplacedBySamePriority, bool soundGroupMute, float soundGroupVolume, int soundAgentHelperCount)
	{
		if (m_SoundManager.HasSoundGroup(soundGroupName))
		{
			return false;
		}
		SoundGroupHelperBase soundGroupHelperBase = Helper.CreateHelper(m_SoundGroupHelperTypeName, m_CustomSoundGroupHelper, SoundGroupCount);
		if (soundGroupHelperBase == null)
		{
			Log.Error("Can not create sound group helper.");
			return false;
		}
		soundGroupHelperBase.name = Utility.Text.Format("Sound Group - {0}", soundGroupName);
		Transform transform = soundGroupHelperBase.transform;
		transform.SetParent(m_InstanceRoot);
		transform.localScale = Vector3.one;
		if ((UnityEngine.Object)(object)m_AudioMixer != null)
		{
			AudioMixerGroup[] array = m_AudioMixer.FindMatchingGroups(Utility.Text.Format("Master/{0}", soundGroupName));
			if (array.Length != 0)
			{
				soundGroupHelperBase.AudioMixerGroup = array[0];
			}
			else
			{
				soundGroupHelperBase.AudioMixerGroup = m_AudioMixer.FindMatchingGroups("Master")[0];
			}
		}
		if (!m_SoundManager.AddSoundGroup(soundGroupName, soundGroupAvoidBeingReplacedBySamePriority, soundGroupMute, soundGroupVolume, soundGroupHelperBase))
		{
			return false;
		}
		for (int i = 0; i < soundAgentHelperCount; i++)
		{
			if (!AddSoundAgentHelper(soundGroupName, soundGroupHelperBase, i))
			{
				return false;
			}
		}
		return true;
	}

	public int[] GetAllLoadingSoundSerialIds()
	{
		return m_SoundManager.GetAllLoadingSoundSerialIds();
	}

	public void GetAllLoadingSoundSerialIds(List<int> results)
	{
		m_SoundManager.GetAllLoadingSoundSerialIds(results);
	}

	public bool IsLoadingSound(int serialId)
	{
		return m_SoundManager.IsLoadingSound(serialId);
	}

	public int PlaySound(string soundAssetName, string soundGroupName)
	{
		return PlaySound(soundAssetName, soundGroupName, 0, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, PlaySoundParams playSoundParams)
	{
		return PlaySound(soundAssetName, soundGroupName, 0, playSoundParams);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, Vector3 worldPosition)
	{
		return PlaySound(soundAssetName, soundGroupName, 0, null, worldPosition, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, object userData)
	{
		return PlaySound(soundAssetName, soundGroupName, 0, null, Vector3.zero, userData);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams)
	{
		return PlaySound(soundAssetName, soundGroupName, priority, playSoundParams, Vector3.zero);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams, Vector3 worldPosition)
	{
		return PlaySound(soundAssetName, soundGroupName, priority, playSoundParams, worldPosition, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams, object userData)
	{
		return m_SoundManager.PlaySound(soundAssetName, soundGroupName, priority, playSoundParams, PlaySoundInfo.Create(Vector3.zero, userData));
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams, Vector3 worldPosition, object userData)
	{
		return m_SoundManager.PlaySound(soundAssetName, soundGroupName, priority, playSoundParams, PlaySoundInfo.Create(worldPosition, userData));
	}

	public bool StopSound(int serialId)
	{
		return m_SoundManager.StopSound(serialId);
	}

	public bool StopSound(int serialId, float fadeOutSeconds)
	{
		return m_SoundManager.StopSound(serialId, fadeOutSeconds);
	}

	public void StopAllLoadedSounds()
	{
		m_SoundManager.StopAllLoadedSounds();
	}

	public void StopAllLoadedSounds(float fadeOutSeconds)
	{
		m_SoundManager.StopAllLoadedSounds(fadeOutSeconds);
	}

	public void StopAllLoadingSounds()
	{
		m_SoundManager.StopAllLoadingSounds();
	}

	public void PauseSound(int serialId)
	{
		m_SoundManager.PauseSound(serialId);
	}

	public void PauseSound(int serialId, float fadeOutSeconds)
	{
		m_SoundManager.PauseSound(serialId, fadeOutSeconds);
	}

	public void ResumeSound(int serialId)
	{
		m_SoundManager.ResumeSound(serialId);
	}

	public void ResumeSound(int serialId, float fadeInSeconds)
	{
		m_SoundManager.ResumeSound(serialId, fadeInSeconds);
	}

	private bool AddSoundAgentHelper(string soundGroupName, SoundGroupHelperBase soundGroupHelper, int index)
	{
		SoundAgentHelperBase soundAgentHelperBase = Helper.CreateHelper(m_SoundAgentHelperTypeName, m_CustomSoundAgentHelper, index);
		if (soundAgentHelperBase == null)
		{
			Log.Error("Can not create sound agent helper.");
			return false;
		}
		soundAgentHelperBase.name = Utility.Text.Format("Sound Agent Helper - {0} - {1}", soundGroupName, index.ToString());
		Transform transform = soundAgentHelperBase.transform;
		transform.SetParent(soundGroupHelper.transform);
		transform.localScale = Vector3.one;
		if ((UnityEngine.Object)(object)m_AudioMixer != null)
		{
			AudioMixerGroup[] array = m_AudioMixer.FindMatchingGroups(Utility.Text.Format("Master/{0}/{1}", soundGroupName, index.ToString()));
			if (array.Length != 0)
			{
				soundAgentHelperBase.AudioMixerGroup = array[0];
			}
			else
			{
				soundAgentHelperBase.AudioMixerGroup = soundGroupHelper.AudioMixerGroup;
			}
		}
		m_SoundManager.AddSoundAgentHelper(soundGroupName, soundAgentHelperBase);
		return true;
	}

	private void OnSceneLoaded(UnityEngine.SceneManagement.Scene scene, LoadSceneMode loadSceneMode)
	{
		RefreshAudioListener();
	}

	private void OnSceneUnloaded(UnityEngine.SceneManagement.Scene scene)
	{
		RefreshAudioListener();
	}

	private void RefreshAudioListener()
	{
		((Behaviour)(object)m_AudioListener).enabled = UnityEngine.Object.FindObjectsOfType<AudioListener>().Length <= 1;
	}
}
