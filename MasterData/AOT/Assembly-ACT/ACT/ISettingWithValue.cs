using System;

namespace ACT;

public interface ISettingWithValue<TValue> : ISetting
{
	bool Enabled { get; }

	TValue GetValue();

	TValue GetAppliedValue();

	void SetValue(TValue value, bool applyImmediately = false);

	void AddChangedListener(Action<TValue> onChanged);

	void RemoveChangedListener(Action<TValue> onChanged);
}
