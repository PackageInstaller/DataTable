namespace System.Globalization;

[Flags]
public enum CultureTypes
{
	NeutralCultures = 1,
	SpecificCultures = 2,
	InstalledWin32Cultures = 4,
	AllCultures = NeutralCultures | SpecificCultures | InstalledWin32Cultures,
	UserCustomCulture = 8,
	ReplacementCultures = 0x10,
	[Obsolete("This value has been deprecated.  Please use other values in CultureTypes.")]
	WindowsOnlyCultures = 0x20,
	[Obsolete("This value has been deprecated.  Please use other values in CultureTypes.")]
	FrameworkCultures = 0x40
}
