using System;
using System.ComponentModel;
using System.IO;

namespace Sirenix.Serialization;

public interface IDataWriter : IDisposable
{
	TwoWaySerializationBinder Binder { get; set; }

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Data readers and writers don't necessarily have streams any longer, so this API has been made obsolete. Using this property may result in NotSupportedExceptions being thrown.", false)]
	Stream Stream { get; set; }

	bool IsInArrayNode { get; }

	SerializationContext Context { get; set; }

	string GetDataDump();

	void FlushToStream();

	void BeginReferenceNode(string name, Type type, int id);

	void BeginStructNode(string name, Type type);

	void EndNode(string name);

	void BeginArrayNode(long length);

	void EndArrayNode();

	void WritePrimitiveArray<T>(T[] array) where T : struct;

	void WriteNull(string name);

	void WriteInternalReference(string name, int id);

	void WriteExternalReference(string name, int index);

	void WriteExternalReference(string name, Guid guid);

	void WriteExternalReference(string name, string id);

	void WriteChar(string name, char value);

	void WriteString(string name, string value);

	void WriteGuid(string name, Guid value);

	void WriteSByte(string name, sbyte value);

	void WriteInt16(string name, short value);

	void WriteInt32(string name, int value);

	void WriteInt64(string name, long value);

	void WriteByte(string name, byte value);

	void WriteUInt16(string name, ushort value);

	void WriteUInt32(string name, uint value);

	void WriteUInt64(string name, ulong value);

	void WriteDecimal(string name, decimal value);

	void WriteSingle(string name, float value);

	void WriteDouble(string name, double value);

	void WriteBoolean(string name, bool value);

	void PrepareNewSerializationSession();
}
