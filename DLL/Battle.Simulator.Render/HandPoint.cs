using System.Collections.Generic;

public static class HandPoint
{
	private static Dictionary<string, string> _handPoints = new Dictionary<string, string>();

	public static void Initialize()
	{
		_handPoints["gua_R_hand"] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand";
		_handPoints["gua_L_hand"] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand";
		_handPoints["gua_Hp"] = "Bip001/gua_Hp";
		_handPoints["gua_Buff_bottom"] = "Bip001/gua_Buff_bottom";
		_handPoints["gua_Buff_top"] = "Bip001/gua_Buff_top";
		_handPoints["gua_hit"] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/gua_hit";
		_handPoints["gua_Weapon"] = "Bip001/Bip001 Prop1/gua_Weapon";
	}

	public static string GetHandPointPath(string key)
	{
		string value = string.Empty;
		_handPoints.TryGetValue(key, out value);
		return value;
	}
}
