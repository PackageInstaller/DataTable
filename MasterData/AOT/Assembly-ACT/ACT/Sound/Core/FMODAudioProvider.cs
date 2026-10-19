using System;
using System.Collections.Generic;
using FMOD;
using FMOD.Studio;
using FMODUnity;
using UnityEngine;

namespace ACT.Sound.Core;

internal class FMODAudioProvider : IAudioProvider
{
	private readonly Dictionary<string, Bank> _directLoadedBanks = new Dictionary<string, Bank>();

	public IAudioInstance CreateInstance(string eventPath)
	{
		try
		{
			EventReference eventReference = RuntimeManager.PathToEventReference(eventPath);
			if (eventReference.IsNull)
			{
				return null;
			}
			return new FMODAudioInstance(RuntimeManager.CreateInstance(eventReference));
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				UnityEngine.Debug.LogWarning("[AudioCore] CreateInstance failed: " + eventPath + "\n" + ex.Message + "\n" + ex.StackTrace);
			}
			return null;
		}
	}

	public bool IsBankLoaded(string bankGuid)
	{
		if (RuntimeManager.HasBankLoaded(bankGuid))
		{
			return true;
		}
		if (_directLoadedBanks.TryGetValue(bankGuid, out var value) && value.isValid())
		{
			return true;
		}
		return false;
	}

	public void LoadBank(TextAsset bankAsset, string bankGuid)
	{
		RuntimeManager.LoadBank(bankAsset, loadSamples: false, bankGuid);
	}

	public void LoadBankFromFile(string filePath, string bankGuid)
	{
		try
		{
			if (RuntimeManager.HasBankLoaded(bankGuid) || (_directLoadedBanks.TryGetValue(bankGuid, out var value) && value.isValid()))
			{
				return;
			}
			FMOD.Studio.System studioSystem = RuntimeManager.StudioSystem;
			if (!studioSystem.isValid())
			{
				UnityEngine.Debug.LogError("[AudioCore] LoadBankFromFile failed: StudioSystem is not valid");
				return;
			}
			RESULT rESULT = studioSystem.loadBankFile(filePath, LOAD_BANK_FLAGS.NORMAL, out var bank);
			switch (rESULT)
			{
			case RESULT.OK:
				_directLoadedBanks[bankGuid] = bank;
				if (LuminApplication.LogEnabled)
				{
					UnityEngine.Debug.Log("[AudioCore] LoadBankFromFile success: " + filePath);
				}
				break;
			case RESULT.ERR_EVENT_ALREADY_LOADED:
				if (LuminApplication.LogEnabled)
				{
					UnityEngine.Debug.LogWarning("[AudioCore] Bank already loaded in FMOD, skipping: " + filePath);
				}
				break;
			default:
				UnityEngine.Debug.LogError($"[AudioCore] LoadBankFromFile failed: {filePath}, result={rESULT}");
				break;
			}
		}
		catch (Exception ex)
		{
			UnityEngine.Debug.LogError("[AudioCore] LoadBankFromFile exception: " + filePath + ", " + ex.Message);
		}
	}

	public void UnloadBank(string bankGuid)
	{
		Bank value;
		if (RuntimeManager.HasBankLoaded(bankGuid))
		{
			RuntimeManager.UnloadBank(bankGuid);
		}
		else if (_directLoadedBanks.TryGetValue(bankGuid, out value))
		{
			if (value.isValid())
			{
				value.unload();
			}
			_directLoadedBanks.Remove(bankGuid);
		}
	}

	public IAudioBus GetBus(string busPath)
	{
		return new FMODAudioBus(RuntimeManager.GetBus(busPath));
	}

	public IAudioVCA GetVCA(string vcaPath)
	{
		return new FMODAudioVCA(RuntimeManager.GetVCA(vcaPath));
	}

	public void SetGlobalParameter(string parameterName, float value)
	{
		if (RuntimeManager.StudioSystem.isValid())
		{
			RuntimeManager.StudioSystem.setParameterByName(parameterName, value);
		}
	}

	public float GetGlobalParameter(string parameterName)
	{
		if (RuntimeManager.StudioSystem.isValid())
		{
			RuntimeManager.StudioSystem.getParameterByName(parameterName, out var value);
			return value;
		}
		return 0f;
	}

	public string PathToEventReference(string path)
	{
		try
		{
			return RuntimeManager.PathToEventReference(path).Guid.ToString();
		}
		catch
		{
			return string.Empty;
		}
	}

	public IAudioListener CreateListener(GameObject gameObject)
	{
		if (gameObject == null)
		{
			return null;
		}
		StudioListener studioListener = gameObject.GetComponent<StudioListener>();
		if (studioListener == null)
		{
			studioListener = gameObject.AddComponent<StudioListener>();
		}
		return new FMODAudioListener(studioListener);
	}
}
