using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public interface ICryptoTransform : IDisposable
{
	int InputBlockSize { get; }

	int OutputBlockSize { get; }

	bool CanTransformMultipleBlocks { get; }

	int TransformBlock(byte[] inputBuffer, int inputOffset, int inputCount, byte[] outputBuffer, int outputOffset);

	byte[] TransformFinalBlock(byte[] inputBuffer, int inputOffset, int inputCount);
}
