namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

public interface IStringProperty : ITrackedProperty
{
	string GetValueAsString(LocaleIdentifier localeIdentifier);

	string GetValueAsString(LocaleIdentifier localeIdentifier, LocaleIdentifier fallback);

	void SetValueFromString(LocaleIdentifier localeIdentifier, string value);
}
