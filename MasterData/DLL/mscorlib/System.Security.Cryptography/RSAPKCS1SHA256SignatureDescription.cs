namespace System.Security.Cryptography;

internal class RSAPKCS1SHA256SignatureDescription : RSAPKCS1SignatureDescription
{
	public RSAPKCS1SHA256SignatureDescription()
		: base("SHA256", "System.Security.Cryptography.SHA256Cng")
	{
	}
}
