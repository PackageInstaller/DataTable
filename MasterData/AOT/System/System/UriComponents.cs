namespace System;

[Flags]
public enum UriComponents
{
	Scheme = 1,
	UserInfo = 2,
	Host = 4,
	Port = 8,
	Path = 0x10,
	Query = 0x20,
	Fragment = 0x40,
	StrongPort = 0x80,
	NormalizedHost = 0x100,
	KeepDelimiter = 0x40000000,
	SerializationInfoString = int.MinValue,
	AbsoluteUri = Scheme | UserInfo | Host | Port | Path | Query | Fragment,
	HostAndPort = Host | StrongPort,
	StrongAuthority = HostAndPort | UserInfo,
	SchemeAndServer = 0xD,
	HttpRequestUrl = 0x3D,
	PathAndQuery = 0x30
}
