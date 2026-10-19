using System.Security.Cryptography.X509Certificates;

namespace System.Net.Security;

internal delegate X509Certificate ServerCertSelectionCallback(string hostName);
