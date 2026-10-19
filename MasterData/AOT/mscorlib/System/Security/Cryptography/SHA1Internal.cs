namespace System.Security.Cryptography;

internal class SHA1Internal
{
	private uint[] _H;

	private ulong count;

	private byte[] _ProcessingBuffer;

	private int _ProcessingBufferCount;

	private uint[] buff;

	public SHA1Internal()
	{
		_H = new uint[5];
		_ProcessingBuffer = new byte[64];
		buff = new uint[80];
		Initialize();
	}

	public void HashCore(byte[] rgb, int ibStart, int cbSize)
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
			ProcessBlock(_ProcessingBuffer, 0u);
			_ProcessingBufferCount = 0;
			ibStart += num;
			cbSize -= num;
		}
		for (int num = 0; num < cbSize - cbSize % 64; num += 64)
		{
			ProcessBlock(rgb, (uint)(ibStart + num));
		}
		if (cbSize % 64 != 0)
		{
			Buffer.BlockCopy(rgb, cbSize - cbSize % 64 + ibStart, _ProcessingBuffer, 0, cbSize % 64);
			_ProcessingBufferCount = cbSize % 64;
		}
	}

	public byte[] HashFinal()
	{
		byte[] array = new byte[20];
		ProcessFinalBlock(_ProcessingBuffer, 0, _ProcessingBufferCount);
		for (int i = 0; i < 5; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				array[i * 4 + j] = (byte)(_H[i] >> 8 * (3 - j));
			}
		}
		return array;
	}

	public void Initialize()
	{
		count = 0uL;
		_ProcessingBufferCount = 0;
		_H[0] = 1732584193u;
		_H[1] = 4023233417u;
		_H[2] = 2562383102u;
		_H[3] = 271733878u;
		_H[4] = 3285377520u;
	}

	private void ProcessBlock(byte[] inputBuffer, uint inputOffset)
	{
		count += 64uL;
		uint[] h = _H;
		uint[] array = buff;
		InitialiseBuff(array, inputBuffer, inputOffset);
		FillBuff(array);
		uint num = h[0];
		uint num2 = h[1];
		uint num3 = h[2];
		uint num4 = h[3];
		uint num5 = h[4];
		int i;
		for (i = 0; i < 20; i += 5)
		{
			num5 += ((num << 5) | (num >> 27)) + (((num3 ^ num4) & num2) ^ num4) + 1518500249 + array[i];
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += ((num5 << 5) | (num5 >> 27)) + (((num2 ^ num3) & num) ^ num3) + 1518500249 + array[i + 1];
			num = (num << 30) | (num >> 2);
			num3 += ((num4 << 5) | (num4 >> 27)) + (((num ^ num2) & num5) ^ num2) + 1518500249 + array[i + 2];
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += ((num3 << 5) | (num3 >> 27)) + (((num5 ^ num) & num4) ^ num) + 1518500249 + array[i + 3];
			num4 = (num4 << 30) | (num4 >> 2);
			num += ((num2 << 5) | (num2 >> 27)) + (((num4 ^ num5) & num3) ^ num5) + 1518500249 + array[i + 4];
			num3 = (num3 << 30) | (num3 >> 2);
		}
		for (; i < 40; i += 5)
		{
			num5 += ((num << 5) | (num >> 27)) + (num2 ^ num3 ^ num4) + 1859775393 + array[i];
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += ((num5 << 5) | (num5 >> 27)) + (num ^ num2 ^ num3) + 1859775393 + array[i + 1];
			num = (num << 30) | (num >> 2);
			num3 += ((num4 << 5) | (num4 >> 27)) + (num5 ^ num ^ num2) + 1859775393 + array[i + 2];
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += ((num3 << 5) | (num3 >> 27)) + (num4 ^ num5 ^ num) + 1859775393 + array[i + 3];
			num4 = (num4 << 30) | (num4 >> 2);
			num += ((num2 << 5) | (num2 >> 27)) + (num3 ^ num4 ^ num5) + 1859775393 + array[i + 4];
			num3 = (num3 << 30) | (num3 >> 2);
		}
		for (; i < 60; i += 5)
		{
			num5 += (uint)((int)(((num << 5) | (num >> 27)) + ((num2 & num3) | (num2 & num4) | (num3 & num4))) + -1894007588 + (int)array[i]);
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += (uint)((int)(((num5 << 5) | (num5 >> 27)) + ((num & num2) | (num & num3) | (num2 & num3))) + -1894007588 + (int)array[i + 1]);
			num = (num << 30) | (num >> 2);
			num3 += (uint)((int)(((num4 << 5) | (num4 >> 27)) + ((num5 & num) | (num5 & num2) | (num & num2))) + -1894007588 + (int)array[i + 2]);
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += (uint)((int)(((num3 << 5) | (num3 >> 27)) + ((num4 & num5) | (num4 & num) | (num5 & num))) + -1894007588 + (int)array[i + 3]);
			num4 = (num4 << 30) | (num4 >> 2);
			num += (uint)((int)(((num2 << 5) | (num2 >> 27)) + ((num3 & num4) | (num3 & num5) | (num4 & num5))) + -1894007588 + (int)array[i + 4]);
			num3 = (num3 << 30) | (num3 >> 2);
		}
		for (; i < 80; i += 5)
		{
			num5 += (uint)((int)(((num << 5) | (num >> 27)) + (num2 ^ num3 ^ num4)) + -899497514 + (int)array[i]);
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += (uint)((int)(((num5 << 5) | (num5 >> 27)) + (num ^ num2 ^ num3)) + -899497514 + (int)array[i + 1]);
			num = (num << 30) | (num >> 2);
			num3 += (uint)((int)(((num4 << 5) | (num4 >> 27)) + (num5 ^ num ^ num2)) + -899497514 + (int)array[i + 2]);
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += (uint)((int)(((num3 << 5) | (num3 >> 27)) + (num4 ^ num5 ^ num)) + -899497514 + (int)array[i + 3]);
			num4 = (num4 << 30) | (num4 >> 2);
			num += (uint)((int)(((num2 << 5) | (num2 >> 27)) + (num3 ^ num4 ^ num5)) + -899497514 + (int)array[i + 4]);
			num3 = (num3 << 30) | (num3 >> 2);
		}
		h[0] += num;
		h[1] += num2;
		h[2] += num3;
		h[3] += num4;
		h[4] += num5;
	}

	private static void InitialiseBuff(uint[] buff, byte[] input, uint inputOffset)
	{
		buff[0] = (uint)((input[inputOffset] << 24) | (input[inputOffset + 1] << 16) | (input[inputOffset + 2] << 8) | input[inputOffset + 3]);
		buff[1] = (uint)((input[inputOffset + 4] << 24) | (input[inputOffset + 5] << 16) | (input[inputOffset + 6] << 8) | input[inputOffset + 7]);
		buff[2] = (uint)((input[inputOffset + 8] << 24) | (input[inputOffset + 9] << 16) | (input[inputOffset + 10] << 8) | input[inputOffset + 11]);
		buff[3] = (uint)((input[inputOffset + 12] << 24) | (input[inputOffset + 13] << 16) | (input[inputOffset + 14] << 8) | input[inputOffset + 15]);
		buff[4] = (uint)((input[inputOffset + 16] << 24) | (input[inputOffset + 17] << 16) | (input[inputOffset + 18] << 8) | input[inputOffset + 19]);
		buff[5] = (uint)((input[inputOffset + 20] << 24) | (input[inputOffset + 21] << 16) | (input[inputOffset + 22] << 8) | input[inputOffset + 23]);
		buff[6] = (uint)((input[inputOffset + 24] << 24) | (input[inputOffset + 25] << 16) | (input[inputOffset + 26] << 8) | input[inputOffset + 27]);
		buff[7] = (uint)((input[inputOffset + 28] << 24) | (input[inputOffset + 29] << 16) | (input[inputOffset + 30] << 8) | input[inputOffset + 31]);
		buff[8] = (uint)((input[inputOffset + 32] << 24) | (input[inputOffset + 33] << 16) | (input[inputOffset + 34] << 8) | input[inputOffset + 35]);
		buff[9] = (uint)((input[inputOffset + 36] << 24) | (input[inputOffset + 37] << 16) | (input[inputOffset + 38] << 8) | input[inputOffset + 39]);
		buff[10] = (uint)((input[inputOffset + 40] << 24) | (input[inputOffset + 41] << 16) | (input[inputOffset + 42] << 8) | input[inputOffset + 43]);
		buff[11] = (uint)((input[inputOffset + 44] << 24) | (input[inputOffset + 45] << 16) | (input[inputOffset + 46] << 8) | input[inputOffset + 47]);
		buff[12] = (uint)((input[inputOffset + 48] << 24) | (input[inputOffset + 49] << 16) | (input[inputOffset + 50] << 8) | input[inputOffset + 51]);
		buff[13] = (uint)((input[inputOffset + 52] << 24) | (input[inputOffset + 53] << 16) | (input[inputOffset + 54] << 8) | input[inputOffset + 55]);
		buff[14] = (uint)((input[inputOffset + 56] << 24) | (input[inputOffset + 57] << 16) | (input[inputOffset + 58] << 8) | input[inputOffset + 59]);
		buff[15] = (uint)((input[inputOffset + 60] << 24) | (input[inputOffset + 61] << 16) | (input[inputOffset + 62] << 8) | input[inputOffset + 63]);
	}

	private static void FillBuff(uint[] buff)
	{
		for (int i = 16; i < 80; i += 8)
		{
			uint num = buff[i - 3] ^ buff[i - 8] ^ buff[i - 14] ^ buff[i - 16];
			buff[i] = (num << 1) | (num >> 31);
			num = buff[i - 2] ^ buff[i - 7] ^ buff[i - 13] ^ buff[i - 15];
			buff[i + 1] = (num << 1) | (num >> 31);
			num = buff[i - 1] ^ buff[i - 6] ^ buff[i - 12] ^ buff[i - 14];
			buff[i + 2] = (num << 1) | (num >> 31);
			num = buff[i] ^ buff[i - 5] ^ buff[i - 11] ^ buff[i - 13];
			buff[i + 3] = (num << 1) | (num >> 31);
			num = buff[i + 1] ^ buff[i - 4] ^ buff[i - 10] ^ buff[i - 12];
			buff[i + 4] = (num << 1) | (num >> 31);
			num = buff[i + 2] ^ buff[i - 3] ^ buff[i - 9] ^ buff[i - 11];
			buff[i + 5] = (num << 1) | (num >> 31);
			num = buff[i + 3] ^ buff[i - 2] ^ buff[i - 8] ^ buff[i - 10];
			buff[i + 6] = (num << 1) | (num >> 31);
			num = buff[i + 4] ^ buff[i - 1] ^ buff[i - 7] ^ buff[i - 9];
			buff[i + 7] = (num << 1) | (num >> 31);
		}
	}

	private void ProcessFinalBlock(byte[] inputBuffer, int inputOffset, int inputCount)
	{
		ulong num = count + (ulong)inputCount;
		int num2 = 56 - (int)(num % 64);
		if (num2 < 1)
		{
			num2 += 64;
		}
		int num3 = inputCount + num2 + 8;
		byte[] array = ((num3 == 64) ? _ProcessingBuffer : new byte[num3]);
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
		ProcessBlock(array, 0u);
		if (num3 == 128)
		{
			ProcessBlock(array, 64u);
		}
	}

	internal void AddLength(ulong length, byte[] buffer, int position)
	{
		buffer[position++] = (byte)(length >> 56);
		buffer[position++] = (byte)(length >> 48);
		buffer[position++] = (byte)(length >> 40);
		buffer[position++] = (byte)(length >> 32);
		buffer[position++] = (byte)(length >> 24);
		buffer[position++] = (byte)(length >> 16);
		buffer[position++] = (byte)(length >> 8);
		buffer[position] = (byte)length;
	}
}
