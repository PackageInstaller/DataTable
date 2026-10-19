using System;

namespace Unity.VisualScripting.FullSerializer;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
public sealed class fsIgnoreAttribute : Attribute
{
}
