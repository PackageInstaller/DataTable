using System;

namespace ACT;

public interface ISetting
{
	string Id { get; }

	string Description { get; }

	bool Usable { get; }

	bool Modified { get; }

	GameSettings Owner { get; }

	Action<ISetting> OnChange { get; set; }

	void Initialize(GameSettings owner);

	bool HasConnection();

	void InitToConnection();

	void PushToConnection();

	void ResetToDefault();

	void ResetToAppliedValue();

	bool HasUnAppliedChanges();

	void Apply();

	SettingData SerializeValueToData();

	void DeserializeValueFromData(SettingData data);

	bool CheckMatchValue(string value);
}
