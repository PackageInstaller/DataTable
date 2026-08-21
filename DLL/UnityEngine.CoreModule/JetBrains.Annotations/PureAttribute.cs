using System;

namespace JetBrains.Annotations;

[AttributeUsage(AttributeTargets.Method)]
public sealed class PureAttribute : Attribute
{
}
