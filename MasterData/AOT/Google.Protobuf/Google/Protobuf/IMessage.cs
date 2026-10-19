using System;
using Google.Protobuf.Reflection;

namespace Google.Protobuf;

public interface IMessage
{
	MessageDescriptor Descriptor { get; }

	void MergeFrom(CodedInputStream input);

	void WriteTo(CodedOutputStream output);

	int CalculateSize();
}
public interface IMessage<T> : IMessage, IEquatable<T>, IDeepCloneable<T> where T : IMessage<T>
{
	void MergeFrom(T message);
}
