using System;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[AttributeUsage(AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public class FlagsEnumAttribute : ObjectDrawerAttribute
{
}
