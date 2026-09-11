using System;

namespace Unity.Collections.LowLevel.Unsafe;

[AttributeUsage(AttributeTargets.Method | AttributeTargets.Property)]
public class WriteAccessRequiredAttribute : Attribute
{
}
