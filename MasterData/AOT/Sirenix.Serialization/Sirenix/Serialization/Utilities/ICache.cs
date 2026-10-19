using System;

namespace Sirenix.Serialization.Utilities;

public interface ICache : IDisposable
{
	object Value { get; }
}
