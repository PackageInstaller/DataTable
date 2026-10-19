using System;
using JetBrains.Annotations;

namespace Sirenix.Serialization;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
[MeansImplicitUse]
public class OdinSerializeAttribute : Attribute
{
}
