using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class PKCS1MaskGenerationMethod : MaskGenerationMethod
{
	private string HashNameValue;

	public PKCS1MaskGenerationMethod()
	{
		HashNameValue = "SHA1";
	}
}
