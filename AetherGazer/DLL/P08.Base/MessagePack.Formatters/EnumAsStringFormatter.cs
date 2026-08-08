using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.Serialization;

namespace MessagePack.Formatters;

public sealed class EnumAsStringFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter
{
	private readonly IReadOnlyDictionary<string, T> nameValueMapping;

	private readonly IReadOnlyDictionary<T, string> valueNameMapping;

	private readonly IReadOnlyDictionary<string, string> clrToSerializationName;

	private readonly IReadOnlyDictionary<string, string> serializationToClrName;

	private readonly bool enumMemberOverridesPresent;

	private readonly bool isFlags;

	public EnumAsStringFormatter()
	{
		isFlags = typeof(T).GetCustomAttribute<FlagsAttribute>() != null;
		FieldInfo[] fields = typeof(T).GetFields(BindingFlags.DeclaredOnly | BindingFlags.Static | BindingFlags.Public);
		Dictionary<string, T> dictionary = new Dictionary<string, T>(fields.Length);
		Dictionary<T, string> dictionary2 = new Dictionary<T, string>();
		Dictionary<string, string> dictionary3 = null;
		Dictionary<string, string> dictionary4 = null;
		FieldInfo[] array = fields;
		foreach (FieldInfo obj in array)
		{
			string text = obj.Name;
			T val = (T)obj.GetValue(null);
			EnumMemberAttribute customAttribute = obj.GetCustomAttribute<EnumMemberAttribute>();
			if (customAttribute != null && customAttribute.IsValueSetExplicitly)
			{
				dictionary3 = dictionary3 ?? new Dictionary<string, string>();
				dictionary4 = dictionary4 ?? new Dictionary<string, string>();
				dictionary3.Add(text, customAttribute.Value);
				dictionary4.Add(customAttribute.Value, text);
				text = customAttribute.Value;
				enumMemberOverridesPresent = true;
			}
			dictionary[text] = val;
			dictionary2[val] = text;
		}
		nameValueMapping = dictionary;
		valueNameMapping = dictionary2;
		clrToSerializationName = dictionary3;
		serializationToClrName = dictionary4;
	}

	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		if (!valueNameMapping.TryGetValue(value, out var value2))
		{
			value2 = GetSerializedNames(value.ToString());
		}
		writer.Write(value2);
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		string text = reader.ReadString();
		if (!nameValueMapping.TryGetValue(text, out var value))
		{
			return (T)Enum.Parse(typeof(T), GetClrNames(text));
		}
		return value;
	}

	private string GetClrNames(string serializedNames)
	{
		if (enumMemberOverridesPresent && isFlags && serializedNames.IndexOf(", ", StringComparison.Ordinal) >= 0)
		{
			return Translate(serializedNames, serializationToClrName);
		}
		return serializedNames;
	}

	private string GetSerializedNames(string clrNames)
	{
		if (enumMemberOverridesPresent && isFlags && clrNames.IndexOf(", ", StringComparison.Ordinal) >= 0)
		{
			return Translate(clrNames, clrToSerializationName);
		}
		return clrNames;
	}

	private static string Translate(string items, IReadOnlyDictionary<string, string> mapping)
	{
		string[] array = items.Split(',');
		for (int i = 0; i < array.Length; i++)
		{
			if (i > 0 && array[i].Length > 0 && array[i][0] == ' ')
			{
				array[i] = array[i].Substring(1);
			}
			if (mapping.TryGetValue(array[i], out var value))
			{
				array[i] = value;
			}
		}
		return string.Join(", ", array);
	}
}
