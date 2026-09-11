using System.Net.Sockets;

namespace System.Net.Configuration;

internal sealed class SettingsSectionInternal
{
	private static readonly SettingsSectionInternal instance = new SettingsSectionInternal();

	internal readonly bool HttpListenerUnescapeRequestUrl = true;

	internal readonly IPProtectionLevel IPProtectionLevel = IPProtectionLevel.Unspecified;

	internal static SettingsSectionInternal Section => instance;

	internal bool Ipv6Enabled => true;
}
