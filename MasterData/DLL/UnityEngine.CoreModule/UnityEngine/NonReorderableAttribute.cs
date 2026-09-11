using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public sealed class NonReorderableAttribute : PropertyAttribute
{
}
