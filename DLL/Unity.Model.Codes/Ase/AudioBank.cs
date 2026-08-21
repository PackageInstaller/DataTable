using FMODUnity;
using UnityEngine;

namespace Ase;

public class AudioBank
{
	private string bankPath;

	private int bankType;

	private string bankTag;

	private int refCount;

	public int BankType => bankType;

	public string BankTag => bankTag;

	public int RefCount => refCount;

	public AudioBank(string bankPath, int bankType)
	{
		this.bankPath = bankPath;
		this.bankType = bankType;
		bankTag = bankType + "_" + bankPath;
		refCount = 1;
	}

	public void UnloadBank(bool unloadComplete = false)
	{
		if (IsLoaded())
		{
			RuntimeManager.UnloadBank(bankPath, unloadComplete);
		}
	}

	public void LoadBank(TextAsset asset, bool loadSamples = false)
	{
		if (!IsLoaded())
		{
			RuntimeManager.LoadBank(asset, bankPath, loadSamples);
		}
	}

	public void AddRef()
	{
		refCount++;
	}

	public void DelRef()
	{
		refCount--;
	}

	public bool IsLoaded()
	{
		return RuntimeManager.HasBankLoaded(bankPath);
	}
}
