using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Text;
using Pathfinding.Util;
using Pathfinding.WindowsStore;
using UnityEngine;

namespace Pathfinding.Serialization;

public class TinyJsonSerializer
{
	private StringBuilder output = new StringBuilder();

	private Dictionary<Type, Action<object>> serializers = new Dictionary<Type, Action<object>>();

	private static readonly CultureInfo invariantCulture = CultureInfo.InvariantCulture;

	public static void Serialize(object obj, StringBuilder output)
	{
		TinyJsonSerializer tinyJsonSerializer = new TinyJsonSerializer();
		tinyJsonSerializer.output = output;
		tinyJsonSerializer.Serialize(obj);
	}

	private TinyJsonSerializer()
	{
		serializers[typeof(float)] = delegate(object v)
		{
			output.Append(((float)v).ToString("R", invariantCulture));
		};
		serializers[typeof(bool)] = delegate(object v)
		{
			output.Append(((bool)v) ? "true" : "false");
		};
		serializers[typeof(Version)] = (serializers[typeof(uint)] = (serializers[typeof(int)] = delegate(object v)
		{
			output.Append(v.ToString());
		}));
		serializers[typeof(string)] = delegate(object v)
		{
			output.AppendFormat("\"{0}\"", v.ToString().Replace("\"", "\\\""));
		};
		serializers[typeof(Vector2)] = delegate(object v)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0011: Unknown result type (might be due to invalid IL or missing references)
			//IL_0029: Unknown result type (might be due to invalid IL or missing references)
			//IL_002e: Unknown result type (might be due to invalid IL or missing references)
			output.AppendFormat("{{ \"x\": {0}, \"y\": {1} }}", ((Vector2)v).x.ToString("R", invariantCulture), ((Vector2)v).y.ToString("R", invariantCulture));
		};
		serializers[typeof(Vector3)] = delegate(object v)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0011: Unknown result type (might be due to invalid IL or missing references)
			//IL_0029: Unknown result type (might be due to invalid IL or missing references)
			//IL_002e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0046: Unknown result type (might be due to invalid IL or missing references)
			//IL_004b: Unknown result type (might be due to invalid IL or missing references)
			output.AppendFormat("{{ \"x\": {0}, \"y\": {1}, \"z\": {2} }}", ((Vector3)v).x.ToString("R", invariantCulture), ((Vector3)v).y.ToString("R", invariantCulture), ((Vector3)v).z.ToString("R", invariantCulture));
		};
		serializers[typeof(Pathfinding.Util.Guid)] = delegate(object v)
		{
			output.AppendFormat("{{ \"value\": \"{0}\" }}", v.ToString());
		};
		serializers[typeof(LayerMask)] = delegate(object v)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			output.AppendFormat("{{ \"value\": {0} }}", LayerMask.op_Implicit((LayerMask)v).ToString());
		};
	}

	private void Serialize(object obj)
	{
		if (obj == null)
		{
			output.Append("null");
			return;
		}
		Type type = obj.GetType();
		Type typeInfo = WindowsStoreCompatibility.GetTypeInfo(type);
		if (serializers.ContainsKey(type))
		{
			serializers[type](obj);
			return;
		}
		if (typeInfo.IsEnum)
		{
			output.Append("\"" + obj.ToString() + "\"");
			return;
		}
		if (obj is IList)
		{
			output.Append("[");
			IList list = obj as IList;
			for (int i = 0; i < list.Count; i++)
			{
				if (i != 0)
				{
					output.Append(", ");
				}
				Serialize(list[i]);
			}
			output.Append("]");
			return;
		}
		if (obj is Object)
		{
			SerializeUnityObject((Object)((obj is Object) ? obj : null));
			return;
		}
		bool flag = typeInfo.GetCustomAttributes(typeof(JsonOptInAttribute), inherit: true).Length != 0;
		output.Append("{");
		FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		bool flag2 = false;
		FieldInfo[] array = fields;
		foreach (FieldInfo fieldInfo in array)
		{
			if ((!flag && fieldInfo.IsPublic) || fieldInfo.GetCustomAttributes(typeof(JsonMemberAttribute), inherit: true).Length != 0)
			{
				if (flag2)
				{
					output.Append(", ");
				}
				flag2 = true;
				output.AppendFormat("\"{0}\": ", fieldInfo.Name);
				Serialize(fieldInfo.GetValue(obj));
			}
		}
		output.Append("}");
	}

	private void QuotedField(string name, string contents)
	{
		output.AppendFormat("\"{0}\": \"{1}\"", name, contents);
	}

	private void SerializeUnityObject(Object obj)
	{
		if (obj == (Object)null)
		{
			Serialize(null);
			return;
		}
		output.Append("{");
		QuotedField("Name", obj.name);
		output.Append(", ");
		QuotedField("Type", ((object)obj).GetType().FullName);
		Component val = (Component)(object)((obj is Component) ? obj : null);
		GameObject val2 = (GameObject)(object)((obj is GameObject) ? obj : null);
		if ((Object)(object)val != (Object)null || (Object)(object)val2 != (Object)null)
		{
			if ((Object)(object)val != (Object)null && (Object)(object)val2 == (Object)null)
			{
				val2 = val.gameObject;
			}
			UnityReferenceHelper unityReferenceHelper = val2.GetComponent<UnityReferenceHelper>();
			if ((Object)(object)unityReferenceHelper == (Object)null)
			{
				Debug.Log((object)("Adding UnityReferenceHelper to Unity Reference '" + obj.name + "'"));
				unityReferenceHelper = val2.AddComponent<UnityReferenceHelper>();
			}
			unityReferenceHelper.Reset();
			output.Append(", ");
			QuotedField("GUID", unityReferenceHelper.GetGUID().ToString());
		}
		output.Append("}");
	}
}
