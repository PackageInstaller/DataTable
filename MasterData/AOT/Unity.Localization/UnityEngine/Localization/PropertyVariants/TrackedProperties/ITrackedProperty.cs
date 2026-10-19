namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

public interface ITrackedProperty
{
	string PropertyPath { get; set; }

	bool HasVariant(LocaleIdentifier localeIdentifier);
}
