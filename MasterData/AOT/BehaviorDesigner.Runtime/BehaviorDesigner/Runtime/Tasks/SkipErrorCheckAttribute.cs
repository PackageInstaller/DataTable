using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public class SkipErrorCheckAttribute : Attribute
{
}
