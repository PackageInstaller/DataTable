using System;
using Google.Protobuf.Collections;

namespace Google.Protobuf;

public interface IExtendableMessage<T> : IMessage<T>, IMessage, IEquatable<T>, IDeepCloneable<T> where T : IExtendableMessage<T>
{
	TValue GetExtension<TValue>(Extension<T, TValue> extension);

	RepeatedField<TValue> GetExtension<TValue>(RepeatedExtension<T, TValue> extension);

	RepeatedField<TValue> GetOrInitializeExtension<TValue>(RepeatedExtension<T, TValue> extension);

	void SetExtension<TValue>(Extension<T, TValue> extension, TValue value);

	bool HasExtension<TValue>(Extension<T, TValue> extension);

	void ClearExtension<TValue>(Extension<T, TValue> extension);
}
