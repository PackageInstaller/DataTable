using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
public class CriAtomMixerBehaviour : PlayableBehaviour
{
	internal PlayableDirector m_Director;

	internal IEnumerable<TimelineClip> m_Clips;

	internal CriAtomSource m_Bind;

	internal string m_AisacControls;

	internal bool m_StopOnWrapping;

	internal bool m_StopAtGraphEnd;

	private const int cScratchTimeIntervalMs = 200;

	private DateTime m_lastScrubTime;

	private double m_lastDirectorTime;

	public Guid m_Guid { get; private set; }

	private static bool IsEditor => false;

	public void Initialize()
	{
		CriWareInitializer.InitializeFileSystem(new CriFsConfig
		{
			numberOfLoaders = 32,
			numberOfBinders = 32,
			installBufferSize = 4096
		});
		CriWareInitializer.InitializeAtom(new CriAtomConfig
		{
			acfFileName = "Eyes_of_deep_space.acf",
			maxVirtualVoices = 64,
			maxVoiceLimitGroups = 64,
			maxParameterBlocks = 1024,
			maxBuses = 16,
			maxCategories = 64,
			maxSequenceEventsPerFrame = 2,
			maxBeatSyncCallbacksPerFrame = 1,
			maxCueLinkCallbacksPerFrame = 1,
			categoriesPerPlayback = 6,
			outputSamplingRate = 0,
			serverFrequency = 60f,
			asrOutputChannels = 0,
			useRandomSeedWithTime = false,
			usesInGamePreview = Debug.isDebugBuild,
			inGamePreviewMode = CriAtomConfig.InGamePreviewSwitchMode.FollowBuildSetting,
			keepPlayingSoundOnPause = true
		});
		CriWareDecrypter.Initialize(new CriWareDecrypter.Config
		{
			key = "1578660190369042886 ",
			enableAtomDecryption = true,
			enableManaDecryption = false
		});
	}

	public override void OnPlayableCreate(Playable playable)
	{
		base.OnPlayableCreate(playable);
		m_Guid = Guid.NewGuid();
		if (IsEditor && !CriAtomPlugin.IsLibraryInitialized())
		{
			CriWareInitializer criWareInitializer = UnityEngine.Object.FindObjectOfType<CriWareInitializer>();
			if (criWareInitializer != null)
			{
				CriWareInitializer.InitializeAtom(criWareInitializer.atomConfig);
			}
			else
			{
				Initialize();
			}
		}
		m_lastDirectorTime = 0.0;
	}

	public override void OnGraphStop(Playable playable)
	{
		base.OnGraphStop(playable);
		if (IsEditor)
		{
			if (CriAtomTimelinePreviewer.IsInitialized)
			{
				CriAtomTimelinePreviewer.Instance.StopAllTracks();
			}
		}
		else if (m_Bind != null && m_StopAtGraphEnd)
		{
			m_Bind.Stop();
		}
		m_lastDirectorTime = 0.0;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!IsEditor || m_Director.time == m_lastDirectorTime)
		{
			return;
		}
		bool flag = false;
		if (m_Director.state == PlayState.Playing && m_Director.time < m_lastDirectorTime)
		{
			flag = true;
		}
		m_lastDirectorTime = m_Director.time;
		int num = 0;
		foreach (TimelineClip clip in m_Clips)
		{
			CriAtomBehaviour behaviour = ((ScriptPlayable<CriAtomBehaviour>)playable.GetInput(num)).GetBehaviour();
			CriAtomClip criAtomClip = clip.asset as CriAtomClip;
			float num2 = (criAtomClip.ignoreBlend ? 1f : playable.GetInputWeight(num));
			if (behaviour != null)
			{
				if ((m_StopOnWrapping & flag) && behaviour.IsClipPlaying)
				{
					behaviour.Stop(criAtomClip.stopWithoutRelease);
				}
				if (m_Director.time >= clip.end || m_Director.time <= clip.start)
				{
					if (behaviour.IsClipPlaying && criAtomClip.stopAtClipEnd)
					{
						behaviour.Stop(criAtomClip.stopWithoutRelease);
					}
				}
				else if (!criAtomClip.muted)
				{
					long startTimeMs = (long)((m_Director.time - clip.start) * 1000.0);
					bool flag2 = m_Director.state == PlayState.Paused;
					CriAtomClipPlayConfig config = new CriAtomClipPlayConfig(criAtomClip.cueSheet, criAtomClip.cueName, startTimeMs, clip.timeScale, criAtomClip.loopWithinClip);
					if (!behaviour.IsClipPlaying)
					{
						if (!IsEditor)
						{
							behaviour.Play(m_Bind, config);
						}
						else
						{
							behaviour.PreviewPlay(m_Guid, flag2, config);
							m_lastScrubTime = DateTime.Now;
						}
						criAtomClip.SetClipDuration(behaviour.CueLength);
					}
					else
					{
						DateTime now = DateTime.Now;
						if ((IsEditor & flag2) && now - m_lastScrubTime > new TimeSpan(0, 0, 0, 0, 200))
						{
							behaviour.Stop(noReleaseTime: true);
							behaviour.PreviewPlay(m_Guid, flag2, config);
							m_lastScrubTime = now;
						}
					}
					if (IsEditor)
					{
						CriAtomTimelinePreviewer.Instance.SetVolume(m_Guid, behaviour.volume * num2);
						CriAtomTimelinePreviewer.Instance.SetPitch(m_Guid, behaviour.pitch);
						if (!string.IsNullOrEmpty(m_AisacControls))
						{
							CriAtomTimelinePreviewer.Instance.SetAISAC(m_Guid, m_AisacControls, behaviour.AISACValue);
						}
						CriAtomTimelinePreviewer.Instance.PlayerUpdateParameter(m_Guid, behaviour.playback);
					}
					else
					{
						m_Bind.player.SetVolume(behaviour.volume * num2);
						m_Bind.player.SetPitch(behaviour.pitch);
						if (!string.IsNullOrEmpty(m_AisacControls))
						{
							m_Bind.player.SetAisacControl(m_AisacControls, behaviour.AISACValue);
						}
						m_Bind.player.Update(behaviour.playback);
					}
				}
			}
			num++;
		}
	}
}
