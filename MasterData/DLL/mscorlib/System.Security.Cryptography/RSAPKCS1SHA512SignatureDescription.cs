namespace System.Security.Cryptography;

internal class RSAPKCS1SHA512SignatureDescription : RSAPKCS1SignatureDescription
{
	public RSAPKCS1SHA512SignatureDescription()
		: base("SHA512", "System.Security.Cryptography.SHA512Cng")
	{
	}
}
