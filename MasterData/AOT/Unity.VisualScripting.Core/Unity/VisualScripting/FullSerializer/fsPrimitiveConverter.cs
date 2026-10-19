using System;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting.FullSerializer;

public class fsPrimitiveConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		if (!type.Resolve().IsPrimitive && !(type == typeof(string)))
		{
			return type == typeof(decimal);
		}
		return true;
	}

	public override bool RequestCycleSupport(Type storageType)
	{
		return false;
	}

	public override bool RequestInheritanceSupport(Type storageType)
	{
		return false;
	}

	public override fsResult TrySerialize(object instance, out fsData serialized, Type storageType)
	{
		Type type = instance.GetType();
		if (Serializer.Config.Serialize64BitIntegerAsString && (type == typeof(long) || type == typeof(ulong)))
		{
			serialized = new fsData((string)Convert.ChangeType(instance, typeof(string)));
			return fsResult.Success;
		}
		if (UseBool(type))
		{
			serialized = new fsData((bool)instance);
			return fsResult.Success;
		}
		if (UseInt64(type))
		{
			serialized = new fsData((long)Convert.ChangeType(instance, typeof(long)));
			return fsResult.Success;
		}
		if (UseDouble(type))
		{
			if (instance.GetType() == typeof(float) && (float)instance != float.MinValue && (float)instance != float.MaxValue && !float.IsInfinity((float)instance) && !float.IsNaN((float)instance))
			{
				serialized = new fsData((double)(decimal)(float)instance);
				return fsResult.Success;
			}
			serialized = new fsData((double)Convert.ChangeType(instance, typeof(double)));
			return fsResult.Success;
		}
		if (UseString(type))
		{
			serialized = new fsData((string)Convert.ChangeType(instance, typeof(string)));
			return fsResult.Success;
		}
		serialized = null;
		return fsResult.Fail("Unhandled primitive type " + instance.GetType());
	}

	public override fsResult TryDeserialize(fsData storage, ref object instance, Type storageType)
	{
		fsResult success = fsResult.Success;
		if (UseBool(storageType))
		{
			fsResult fsResult2 = (success += CheckType(storage, fsDataType.Boolean));
			if (fsResult2.Succeeded)
			{
				instance = storage.AsBool;
			}
			return success;
		}
		if (UseDouble(storageType) || UseInt64(storageType))
		{
			if (storage.IsDouble)
			{
				instance = Convert.ChangeType(storage.AsDouble, storageType);
			}
			else if (storage.IsInt64)
			{
				instance = Convert.ChangeType(storage.AsInt64, storageType);
			}
			else
			{
				if (!Serializer.Config.Serialize64BitIntegerAsString || !storage.IsString || (!(storageType == typeof(long)) && !(storageType == typeof(ulong))))
				{
					return fsResult.Fail(GetType().Name + " expected number but got " + storage.Type.ToString() + " in " + storage);
				}
				instance = Convert.ChangeType(storage.AsString, storageType);
			}
			return fsResult.Success;
		}
		if (UseString(storageType))
		{
			fsResult fsResult2 = (success += CheckType(storage, fsDataType.String));
			if (fsResult2.Succeeded)
			{
				string asString = storage.AsString;
				if (storageType == typeof(char))
				{
					if (storageType == typeof(char))
					{
						if (asString.Length == 1)
						{
							instance = asString[0];
						}
						else
						{
							instance = '\0';
						}
					}
				}
				else
				{
					instance = asString;
				}
			}
			return success;
		}
		return fsResult.Fail(GetType().Name + ": Bad data; expected bool, number, string, but got " + storage);
	}

	private static bool UseBool(Type type)
	{
		return type == typeof(bool);
	}

	private static bool UseInt64(Type type)
	{
		if (!(type == typeof(sbyte)) && !(type == typeof(byte)) && !(type == typeof(short)) && !(type == typeof(ushort)) && !(type == typeof(int)) && !(type == typeof(uint)) && !(type == typeof(long)))
		{
			return type == typeof(ulong);
		}
		return true;
	}

	private static bool UseDouble(Type type)
	{
		if (!(type == typeof(float)) && !(type == typeof(double)))
		{
			return type == typeof(decimal);
		}
		return true;
	}

	private static bool UseString(Type type)
	{
		if (!(type == typeof(string)))
		{
			return type == typeof(char);
		}
		return true;
	}
}
