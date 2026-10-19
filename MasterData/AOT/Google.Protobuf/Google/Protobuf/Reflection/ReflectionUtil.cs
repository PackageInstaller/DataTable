using System;
using System.Reflection;

namespace Google.Protobuf.Reflection;

internal static class ReflectionUtil
{
	private interface IReflectionHelper
	{
		Func<IMessage, int> CreateFuncIMessageInt32(MethodInfo method);

		Action<IMessage> CreateActionIMessage(MethodInfo method);

		Func<IMessage, object> CreateFuncIMessageObject(MethodInfo method);

		Action<IMessage, object> CreateActionIMessageObject(MethodInfo method);

		Func<IMessage, bool> CreateFuncIMessageBool(MethodInfo method);
	}

	internal interface IExtensionReflectionHelper
	{
		object GetExtension(IMessage message);

		void SetExtension(IMessage message, object value);

		bool HasExtension(IMessage message);

		void ClearExtension(IMessage message);
	}

	private interface IExtensionSetReflector
	{
		Func<IMessage, bool> CreateIsInitializedCaller();
	}

	private class ReflectionHelper<T1, T2> : IReflectionHelper
	{
		public Func<IMessage, int> CreateFuncIMessageInt32(MethodInfo method)
		{
			if (CanConvertEnumFuncToInt32Func)
			{
				Func<T1, int> del = (Func<T1, int>)method.CreateDelegate(typeof(Func<T1, int>));
				return (IMessage message) => del((T1)message);
			}
			Func<T1, T2> del2 = (Func<T1, T2>)method.CreateDelegate(typeof(Func<T1, T2>));
			return (IMessage message) => (int)(object)del2((T1)message);
		}

		public Action<IMessage> CreateActionIMessage(MethodInfo method)
		{
			Action<T1> del = (Action<T1>)method.CreateDelegate(typeof(Action<T1>));
			return (IMessage message) =>
			{
				del((T1)message);
			};
		}

		public Func<IMessage, object> CreateFuncIMessageObject(MethodInfo method)
		{
			Func<T1, T2> del = (Func<T1, T2>)method.CreateDelegate(typeof(Func<T1, T2>));
			return (IMessage message) => del((T1)message);
		}

		public Action<IMessage, object> CreateActionIMessageObject(MethodInfo method)
		{
			Action<T1, T2> del = (Action<T1, T2>)method.CreateDelegate(typeof(Action<T1, T2>));
			return (IMessage message, object arg) =>
			{
				del((T1)message, (T2)arg);
			};
		}

		public Func<IMessage, bool> CreateFuncIMessageBool(MethodInfo method)
		{
			Func<T1, bool> del = (Func<T1, bool>)method.CreateDelegate(typeof(Func<T1, bool>));
			return (IMessage message) => del((T1)message);
		}
	}

	private class ExtensionReflectionHelper<T1, T3> : IExtensionReflectionHelper where T1 : IExtendableMessage<T1>
	{
		private readonly Extension extension;

		public ExtensionReflectionHelper(Extension extension)
		{
			this.extension = extension;
		}

		public object GetExtension(IMessage message)
		{
			if (!(message is T1 val))
			{
				throw new InvalidCastException("Cannot access extension on message that isn't IExtensionMessage");
			}
			if (extension is Extension<T1, T3>)
			{
				Extension<T1, T3> obj = extension as Extension<T1, T3>;
				return val.GetExtension(obj);
			}
			if (extension is RepeatedExtension<T1, T3>)
			{
				RepeatedExtension<T1, T3> obj2 = extension as RepeatedExtension<T1, T3>;
				return val.GetOrInitializeExtension(obj2);
			}
			throw new InvalidCastException("The provided extension is not a valid extension identifier type");
		}

		public bool HasExtension(IMessage message)
		{
			if (!(message is T1 val))
			{
				throw new InvalidCastException("Cannot access extension on message that isn't IExtensionMessage");
			}
			if (extension is Extension<T1, T3>)
			{
				return val.HasExtension(extension as Extension<T1, T3>);
			}
			if (extension is RepeatedExtension<T1, T3>)
			{
				throw new InvalidOperationException("HasValue is not implemented for repeated extensions");
			}
			throw new InvalidCastException("The provided extension is not a valid extension identifier type");
		}

		public void SetExtension(IMessage message, object value)
		{
			if (!(message is T1 val))
			{
				throw new InvalidCastException("Cannot access extension on message that isn't IExtensionMessage");
			}
			if (extension is Extension<T1, T3>)
			{
				val.SetExtension(extension as Extension<T1, T3>, (T3)value);
				return;
			}
			if (extension is RepeatedExtension<T1, T3>)
			{
				throw new InvalidOperationException("SetValue is not implemented for repeated extensions");
			}
			throw new InvalidCastException("The provided extension is not a valid extension identifier type");
		}

		public void ClearExtension(IMessage message)
		{
			if (!(message is T1 val))
			{
				throw new InvalidCastException("Cannot access extension on message that isn't IExtensionMessage");
			}
			if (extension is Extension<T1, T3>)
			{
				Extension<T1, T3> obj = extension as Extension<T1, T3>;
				val.ClearExtension(obj);
				return;
			}
			if (extension is RepeatedExtension<T1, T3>)
			{
				RepeatedExtension<T1, T3> obj2 = extension as RepeatedExtension<T1, T3>;
				val.GetExtension(obj2).Clear();
				return;
			}
			throw new InvalidCastException("The provided extension is not a valid extension identifier type");
		}
	}

	private class ExtensionSetReflector<T1> : IExtensionSetReflector where T1 : IExtendableMessage<T1>
	{
		public Func<IMessage, bool> CreateIsInitializedCaller()
		{
			PropertyInfo declaredProperty = typeof(T1).GetTypeInfo().GetDeclaredProperty("_Extensions");
			Func<T1, ExtensionSet<T1>> getFunc = (Func<T1, ExtensionSet<T1>>)declaredProperty.GetMethod.CreateDelegate(typeof(Func<T1, ExtensionSet<T1>>));
			Func<ExtensionSet<T1>, bool> initializedFunc = (Func<ExtensionSet<T1>, bool>)typeof(ExtensionSet<T1>).GetTypeInfo().GetDeclaredMethod("IsInitialized").CreateDelegate(typeof(Func<ExtensionSet<T1>, bool>));
			return (IMessage m) =>
			{
				ExtensionSet<T1> extensionSet = getFunc((T1)m);
				return extensionSet == null || initializedFunc(extensionSet);
			};
		}
	}

	public enum SampleEnum
	{
		X
	}

	internal static readonly Type[] EmptyTypes;

	private static bool CanConvertEnumFuncToInt32Func { get; }

	static ReflectionUtil()
	{
		EmptyTypes = new Type[0];
		CanConvertEnumFuncToInt32Func = CheckCanConvertEnumFuncToInt32Func();
		ForceInitialize<string>();
		ForceInitialize<int>();
		ForceInitialize<long>();
		ForceInitialize<uint>();
		ForceInitialize<ulong>();
		ForceInitialize<float>();
		ForceInitialize<double>();
		ForceInitialize<bool>();
		ForceInitialize<int?>();
		ForceInitialize<long?>();
		ForceInitialize<uint?>();
		ForceInitialize<ulong?>();
		ForceInitialize<float?>();
		ForceInitialize<double?>();
		ForceInitialize<bool?>();
		ForceInitialize<SampleEnum>();
		SampleEnumMethod();
	}

	internal static void ForceInitialize<T>()
	{
		new ReflectionHelper<IMessage, T>();
	}

	internal static Func<IMessage, object> CreateFuncIMessageObject(MethodInfo method)
	{
		return GetReflectionHelper(method.DeclaringType, method.ReturnType).CreateFuncIMessageObject(method);
	}

	internal static Func<IMessage, int> CreateFuncIMessageInt32(MethodInfo method)
	{
		return GetReflectionHelper(method.DeclaringType, method.ReturnType).CreateFuncIMessageInt32(method);
	}

	internal static Action<IMessage, object> CreateActionIMessageObject(MethodInfo method)
	{
		return GetReflectionHelper(method.DeclaringType, method.GetParameters()[0].ParameterType).CreateActionIMessageObject(method);
	}

	internal static Action<IMessage> CreateActionIMessage(MethodInfo method)
	{
		return GetReflectionHelper(method.DeclaringType, typeof(object)).CreateActionIMessage(method);
	}

	internal static Func<IMessage, bool> CreateFuncIMessageBool(MethodInfo method)
	{
		return GetReflectionHelper(method.DeclaringType, method.ReturnType).CreateFuncIMessageBool(method);
	}

	internal static Func<IMessage, bool> CreateIsInitializedCaller(Type msg)
	{
		return ((IExtensionSetReflector)Activator.CreateInstance(typeof(ExtensionSetReflector<>).MakeGenericType(msg))).CreateIsInitializedCaller();
	}

	internal static IExtensionReflectionHelper CreateExtensionHelper(Extension extension)
	{
		return (IExtensionReflectionHelper)Activator.CreateInstance(typeof(ExtensionReflectionHelper<, >).MakeGenericType(extension.TargetType, extension.GetType().GenericTypeArguments[1]), extension);
	}

	private static IReflectionHelper GetReflectionHelper(Type t1, Type t2)
	{
		return (IReflectionHelper)Activator.CreateInstance(typeof(ReflectionHelper<, >).MakeGenericType(t1, t2));
	}

	private static bool CheckCanConvertEnumFuncToInt32Func()
	{
		try
		{
			typeof(ReflectionUtil).GetMethod("SampleEnumMethod").CreateDelegate(typeof(Func<int>));
			return true;
		}
		catch (ArgumentException)
		{
			return false;
		}
	}

	public static SampleEnum SampleEnumMethod()
	{
		return SampleEnum.X;
	}
}
