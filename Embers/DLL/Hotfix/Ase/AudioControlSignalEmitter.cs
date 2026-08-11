using System.Collections.Generic;
using FMOD.Studio;
using UnityEngine;

namespace Ase;

public class AudioControlSignalEmitter : CustomSignalEmitter
{
	public AudioType audioType;

	public int audioId;

	public float volume = -1f;

	public bool clearBgmStack = true;

	public float fadeInTime = 3f;

	public float fadeOutTime = 3f;

	public STOP_MODE stopMode;

	public bool bgmPause;

	public Transform snapshotTrans;

	public List<AudioParameterSerializable> parameters = new List<AudioParameterSerializable>();

	public void DoExecute()
	{
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_0121: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0252: Unknown result type (might be due to invalid IL or missing references)
		//IL_0234: Unknown result type (might be due to invalid IL or missing references)
		switch (audioType)
		{
		case AudioType.BGM:
			Singleton<AudioSystem>.Instance.PlayStoryBGM(audioId, new FMOD_Define.BgmParameter(volume, parameters, !clearBgmStack, stopMode, fadeInTime, fadeOutTime));
			break;
		case AudioType.BGMCheckId:
			Singleton<AudioSystem>.Instance.PlayStoryBgmWithIdCheck(audioId, new FMOD_Define.BgmParameter(volume, parameters, !clearBgmStack, stopMode, fadeInTime, fadeOutTime));
			break;
		case AudioType.StopBGM:
			Singleton<AudioSystem>.Instance.StopStoryBGM(audioId, stopMode, clearBgmStack, fadeInTime, fadeOutTime);
			break;
		case AudioType.StopCurBGM:
			Singleton<AudioSystem>.Instance.StopCurStoryBgm(stopMode, clearBgmStack, fadeInTime, fadeOutTime);
			break;
		case AudioType.SetBGMParameter:
			Singleton<AudioSystem>.Instance.SetStoryBgmParameter(audioId, new FMOD_Define.BgmParameter(volume, parameters, !clearBgmStack, stopMode));
			break;
		case AudioType.SetCurBgmParameter:
			Singleton<AudioSystem>.Instance.SetCurStoryBgmParameter(new FMOD_Define.BgmParameter(volume, parameters, !clearBgmStack, stopMode));
			break;
		case AudioType.SetCurBGMPause:
		{
			float fadeTime = (bgmPause ? fadeOutTime : fadeInTime);
			Singleton<AudioSystem>.Instance.SetStoryBgmPause(bgmPause, fadeTime);
			break;
		}
		case AudioType.SoundEffect:
		{
			EventInstance val = Singleton<AudioSystem>.Instance.CreateInstance(audioId, volume, parameters, hosting: true);
			((EventInstance)(ref val)).start();
			break;
		}
		case AudioType.PlaySnapshot:
			if (snapshotTrans == null)
			{
				Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(audioId, new FMOD_Define.SoundEffectParameter(volume, parameters));
			}
			else
			{
				Singleton<AudioSystem>.Instance.PlayLocalSnapshot(snapshotTrans, audioId, new FMOD_Define.SoundEffectParameter(volume, parameters));
			}
			break;
		case AudioType.StopSnapshot:
			if (snapshotTrans == null)
			{
				Singleton<AudioSystem>.Instance.StopGlobalSnapshot(audioId, stopMode);
			}
			else
			{
				Singleton<AudioSystem>.Instance.StopLocalSnapshot(snapshotTrans, audioId, stopMode);
			}
			break;
		case AudioType.ClearSnapshot:
			break;
		}
	}
}
