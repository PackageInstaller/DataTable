using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;

namespace ACT.Battle.Configs;

public class ConfigAutoEffectSet : LuminSerializedScriptableObject
{
	public class AutoEffectSetData
	{
		public string preEffectType;

		public string comment;

		public bool isAttackEffect;

		public ActionFireEffect actionfireEffect;

		public ActionAttachEffect attachEffect;

		public static IEnumerable GetString()
		{
			List<string> list = new List<string> { "常用", "不常用" };
			ValueDropdownList<int> valueDropdownList = new ValueDropdownList<int>();
			List<string> list2 = list;
			for (int i = 0; i < list2.Count; i++)
			{
				valueDropdownList.Add(list2[i], i);
			}
			return valueDropdownList;
		}
	}

	public enum PreEffectType
	{
		MoreUse,
		LessUse
	}

	public List<AutoEffectSetData> autoEffectData;
}
