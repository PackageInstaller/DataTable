namespace System.Security.Cryptography;

internal abstract class RSAPKCS1SignatureDescription : SignatureDescription
{
	private string _hashAlgorithm;

	protected RSAPKCS1SignatureDescription(string hashAlgorithm, string digestAlgorithm)
	{
		base.KeyAlgorithm = "System.Security.Cryptography.RSA";
		base.DigestAlgorithm = digestAlgorithm;
		base.FormatterAlgorithm = "System.Security.Cryptography.RSAPKCS1SignatureFormatter";
		base.DeformatterAlgorithm = "System.Security.Cryptography.RSAPKCS1SignatureDeformatter";
		_hashAlgorithm = hashAlgorithm;
	}
}
