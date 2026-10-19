using System;

namespace Google.Protobuf;

internal interface IExtensionValue : IEquatable<IExtensionValue>, IDeepCloneable<IExtensionValue>
{
	void MergeFrom(ref ParseContext ctx);

	void MergeFrom(IExtensionValue value);

	void WriteTo(ref WriteContext ctx);

	int CalculateSize();
}
