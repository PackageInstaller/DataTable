using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[Serializable]
[ComVisible(true)]
public enum PaddingMode
{
	None = 1,
	PKCS7,
	Zeros,
	ANSIX923,
	ISO10126
}
