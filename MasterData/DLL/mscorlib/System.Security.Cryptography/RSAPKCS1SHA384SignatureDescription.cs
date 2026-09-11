namespace System.Security.Cryptography;

internal class RSAPKCS1SHA384SignatureDescription : RSAPKCS1SignatureDescription
{
	public RSAPKCS1SHA384SignatureDescription()
		: base("SHA384", "System.Security.Cryptography.SHA384Cng")
	{
	}
}
