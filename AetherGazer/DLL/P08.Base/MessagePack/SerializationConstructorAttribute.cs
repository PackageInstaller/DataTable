using System;

namespace MessagePack;

[AttributeUsage(AttributeTargets.Constructor, AllowMultiple = false, Inherited = true)]
public class SerializationConstructorAttribute : Attribute
{
}
