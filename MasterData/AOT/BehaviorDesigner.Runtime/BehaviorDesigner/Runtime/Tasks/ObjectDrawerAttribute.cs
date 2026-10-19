using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public abstract class ObjectDrawerAttribute : Attribute
{
}
