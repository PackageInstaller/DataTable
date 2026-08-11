namespace Ase;

public readonly struct EnvironmentModifierDisplayInfo(int environId, int effectId, EnvironmentModifierType environmentType, EnvironmentModifierTargetType targetType, string name, string desc, string icon)
{
	public int EnvironId { get; } = environId;

	public int EffectId { get; } = effectId;

	public EnvironmentModifierType EnvironmentType { get; } = environmentType;

	public EnvironmentModifierTargetType TargetType { get; } = targetType;

	public string Name { get; } = name ?? string.Empty;

	public string Desc { get; } = desc ?? string.Empty;

	public string Icon { get; } = icon ?? string.Empty;

	public bool IsBuff => EnvironmentType == EnvironmentModifierType.Buff;

	public bool IsParadox => EnvironmentType == EnvironmentModifierType.Paradox;
}
