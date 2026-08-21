using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Text;
using Pathfinding.Util;
using Pathfinding.WindowsStore;
using UnityEngine;

namespace Pathfinding.Serialization;

public class TinyJsonDeserializer
{
	private TextReader reader;

	private static readonly NumberFormatInfo numberFormat = NumberFormatInfo.InvariantInfo;

	private StringBuilder builder = new StringBuilder();

	public static object Deserialize(string text, Type type, object populate = null)
	{
		return new TinyJsonDeserializer
		{
			reader = new StringReader(text)
		}.Deserialize(type, populate);
	}

	private object Deserialize(Type tp, object populate = null)
	{
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_017a: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_020b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0283: Unknown result type (might be due to invalid IL or missing references)
		//IL_0288: Unknown result type (might be due to invalid IL or missing references)
		//IL_0295: Unknown result type (might be due to invalid IL or missing references)
		Type typeInfo = WindowsStoreCompatibility.GetTypeInfo(tp);
		if (typeInfo.IsEnum)
		{
			return Enum.Parse(tp, EatField());
		}
		if (TryEat('n'))
		{
			Eat("ull");
			TryEat(',');
			return null;
		}
		if (object.Equals(tp, typeof(float)))
		{
			return float.Parse(EatField(), numberFormat);
		}
		if (object.Equals(tp, typeof(int)))
		{
			return int.Parse(EatField(), numberFormat);
		}
		if (object.Equals(tp, typeof(uint)))
		{
			return uint.Parse(EatField(), numberFormat);
		}
		if (object.Equals(tp, typeof(bool)))
		{
			return bool.Parse(EatField());
		}
		if (object.Equals(tp, typeof(string)))
		{
			return EatField();
		}
		if (object.Equals(tp, typeof(Version)))
		{
			return new Version(EatField());
		}
		if (object.Equals(tp, typeof(Vector2)))
		{
			Eat("{");
			Vector2 val = default(Vector2);
			EatField();
			val.x = float.Parse(EatField(), numberFormat);
			EatField();
			val.y = float.Parse(EatField(), numberFormat);
			Eat("}");
			return val;
		}
		if (object.Equals(tp, typeof(Vector3)))
		{
			Eat("{");
			Vector3 val2 = default(Vector3);
			EatField();
			val2.x = float.Parse(EatField(), numberFormat);
			EatField();
			val2.y = float.Parse(EatField(), numberFormat);
			EatField();
			val2.z = float.Parse(EatField(), numberFormat);
			Eat("}");
			return val2;
		}
		if (object.Equals(tp, typeof(Pathfinding.Util.Guid)))
		{
			Eat("{");
			EatField();
			Pathfinding.Util.Guid guid = Pathfinding.Util.Guid.Parse(EatField());
			Eat("}");
			return guid;
		}
		if (object.Equals(tp, typeof(LayerMask)))
		{
			Eat("{");
			EatField();
			LayerMask val3 = LayerMask.op_Implicit(int.Parse(EatField()));
			Eat("}");
			return val3;
		}
		if (object.Equals(tp, typeof(List<string>)))
		{
			IList list = new List<string>();
			Eat("[");
			while (!TryEat(']'))
			{
				list.Add(Deserialize(typeof(string)));
				TryEat(',');
			}
			return list;
		}
		if (typeInfo.IsArray)
		{
			List<object> list2 = new List<object>();
			Eat("[");
			while (!TryEat(']'))
			{
				list2.Add(Deserialize(tp.GetElementType()));
				TryEat(',');
			}
			Array array = Array.CreateInstance(tp.GetElementType(), list2.Count);
			list2.ToArray().CopyTo(array, 0);
			return array;
		}
		if (object.Equals(tp, typeof(Mesh)) || object.Equals(tp, typeof(Texture2D)) || object.Equals(tp, typeof(Transform)) || object.Equals(tp, typeof(GameObject)))
		{
			return DeserializeUnityObject();
		}
		object obj = populate ?? Activator.CreateInstance(tp);
		Eat("{");
		while (!TryEat('}'))
		{
			string name = EatField();
			FieldInfo field = tp.GetField(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			if (field == null)
			{
				SkipFieldData();
			}
			else
			{
				field.SetValue(obj, Deserialize(field.FieldType));
			}
			TryEat(',');
		}
		return obj;
	}

	private Object DeserializeUnityObject()
	{
		Eat("{");
		Object result = DeserializeUnityObjectInner();
		Eat("}");
		return result;
	}

	private Object DeserializeUnityObjectInner()
	{
		string text = EatField();
		if (text == "InstanceID")
		{
			EatField();
			text = EatField();
		}
		if (text != "Name")
		{
			throw new Exception("Expected 'Name' field");
		}
		string text2 = EatField();
		if (text2 == null)
		{
			return null;
		}
		if (EatField() != "Type")
		{
			throw new Exception("Expected 'Type' field");
		}
		string text3 = EatField();
		if (text3.IndexOf(',') != -1)
		{
			text3 = text3.Substring(0, text3.IndexOf(','));
		}
		Type type = WindowsStoreCompatibility.GetTypeInfo(typeof(AstarPath)).Assembly.GetType(text3);
		type = type ?? WindowsStoreCompatibility.GetTypeInfo(typeof(Transform)).Assembly.GetType(text3);
		if (object.Equals(type, null))
		{
			Debug.LogError((object)("Could not find type '" + text3 + "'. Cannot deserialize Unity reference"));
			return null;
		}
		EatWhitespace();
		if ((ushort)reader.Peek() == 34)
		{
			if (EatField() != "GUID")
			{
				throw new Exception("Expected 'GUID' field");
			}
			string text4 = EatField();
			UnityReferenceHelper[] array = Object.FindObjectsOfType<UnityReferenceHelper>();
			foreach (UnityReferenceHelper unityReferenceHelper in array)
			{
				if (unityReferenceHelper.GetGUID() == text4)
				{
					if (object.Equals(type, typeof(GameObject)))
					{
						return (Object)(object)((Component)unityReferenceHelper).gameObject;
					}
					return (Object)(object)((Component)unityReferenceHelper).GetComponent(type);
				}
			}
		}
		return null;
	}

	private void EatWhitespace()
	{
		while (char.IsWhiteSpace((char)reader.Peek()))
		{
			reader.Read();
		}
	}

	private void Eat(string s)
	{
		EatWhitespace();
		for (int i = 0; i < s.Length; i++)
		{
			char c = (char)reader.Read();
			if (c != s[i])
			{
				throw new Exception("Expected '" + s[i] + "' found '" + c + "'\n\n..." + reader.ReadLine());
			}
		}
	}

	private string EatUntil(string c, bool inString)
	{
		builder.Length = 0;
		bool flag = false;
		while (true)
		{
			int num = reader.Peek();
			if (!flag && (ushort)num == 34)
			{
				inString = !inString;
			}
			char c2 = (char)num;
			if (num == -1)
			{
				throw new Exception("Unexpected EOF");
			}
			if (!flag && c2 == '\\')
			{
				flag = true;
				reader.Read();
				continue;
			}
			if (!inString && c.IndexOf(c2) != -1)
			{
				break;
			}
			builder.Append(c2);
			reader.Read();
			flag = false;
		}
		return builder.ToString();
	}

	private bool TryEat(char c)
	{
		EatWhitespace();
		if ((ushort)reader.Peek() == c)
		{
			reader.Read();
			return true;
		}
		return false;
	}

	private string EatField()
	{
		string result = EatUntil("\",}]", TryEat('"'));
		TryEat('"');
		TryEat(':');
		TryEat(',');
		return result;
	}

	private void SkipFieldData()
	{
		int num = 0;
		while (true)
		{
			EatUntil(",{}[]", inString: false);
			switch ((char)(ushort)reader.Peek())
			{
			case '[':
			case '{':
				num++;
				break;
			case ']':
			case '}':
				num--;
				if (num < 0)
				{
					return;
				}
				break;
			case ',':
				if (num == 0)
				{
					reader.Read();
					return;
				}
				break;
			default:
				throw new Exception("Should not reach this part");
			}
			reader.Read();
		}
	}
}
