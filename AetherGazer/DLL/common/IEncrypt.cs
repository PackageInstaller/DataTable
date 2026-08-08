public interface IEncrypt
{
	byte[] Decrypt(byte[] data);

	byte[] Encrypt(byte[] data);
}
