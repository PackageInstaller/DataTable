using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Field)]
public sealed class fsSerializeAsReference : Attribute
{
}
