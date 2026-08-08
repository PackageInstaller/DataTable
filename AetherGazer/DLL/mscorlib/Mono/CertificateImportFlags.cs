using System;

namespace Mono;

[Flags]
internal enum CertificateImportFlags
{
	None = 0,
	DisableNativeBackend = 1,
	DisableAutomaticFallback = 2
}
