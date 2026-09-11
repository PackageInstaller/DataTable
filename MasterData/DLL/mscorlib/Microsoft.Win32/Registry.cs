using System;

namespace Microsoft.Win32;

public static class Registry
{
	public static readonly RegistryKey CurrentUser = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Default);

	public static readonly RegistryKey LocalMachine = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Default);

	public static readonly RegistryKey ClassesRoot = RegistryKey.OpenBaseKey(RegistryHive.ClassesRoot, RegistryView.Default);

	public static readonly RegistryKey Users = RegistryKey.OpenBaseKey(RegistryHive.Users, RegistryView.Default);

	public static readonly RegistryKey PerformanceData = RegistryKey.OpenBaseKey(RegistryHive.PerformanceData, RegistryView.Default);

	public static readonly RegistryKey CurrentConfig = RegistryKey.OpenBaseKey(RegistryHive.CurrentConfig, RegistryView.Default);

	[Obsolete("Use PerformanceData instead")]
	public static readonly RegistryKey DynData = RegistryKey.OpenBaseKey(RegistryHive.DynData, RegistryView.Default);
}
