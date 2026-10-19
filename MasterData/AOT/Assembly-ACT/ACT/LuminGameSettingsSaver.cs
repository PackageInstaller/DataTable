using UnityEngine;

namespace ACT;

[CreateAssetMenu(fileName = "LuminGameSettingsSaver", menuName = "ACT/GameSettingsSaver")]
public class LuminGameSettingsSaver : GameSettingsSaver
{
	public override bool HasSavedData(string key)
	{
		return PlayerPrefs.HasKey(key);
	}

	public override SerializedSettingsData Load(string key)
	{
		string text = PlayerPrefs.GetString(key, string.Empty);
		SerializedSettingsData serializedSettingsData = null;
		if (!string.IsNullOrEmpty(text))
		{
			return JsonUtility.FromJson<SerializedSettingsData>(text);
		}
		return new SerializedSettingsData();
	}

	public override void Save(string key, SerializedSettingsData settingsData)
	{
		string value = JsonUtility.ToJson(settingsData);
		PlayerPrefs.SetString(key, value);
		PlayerPrefs.Save();
	}

	public override void Delete(string key)
	{
		PlayerPrefs.DeleteKey(key);
		PlayerPrefs.Save();
	}
}
