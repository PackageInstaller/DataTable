using System;
using System.Buffers;

namespace MessagePack;

public struct ExtensionResult
{
	public sbyte TypeCode { get; private set; }

	public ReadOnlySequence<byte> Data { get; private set; }

	public ExtensionHeader Header => new ExtensionHeader(TypeCode, (uint)Data.Length);

	public ExtensionResult(sbyte typeCode, Memory<byte> data)
	{
		TypeCode = typeCode;
		Data = new ReadOnlySequence<byte>(data);
	}

	public ExtensionResult(sbyte typeCode, ReadOnlySequence<byte> data)
	{
		TypeCode = typeCode;
		Data = data;
	}
}
