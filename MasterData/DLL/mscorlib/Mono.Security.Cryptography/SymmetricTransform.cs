using System;
using System.Security.Cryptography;

namespace Mono.Security.Cryptography;

internal abstract class SymmetricTransform : ICryptoTransform, IDisposable
{
	protected SymmetricAlgorithm algo;

	protected bool encrypt;

	protected int BlockSizeByte;

	protected byte[] temp;

	protected byte[] temp2;

	private byte[] workBuff;

	private byte[] workout;

	protected PaddingMode padmode;

	protected int FeedBackByte;

	private bool m_disposed;

	protected bool lastBlock;

	private RandomNumberGenerator _rng;

	public virtual bool CanTransformMultipleBlocks => true;

	public virtual int InputBlockSize => BlockSizeByte;

	public virtual int OutputBlockSize => BlockSizeByte;

	private bool KeepLastBlock
	{
		get
		{
			if (!encrypt && padmode != PaddingMode.None)
			{
				return padmode != PaddingMode.Zeros;
			}
			return false;
		}
	}

	public SymmetricTransform(SymmetricAlgorithm symmAlgo, bool encryption, byte[] rgbIV)
	{
		algo = symmAlgo;
		encrypt = encryption;
		BlockSizeByte = algo.BlockSize >> 3;
		rgbIV = ((rgbIV != null) ? ((byte[])rgbIV.Clone()) : KeyBuilder.IV(BlockSizeByte));
		if (rgbIV.Length < BlockSizeByte)
		{
			throw new CryptographicException(Locale.GetText("IV is too small ({0} bytes), it should be {1} bytes long.", rgbIV.Length, BlockSizeByte));
		}
		padmode = algo.Padding;
		temp = new byte[BlockSizeByte];
		Buffer.BlockCopy(rgbIV, 0, temp, 0, System.Math.Min(BlockSizeByte, rgbIV.Length));
		temp2 = new byte[BlockSizeByte];
		FeedBackByte = algo.FeedbackSize >> 3;
		workBuff = new byte[BlockSizeByte];
		workout = new byte[BlockSizeByte];
	}

	~SymmetricTransform()
	{
		Dispose(disposing: false);
	}

	void IDisposable.Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!m_disposed)
		{
			if (disposing)
			{
				Array.Clear(temp, 0, BlockSizeByte);
				temp = null;
				Array.Clear(temp2, 0, BlockSizeByte);
				temp2 = null;
			}
			m_disposed = true;
		}
	}

	protected virtual void Transform(byte[] input, byte[] output)
	{
		switch (algo.Mode)
		{
		case CipherMode.ECB:
			ECB(input, output);
			break;
		case CipherMode.CBC:
			CBC(input, output);
			break;
		case CipherMode.CFB:
			CFB(input, output);
			break;
		case CipherMode.OFB:
			OFB(input, output);
			break;
		case CipherMode.CTS:
			CTS(input, output);
			break;
		default:
			throw new NotImplementedException("Unkown CipherMode" + algo.Mode);
		}
	}

	protected abstract void ECB(byte[] input, byte[] output);

	protected virtual void CBC(byte[] input, byte[] output)
	{
		if (encrypt)
		{
			for (int i = 0; i < BlockSizeByte; i++)
			{
				temp[i] ^= input[i];
			}
			ECB(temp, output);
			Buffer.BlockCopy(output, 0, temp, 0, BlockSizeByte);
			return;
		}
		Buffer.BlockCopy(input, 0, temp2, 0, BlockSizeByte);
		ECB(input, output);
		for (int j = 0; j < BlockSizeByte; j++)
		{
			output[j] ^= temp[j];
		}
		Buffer.BlockCopy(temp2, 0, temp, 0, BlockSizeByte);
	}

	protected virtual void CFB(byte[] input, byte[] output)
	{
		if (encrypt)
		{
			for (int i = 0; i < BlockSizeByte; i++)
			{
				ECB(temp, temp2);
				output[i] = (byte)(temp2[0] ^ input[i]);
				Buffer.BlockCopy(temp, 1, temp, 0, BlockSizeByte - 1);
				Buffer.BlockCopy(output, i, temp, BlockSizeByte - 1, 1);
			}
			return;
		}
		for (int j = 0; j < BlockSizeByte; j++)
		{
			encrypt = true;
			ECB(temp, temp2);
			encrypt = false;
			Buffer.BlockCopy(temp, 1, temp, 0, BlockSizeByte - 1);
			Buffer.BlockCopy(input, j, temp, BlockSizeByte - 1, 1);
			output[j] = (byte)(temp2[0] ^ input[j]);
		}
	}

	protected virtual void OFB(byte[] input, byte[] output)
	{
		throw new CryptographicException("OFB isn't supported by the framework");
	}

	protected virtual void CTS(byte[] input, byte[] output)
	{
		throw new CryptographicException("CTS isn't supported by the framework");
	}

	private void CheckInput(byte[] inputBuffer, int inputOffset, int inputCount)
	{
		if (inputBuffer == null)
		{
			throw new ArgumentNullException("inputBuffer");
		}
		if (inputOffset < 0)
		{
			throw new ArgumentOutOfRangeException("inputOffset", "< 0");
		}
		if (inputCount < 0)
		{
			throw new ArgumentOutOfRangeException("inputCount", "< 0");
		}
		if (inputOffset > inputBuffer.Length - inputCount)
		{
			throw new ArgumentException("inputBuffer", Locale.GetText("Overflow"));
		}
	}

	public virtual int TransformBlock(byte[] inputBuffer, int inputOffset, int inputCount, byte[] outputBuffer, int outputOffset)
	{
		if (m_disposed)
		{
			throw new ObjectDisposedException("Object is disposed");
		}
		CheckInput(inputBuffer, inputOffset, inputCount);
		if (outputBuffer == null)
		{
			throw new ArgumentNullException("outputBuffer");
		}
		if (outputOffset < 0)
		{
			throw new ArgumentOutOfRangeException("outputOffset", "< 0");
		}
		int num = outputBuffer.Length - inputCount - outputOffset;
		if (!encrypt && 0 > num && (padmode == PaddingMode.None || padmode == PaddingMode.Zeros))
		{
			throw new CryptographicException("outputBuffer", Locale.GetText("Overflow"));
		}
		if (KeepLastBlock)
		{
			if (0 > num + BlockSizeByte)
			{
				throw new CryptographicException("outputBuffer", Locale.GetText("Overflow"));
			}
		}
		else if (0 > num)
		{
			if (inputBuffer.Length - inputOffset - outputBuffer.Length != BlockSizeByte)
			{
				throw new CryptographicException("outputBuffer", Locale.GetText("Overflow"));
			}
			inputCount = outputBuffer.Length - outputOffset;
		}
		return InternalTransformBlock(inputBuffer, inputOffset, inputCount, outputBuffer, outputOffset);
	}

	private int InternalTransformBlock(byte[] inputBuffer, int inputOffset, int inputCount, byte[] outputBuffer, int outputOffset)
	{
		int num = inputOffset;
		int num2;
		if (inputCount != BlockSizeByte)
		{
			if (inputCount % BlockSizeByte != 0)
			{
				throw new CryptographicException("Invalid input block size.");
			}
			num2 = inputCount / BlockSizeByte;
		}
		else
		{
			num2 = 1;
		}
		if (KeepLastBlock)
		{
			num2--;
		}
		int num3 = 0;
		if (lastBlock)
		{
			Transform(workBuff, workout);
			Buffer.BlockCopy(workout, 0, outputBuffer, outputOffset, BlockSizeByte);
			outputOffset += BlockSizeByte;
			num3 += BlockSizeByte;
			lastBlock = false;
		}
		for (int i = 0; i < num2; i++)
		{
			Buffer.BlockCopy(inputBuffer, num, workBuff, 0, BlockSizeByte);
			Transform(workBuff, workout);
			Buffer.BlockCopy(workout, 0, outputBuffer, outputOffset, BlockSizeByte);
			num += BlockSizeByte;
			outputOffset += BlockSizeByte;
			num3 += BlockSizeByte;
		}
		if (KeepLastBlock)
		{
			Buffer.BlockCopy(inputBuffer, num, workBuff, 0, BlockSizeByte);
			lastBlock = true;
		}
		return num3;
	}

	private void Random(byte[] buffer, int start, int length)
	{
		if (_rng == null)
		{
			_rng = RandomNumberGenerator.Create();
		}
		byte[] array = new byte[length];
		_rng.GetBytes(array);
		Buffer.BlockCopy(array, 0, buffer, start, length);
	}

	private void ThrowBadPaddingException(PaddingMode padding, int length, int position)
	{
		string text = string.Format(Locale.GetText("Bad {0} padding."), padding);
		if (length >= 0)
		{
			text += string.Format(Locale.GetText(" Invalid length {0}."), length);
		}
		if (position >= 0)
		{
			text += string.Format(Locale.GetText(" Error found at position {0}."), position);
		}
		throw new CryptographicException(text);
	}

	protected virtual byte[] FinalEncrypt(byte[] inputBuffer, int inputOffset, int inputCount)
	{
		int num = inputCount / BlockSizeByte * BlockSizeByte;
		int num2 = inputCount - num;
		int num3 = num;
		PaddingMode paddingMode = padmode;
		if (paddingMode == PaddingMode.PKCS7 || (uint)(paddingMode - 4) <= 1u)
		{
			num3 += BlockSizeByte;
		}
		else
		{
			if (inputCount == 0)
			{
				return new byte[0];
			}
			if (num2 != 0)
			{
				if (padmode == PaddingMode.None)
				{
					throw new CryptographicException("invalid block length");
				}
				byte[] array = new byte[num + BlockSizeByte];
				Buffer.BlockCopy(inputBuffer, inputOffset, array, 0, inputCount);
				inputBuffer = array;
				inputOffset = 0;
				inputCount = array.Length;
				num3 = inputCount;
			}
		}
		byte[] array2 = new byte[num3];
		int num4 = 0;
		while (num3 > BlockSizeByte)
		{
			InternalTransformBlock(inputBuffer, inputOffset, BlockSizeByte, array2, num4);
			inputOffset += BlockSizeByte;
			num4 += BlockSizeByte;
			num3 -= BlockSizeByte;
		}
		byte b = (byte)(BlockSizeByte - num2);
		switch (padmode)
		{
		case PaddingMode.ANSIX923:
			array2[array2.Length - 1] = b;
			Buffer.BlockCopy(inputBuffer, inputOffset, array2, num, num2);
			InternalTransformBlock(array2, num, BlockSizeByte, array2, num);
			break;
		case PaddingMode.ISO10126:
			Random(array2, array2.Length - b, b - 1);
			array2[array2.Length - 1] = b;
			Buffer.BlockCopy(inputBuffer, inputOffset, array2, num, num2);
			InternalTransformBlock(array2, num, BlockSizeByte, array2, num);
			break;
		case PaddingMode.PKCS7:
		{
			int num5 = array2.Length;
			while (--num5 >= array2.Length - b)
			{
				array2[num5] = b;
			}
			Buffer.BlockCopy(inputBuffer, inputOffset, array2, num, num2);
			InternalTransformBlock(array2, num, BlockSizeByte, array2, num);
			break;
		}
		default:
			InternalTransformBlock(inputBuffer, inputOffset, BlockSizeByte, array2, num4);
			break;
		}
		return array2;
	}

	protected virtual byte[] FinalDecrypt(byte[] inputBuffer, int inputOffset, int inputCount)
	{
		int num = inputCount;
		int num2 = inputCount;
		if (lastBlock)
		{
			num2 += BlockSizeByte;
		}
		byte[] array = new byte[num2];
		int num3 = 0;
		while (num > 0)
		{
			int num4 = InternalTransformBlock(inputBuffer, inputOffset, BlockSizeByte, array, num3);
			inputOffset += BlockSizeByte;
			num3 += num4;
			num -= BlockSizeByte;
		}
		if (lastBlock)
		{
			Transform(workBuff, workout);
			Buffer.BlockCopy(workout, 0, array, num3, BlockSizeByte);
			num3 += BlockSizeByte;
			lastBlock = false;
		}
		byte b = (byte)((num2 > 0) ? array[num2 - 1] : 0);
		switch (padmode)
		{
		case PaddingMode.ANSIX923:
		{
			if (b == 0 || b > BlockSizeByte)
			{
				ThrowBadPaddingException(padmode, b, -1);
			}
			for (int num6 = b - 1; num6 > 0; num6--)
			{
				if (array[num2 - 1 - num6] != 0)
				{
					ThrowBadPaddingException(padmode, -1, num6);
				}
			}
			num2 -= b;
			break;
		}
		case PaddingMode.ISO10126:
			if (b == 0 || b > BlockSizeByte)
			{
				ThrowBadPaddingException(padmode, b, -1);
			}
			num2 -= b;
			break;
		case PaddingMode.PKCS7:
		{
			if (b == 0 || b > BlockSizeByte)
			{
				ThrowBadPaddingException(padmode, b, -1);
			}
			for (int num5 = b - 1; num5 > 0; num5--)
			{
				if (array[num2 - 1 - num5] != b)
				{
					ThrowBadPaddingException(padmode, -1, num5);
				}
			}
			num2 -= b;
			break;
		}
		}
		if (num2 > 0)
		{
			byte[] array2 = new byte[num2];
			Buffer.BlockCopy(array, 0, array2, 0, num2);
			Array.Clear(array, 0, array.Length);
			return array2;
		}
		return new byte[0];
	}

	public virtual byte[] TransformFinalBlock(byte[] inputBuffer, int inputOffset, int inputCount)
	{
		if (m_disposed)
		{
			throw new ObjectDisposedException("Object is disposed");
		}
		CheckInput(inputBuffer, inputOffset, inputCount);
		if (encrypt)
		{
			return FinalEncrypt(inputBuffer, inputOffset, inputCount);
		}
		return FinalDecrypt(inputBuffer, inputOffset, inputCount);
	}
}
