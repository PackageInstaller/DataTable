using System;

[AttributeUsage(AttributeTargets.Class)]
public class AdventureEffectAttribute : Attribute
{
	public HotfixEnum.effectType EffectType { get; private set; }

	public AdventureEffectAttribute(HotfixEnum.effectType effectType)
	{
		EffectType = effectType;
	}
}
