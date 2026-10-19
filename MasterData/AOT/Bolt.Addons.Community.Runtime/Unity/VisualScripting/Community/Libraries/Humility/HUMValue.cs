using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMValue
{
	public static class Data
	{
		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Create
		{
		}

		public struct Ensure(GameObject target)
		{
			public GameObject target = target;
		}

		public struct MBehaviour(Ensure ensure)
		{
			public Ensure ensure = ensure;
		}

		public struct Interface(MBehaviour ensure)
		{
			public MBehaviour ensure = ensure;
		}

		public struct As(object value)
		{
			public object value = value;
		}

		public struct Is(object value)
		{
			public object value = value;
		}

		public struct Or(object value, bool wasNull)
		{
			public bool wasNull = wasNull;

			public object value = value;
		}

		public struct IsNull
		{
			public Is @is;

			public Or or;

			public bool isNull;

			public IsNull(Is @is, bool isNull)
			{
				this.@is = @is;
				or = default;
				this.isNull = isNull;
			}

			public IsNull(Or or, bool isNull)
			{
				@is = default;
				this.or = or;
				this.isNull = isNull;
			}
		}

		public struct NotNull
		{
			public Is @is;

			public Or or;

			public bool isNull;

			public NotNull(Is @is, bool isNull)
			{
				this.@is = @is;
				or = default;
				this.isNull = isNull;
			}

			public NotNull(Or or, bool isNull)
			{
				@is = default;
				this.or = or;
				this.isNull = isNull;
			}
		}
	}

	public static string Serialized(this object value)
	{
		Type type = value?.GetType();
		if (type == null)
		{
			return "null";
		}
		if (type == typeof(bool))
		{
			return value.ToString().ToLower() + "[Type:Boolean]";
		}
		if (type == typeof(float))
		{
			return value.ToString() + "[Type:Float]";
		}
		if (type == typeof(int))
		{
			return value.ToString() + "[Type:Int]";
		}
		if (type == typeof(string))
		{
			return value?.ToString() + "[Type:String]";
		}
		if (type == typeof(Type))
		{
			return ((Type)value).FullName + "[Type:Type]";
		}
		if (type == typeof(GameObject))
		{
			return "null";
		}
		return string.Empty;
	}

	public static object Deserialized(this string str)
	{
		if (str.Contains("[Type:Boolean]"))
		{
			if (str.Contains("true"))
			{
				return true;
			}
			if (str.Contains("false"))
			{
				return false;
			}
		}
		if (str.Contains("[Type:Float]"))
		{
			return float.Parse(str.Replace("[Type:Float]", string.Empty));
		}
		if (str.Contains("[Type:String]"))
		{
			return str.Replace("[Type:String]", string.Empty);
		}
		if (str.Contains("[Type:Int]"))
		{
			return int.Parse(str.Replace("[Type:Int]", string.Empty));
		}
		if (str.Contains("[Type:Type]"))
		{
			return Type.GetType(str.Replace("[Type:Type]", string.Empty));
		}
		if (str.Contains("[Type:GameObject"))
		{
			int.Parse(str.Replace("[Type:GameObject]", string.Empty));
		}
		return null;
	}

	public static bool Changed(ref object refValue, object value, bool assign = true)
	{
		bool result = refValue != value;
		if (assign)
		{
			refValue = value;
		}
		return result;
	}

	public static bool Changed(this object refValue, object value, Action<object> onValueChanged)
	{
		bool result = refValue != value;
		if (refValue != value)
		{
			onValueChanged?.Invoke(value);
		}
		return result;
	}

	public static Data.Create Create()
	{
		return default;
	}

	public static Data.Is Is<T>(this T value) where T : class
	{
		return new Data.Is(value);
	}

	public static object Fallback(ref object @object, object value)
	{
		if (@object == null)
		{
			return value;
		}
		return @object;
	}

	public static T Fallback<T>(ref T @object, T value)
	{
		if (@object == null)
		{
			return value;
		}
		return @object;
	}

	public static Data.Ensure Ensure(this GameObject target)
	{
		return new Data.Ensure(target);
	}

	public static Data.Ensure Ensure(this Transform target)
	{
		return new Data.Ensure(target.gameObject);
	}

	public static Data.As As(this object value)
	{
		return new Data.As(value);
	}
}
