using System.Collections.Generic;
using System.Text;
using FMOD.Studio;
using UnityEngine.Pool;

namespace Ase;

public static class AudioManagerExtension
{
	public static bool SameAudio(this AudioItem audioItem, AudioItem other)
	{
		return audioItem.Info == other.Info;
	}

	public static bool SameAudio(this AudioItem audioItem, AudioInfo audioInfo)
	{
		return audioItem.Info == audioInfo;
	}

	public static void PlayItem(this AudioItem audioItem, bool forcePlay = true, bool needAwait = true)
	{
		audioItem.SetOriParameters().SetParameters(audioItem.AudioParams).SetAttributes()
			.Start(forcePlay, needAwait);
	}

	public static List<AudioParameter> GetFadeInParameters(float targetValue, float fadeInTime)
	{
		List<AudioParameter> list = CollectionPool<List<AudioParameter>, AudioParameter>.Get();
		if (fadeInTime > 0f)
		{
			list.Add(new AudioParameter
			{
				key = AudioDef.BGMFadeParamVolume,
				oriVal = 1f,
				targetVal = targetValue,
				duration = fadeInTime
			});
		}
		return list;
	}

	public static List<AudioParameter> GetFadeOutParameters(float targetValue, float fadeOutTime)
	{
		List<AudioParameter> list = CollectionPool<List<AudioParameter>, AudioParameter>.Get();
		if (fadeOutTime > 0f)
		{
			list.Add(new AudioParameter
			{
				key = AudioDef.BGMFadeParamVolume,
				oriVal = 0f,
				targetVal = targetValue,
				duration = fadeOutTime
			});
		}
		return list;
	}

	public static void Debug(this AudioItem item, StringBuilder sb)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0120: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0164: Unknown result type (might be due to invalid IL or missing references)
		EventInstance eventInstance = item.EventInstance;
		bool flag = default(bool);
		((EventInstance)(ref eventInstance)).getPaused(ref flag);
		string text = $"{item.Info.id} Paused:{flag} 参数：";
		if (GetEventParamValue(item.EventInstance, "Volume reduce", out var log))
		{
			text = text + log + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "Ambience", out var log2))
		{
			text = text + log2 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "Boss intensity 2", out var log3))
		{
			text = text + log3 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "Boss intensity", out var log4))
		{
			text = text + log4 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "bossfight victory", out var log5))
		{
			text = text + log5 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "Intensity", out var log6))
		{
			text = text + log6 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "music A1", out var log7))
		{
			text = text + log7 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "music A2", out var log8))
		{
			text = text + log8 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "music A3", out var log9))
		{
			text = text + log9 + "  ";
		}
		if (GetEventParamValue(item.EventInstance, "Music Volume reduce", out var log10))
		{
			text = text + log10 + "  ";
		}
		sb.AppendLine(text);
	}

	private static bool GetEventParamValue(EventInstance eventInstance, string paramName, out string log)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		log = string.Empty;
		float num = default(float);
		float num2 = default(float);
		if ((int)((EventInstance)(ref eventInstance)).getParameterByName(paramName, ref num, ref num2) == 0)
		{
			log = $"{paramName}:{num},{num2}";
			return true;
		}
		return false;
	}
}
