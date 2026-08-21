using System;
using System.Collections;
using Sirenix.OdinInspector;

namespace Ase;

public static class EntityTypeUtility
{
	public static IEnumerator GetEntityTypeLabelTextList()
	{
		ValueDropdownList<EntityType> valueDropdownList = new ValueDropdownList<EntityType>();
		foreach (EntityType value in Enum.GetValues(typeof(EntityType)))
		{
			valueDropdownList.Add(value.GetEnumLabelText() ?? "", value);
		}
		return valueDropdownList.GetEnumerator();
	}
}
