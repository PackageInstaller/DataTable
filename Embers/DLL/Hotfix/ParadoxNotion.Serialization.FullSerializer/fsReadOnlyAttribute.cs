using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Field)]
public sealed class fsReadOnlyAttribute : Attribute
{
}
