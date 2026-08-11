using System.Collections.Generic;
using FMOD.Studio;

namespace Ase;

public static class FMOD_Define
{
	public enum UIAudioEnum
	{
		NONE,
		BUTTON_CLICK,
		TOGGLE_IN,
		TOGGLE_OUT,
		ObjectStart,
		ObjectDestroy,
		ObjectEnable,
		ObjectDisable,
		VIEW_ANIMATION_ENTER,
		VIEW_ANIMATION_OUT,
		AnimationUIView_Show,
		AnimationUIView_Hide,
		OnPointerDown,
		OnPointerClick
	}

	public struct SoundEffectParameter
	{
		public List<AudioParameterSerializable> Params;

		public float Volume;

		public SoundEffectParameter(float volume = 1f, Dictionary<string, float> paramDic = null)
		{
			Volume = volume;
			Params = new List<AudioParameterSerializable>();
			if (paramDic == null)
			{
				return;
			}
			foreach (KeyValuePair<string, float> item in paramDic)
			{
				Params.Add(new AudioParameterSerializable
				{
					Key = item.Key,
					Value = item.Value,
					Duration = 0f
				});
			}
		}

		public SoundEffectParameter(float volume = 1f, List<AudioParameterSerializable> paramList = null)
		{
			Volume = volume;
			Params = paramList;
		}
	}

	public struct BgmParameter
	{
		public List<AudioParameterSerializable> Params;

		public float Volume;

		public bool CanReturn;

		public STOP_MODE StopMode;

		public float FadeInTime;

		public float FadeOutTime;

		public BgmParameter(List<AudioParameterSerializable> paramList = null, bool canReturn = true, STOP_MODE stopMode = (STOP_MODE)0, float fadeInTime = 3f, float fadeOutTime = 3f)
		{
			//IL_001a: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			Volume = -1f;
			Params = paramList;
			CanReturn = canReturn;
			StopMode = stopMode;
			FadeInTime = fadeInTime;
			FadeOutTime = fadeOutTime;
		}

		public BgmParameter(float volume = -1f, List<AudioParameterSerializable> paramList = null, bool canReturn = true, STOP_MODE stopMode = (STOP_MODE)0, float fadeInTime = 3f, float fadeOutTime = 3f)
		{
			//IL_0016: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			Volume = volume;
			Params = paramList;
			CanReturn = canReturn;
			StopMode = stopMode;
			FadeInTime = fadeInTime;
			FadeOutTime = fadeOutTime;
		}
	}

	public static string VCA_MAIN = "vca:/Master";

	public static string VCA_MUSIC = "vca:/Music";

	public static string VCA_SFX = "vca:/SFX";

	public static string VCA_VOICE = "vca:/VO";
}
