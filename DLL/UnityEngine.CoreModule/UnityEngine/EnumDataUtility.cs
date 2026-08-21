using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace UnityEngine;

internal static class EnumDataUtility
{
	public enum CachedType
	{
		ExcludeObsolete,
		IncludeObsoleteExceptErrors,
		IncludeAllObsolete
	}

	private static readonly Dictionary<(CachedType, Type), EnumData> s_EnumData = new Dictionary<(CachedType, Type), EnumData>();

	public static EnumData GetCachedEnumData(Type enumType, CachedType cachedType = CachedType.IncludeObsoleteExceptErrors, Func<string, string> nicifyName = null)
	{
		if (s_EnumData.TryGetValue((cachedType, enumType), out var value))
		{
			return value;
		}
		value = new EnumData
		{
			underlyingType = Enum.GetUnderlyingType(enumType)
		};
		value.unsigned = value.underlyingType == typeof(byte) || value.underlyingType == typeof(ushort) || value.underlyingType == typeof(uint) || value.underlyingType == typeof(ulong);
		FieldInfo[] fields = enumType.GetFields(BindingFlags.Static | BindingFlags.Public);
		List<FieldInfo> list = new List<FieldInfo>();
		int num = fields.Length;
		for (int i = 0; i < num; i++)
		{
			if (CheckObsoleteAddition(fields[i], cachedType))
			{
				list.Add(fields[i]);
			}
		}
		if (!list.Any())
		{
			string[] array = new string[1] { "" };
			Enum[] values = new Enum[0];
			int[] flagValues = new int[1];
			value.values = values;
			value.flagValues = flagValues;
			value.displayNames = array;
			value.names = array;
			value.tooltip = array;
			value.flags = true;
			value.serializable = true;
			return value;
		}
		try
		{
			string location = list.First().Module.Assembly.Location;
			if (!string.IsNullOrEmpty(location))
			{
				list = list.OrderBy((FieldInfo f) => f.MetadataToken).ToList();
			}
		}
		catch
		{
		}
		value.displayNames = list.Select((FieldInfo f) => EnumNameFromEnumField(f, nicifyName)).ToArray();
		if (value.displayNames.Distinct().Count() != value.displayNames.Length)
		{
			Debug.LogWarning("Enum " + enumType.Name + " has multiple entries with the same display name, this prevents selection in EnumPopup.");
		}
		value.tooltip = list.Select((FieldInfo f) => EnumTooltipFromEnumField(f)).ToArray();
		value.values = list.Select((FieldInfo f) => (Enum)f.GetValue(null)).ToArray();
		value.flagValues = (value.unsigned ? value.values.Select((Enum v) => (int)Convert.ToUInt64(v)).ToArray() : value.values.Select((Enum v) => (int)Convert.ToInt64(v)).ToArray());
		value.names = new string[value.values.Length];
		for (int num2 = 0; num2 < list.Count; num2++)
		{
			value.names[num2] = list[num2].Name;
		}
		if (value.underlyingType == typeof(ushort))
		{
			int num3 = 0;
			for (int num4 = value.flagValues.Length; num3 < num4; num3++)
			{
				if ((long)value.flagValues[num3] == 65535)
				{
					value.flagValues[num3] = -1;
				}
			}
		}
		else if (value.underlyingType == typeof(byte))
		{
			int num5 = 0;
			for (int num6 = value.flagValues.Length; num5 < num6; num5++)
			{
				if ((long)value.flagValues[num5] == 255)
				{
					value.flagValues[num5] = -1;
				}
			}
		}
		value.flags = enumType.IsDefined(typeof(FlagsAttribute), inherit: false);
		value.serializable = value.underlyingType != typeof(long) && value.underlyingType != typeof(ulong);
		HandleInspectorOrderAttribute(enumType, ref value);
		s_EnumData[(cachedType, enumType)] = value;
		return value;
	}

	internal static void HandleInspectorOrderAttribute(Type enumType, ref EnumData enumData)
	{
		if (Attribute.GetCustomAttribute(enumType, typeof(InspectorOrderAttribute)) is InspectorOrderAttribute inspectorOrderAttribute)
		{
			int num = enumData.displayNames.Length;
			int[] array = new int[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = i;
			}
			InspectorSort inspectorSort = inspectorOrderAttribute.m_inspectorSort;
			InspectorSort inspectorSort2 = inspectorSort;
			if (inspectorSort2 == InspectorSort.ByValue)
			{
				int[] array2 = new int[num];
				Array.Copy(enumData.flagValues, array2, num);
				Array.Sort(array2, array);
			}
			else
			{
				string[] array3 = new string[num];
				Array.Copy(enumData.displayNames, array3, num);
				Array.Sort(array3, array, StringComparer.Ordinal);
			}
			if (inspectorOrderAttribute.m_sortDirection == InspectorSortDirection.Descending)
			{
				Array.Reverse(array);
			}
			Enum[] array4 = new Enum[num];
			int[] array5 = new int[num];
			string[] array6 = new string[num];
			string[] array7 = new string[num];
			string[] array8 = new string[num];
			for (int j = 0; j < num; j++)
			{
				int num2 = array[j];
				array4[j] = enumData.values[num2];
				array5[j] = enumData.flagValues[num2];
				array6[j] = enumData.displayNames[num2];
				array7[j] = enumData.names[num2];
				array8[j] = enumData.tooltip[num2];
			}
			enumData.values = array4;
			enumData.flagValues = array5;
			enumData.displayNames = array6;
			enumData.names = array7;
			enumData.tooltip = array8;
		}
	}

	private static bool CheckObsoleteAddition(FieldInfo field, CachedType cachedType)
	{
		object[] customAttributes = field.GetCustomAttributes(typeof(ObsoleteAttribute), inherit: false);
		if (customAttributes.Length != 0)
		{
			return cachedType switch
			{
				CachedType.ExcludeObsolete => false, 
				CachedType.IncludeAllObsolete => true, 
				_ => !((ObsoleteAttribute)customAttributes.First()).IsError, 
			};
		}
		return true;
	}

	private static string EnumTooltipFromEnumField(FieldInfo field)
	{
		object[] customAttributes = field.GetCustomAttributes(typeof(TooltipAttribute), inherit: false);
		if (customAttributes.Length != 0)
		{
			return ((TooltipAttribute)customAttributes.First()).tooltip;
		}
		return string.Empty;
	}

	private static string EnumNameFromEnumField(FieldInfo field, Func<string, string> nicifyName)
	{
		object[] customAttributes = field.GetCustomAttributes(typeof(InspectorNameAttribute), inherit: false);
		if (customAttributes.Length != 0)
		{
			return ((InspectorNameAttribute)customAttributes.First()).displayName;
		}
		if (field.IsDefined(typeof(ObsoleteAttribute), inherit: false))
		{
			return NicifyName() + " (Obsolete)";
		}
		return NicifyName();
		string NicifyName()
		{
			return (nicifyName == null) ? field.Name : nicifyName(field.Name);
		}
	}
}
