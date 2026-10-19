using System;

namespace Sirenix.Serialization;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct, AllowMultiple = false, Inherited = true)]
public class AllowDeserializeInvalidDataAttribute : Attribute
{
}
