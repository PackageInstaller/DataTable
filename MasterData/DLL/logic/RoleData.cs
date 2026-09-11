using System.Collections.Generic;

public struct RoleData
{
	public long UID;

	public int playerLevel;

	public int ID;

	public int SkinID;

	public int level;

	public int AI_ID;

	public Dictionary<int, long> attribute;

	public Dictionary<int, int> equipLv;

	public int[] skillLevel;

	public int[] astrolabe;

	public int[] equipment;

	public int weaponEffectID;

	public int weaponEffectLevel;

	public int[] AIEffect;
}
