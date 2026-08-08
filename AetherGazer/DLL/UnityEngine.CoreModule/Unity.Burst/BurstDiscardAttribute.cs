using System;

namespace Unity.Burst;

[AttributeUsage(AttributeTargets.Method | AttributeTargets.Property)]
public class BurstDiscardAttribute : Attribute
{
}
