namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

public interface ITrackedPropertyValue<T> : ITrackedProperty
{
	bool GetValue(LocaleIdentifier localeIdentifier, out T foundValue);

	bool GetValue(LocaleIdentifier localeIdentifier, LocaleIdentifier fallback, out T foundValue);

	void SetValue(LocaleIdentifier localeIdentifier, T value);
}
