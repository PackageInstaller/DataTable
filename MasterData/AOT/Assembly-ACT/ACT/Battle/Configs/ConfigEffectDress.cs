using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[CreateAssetMenu(fileName = "ConfigEffectDress", menuName = "ACT/Battle/EffectDress")]
public class ConfigEffectDress : LuminSerializedScriptableObject
{
	public List<EffectDressConfigItem> dresses = new List<EffectDressConfigItem>();

	public bool TryGetDress(int dressId, out EffectDressConfigItem config)
	{
		if (dresses != null)
		{
			for (int i = 0; i < dresses.Count; i++)
			{
				EffectDressConfigItem effectDressConfigItem = dresses[i];
				if (effectDressConfigItem != null && effectDressConfigItem.dressId == dressId)
				{
					config = effectDressConfigItem;
					return true;
				}
			}
		}
		config = null;
		return false;
	}
}
