using System;
using System.Reflection;
using System.Reflection.Emit;
using System.Threading;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class DynamicEnumResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			TypeInfo typeInfo = typeof(T).GetTypeInfo();
			if (typeInfo.IsNullable())
			{
				typeInfo = typeInfo.GenericTypeArguments[0].GetTypeInfo();
				if (typeInfo.IsEnum)
				{
					object formatterDynamic = Instance.GetFormatterDynamic(typeInfo.AsType());
					if (formatterDynamic != null)
					{
						Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(typeof(StaticNullableFormatter<>).MakeGenericType(typeInfo.AsType()), formatterDynamic);
					}
				}
			}
			else if (typeInfo.IsEnum)
			{
				Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(BuildType(typeof(T)).AsType());
			}
		}
	}

	public static readonly DynamicEnumResolver Instance;

	private const string ModuleName = "MessagePack.Resolvers.DynamicEnumResolver";

	private static readonly Lazy<DynamicAssembly> DynamicAssembly;

	private static int nameSequence;

	private DynamicEnumResolver()
	{
	}

	static DynamicEnumResolver()
	{
		Instance = new DynamicEnumResolver();
		nameSequence = 0;
		DynamicAssembly = new Lazy<DynamicAssembly>(() => new DynamicAssembly("MessagePack.Resolvers.DynamicEnumResolver"));
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}

	private static TypeInfo BuildType(Type enumType)
	{
		Type underlyingType = Enum.GetUnderlyingType(enumType);
		Type type = typeof(IMessagePackFormatter<>).MakeGenericType(enumType);
		using (MonoProtection.EnterRefEmitLock())
		{
			TypeBuilder typeBuilder = DynamicAssembly.Value.DefineType("MessagePack.Formatters." + enumType.FullName.Replace(".", "_") + "Formatter" + Interlocked.Increment(ref nameSequence), TypeAttributes.Public | TypeAttributes.Sealed, null, new Type[1] { type });
			ILGenerator iLGenerator = typeBuilder.DefineMethod("Serialize", MethodAttributes.Public | MethodAttributes.Final | MethodAttributes.Virtual, null, new Type[3]
			{
				typeof(MessagePackWriter).MakeByRefType(),
				enumType,
				typeof(MessagePackSerializerOptions)
			}).GetILGenerator();
			iLGenerator.Emit(OpCodes.Ldarg_1);
			iLGenerator.Emit(OpCodes.Ldarg_2);
			iLGenerator.Emit(OpCodes.Call, typeof(MessagePackWriter).GetRuntimeMethod("Write", new Type[1] { underlyingType }));
			iLGenerator.Emit(OpCodes.Ret);
			ILGenerator iLGenerator2 = typeBuilder.DefineMethod("Deserialize", MethodAttributes.Public | MethodAttributes.Final | MethodAttributes.Virtual, enumType, new Type[2]
			{
				typeof(MessagePackReader).MakeByRefType(),
				typeof(MessagePackSerializerOptions)
			}).GetILGenerator();
			iLGenerator2.Emit(OpCodes.Ldarg_1);
			iLGenerator2.Emit(OpCodes.Call, typeof(MessagePackReader).GetRuntimeMethod("Read" + underlyingType.Name, Type.EmptyTypes));
			iLGenerator2.Emit(OpCodes.Ret);
			return typeBuilder.CreateTypeInfo();
		}
	}
}
