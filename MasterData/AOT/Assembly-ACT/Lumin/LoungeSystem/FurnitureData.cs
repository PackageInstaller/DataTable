using System;
using System.Collections.Generic;
using UnityEngine;

namespace Lumin.LoungeSystem;

[Serializable]
public class FurnitureData
{
	public int furnitureId;

	public string furnitureName;

	public FurnitureType furnitureType;

	public int comfortBonus;

	public int comfortBonusPerLevel = 5;

	public Vector3 position;

	public Quaternion rotation;

	public bool isInteractable = true;

	public bool isUnlocked = true;

	public int currentLevel = 1;

	public int maxLevel = 5;

	public int durability = 100;

	public int maxDurability = 100;

	public FurnitureState state;

	public Dictionary<string, object> customData;

	public FurnitureData(int id, string name, FurnitureType type, int comfort)
	{
		furnitureId = id;
		furnitureName = name;
		furnitureType = type;
		comfortBonus = comfort;
		customData = new Dictionary<string, object>();
	}
}
