using System.Collections.Generic;

namespace System.Net;

[Obsolete("This API is no longer supported.")]
public delegate IEnumerable<string> CipherSuitesCallback(SecurityProtocolType protocol, IEnumerable<string> allCiphers);
