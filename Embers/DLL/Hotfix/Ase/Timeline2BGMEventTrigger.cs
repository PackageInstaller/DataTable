using System.Collections.Generic;
using FMOD.Studio;
using UnityEngine;

namespace Ase;

[Trigger("Timeline2BGM")]
public class Timeline2BGMEventTrigger : TimelineEventTrigger
{
	public AudioType audioType;

	public int audioId;

	public float volume = 1f;

	public bool clearBgmStack;

	public STOP_MODE stopMode;

	public bool bgmPause;

	public Transform snapshotTrans;

	public float fadeInTime = 3f;

	public float fadeOutTime = 3f;

	public List<AudioParameterSerializable> paramList = new List<AudioParameterSerializable>();

	public override string TriggerName => "Timeline-BGM";

	protected override void DoExecute()
	{
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_0179: Unknown result type (might be due to invalid IL or missing references)
		//IL_024f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0231: Unknown result type (might be due to invalid IL or missing references)
		base.DoExecute();
		switch (audioType)
		{
		case AudioType.BGM:
			Singleton<AudioSystem>.Instance.PlayBgm(audioId, new FMOD_Define.BgmParameter(volume, paramList, clearBgmStack, stopMode, fadeInTime, fadeOutTime));
			break;
		case AudioType.BGMCheckId:
			Singleton<AudioSystem>.Instance.PlayBgmWithIdCheck(audioId, new FMOD_Define.BgmParameter(volume, paramList, clearBgmStack, stopMode, fadeInTime, fadeOutTime));
			break;
		case AudioType.SetBGMParameter:
			Singleton<AudioSystem>.Instance.SetBgmParameter(audioId, new FMOD_Define.BgmParameter(volume, paramList, clearBgmStack, stopMode));
			break;
		case AudioType.SetCurBgmParameter:
			Singleton<AudioSystem>.Instance.SetCurBgmParameter(new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode));
			break;
		case AudioType.SetCurBGMPause:
		{
			float fadeTime = (bgmPause ? fadeOutTime : fadeInTime);
			Singleton<AudioSystem>.Instance.SetBgmPause(bgmPause, fadeTime);
			break;
		}
		case AudioType.StopBGM:
			Singleton<AudioSystem>.Instance.StopBgm(audioId, stopMode, clearBgmStack, fadeInTime, fadeOutTime);
			break;
		case AudioType.StopCurBGM:
			Singleton<AudioSystem>.Instance.StopCurBgm(stopMode, clearBgmStack, fadeInTime, fadeOutTime);
			break;
		case AudioType.SoundEffect:
		{
			EventInstance val = Singleton<AudioSystem>.Instance.CreateInstance(audioId, volume, paramList, hosting: true);
			((EventInstance)(ref val)).start();
			break;
		}
		case AudioType.PlaySnapshot:
			if (snapshotTrans == null)
			{
				Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(audioId, new FMOD_Define.SoundEffectParameter(volume, paramList));
			}
			else
			{
				Singleton<AudioSystem>.Instance.PlayLocalSnapshot(snapshotTrans, audioId, new FMOD_Define.SoundEffectParameter(volume, paramList));
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
