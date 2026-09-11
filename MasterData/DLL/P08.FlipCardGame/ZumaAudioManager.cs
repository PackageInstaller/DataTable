using System.Collections.Generic;
using UnityEngine;

public class ZumaAudioManager : MonoBehaviour
{
	private static ZumaAudioManager mInstance;

	public string cueSheetName;

	public List<ZumaCueItem> cueNameList;

	private Dictionary<ZumaAudioEnum, string> cueNameDict = new Dictionary<ZumaAudioEnum, string>();

	public static ZumaAudioManager Instance => mInstance;

	public void Awake()
	{
		mInstance = this;
		for (int i = 0; i < cueNameList.Count; i++)
		{
			cueNameDict.Add(cueNameList[i].cueType, cueNameList[i].cueName);
		}
	}

	public void PlayZumaAudio(ZumaAudioEnum cueType)
	{
		string cueName = cueNameDict[cueType];
		AudioManager.Instance.Play("effect", cueSheetName, cueName, useStream: false);
	}

	public void PlayZumaComboAudio(int comboCount)
	{
		if (comboCount == 2)
		{
			PlayZumaAudio(ZumaAudioEnum.Combo2Hit);
		}
		else if (comboCount == 3)
		{
			PlayZumaAudio(ZumaAudioEnum.Combo3Hit);
		}
		else if (comboCount == 4)
		{
			PlayZumaAudio(ZumaAudioEnum.Combo4Hit);
		}
		else if (comboCount >= 5)
		{
			PlayZumaAudio(ZumaAudioEnum.Combo5Hit);
		}
	}
}
