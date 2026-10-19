using ACT.Model;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class LocalQualitySettings
{
	public const string SILENCE_TIP = "SILENCE_TIP";

	public const string CUSTOMSCHEME = "CUSTOMSCHEME";

	public const string CUSTOMSCHEMEORDER = "CUSTOMSCHEMEORDER";

	private static LocalQualitySettings instance;

	private int _cameraNoise;

	public int silenceTip;

	public int cameraNoise
	{
		get
		{
			return _cameraNoise;
		}
		set
		{
			_cameraNoise = value;
		}
	}

	public static LocalQualitySettings ReadFromLocal()
	{
		if (instance == null)
		{
			instance = new LocalQualitySettings();
		}
		if (Model<ServerPlayerPrefs>.HasInstance())
		{
			instance.silenceTip = ServerPlayerPrefs.GetInt("SILENCE_TIP");
		}
		return instance;
	}

	public void SaveLocal()
	{
		ServerPlayerPrefs.SetInt("SILENCE_TIP", silenceTip);
		PlayerPrefs.Save();
		ServerPlayerPrefs.Save();
	}
}
