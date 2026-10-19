namespace ACT.UI;

internal readonly struct BossBloodBarSnapshot(int basicMaxHp, int curMaxHp, int curHp, int basicBloodNum, int characterDamageType, bool inWeak)
{
	public readonly int BasicMaxHp = basicMaxHp;

	public readonly int CurMaxHp = curMaxHp;

	public readonly int CurHp = curHp;

	public readonly int BasicBloodNum = basicBloodNum;

	public readonly int CharacterDamageType = characterDamageType;

	public readonly bool InWeak = inWeak;
}
