namespace System.Security.Cryptography;

internal class DSASignatureDescription : SignatureDescription
{
	public DSASignatureDescription()
	{
		KeyAlgorithm = "System.Security.Cryptography.DSACryptoServiceProvider";
		DigestAlgorithm = "System.Security.Cryptography.SHA1CryptoServiceProvider";
		FormatterAlgorithm = "System.Security.Cryptography.DSASignatureFormatter";
		DeformatterAlgorithm = "System.Security.Cryptography.DSASignatureDeformatter";
	}
}
