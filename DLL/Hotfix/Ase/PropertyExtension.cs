namespace Ase;

public static class PropertyExtension
{
	public static string GetPropertyString(string propertyKey)
	{
		return propertyKey switch
		{
			"Hp" => "生命值", 
			"Attack" => "攻击力", 
			"Defence" => "防御力", 
			_ => "未定义属性", 
		};
	}
}
