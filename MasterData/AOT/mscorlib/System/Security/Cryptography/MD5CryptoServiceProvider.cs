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
		3614090360u, 3905402710u, 606105819u, 3250441966u, 4118548399u, 1200080426u, 2821735955u, 4249261313u, 1770035416u, 2336552879u,
		4294925233u, 2304563134u, 1804603682u, 4254626195u, 2792965006u, 1236535329u, 4129170786u, 3225465664u, 643717713u, 3921069994u,
		3593408605u, 38016083u, 3634488961u, 3889429448u, 568446438u, 3275163606u, 4107603335u, 1163531501u, 2850285829u, 4243563512u,
		1735328473u, 2368359562u, 4294588738u, 2272392833u, 1839030562u, 4259657740u, 2763975236u, 1272893353u, 4139469664u, 3200236656u,
		681279174u, 3936430074u, 3572445317u, 76029189u, 3654602809u, 3873151461u, 530742520u, 3299628645u, 4096336452u, 1126891415u,
		2878612391u, 4237533241u, 1700485571u, 2399980690u, 4293915773u, 2240044497u, 1873313359u, 4264355552u, 2734768916u, 1309151649u,
		4149444226u, 3174756917u, 718787259u, 3951481745u
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
