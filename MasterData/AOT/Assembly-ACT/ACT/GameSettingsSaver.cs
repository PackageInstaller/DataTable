using UnityEngine;

namespace ACT;

public abstract class GameSettingsSaver : ScriptableObject
{
	public abstract SerializedSettingsData Load(string key);

	public virtual bool HasSavedData(string key)
	{
		return Load(key) != null;
	}

	public abstract void Save(string key, SerializedSettingsData settingsData);

	public abstract void Delete(string key);
}
