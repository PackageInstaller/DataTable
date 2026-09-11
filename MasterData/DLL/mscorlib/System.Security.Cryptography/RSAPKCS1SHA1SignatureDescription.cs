namespace System.Security.Cryptography;

internal class RSAPKCS1SHA1SignatureDescription : RSAPKCS1SignatureDescription
{
	public RSAPKCS1SHA1SignatureDescription()
		: base("SHA1", "System.Security.Cryptography.SHA1Cng")
	{
	}
}
