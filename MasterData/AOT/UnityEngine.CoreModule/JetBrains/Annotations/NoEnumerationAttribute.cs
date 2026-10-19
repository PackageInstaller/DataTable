using System;

namespace JetBrains.Annotations;

[AttributeUsage(AttributeTargets.Parameter)]
public sealed class NoEnumerationAttribute : Attribute
{
}
