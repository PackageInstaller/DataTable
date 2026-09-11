using System.Buffers;

namespace System.Runtime.InteropServices;

public static class SequenceMarshal
{
	internal static bool TryGetString(ReadOnlySequence<char> sequence, out string text, out int start, out int length)
	{
		return sequence.TryGetString(out text, out start, out length);
	}
}
