using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[Serializable]
[ComVisible(true)]
public enum CipherMode
{
	CBC = 1,
	ECB,
	OFB,
	CFB,
	CTS
}
