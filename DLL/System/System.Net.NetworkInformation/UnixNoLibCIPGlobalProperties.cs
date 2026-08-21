namespace System.Net.NetworkInformation;

internal sealed class UnixNoLibCIPGlobalProperties : UnixIPGlobalProperties
{
	public override string DomainName => string.Empty;
}
