namespace Ase;

public static class PlayerDefinition
{
	public static string GetStateText(int state)
	{
		return state switch
		{
			1 => "在线", 
			2 => "组队中", 
			3 => "战斗中", 
			4 => "离线", 
			5 => "结算中", 
			_ => string.Empty, 
		};
	}
}
