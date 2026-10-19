using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
public class SharedRequiredAttribute : Attribute
{
}
