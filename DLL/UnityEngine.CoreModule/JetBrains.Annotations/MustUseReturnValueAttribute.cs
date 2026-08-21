using System;

namespace JetBrains.Annotations;

[AttributeUsage(AttributeTargets.Method)]
public sealed class MustUseReturnValueAttribute : Attribute
{
}
