using System.Collections.Generic;
using Config;
using UnityEngine;

public class TimelineAudioVoicePlayer : CommonSimpleTimelineClipPlayer<AudioPlayActionClip>, ILoopClipPlayer, ITimeScalePlayer
{
	public int m_CreationIndex;

	public AgentHuman m_NAgent;

	public CriAtomSource m_CriAtomSource;

	private int m_CurOrder;

	public int m_RoleID;

	public BattleVoiceConfig m_BattleVoiceConfig;

	private List<int> _VoiceCDKeys = new List<int>(20);

	private List<float> _VoiceCDValues = new List<float>(20);

	private CriAtomExPlayback _waitPlayback;

	private RoleVoice _waitPlayVoiceConfig;

	private bool _playTextWithoutAudio;

	protected override void _Initialize(List<AudioPlayActionClip> clips)
	{
	}

	protected override void _EnterNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (!CanPlayVoice())
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			AudioPlayActionClip audioPlayActionClip = clipsInThisFrame[i];
			if (!audioPlayActionClip.IsVoice)
			{
				continue;
			}
			if (audioPlayActionClip.PercentOfPlay > 0 && audioPlayActionClip.PercentOfPlay < 100)
			{
				int num = Random.Range(0, 100);
				if (audioPlayActionClip.PercentOfPlay < num)
				{
					continue;
				}
			}
			string text = audioPlayActionClip.CueSheet;
			string text2 = audioPlayActionClip.CueName;
			bool useStream = !string.IsNullOrEmpty(audioPlayActionClip.AwbName);
			int startTime = audioPlayActionClip.StartTimeInMs;
			int num2 = 0;
			if (audioPlayActionClip.RandomTotalWitght > 0)
			{
				int num3 = Random.Range(0, audioPlayActionClip.RandomTotalWitght);
				for (int j = 0; j < audioPlayActionClip.RandomWeight.Length; j++)
				{
					if (audioPlayActionClip.RandomWeight[j] > num3)
					{
						if (audioPlayActionClip.RandomRoleVoiceIDs.Length > j)
						{
							num2 = audioPlayActionClip.RandomRoleVoiceIDs[j];
							startTime = ((audioPlayActionClip.RandomStartTimeInMs != null && audioPlayActionClip.RandomStartTimeInMs.Length > j) ? audioPlayActionClip.RandomStartTimeInMs[j] : 0);
						}
						else if (audioPlayActionClip.CriCueInfoArr.Length > j)
						{
							CriCueInfo obj = audioPlayActionClip.CriCueInfoArr[j];
							text = obj.mCueSheet;
							text2 = obj.mCueName;
							useStream = obj.mUseStream;
							startTime = ((audioPlayActionClip.RandomStartTimeInMs != null && audioPlayActionClip.RandomStartTimeInMs.Length > j) ? audioPlayActionClip.RandomStartTimeInMs[j] : 0);
						}
						break;
					}
					num3 -= audioPlayActionClip.RandomWeight[j];
				}
			}
			if (num2 != 0)
			{
				if (m_CreationIndex < 0 && m_NAgent != null && m_NAgent.ComponentTimeline != null)
				{
					m_NAgent.ComponentTimeline.TryPlayRoleVoiceByConfig(num2, out var _, startTime);
				}
				else
				{
					TryPlayRoleVoiceByConfig(num2, out var _, startTime);
				}
			}
			else if (!string.IsNullOrEmpty(text) && !string.IsNullOrEmpty(text2) && (m_NAgent == null || m_NAgent.IsLocalPlayer || AudioManager.BattleTeammateVoiceSwitch))
			{
				PlayCriwareCue(text, text2, useStream, out var _, startTime);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return true;
	}

	public bool PlayCriwareCue(string pCueSheet, string pCueName, bool useStream, out CriAtomExPlayback criAtomExPlayback, int startTime)
	{
		if (string.IsNullOrEmpty(pCueSheet) || string.IsNullOrEmpty(pCueName))
		{
			criAtomExPlayback = default(CriAtomExPlayback);
			return false;
		}
		if (!CanPlayVoice())
		{
			criAtomExPlayback = default(CriAtomExPlayback);
			return false;
		}
		if (!AudioManager.Instance.HasVoiceFile(pCueSheet))
		{
			criAtomExPlayback = default(CriAtomExPlayback);
			return false;
		}
		AudioManager.Instance.AddCue("voice", pCueSheet, useStream);
		if (m_CriAtomSource.status == CriAtomSourceBase.Status.Stop || m_CriAtomSource.status == CriAtomSourceBase.Status.PlayEnd)
		{
			m_CurOrder = 0;
		}
		int num = 1;
		bool flag = false;
		if (m_BattleVoiceConfig != null && m_BattleVoiceConfig.TryGetData(GetPCueName(pCueName), out var item))
		{
			num = item.m_Order;
			flag = item.m_CanPlayOfTeammate;
		}
		if (m_NAgent == null || (!flag && !m_NAgent.IsLocalPlayer))
		{
			criAtomExPlayback = default(CriAtomExPlayback);
			return false;
		}
		if (num <= m_CurOrder)
		{
			criAtomExPlayback = default(CriAtomExPlayback);
			return false;
		}
		if (num > m_CurOrder)
		{
			StopCriwareCue();
		}
		m_CurOrder = num;
		m_CriAtomSource.cueSheet = pCueSheet;
		m_CriAtomSource.cueName = pCueName;
		m_CriAtomSource.startTime = startTime;
		criAtomExPlayback = m_CriAtomSource.Play();
		return true;
	}

	private string GetPCueName(string origin)
	{
		if (string.IsNullOrEmpty(origin))
		{
			return string.Empty;
		}
		int num = -1;
		int num2 = 0;
		int num3 = 0;
		int num4 = 3;
		while (num2 < num4)
		{
			num = origin.IndexOf('_', num3);
			if (num == -1)
			{
				return string.Empty;
			}
			num2++;
			num3 = num + 1;
			if (num3 > origin.Length && num2 < num4)
			{
				return string.Empty;
			}
		}
		return origin.Substring(num3);
	}

	public void StopCriwareCue()
	{
		m_CriAtomSource.Stop();
	}

	protected override void _UpdateNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized)
	{
	}

	protected override void _ExitNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override void _Shutdown()
	{
		ClearVoiceCD();
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	public override void UpdateWithoutTimeScale(float realTimeDelta)
	{
		base.UpdateWithoutTimeScale(realTimeDelta);
		UpdateVoiceCDTimer();
	}

	public bool TryPlayRoleVoiceByConfig(int id, out RoleVoice roleVoice, int startTime)
	{
		if (!ConfigHelper.GetInstance().TryGetConfig<RoleVoice>(id, out roleVoice))
		{
			return false;
		}
		if (!ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(roleVoice.AudioID, out var config))
		{
			return false;
		}
		if (!CanPlayVoice())
		{
			return false;
		}
		if (HasVoiceCD(roleVoice.ID))
		{
			return false;
		}
		if (m_NAgent != null && !m_NAgent.IsLocalPlayer && !AudioManager.BattleTeammateVoiceSwitch)
		{
			_playTextWithoutAudio = true;
		}
		else
		{
			string cueSheet = config.CueSheet;
			string cueName = config.CueName;
			if (!PlayCriwareCue(cueSheet, cueName, config.UseStream, out var criAtomExPlayback, startTime))
			{
				return false;
			}
			_waitPlayback = criAtomExPlayback;
		}
		AddVoiceCD(roleVoice.ID, (float)roleVoice.Cd / 1000f);
		RoleVoice config2 = null;
		for (int i = 0; i < roleVoice.InfluenceId.Count; i++)
		{
			if (ConfigHelper.GetInstance().TryGetConfig<RoleVoice>(roleVoice.InfluenceId.get_Item(i), out config2))
			{
				AddVoiceCD(config2.ID, (float)config2.Cd / 1000f);
			}
		}
		_waitPlayVoiceConfig = roleVoice;
		return true;
	}

	public void UpdateVoiceCDTimer()
	{
		if (_VoiceCDKeys.Count <= 0)
		{
			return;
		}
		if (_waitPlayVoiceConfig != null)
		{
			if (_playTextWithoutAudio)
			{
				_playTextWithoutAudio = false;
				if (m_NAgent != null && m_NAgent.RoleTalkPanel != null)
				{
					m_NAgent.RoleTalkPanel.ShowTalk(WorldStateManager.GetTipsContent(_waitPlayVoiceConfig.Content), 1000L);
				}
				_waitPlayVoiceConfig = null;
			}
			else if (_waitPlayback.GetStatus() == CriAtomExPlayback.Status.Playing)
			{
				ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(_waitPlayVoiceConfig.AudioID, out var config);
				string cueSheet = config.CueSheet;
				string cueName = config.CueName;
				long num = AudioManager.Instance.GetCueInfoLength("voice", cueSheet, cueName, config.UseStream);
				if (num > 0 && m_NAgent != null && m_NAgent.RoleTalkPanel != null)
				{
					m_NAgent.RoleTalkPanel.ShowTalk(WorldStateManager.GetTipsContent(_waitPlayVoiceConfig.Content), num);
				}
				_waitPlayVoiceConfig = null;
			}
			else if (_waitPlayback.GetStatus() == CriAtomExPlayback.Status.Removed)
			{
				_waitPlayVoiceConfig = null;
			}
		}
		for (int num2 = _VoiceCDKeys.Count - 1; num2 >= 0; num2--)
		{
			if (_VoiceCDValues[num2] <= 0f)
			{
				_VoiceCDKeys.RemoveAt(num2);
				_VoiceCDValues.RemoveAt(num2);
			}
			else
			{
				_VoiceCDValues[num2] -= Time.deltaTime;
			}
		}
	}

	public bool HasVoiceCD(int key)
	{
		if (_VoiceCDKeys.Count <= 0)
		{
			return false;
		}
		return _VoiceCDKeys.Contains(key);
	}

	public void AddVoiceCD(int key, float cd)
	{
		for (int i = 0; i < _VoiceCDKeys.Count; i++)
		{
			if (_VoiceCDKeys[i] == key)
			{
				_VoiceCDValues[i] = cd;
				return;
			}
		}
		_VoiceCDKeys.Add(key);
		_VoiceCDValues.Add(cd);
	}

	public void ClearVoiceCD()
	{
		if (_VoiceCDKeys.Count > 0)
		{
			_VoiceCDKeys.Clear();
			_VoiceCDValues.Clear();
		}
	}

	public void SetTimeScale(float timeScale)
	{
	}

	public void Pause(bool isPause = true)
	{
		if (m_CriAtomSource != null)
		{
			m_CriAtomSource.Pause(isPause);
		}
	}

	private bool CanPlayVoice()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (!worldSatetManager.notMuteBattleVoice || !worldSatetManager.notMuteCharacterVoice)
			{
				return false;
			}
		}
		return true;
	}
}
