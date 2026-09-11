using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
public sealed class fsIgnoreAttribute : Attribute
{
}
