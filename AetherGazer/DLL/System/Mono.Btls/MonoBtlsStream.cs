using System.IO;
using System.Net.Security;
using Mono.Net.Security;
using Mono.Security.Interface;

namespace Mono.Btls;

internal class MonoBtlsStream : MobileAuthenticatedStream
{
	public MonoBtlsStream(Stream innerStream, bool leaveInnerStreamOpen, SslStream owner, MonoTlsSettings settings, MobileTlsProvider provider)
		: base(innerStream, leaveInnerStreamOpen, owner, settings, provider)
	{
	}

	protected override MobileTlsContext CreateContext(MonoSslAuthenticationOptions options)
	{
		return new MonoBtlsContext(this, options);
	}
}
