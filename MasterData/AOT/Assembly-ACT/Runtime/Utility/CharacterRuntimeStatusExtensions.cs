using ACT.Game.Data;

namespace Runtime.Utility;

public static class CharacterRuntimeStatusExtensions
{
	public static bool IsRuntimeAlive(this Character character)
	{
		return EntityHelper.IsCharacterRuntimeAlive(character);
	}

	public static int GetRuntimeStatusHp(this Character character)
	{
		return EntityHelper.GetCharacterRuntimeStatusHp(character);
	}
}
