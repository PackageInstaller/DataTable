namespace GameFramework.Runtime;

public interface IEncryptor
{
	byte[] Encode(byte[] plainData);

	byte[] Decode(byte[] cipherData);
}
