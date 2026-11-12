public readonly struct MathParkourDamageResult(int actualDamage, bool isDefeated, bool isFirstDefeat)
{
	public readonly int ActualDamage = actualDamage;

	public readonly bool IsDefeated = isDefeated;

	public readonly bool IsFirstDefeat = isFirstDefeat;
}
