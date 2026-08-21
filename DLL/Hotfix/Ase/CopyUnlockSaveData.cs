using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class CopyUnlockSaveData
{
	public List<int> MainEffectPlayItems;

	public List<int> TypeEffectPlayItems;

	public List<int> dataEffectPlayItems;

	public Dictionary<int, int> second2SelectSaveItems;

	public void SaveEffectPlay(int type, int id)
	{
		switch (type)
		{
		case 0:
			if (MainEffectPlayItems == null)
			{
				MainEffectPlayItems = new List<int>();
			}
			MainEffectPlayItems.Add(id);
			break;
		case 1:
			if (TypeEffectPlayItems == null)
			{
				TypeEffectPlayItems = new List<int>();
			}
			TypeEffectPlayItems.Add(id);
			break;
		case 2:
			if (dataEffectPlayItems == null)
			{
				dataEffectPlayItems = new List<int>();
			}
			dataEffectPlayItems.Add(id);
			break;
		}
	}

	public bool GetEffectPlay(int type, int id)
	{
		switch (type)
		{
		case 0:
			if (MainEffectPlayItems == null)
			{
				return false;
			}
			return MainEffectPlayItems.Contains(id);
		case 1:
			if (TypeEffectPlayItems == null)
			{
				return false;
			}
			return TypeEffectPlayItems.Contains(id);
		case 2:
			if (dataEffectPlayItems == null)
			{
				return false;
			}
			return dataEffectPlayItems.Contains(id);
		default:
			return false;
		}
	}

	public int GetLastSelectCopyId(int copyTypeId)
	{
		if (second2SelectSaveItems == null || !second2SelectSaveItems.ContainsKey(copyTypeId))
		{
			return 0;
		}
		return second2SelectSaveItems[copyTypeId];
	}

	public void SaveLastSelectCopyId(int copyType, int id)
	{
		if (second2SelectSaveItems == null)
		{
			second2SelectSaveItems = new Dictionary<int, int>();
		}
		if (second2SelectSaveItems.ContainsKey(copyType))
		{
			second2SelectSaveItems[copyType] = id;
		}
		else
		{
			second2SelectSaveItems.Add(copyType, id);
		}
	}

	public void Clear()
	{
		if (MainEffectPlayItems != null)
		{
			MainEffectPlayItems.Clear();
			MainEffectPlayItems = null;
		}
		if (TypeEffectPlayItems != null)
		{
			TypeEffectPlayItems.Clear();
			TypeEffectPlayItems = null;
		}
		if (dataEffectPlayItems != null)
		{
			dataEffectPlayItems.Clear();
			dataEffectPlayItems = null;
		}
		if (second2SelectSaveItems != null)
		{
			second2SelectSaveItems.Clear();
			second2SelectSaveItems = null;
		}
	}
}
