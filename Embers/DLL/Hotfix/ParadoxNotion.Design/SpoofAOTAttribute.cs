using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface | AttributeTargets.Delegate)]
public class SpoofAOTAttribute : Attribute
{
}
