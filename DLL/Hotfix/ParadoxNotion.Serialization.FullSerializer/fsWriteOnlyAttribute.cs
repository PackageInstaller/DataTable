using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Field)]
public sealed class fsWriteOnlyAttribute : Attribute
{
}
