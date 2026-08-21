namespace Mono;

internal struct RuntimeRemoteClassHandle
{
	private unsafe RuntimeStructs.RemoteClass* value;

	internal unsafe RuntimeClassHandle ProxyClass => new RuntimeClassHandle(value->proxy_class);
}
