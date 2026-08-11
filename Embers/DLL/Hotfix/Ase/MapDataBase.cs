using System.Collections.Generic;
using FMOD.Studio;
using Sirenix.OdinInspector;

namespace Ase;

public class MapDataBase : SerializedMonoBehaviour
{
	public enum MapDataAudioType
	{
		PlayBgm,
		PlayBgmCheckId
	}

	public MapDataAudioType audioType;

	public int configId;

	public float volume = 1f;

	public bool clearBgmStack = true;

	public STOP_MODE stopMode;

	public float fadeInTime = 3f;

	public float fadeOutTime = 3f;

	public List<AudioParameterSerializable> paramList = new List<AudioParameterSerializable>();

	public void PlayBGM()
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		if (configId > 0)
		{
			if (audioType == MapDataAudioType.PlayBgm)
			{
				Singleton<AudioSystem>.Instance.PlayBgm(configId, new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode));
			}
			else if (audioType == MapDataAudioType.PlayBgmCheckId)
			{
				Singleton<AudioSystem>.Instance.PlayBgmWithIdCheck(configId, new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode));
			}
		}
	}

	public void StopAllBGM()
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		if (configId > 0 && Singleton<AudioSystem>.Instance != null)
		{
			Singleton<AudioSystem>.Instance.StopCurBgm(stopMode, clearCache: true);
		}
	}

	public void StopCurrentBGM()
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		if (configId > 0 && Singleton<AudioSystem>.Instance != null)
		{
			Singleton<AudioSystem>.Instance.StopCurBgm(stopMode);
		}
	}
}
