using System;

[AttributeUsage(AttributeTargets.Class)]
public class BuffEffectAttribute : Attribute
{
	public HotfixEnum.BuffEffectType BuffEffectType { get; private set; }

	public BuffEffectAttribute(HotfixEnum.BuffEffectType effectType)
	{
		BuffEffectType = effectType;
	}
}
