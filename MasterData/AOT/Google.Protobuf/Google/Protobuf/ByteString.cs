using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Google.Protobuf;

public sealed class ByteString : IEnumerable<byte>, IEnumerable, IEquatable<ByteString>
{
	private static readonly ByteString empty = new ByteString(new byte[0]);

	private readonly ReadOnlyMemory<byte> bytes;

	public static ByteString Empty => empty;

	public int Length => bytes.Length;

	public bool IsEmpty => Length == 0;

	public ReadOnlySpan<byte> Span => bytes.Span;

	public ReadOnlyMemory<byte> Memory => bytes;

	public byte this[int index] => bytes.Span[index];

	internal static ByteString AttachBytes(ReadOnlyMemory<byte> bytes)
	{
		return new ByteString(bytes);
	}

	internal static ByteString AttachBytes(byte[] bytes)
	{
		return AttachBytes(bytes.AsMemory());
	}

	private ByteString(ReadOnlyMemory<byte> bytes)
	{
		this.bytes = bytes;
	}

	public byte[] ToByteArray()
	{
		return bytes.ToArray();
	}

	public string ToBase64()
	{
		if (MemoryMarshal.TryGetArray(bytes, out var segment))
		{
			return Convert.ToBase64String(segment.Array, segment.Offset, segment.Count);
		}
		return Convert.ToBase64String(bytes.ToArray());
	}

	public static ByteString FromBase64(string bytes)
	{
		if (!(bytes == ""))
		{
			return new ByteString(Convert.FromBase64String(bytes));
		}
		return Empty;
	}

	public static ByteString FromStream(Stream stream)
	{
		ProtoPreconditions.CheckNotNull(stream, "stream");
		MemoryStream memoryStream = new MemoryStream(stream.CanSeek ? checked((int)(stream.Length - stream.Position)) : 0);
		stream.CopyTo(memoryStream);
		return AttachBytes((memoryStream.Length == memoryStream.Capacity) ? memoryStream.GetBuffer() : memoryStream.ToArray());
	}

	public static Task<ByteString> FromStreamAsync(Stream stream, CancellationToken cancellationToken = default(CancellationToken))
	{
		ProtoPreconditions.CheckNotNull(stream, "stream");
		return ByteStringAsync.FromStreamAsyncCore(stream, cancellationToken);
	}

	public static ByteString CopyFrom(params byte[] bytes)
	{
		return new ByteString((byte[])bytes.Clone());
	}

	public static ByteString CopyFrom(byte[] bytes, int offset, int count)
	{
		byte[] array = new byte[count];
		ByteArray.Copy(bytes, offset, array, 0, count);
		return new ByteString(array);
	}

	public static ByteString CopyFrom(ReadOnlySpan<byte> bytes)
	{
		return new ByteString(bytes.ToArray());
	}

	public static ByteString CopyFrom(string text, Encoding encoding)
	{
		return new ByteString(encoding.GetBytes(text));
	}

	public static ByteString CopyFromUtf8(string text)
	{
		return CopyFrom(text, Encoding.UTF8);
	}

	public string ToString(Encoding encoding)
	{
		if (MemoryMarshal.TryGetArray(bytes, out var segment))
		{
			return encoding.GetString(segment.Array, segment.Offset, segment.Count);
		}
		byte[] array = bytes.ToArray();
		return encoding.GetString(array, 0, array.Length);
	}

	public string ToStringUtf8()
	{
		return ToString(Encoding.UTF8);
	}

	public IEnumerator<byte> GetEnumerator()
	{
		return MemoryMarshal.ToEnumerable(bytes).GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public CodedInputStream CreateCodedInput()
	{
		if (MemoryMarshal.TryGetArray(bytes, out var segment) && segment.Count == bytes.Length)
		{
			return new CodedInputStream(segment.Array, segment.Offset, segment.Count);
		}
		return new CodedInputStream(bytes.ToArray());
	}

	public static bool operator ==(ByteString lhs, ByteString rhs)
	{
		if ((object)lhs == rhs)
		{
			return true;
		}
		if ((object)lhs == null || (object)rhs == null)
		{
			return false;
		}
		return lhs.bytes.Span.SequenceEqual(rhs.bytes.Span);
	}

	public static bool operator !=(ByteString lhs, ByteString rhs)
	{
		return !(lhs == rhs);
	}

	public override bool Equals(object obj)
	{
		return this == obj as ByteString;
	}

	public override int GetHashCode()
	{
		ReadOnlySpan<byte> span = bytes.Span;
		int num = 23;
		for (int i = 0; i < span.Length; i++)
		{
			num = num * 31 + span[i];
		}
		return num;
	}

	public bool Equals(ByteString other)
	{
		return this == other;
	}

	public void CopyTo(byte[] array, int position)
	{
		bytes.CopyTo(array.AsMemory(position));
	}

	public void WriteTo(Stream outputStream)
	{
		if (MemoryMarshal.TryGetArray(bytes, out var segment))
		{
			outputStream.Write(segment.Array, segment.Offset, segment.Count);
			return;
		}
		byte[] array = bytes.ToArray();
		outputStream.Write(array, 0, array.Length);
	}
}
