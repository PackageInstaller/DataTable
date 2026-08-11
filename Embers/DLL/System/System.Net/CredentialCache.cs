namespace System.Net;

public class CredentialCache
{
	public static ICredentials DefaultCredentials => SystemNetworkCredential.defaultCredential;

	public static NetworkCredential DefaultNetworkCredentials => SystemNetworkCredential.defaultCredential;
}
