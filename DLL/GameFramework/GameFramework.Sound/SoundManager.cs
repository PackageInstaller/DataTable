using System;
using System.Collections.Generic;
using GameFramework.Resource;

namespace GameFramework.Sound;

internal sealed class SoundManager : GameFrameworkModule, ISoundManager
{
	private sealed class PlaySoundInfo : IReference
	{
		private int m_SerialId;

		private SoundGroup m_SoundGroup;

		private PlaySoundParams m_PlaySoundParams;

		private object m_UserData;

		public int SerialId => m_SerialId;

		public SoundGroup SoundGroup => m_SoundGroup;

		public PlaySoundParams PlaySoundParams => m_PlaySoundParams;

		public object UserData => m_UserData;

		public PlaySoundInfo()
		{
			m_SerialId = 0;
			m_SoundGroup = null;
			m_PlaySoundParams = null;
			m_UserData = null;
		}

		public static PlaySoundInfo Create(int serialId, SoundGroup soundGroup, PlaySoundParams playSoundParams, object userData)
		{
			PlaySoundInfo playSoundInfo = ReferencePool.Acquire<PlaySoundInfo>();
			playSoundInfo.m_SerialId = serialId;
			playSoundInfo.m_SoundGroup = soundGroup;
			playSoundInfo.m_PlaySoundParams = playSoundParams;
			playSoundInfo.m_UserData = userData;
			return playSoundInfo;
		}

		public void Clear()
		{
			m_SerialId = 0;
			m_SoundGroup = null;
			m_PlaySoundParams = null;
			m_UserData = null;
		}
	}

	private sealed class SoundAgent : ISoundAgent
	{
		private readonly SoundGroup m_SoundGroup;

		private readonly ISoundHelper m_SoundHelper;

		private readonly ISoundAgentHelper m_SoundAgentHelper;

		private int m_SerialId;

		private object m_SoundAsset;

		private string m_SoundAssetName;

		private DateTime m_SetSoundAssetTime;

		private bool m_MuteInSoundGroup;

		private float m_VolumeInSoundGroup;

		public ISoundGroup SoundGroup => m_SoundGroup;

		public int SerialId
		{
			get
			{
				return m_SerialId;
			}
			set
			{
				m_SerialId = value;
			}
		}

		public bool IsPlaying => m_SoundAgentHelper.IsPlaying;

		public float Length => m_SoundAgentHelper.Length;

		public float Time
		{
			get
			{
				return m_SoundAgentHelper.Time;
			}
			set
			{
				m_SoundAgentHelper.Time = value;
			}
		}

		public bool Mute => m_SoundAgentHelper.Mute;

		public bool MuteInSoundGroup
		{
			get
			{
				return m_MuteInSoundGroup;
			}
			set
			{
				m_MuteInSoundGroup = value;
				RefreshMute();
			}
		}

		public bool Loop
		{
			get
			{
				return m_SoundAgentHelper.Loop;
			}
			set
			{
				m_SoundAgentHelper.Loop = value;
			}
		}

		public int Priority
		{
			get
			{
				return m_SoundAgentHelper.Priority;
			}
			set
			{
				m_SoundAgentHelper.Priority = value;
			}
		}

		public float Volume => m_SoundAgentHelper.Volume;

		public float VolumeInSoundGroup
		{
			get
			{
				return m_VolumeInSoundGroup;
			}
			set
			{
				m_VolumeInSoundGroup = value;
				RefreshVolume();
			}
		}

		public float Pitch
		{
			get
			{
				return m_SoundAgentHelper.Pitch;
			}
			set
			{
				m_SoundAgentHelper.Pitch = value;
			}
		}

		public float PanStereo
		{
			get
			{
				return m_SoundAgentHelper.PanStereo;
			}
			set
			{
				m_SoundAgentHelper.PanStereo = value;
			}
		}

		public float SpatialBlend
		{
			get
			{
				return m_SoundAgentHelper.SpatialBlend;
			}
			set
			{
				m_SoundAgentHelper.SpatialBlend = value;
			}
		}

		public float MaxDistance
		{
			get
			{
				return m_SoundAgentHelper.MaxDistance;
			}
			set
			{
				m_SoundAgentHelper.MaxDistance = value;
			}
		}

		public float DopplerLevel
		{
			get
			{
				return m_SoundAgentHelper.DopplerLevel;
			}
			set
			{
				m_SoundAgentHelper.DopplerLevel = value;
			}
		}

		public ISoundAgentHelper Helper => m_SoundAgentHelper;

		internal DateTime SetSoundAssetTime => m_SetSoundAssetTime;

		public SoundAgent(SoundGroup soundGroup, ISoundHelper soundHelper, ISoundAgentHelper soundAgentHelper)
		{
			if (soundGroup == null)
			{
				throw new GameFrameworkException("Sound group is invalid.");
			}
			if (soundHelper == null)
			{
				throw new GameFrameworkException("Sound helper is invalid.");
			}
			if (soundAgentHelper == null)
			{
				throw new GameFrameworkException("Sound agent helper is invalid.");
			}
			m_SoundGroup = soundGroup;
			m_SoundHelper = soundHelper;
			m_SoundAgentHelper = soundAgentHelper;
			m_SerialId = 0;
			m_SoundAsset = null;
			Reset();
		}

		public void Play()
		{
			m_SoundAgentHelper.Play(0f);
		}

		public void Play(float fadeInSeconds)
		{
			m_SoundAgentHelper.Play(fadeInSeconds);
		}

		public void Stop()
		{
			m_SoundAgentHelper.Stop(0f);
		}

		public void Stop(float fadeOutSeconds)
		{
			m_SoundAgentHelper.Stop(fadeOutSeconds);
		}

		public void Pause()
		{
			m_SoundAgentHelper.Pause(0f);
		}

		public void Pause(float fadeOutSeconds)
		{
			m_SoundAgentHelper.Pause(fadeOutSeconds);
		}

		public void Resume()
		{
			m_SoundAgentHelper.Resume(0f);
		}

		public void Resume(float fadeInSeconds)
		{
			m_SoundAgentHelper.Resume(fadeInSeconds);
		}

		public void Reset()
		{
			if (m_SoundAsset != null)
			{
				m_SoundHelper.ReleaseSoundAsset(m_SoundAssetName);
				m_SoundAsset = null;
			}
			m_SetSoundAssetTime = DateTime.MinValue;
			Time = 0f;
			MuteInSoundGroup = false;
			Loop = false;
			Priority = 0;
			VolumeInSoundGroup = 1f;
			Pitch = 1f;
			PanStereo = 0f;
			SpatialBlend = 0f;
			MaxDistance = 100f;
			DopplerLevel = 1f;
			m_SoundAgentHelper.Reset();
		}

		internal bool SetSoundAsset(object soundAsset, string soundAssetName)
		{
			Reset();
			m_SoundAsset = soundAsset;
			m_SoundAssetName = soundAssetName;
			m_SetSoundAssetTime = DateTime.Now;
			return m_SoundAgentHelper.SetSoundAsset(soundAsset);
		}

		internal void RefreshMute()
		{
			m_SoundAgentHelper.Mute = m_SoundGroup.Mute || m_MuteInSoundGroup;
		}

		internal void RefreshVolume()
		{
			m_SoundAgentHelper.Volume = m_SoundGroup.Volume * m_VolumeInSoundGroup;
		}
	}

	private sealed class SoundGroup : ISoundGroup
	{
		private readonly string m_Name;

		private readonly ISoundGroupHelper m_SoundGroupHelper;

		private readonly List<SoundAgent> m_SoundAgents;

		private bool m_AvoidBeingReplacedBySamePriority;

		private bool m_Mute;

		private float m_Volume;

		public string Name => m_Name;

		public int SoundAgentCount => m_SoundAgents.Count;

		public bool AvoidBeingReplacedBySamePriority
		{
			get
			{
				return m_AvoidBeingReplacedBySamePriority;
			}
			set
			{
				m_AvoidBeingReplacedBySamePriority = value;
			}
		}

		public bool Mute
		{
			get
			{
				return m_Mute;
			}
			set
			{
				m_Mute = value;
				foreach (SoundAgent soundAgent in m_SoundAgents)
				{
					soundAgent.RefreshMute();
				}
			}
		}

		public float Volume
		{
			get
			{
				return m_Volume;
			}
			set
			{
				m_Volume = value;
				foreach (SoundAgent soundAgent in m_SoundAgents)
				{
					soundAgent.RefreshVolume();
				}
			}
		}

		public ISoundGroupHelper Helper => m_SoundGroupHelper;

		public SoundGroup(string name, ISoundGroupHelper soundGroupHelper)
		{
			if (string.IsNullOrEmpty(name))
			{
				throw new GameFrameworkException("Sound group name is invalid.");
			}
			if (soundGroupHelper == null)
			{
				throw new GameFrameworkException("Sound group helper is invalid.");
			}
			m_Name = name;
			m_SoundGroupHelper = soundGroupHelper;
			m_SoundAgents = new List<SoundAgent>();
		}

		public void AddSoundAgentHelper(ISoundHelper soundHelper, ISoundAgentHelper soundAgentHelper)
		{
			m_SoundAgents.Add(new SoundAgent(this, soundHelper, soundAgentHelper));
		}

		public ISoundAgent PlaySound(int serialId, object soundAsset, string soundAssetName, PlaySoundParams playSoundParams, out PlaySoundErrorCode? errorCode)
		{
			errorCode = null;
			SoundAgent soundAgent = null;
			foreach (SoundAgent soundAgent2 in m_SoundAgents)
			{
				if (!soundAgent2.IsPlaying)
				{
					soundAgent = soundAgent2;
					break;
				}
				if (soundAgent2.Priority < playSoundParams.Priority)
				{
					if (soundAgent == null || soundAgent2.Priority < soundAgent.Priority)
					{
						soundAgent = soundAgent2;
					}
				}
				else if (!m_AvoidBeingReplacedBySamePriority && soundAgent2.Priority == playSoundParams.Priority && (soundAgent == null || soundAgent2.SetSoundAssetTime < soundAgent.SetSoundAssetTime))
				{
					soundAgent = soundAgent2;
				}
			}
			if (soundAgent == null)
			{
				errorCode = PlaySoundErrorCode.IgnoredDueToLowPriority;
				return null;
			}
			if (!soundAgent.SetSoundAsset(soundAsset, soundAssetName))
			{
				errorCode = PlaySoundErrorCode.SetSoundAssetFailure;
				return null;
			}
			soundAgent.SerialId = serialId;
			soundAgent.Time = playSoundParams.Time;
			soundAgent.MuteInSoundGroup = playSoundParams.MuteInSoundGroup;
			soundAgent.Loop = playSoundParams.Loop;
			soundAgent.Priority = playSoundParams.Priority;
			soundAgent.VolumeInSoundGroup = playSoundParams.VolumeInSoundGroup;
			soundAgent.Pitch = playSoundParams.Pitch;
			soundAgent.PanStereo = playSoundParams.PanStereo;
			soundAgent.SpatialBlend = playSoundParams.SpatialBlend;
			soundAgent.MaxDistance = playSoundParams.MaxDistance;
			soundAgent.DopplerLevel = playSoundParams.DopplerLevel;
			soundAgent.Play(playSoundParams.FadeInSeconds);
			return soundAgent;
		}

		public bool StopSound(int serialId, float fadeOutSeconds)
		{
			foreach (SoundAgent soundAgent in m_SoundAgents)
			{
				if (soundAgent.SerialId != serialId)
				{
					continue;
				}
				soundAgent.Stop(fadeOutSeconds);
				return true;
			}
			return false;
		}

		public bool PauseSound(int serialId, float fadeOutSeconds)
		{
			foreach (SoundAgent soundAgent in m_SoundAgents)
			{
				if (soundAgent.SerialId != serialId)
				{
					continue;
				}
				soundAgent.Pause(fadeOutSeconds);
				return true;
			}
			return false;
		}

		public bool ResumeSound(int serialId, float fadeInSeconds)
		{
			foreach (SoundAgent soundAgent in m_SoundAgents)
			{
				if (soundAgent.SerialId != serialId)
				{
					continue;
				}
				soundAgent.Resume(fadeInSeconds);
				return true;
			}
			return false;
		}

		public void StopAllLoadedSounds()
		{
			foreach (SoundAgent soundAgent in m_SoundAgents)
			{
				if (soundAgent.IsPlaying)
				{
					soundAgent.Stop();
				}
			}
		}

		public void StopAllLoadedSounds(float fadeOutSeconds)
		{
			foreach (SoundAgent soundAgent in m_SoundAgents)
			{
				if (soundAgent.IsPlaying)
				{
					soundAgent.Stop(fadeOutSeconds);
				}
			}
		}
	}

	private readonly Dictionary<string, SoundGroup> m_SoundGroups;

	private readonly List<int> m_SoundsBeingLoaded;

	private readonly HashSet<int> m_SoundsToReleaseOnLoad;

	private readonly LoadAssetCallbacks m_LoadAssetCallbacks;

	private IResourceManager m_ResourceManager;

	private ISoundHelper m_SoundHelper;

	private int m_Serial;

	public int SoundGroupCount => m_SoundGroups.Count;

	public SoundManager()
	{
		m_SoundGroups = new Dictionary<string, SoundGroup>();
		m_SoundsBeingLoaded = new List<int>();
		m_SoundsToReleaseOnLoad = new HashSet<int>();
		m_LoadAssetCallbacks = new LoadAssetCallbacks(LoadSoundSuccessCallback, LoadSoundFailureCallback);
		m_ResourceManager = null;
		m_SoundHelper = null;
		m_Serial = 0;
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
	}

	internal override void Shutdown()
	{
		StopAllLoadedSounds();
		m_SoundGroups.Clear();
		m_SoundsBeingLoaded.Clear();
		m_SoundsToReleaseOnLoad.Clear();
	}

	public void SetResourceManager(IResourceManager resourceManager)
	{
		if (resourceManager == null)
		{
			throw new GameFrameworkException("Resource manager is invalid.");
		}
		m_ResourceManager = resourceManager;
	}

	public void SetSoundHelper(ISoundHelper soundHelper)
	{
		if (soundHelper == null)
		{
			throw new GameFrameworkException("Sound helper is invalid.");
		}
		m_SoundHelper = soundHelper;
	}

	public bool HasSoundGroup(string soundGroupName)
	{
		if (string.IsNullOrEmpty(soundGroupName))
		{
			throw new GameFrameworkException("Sound group name is invalid.");
		}
		return m_SoundGroups.ContainsKey(soundGroupName);
	}

	public ISoundGroup GetSoundGroup(string soundGroupName)
	{
		if (string.IsNullOrEmpty(soundGroupName))
		{
			throw new GameFrameworkException("Sound group name is invalid.");
		}
		SoundGroup value = null;
		if (m_SoundGroups.TryGetValue(soundGroupName, out value))
		{
			return value;
		}
		return null;
	}

	public ISoundGroup[] GetAllSoundGroups()
	{
		int num = 0;
		ISoundGroup[] array = new ISoundGroup[m_SoundGroups.Count];
		foreach (KeyValuePair<string, SoundGroup> soundGroup in m_SoundGroups)
		{
			array[num++] = soundGroup.Value;
		}
		return array;
	}

	public void GetAllSoundGroups(List<ISoundGroup> results)
	{
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		foreach (KeyValuePair<string, SoundGroup> soundGroup in m_SoundGroups)
		{
			results.Add(soundGroup.Value);
		}
	}

	public bool AddSoundGroup(string soundGroupName, ISoundGroupHelper soundGroupHelper)
	{
		return AddSoundGroup(soundGroupName, soundGroupAvoidBeingReplacedBySamePriority: false, soundGroupMute: false, 1f, soundGroupHelper);
	}

	public bool AddSoundGroup(string soundGroupName, bool soundGroupAvoidBeingReplacedBySamePriority, bool soundGroupMute, float soundGroupVolume, ISoundGroupHelper soundGroupHelper)
	{
		if (string.IsNullOrEmpty(soundGroupName))
		{
			throw new GameFrameworkException("Sound group name is invalid.");
		}
		if (soundGroupHelper == null)
		{
			throw new GameFrameworkException("Sound group helper is invalid.");
		}
		if (HasSoundGroup(soundGroupName))
		{
			return false;
		}
		SoundGroup value = new SoundGroup(soundGroupName, soundGroupHelper)
		{
			AvoidBeingReplacedBySamePriority = soundGroupAvoidBeingReplacedBySamePriority,
			Mute = soundGroupMute,
			Volume = soundGroupVolume
		};
		m_SoundGroups.Add(soundGroupName, value);
		return true;
	}

	public void AddSoundAgentHelper(string soundGroupName, ISoundAgentHelper soundAgentHelper)
	{
		if (m_SoundHelper == null)
		{
			throw new GameFrameworkException("You must set sound helper first.");
		}
		SoundGroup soundGroup = (SoundGroup)GetSoundGroup(soundGroupName);
		if (soundGroup == null)
		{
			throw new GameFrameworkException(Utility.Text.Format("Sound group '{0}' is not exist.", soundGroupName));
		}
		soundGroup.AddSoundAgentHelper(m_SoundHelper, soundAgentHelper);
	}

	public int[] GetAllLoadingSoundSerialIds()
	{
		return m_SoundsBeingLoaded.ToArray();
	}

	public void GetAllLoadingSoundSerialIds(List<int> results)
	{
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		results.AddRange(m_SoundsBeingLoaded);
	}

	public bool IsLoadingSound(int serialId)
	{
		return m_SoundsBeingLoaded.Contains(serialId);
	}

	public int PlaySound(string soundAssetName, string soundGroupName)
	{
		return PlaySound(soundAssetName, soundGroupName, 1, null, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority)
	{
		return PlaySound(soundAssetName, soundGroupName, priority, null, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, PlaySoundParams playSoundParams)
	{
		return PlaySound(soundAssetName, soundGroupName, 1, playSoundParams, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, object userData)
	{
		return PlaySound(soundAssetName, soundGroupName, 1, null, userData);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams)
	{
		return PlaySound(soundAssetName, soundGroupName, priority, playSoundParams, null);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, object userData)
	{
		return PlaySound(soundAssetName, soundGroupName, priority, null, userData);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, PlaySoundParams playSoundParams, object userData)
	{
		return PlaySound(soundAssetName, soundGroupName, 1, playSoundParams, userData);
	}

	public int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams, object userData)
	{
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		if (m_SoundHelper == null)
		{
			throw new GameFrameworkException("You must set sound helper first.");
		}
		if (playSoundParams == null)
		{
			playSoundParams = PlaySoundParams.Create();
		}
		int num = ++m_Serial;
		PlaySoundErrorCode? playSoundErrorCode = null;
		string message = null;
		SoundGroup soundGroup = (SoundGroup)GetSoundGroup(soundGroupName);
		if (soundGroup == null)
		{
			playSoundErrorCode = PlaySoundErrorCode.SoundGroupNotExist;
			message = Utility.Text.Format("Sound group '{0}' is not exist.", soundGroupName);
		}
		else if (soundGroup.SoundAgentCount <= 0)
		{
			playSoundErrorCode = PlaySoundErrorCode.SoundGroupHasNoAgent;
			message = Utility.Text.Format("Sound group '{0}' is have no sound agent.", soundGroupName);
		}
		if (playSoundErrorCode.HasValue)
		{
			throw new GameFrameworkException(message);
		}
		m_SoundsBeingLoaded.Add(num);
		m_ResourceManager.LoadAssetAsync(soundAssetName, m_LoadAssetCallbacks, PlaySoundInfo.Create(num, soundGroup, playSoundParams, userData));
		return num;
	}

	public bool StopSound(int serialId)
	{
		return StopSound(serialId, 0f);
	}

	public bool StopSound(int serialId, float fadeOutSeconds)
	{
		if (IsLoadingSound(serialId))
		{
			m_SoundsToReleaseOnLoad.Add(serialId);
			m_SoundsBeingLoaded.Remove(serialId);
			return true;
		}
		foreach (KeyValuePair<string, SoundGroup> soundGroup in m_SoundGroups)
		{
			if (soundGroup.Value.StopSound(serialId, fadeOutSeconds))
			{
				return true;
			}
		}
		return false;
	}

	public void StopAllLoadedSounds()
	{
		StopAllLoadedSounds(0f);
	}

	public void StopAllLoadedSounds(float fadeOutSeconds)
	{
		foreach (KeyValuePair<string, SoundGroup> soundGroup in m_SoundGroups)
		{
			soundGroup.Value.StopAllLoadedSounds(fadeOutSeconds);
		}
	}

	public void StopAllLoadingSounds()
	{
		foreach (int item in m_SoundsBeingLoaded)
		{
			m_SoundsToReleaseOnLoad.Add(item);
		}
	}

	public void PauseSound(int serialId)
	{
		PauseSound(serialId, 0f);
	}

	public void PauseSound(int serialId, float fadeOutSeconds)
	{
		foreach (KeyValuePair<string, SoundGroup> soundGroup in m_SoundGroups)
		{
			if (soundGroup.Value.PauseSound(serialId, fadeOutSeconds))
			{
				return;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("Can not find sound '{0}'.", serialId.ToString()));
	}

	public void ResumeSound(int serialId)
	{
		ResumeSound(serialId, 0f);
	}

	public void ResumeSound(int serialId, float fadeInSeconds)
	{
		foreach (KeyValuePair<string, SoundGroup> soundGroup in m_SoundGroups)
		{
			if (soundGroup.Value.ResumeSound(serialId, fadeInSeconds))
			{
				return;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("Can not find sound '{0}'.", serialId.ToString()));
	}

	private void LoadSoundSuccessCallback(string soundAssetName, string packageName, object soundAsset, float duration, object userData)
	{
		PlaySoundInfo playSoundInfo = (PlaySoundInfo)userData;
		if (playSoundInfo == null)
		{
			throw new GameFrameworkException("Play sound info is invalid.");
		}
		if (m_SoundsToReleaseOnLoad.Contains(playSoundInfo.SerialId))
		{
			m_SoundsToReleaseOnLoad.Remove(playSoundInfo.SerialId);
			m_SoundHelper.ReleaseSoundAsset(soundAssetName);
			return;
		}
		m_SoundsBeingLoaded.Remove(playSoundInfo.SerialId);
		PlaySoundErrorCode? errorCode = null;
		ISoundAgent soundAgent = playSoundInfo.SoundGroup.PlaySound(playSoundInfo.SerialId, soundAsset, soundAssetName, playSoundInfo.PlaySoundParams, out errorCode);
		if (soundAgent != null)
		{
			return;
		}
		m_SoundsToReleaseOnLoad.Remove(playSoundInfo.SerialId);
		m_SoundHelper.ReleaseSoundAsset(soundAssetName);
		string message = Utility.Text.Format("Sound group '{0}' play sound '{1}' failure.", playSoundInfo.SoundGroup.Name, soundAssetName);
		throw new GameFrameworkException(message);
	}

	private void LoadSoundFailureCallback(string soundAssetName, LoadResourceStatus status, string errorMessage, object userData)
	{
		PlaySoundInfo playSoundInfo = (PlaySoundInfo)userData;
		if (playSoundInfo == null)
		{
			throw new GameFrameworkException("Play sound info is invalid.");
		}
		if (m_SoundsToReleaseOnLoad.Contains(playSoundInfo.SerialId))
		{
			m_SoundsToReleaseOnLoad.Remove(playSoundInfo.SerialId);
			return;
		}
		m_SoundsBeingLoaded.Remove(playSoundInfo.SerialId);
		string message = Utility.Text.Format("Load sound failure, asset name '{0}', status '{1}', error message '{2}'.", soundAssetName, status.ToString(), errorMessage);
		throw new GameFrameworkException(message);
	}
}
