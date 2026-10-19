using UnityEngine;

namespace ACT.Sound.Core;

public static class AudioCore
{
	private static IAudioProvider _provider;

	static AudioCore()
	{
		_provider = new FMODAudioProvider();
	}

	public static IAudioInstance CreateInstance(string eventPath)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return null;
		}
		return _provider.CreateInstance(eventPath);
	}

	public static bool IsBankLoaded(string bankGuid)
	{
		return _provider.IsBankLoaded(bankGuid);
	}

	public static void LoadBank(TextAsset bankAsset, string bankGuid)
	{
		_provider.LoadBank(bankAsset, bankGuid);
	}

	public static void LoadBankFromFile(string filePath, string bankGuid)
	{
		_provider.LoadBankFromFile(filePath, bankGuid);
	}

	public static void UnloadBank(string bankGuid)
	{
		_provider.UnloadBank(bankGuid);
	}

	public static IAudioBus GetBus(string busPath)
	{
		return _provider.GetBus(busPath);
	}

	public static IAudioVCA GetVCA(string vcaPath)
	{
		return _provider.GetVCA(vcaPath);
	}

	public static void SetGlobalParameter(string parameterName, float value)
	{
		_provider.SetGlobalParameter(parameterName, value);
	}

	public static float GetGlobalParameter(string parameterName)
	{
		return _provider.GetGlobalParameter(parameterName);
	}

	public static string PathToEventReference(string path)
	{
		return _provider.PathToEventReference(path);
	}

	public static IAudioListener CreateListener(GameObject gameObject)
	{
		return _provider.CreateListener(gameObject);
	}
}
