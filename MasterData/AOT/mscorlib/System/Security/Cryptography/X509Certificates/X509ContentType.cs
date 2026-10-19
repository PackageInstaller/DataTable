namespace System.Security.Cryptography.X509Certificates;

public enum X509ContentType
{
	Unknown = 0,
	Cert = 1,
	SerializedCert = 2,
	Pfx = 3,
	Pkcs12 = Pfx,
	SerializedStore = 4,
	Pkcs7 = 5,
	Authenticode = 6
}
