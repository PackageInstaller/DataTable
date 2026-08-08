namespace System.Security.Authentication;

[Flags]
public enum SslProtocols
{
	None = 0,
	Ssl2 = 0xC,
	Ssl3 = 0x30,
	Tls = 0xC0,
	[System.MonoTODO("unsupported")]
	Tls11 = 0x300,
	[System.MonoTODO("unsupported")]
	Tls12 = 0xC00,
	Tls13 = 0x3000,
	Default = Ssl3 | Tls
}
