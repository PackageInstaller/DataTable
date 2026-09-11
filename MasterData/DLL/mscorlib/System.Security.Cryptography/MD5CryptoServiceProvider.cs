using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class MD5CryptoServiceProvider : MD5
{
	private uint[] _H;

	private uint[] buff;

	private ulong count;

	private byte[] _ProcessingBuffer;

	private int _ProcessingBufferCount;

	private static readonly uint[] K = new uint[64]
	{
		370546198u, 370546198u, 370546198u, 522130966u, 370540544u, 370546198u, 370540544u, 370546198u, 370540544u, 370546198u,
		370540544u, 22u, 286197768u, 526357u, 252645141u, 1381647u, 0u, 0u, 1296911616u, 5397u,
		370546198u, 370546198u, 370546198u, 370546176u, 370546198u, 370546198u, 1447446u, 369104406u, 2360868u, 939524096u,
		943208504u, 943208504u, 943208504u, 943208504u, 943208504u, 943208504u, 943208504u, 570425344u, 572662306u, 572662306u,
		1313754702u, 1313754702u, 1313754702u, 1313754702u, 1313754702u, 488447310u, 353703197u, 353703189u, 353703189u, 353703189u,
		488445205u, 2236949u, 21u, 0u, 0u, 0u, 572662306u, 572662306u, 572662306u, 8482u,
		454761249u, 454761243u, 454761243u, 454761243u
	};

	public MD5CryptoServiceProvider()
	{
		_H = new uint[4];
		buff = new uint[16];
		_ProcessingBuffer = new byte[64];
		Initialize();
	}

	~MD5CryptoServiceProvider()
	{
		Dispose(disposing: false);
	}

	protected override void Dispose(bool disposing)
	{
		if (_ProcessingBuffer != null)
		{
			Array.Clear(_ProcessingBuffer, 0, _ProcessingBuffer.Length);
		}
		if (_H != null)
		{
			Array.Clear(_H, 0, _H.Length);
		}
		if (buff != null)
		{
			Array.Clear(buff, 0, buff.Length);
		}
		base.Dispose(disposing);
	}

	protected override void HashCore(byte[] rgb, int ibStart, int cbSize)
	{
		if (_ProcessingBufferCount != 0)
		{
			if (cbSize < 64 - _ProcessingBufferCount)
			{
				Buffer.BlockCopy(rgb, ibStart, _ProcessingBuffer, _ProcessingBufferCount, cbSize);
				_ProcessingBufferCount += cbSize;
				return;
			}
			int num = 64 - _ProcessingBufferCount;
			Buffer.BlockCopy(rgb, ibStart, _ProcessingBuffer, _ProcessingBufferCount, num);
			ProcessBlock(_ProcessingBuffer, 0);
			_ProcessingBufferCount = 0;
			ibStart += num;
			cbSize -= num;
		}
		for (int num = 0; num < cbSize - cbSize % 64; num += 64)
		{
			ProcessBlock(rgb, ibStart + num);
		}
		if (cbSize % 64 != 0)
		{
			Buffer.BlockCopy(rgb, cbSize - cbSize % 64 + ibStart, _ProcessingBuffer, 0, cbSize % 64);
			_ProcessingBufferCount = cbSize % 64;
		}
	}

	protected override byte[] HashFinal()
	{
		byte[] array = new byte[16];
		ProcessFinalBlock(_ProcessingBuffer, 0, _ProcessingBufferCount);
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				array[i * 4 + j] = (byte)(_H[i] >> j * 8);
			}
		}
		return array;
	}

	public override void Initialize()
	{
		count = 0uL;
		_ProcessingBufferCount = 0;
		_H[0] = 1732584193u;
		_H[1] = 4023233417u;
		_H[2] = 2562383102u;
		_H[3] = 271733878u;
	}

	private void ProcessBlock(byte[] inputBuffer, int inputOffset)
	{
		count += 64uL;
		for (int i = 0; i < 16; i++)
		{
			buff[i] = (uint)(inputBuffer[inputOffset + 4 * i] | (inputBuffer[inputOffset + 4 * i + 1] << 8) | (inputBuffer[inputOffset + 4 * i + 2] << 16) | (inputBuffer[inputOffset + 4 * i + 3] << 24));
		}
		uint num = _H[0];
		uint num2 = _H[1];
		uint num3 = _H[2];
		uint num4 = _H[3];
		num += (((num3 ^ num4) & num2) ^ num4) + K[0] + buff[0];
		num = (num << 7) | (num >> 25);
		num += num2;
		num4 += (((num2 ^ num3) & num) ^ num3) + K[1] + buff[1];
		num4 = (num4 << 12) | (num4 >> 20);
		num4 += num;
		num3 += (((num ^ num2) & num4) ^ num2) + K[2] + buff[2];
		num3 = (num3 << 17) | (num3 >> 15);
		num3 += num4;
		num2 += (((num4 ^ num) & num3) ^ num) + K[3] + buff[3];
		num2 = (num2 << 22) | (num2 >> 10);
		num2 += num3;
		num += (((num3 ^ num4) & num2) ^ num4) + K[4] + buff[4];
		num = (num << 7) | (num >> 25);
		num += num2;
		num4 += (((num2 ^ num3) & num) ^ num3) + K[5] + buff[5];
		num4 = (num4 << 12) | (num4 >> 20);
		num4 += num;
		num3 += (((num ^ num2) & num4) ^ num2) + K[6] + buff[6];
		num3 = (num3 << 17) | (num3 >> 15);
		num3 += num4;
		num2 += (((num4 ^ num) & num3) ^ num) + K[7] + buff[7];
		num2 = (num2 << 22) | (num2 >> 10);
		num2 += num3;
		num += (((num3 ^ num4) & num2) ^ num4) + K[8] + buff[8];
		num = (num << 7) | (num >> 25);
		num += num2;
		num4 += (((num2 ^ num3) & num) ^ num3) + K[9] + buff[9];
		num4 = (num4 << 12) | (num4 >> 20);
		num4 += num;
		num3 += (((num ^ num2) & num4) ^ num2) + K[10] + buff[10];
		num3 = (num3 << 17) | (num3 >> 15);
		num3 += num4;
		num2 += (((num4 ^ num) & num3) ^ num) + K[11] + buff[11];
		num2 = (num2 << 22) | (num2 >> 10);
		num2 += num3;
		num += (((num3 ^ num4) & num2) ^ num4) + K[12] + buff[12];
		num = (num << 7) | (num >> 25);
		num += num2;
		num4 += (((num2 ^ num3) & num) ^ num3) + K[13] + buff[13];
		num4 = (num4 << 12) | (num4 >> 20);
		num4 += num;
		num3 += (((num ^ num2) & num4) ^ num2) + K[14] + buff[14];
		num3 = (num3 << 17) | (num3 >> 15);
		num3 += num4;
		num2 += (((num4 ^ num) & num3) ^ num) + K[15] + buff[15];
		num2 = (num2 << 22) | (num2 >> 10);
		num2 += num3;
		num += (((num2 ^ num3) & num4) ^ num3) + K[16] + buff[1];
		num = (num << 5) | (num >> 27);
		num += num2;
		num4 += (((num ^ num2) & num3) ^ num2) + K[17] + buff[6];
		num4 = (num4 << 9) | (num4 >> 23);
		num4 += num;
		num3 += (((num4 ^ num) & num2) ^ num) + K[18] + buff[11];
		num3 = (num3 << 14) | (num3 >> 18);
		num3 += num4;
		num2 += (((num3 ^ num4) & num) ^ num4) + K[19] + buff[0];
		num2 = (num2 << 20) | (num2 >> 12);
		num2 += num3;
		num += (((num2 ^ num3) & num4) ^ num3) + K[20] + buff[5];
		num = (num << 5) | (num >> 27);
		num += num2;
		num4 += (((num ^ num2) & num3) ^ num2) + K[21] + buff[10];
		num4 = (num4 << 9) | (num4 >> 23);
		num4 += num;
		num3 += (((num4 ^ num) & num2) ^ num) + K[22] + buff[15];
		num3 = (num3 << 14) | (num3 >> 18);
		num3 += num4;
		num2 += (((num3 ^ num4) & num) ^ num4) + K[23] + buff[4];
		num2 = (num2 << 20) | (num2 >> 12);
		num2 += num3;
		num += (((num2 ^ num3) & num4) ^ num3) + K[24] + buff[9];
		num = (num << 5) | (num >> 27);
		num += num2;
		num4 += (((num ^ num2) & num3) ^ num2) + K[25] + buff[14];
		num4 = (num4 << 9) | (num4 >> 23);
		num4 += num;
		num3 += (((num4 ^ num) & num2) ^ num) + K[26] + buff[3];
		num3 = (num3 << 14) | (num3 >> 18);
		num3 += num4;
		num2 += (((num3 ^ num4) & num) ^ num4) + K[27] + buff[8];
		num2 = (num2 << 20) | (num2 >> 12);
		num2 += num3;
		num += (((num2 ^ num3) & num4) ^ num3) + K[28] + buff[13];
		num = (num << 5) | (num >> 27);
		num += num2;
		num4 += (((num ^ num2) & num3) ^ num2) + K[29] + buff[2];
		num4 = (num4 << 9) | (num4 >> 23);
		num4 += num;
		num3 += (((num4 ^ num) & num2) ^ num) + K[30] + buff[7];
		num3 = (num3 << 14) | (num3 >> 18);
		num3 += num4;
		num2 += (((num3 ^ num4) & num) ^ num4) + K[31] + buff[12];
		num2 = (num2 << 20) | (num2 >> 12);
		num2 += num3;
		num += (num2 ^ num3 ^ num4) + K[32] + buff[5];
		num = (num << 4) | (num >> 28);
		num += num2;
		num4 += (num ^ num2 ^ num3) + K[33] + buff[8];
		num4 = (num4 << 11) | (num4 >> 21);
		num4 += num;
		num3 += (num4 ^ num ^ num2) + K[34] + buff[11];
		num3 = (num3 << 16) | (num3 >> 16);
		num3 += num4;
		num2 += (num3 ^ num4 ^ num) + K[35] + buff[14];
		num2 = (num2 << 23) | (num2 >> 9);
		num2 += num3;
		num += (num2 ^ num3 ^ num4) + K[36] + buff[1];
		num = (num << 4) | (num >> 28);
		num += num2;
		num4 += (num ^ num2 ^ num3) + K[37] + buff[4];
		num4 = (num4 << 11) | (num4 >> 21);
		num4 += num;
		num3 += (num4 ^ num ^ num2) + K[38] + buff[7];
		num3 = (num3 << 16) | (num3 >> 16);
		num3 += num4;
		num2 += (num3 ^ num4 ^ num) + K[39] + buff[10];
		num2 = (num2 << 23) | (num2 >> 9);
		num2 += num3;
		num += (num2 ^ num3 ^ num4) + K[40] + buff[13];
		num = (num << 4) | (num >> 28);
		num += num2;
		num4 += (num ^ num2 ^ num3) + K[41] + buff[0];
		num4 = (num4 << 11) | (num4 >> 21);
		num4 += num;
		num3 += (num4 ^ num ^ num2) + K[42] + buff[3];
		num3 = (num3 << 16) | (num3 >> 16);
		num3 += num4;
		num2 += (num3 ^ num4 ^ num) + K[43] + buff[6];
		num2 = (num2 << 23) | (num2 >> 9);
		num2 += num3;
		num += (num2 ^ num3 ^ num4) + K[44] + buff[9];
		num = (num << 4) | (num >> 28);
		num += num2;
		num4 += (num ^ num2 ^ num3) + K[45] + buff[12];
		num4 = (num4 << 11) | (num4 >> 21);
		num4 += num;
		num3 += (num4 ^ num ^ num2) + K[46] + buff[15];
		num3 = (num3 << 16) | (num3 >> 16);
		num3 += num4;
		num2 += (num3 ^ num4 ^ num) + K[47] + buff[2];
		num2 = (num2 << 23) | (num2 >> 9);
		num2 += num3;
		num += ((~num4 | num2) ^ num3) + K[48] + buff[0];
		num = (num << 6) | (num >> 26);
		num += num2;
		num4 += ((~num3 | num) ^ num2) + K[49] + buff[7];
		num4 = (num4 << 10) | (num4 >> 22);
		num4 += num;
		num3 += ((~num2 | num4) ^ num) + K[50] + buff[14];
		num3 = (num3 << 15) | (num3 >> 17);
		num3 += num4;
		num2 += ((~num | num3) ^ num4) + K[51] + buff[5];
		num2 = (num2 << 21) | (num2 >> 11);
		num2 += num3;
		num += ((~num4 | num2) ^ num3) + K[52] + buff[12];
		num = (num << 6) | (num >> 26);
		num += num2;
		num4 += ((~num3 | num) ^ num2) + K[53] + buff[3];
		num4 = (num4 << 10) | (num4 >> 22);
		num4 += num;
		num3 += ((~num2 | num4) ^ num) + K[54] + buff[10];
		num3 = (num3 << 15) | (num3 >> 17);
		num3 += num4;
		num2 += ((~num | num3) ^ num4) + K[55] + buff[1];
		num2 = (num2 << 21) | (num2 >> 11);
		num2 += num3;
		num += ((~num4 | num2) ^ num3) + K[56] + buff[8];
		num = (num << 6) | (num >> 26);
		num += num2;
		num4 += ((~num3 | num) ^ num2) + K[57] + buff[15];
		num4 = (num4 << 10) | (num4 >> 22);
		num4 += num;
		num3 += ((~num2 | num4) ^ num) + K[58] + buff[6];
		num3 = (num3 << 15) | (num3 >> 17);
		num3 += num4;
		num2 += ((~num | num3) ^ num4) + K[59] + buff[13];
		num2 = (num2 << 21) | (num2 >> 11);
		num2 += num3;
		num += ((~num4 | num2) ^ num3) + K[60] + buff[4];
		num = (num << 6) | (num >> 26);
		num += num2;
		num4 += ((~num3 | num) ^ num2) + K[61] + buff[11];
		num4 = (num4 << 10) | (num4 >> 22);
		num4 += num;
		num3 += ((~num2 | num4) ^ num) + K[62] + buff[2];
		num3 = (num3 << 15) | (num3 >> 17);
		num3 += num4;
		num2 += ((~num | num3) ^ num4) + K[63] + buff[9];
		num2 = (num2 << 21) | (num2 >> 11);
		num2 += num3;
		_H[0] += num;
		_H[1] += num2;
		_H[2] += num3;
		_H[3] += num4;
	}

	private void ProcessFinalBlock(byte[] inputBuffer, int inputOffset, int inputCount)
	{
		ulong num = count + (ulong)inputCount;
		int num2 = (int)(56 - num % 64);
		if (num2 < 1)
		{
			num2 += 64;
		}
		byte[] array = new byte[inputCount + num2 + 8];
		for (int i = 0; i < inputCount; i++)
		{
			array[i] = inputBuffer[i + inputOffset];
		}
		array[inputCount] = 128;
		for (int j = inputCount + 1; j < inputCount + num2; j++)
		{
			array[j] = 0;
		}
		ulong length = num << 3;
		AddLength(length, array, inputCount + num2);
		ProcessBlock(array, 0);
		if (inputCount + num2 + 8 == 128)
		{
			ProcessBlock(array, 64);
		}
	}

	internal void AddLength(ulong length, byte[] buffer, int position)
	{
		buffer[position++] = (byte)length;
		buffer[position++] = (byte)(length >> 8);
		buffer[position++] = (byte)(length >> 16);
		buffer[position++] = (byte)(length >> 24);
		buffer[position++] = (byte)(length >> 32);
		buffer[position++] = (byte)(length >> 40);
		buffer[position++] = (byte)(length >> 48);
		buffer[position] = (byte)(length >> 56);
	}
}
