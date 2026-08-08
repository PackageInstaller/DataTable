using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[Serializable]
[ComVisible(true)]
public struct RSAParameters
{
	public byte[] Exponent;

	public byte[] Modulus;

	[NonSerialized]
	public byte[] P;

	[NonSerialized]
	public byte[] Q;

	[NonSerialized]
	public byte[] DP;

	[NonSerialized]
	public byte[] DQ;

	[NonSerialized]
	public byte[] InverseQ;

	[NonSerialized]
	public byte[] D;
}
