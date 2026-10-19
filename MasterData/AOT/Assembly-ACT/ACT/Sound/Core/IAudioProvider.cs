using UnityEngine;

namespace ACT.Sound.Core;

public interface IAudioProvider
{
	IAudioInstance CreateInstance(string eventPath);

	bool IsBankLoaded(string bankGuid);

	void LoadBank(TextAsset bankAsset, string bankGuid);

	void LoadBankFromFile(string filePath, string bankGuid);

	void UnloadBank(string bankGuid);

	IAudioBus GetBus(string busPath);

	IAudioVCA GetVCA(string vcaPath);

	void SetGlobalParameter(string parameterName, float value);

	float GetGlobalParameter(string parameterName);

	string PathToEventReference(string path);

	IAudioListener CreateListener(GameObject gameObject);
}
