using System.Collections.Generic;
using FMOD.Studio;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Serialization;

namespace Ase;

[RequireComponent(typeof(MonsterGroup))]
public class MonsterGroupExpandConfig : SerializedMonoBehaviour
{
	public int TriggerType;

	public List<MapItemNode> mapItemList;

	public List<GameObject> AirWalls;

	public bool mode;

	public bool lockMiniMap;

	public bool closeMiniMap;

	public bool TaskBtnCtrl;

	[FormerlySerializedAs("TaskBtnCanClick")]
	public bool TaskBtnLockClick = true;

	public bool UseAudioControl = true;

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

	public int TLId;

	public int popupTipQueueId;

	public PopupTipType popupTipType;

	public void Excute(bool isDead)
	{
		//IL_00da: Unknown result type (might be due to invalid IL or missing references)
		//IL_0114: Unknown result type (might be due to invalid IL or missing references)
		//IL_014e: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_022a: Unknown result type (might be due to invalid IL or missing references)
		//IL_022f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0232: Unknown result type (might be due to invalid IL or missing references)
		//IL_0183: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_02cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ad: Unknown result type (might be due to invalid IL or missing references)
		foreach (MapItemNode mapItem in mapItemList)
		{
			if (!((Object)(object)mapItem == null))
			{
				if (isDead)
				{
					mapItem.OnUnLoadNode();
				}
				else
				{
					mapItem.ForceLoadNode();
				}
			}
		}
		SetAirWalls(!isDead);
		if (!isDead && popupTipQueueId > 0)
		{
			Singleton<Story>.Instance.PlayQueueTip(popupTipType, popupTipQueueId);
		}
		if (!UseAudioControl)
		{
			return;
		}
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

	public void SetAirWalls(bool isShow)
	{
		foreach (GameObject airWall in AirWalls)
		{
			if (!(airWall == null))
			{
				airWall.SetActive(isShow);
			}
		}
	}

	public bool IsHaveAirWall()
	{
		foreach (MapItemNode mapItem in mapItemList)
		{
			if ((Object)(object)mapItem != null)
			{
				return true;
			}
		}
		foreach (GameObject airWall in AirWalls)
		{
			if (airWall != null)
			{
				return true;
			}
		}
		return false;
	}
}
