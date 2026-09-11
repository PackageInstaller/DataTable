using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Text.RegularExpressions;
using System.Threading;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class DynamicUnionResolver : IFormatterResolver
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
				object formatterDynamic = Instance.GetFormatterDynamic(typeInfo.AsType());
				if (formatterDynamic != null)
				{
					Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(typeof(StaticNullableFormatter<>).MakeGenericType(typeInfo.AsType()), formatterDynamic);
				}
			}
			else
			{
				TypeInfo typeInfo2 = BuildType(typeof(T));
				if (!(typeInfo2 == null))
				{
					Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(typeInfo2.AsType());
				}
			}
		}
	}

	private static class MessagePackReaderTypeInfo
	{
		internal static readonly TypeInfo ReaderTypeInfo = typeof(MessagePackReader).GetTypeInfo();

		internal static readonly MethodInfo ReadBytes = typeof(MessagePackReader).GetRuntimeMethod("ReadBytes", Type.EmptyTypes);

		internal static readonly MethodInfo ReadInt32 = typeof(MessagePackReader).GetRuntimeMethod("ReadInt32", Type.EmptyTypes);

		internal static readonly MethodInfo ReadString = typeof(MessagePackReader).GetRuntimeMethod("ReadString", Type.EmptyTypes);

		internal static readonly MethodInfo TryReadNil = typeof(MessagePackReader).GetRuntimeMethod("TryReadNil", Type.EmptyTypes);

		internal static readonly MethodInfo Skip = typeof(MessagePackReader).GetRuntimeMethod("Skip", Type.EmptyTypes);

		internal static readonly MethodInfo ReadArrayHeader = typeof(MessagePackReader).GetRuntimeMethod("ReadArrayHeader", Type.EmptyTypes);

		internal static readonly MethodInfo ReadMapHeader = typeof(MessagePackReader).GetRuntimeMethod("ReadMapHeader", Type.EmptyTypes);
	}

	private static class MessagePackWriterTypeInfo
	{
		internal static readonly TypeInfo WriterTypeInfo = typeof(MessagePackWriter).GetTypeInfo();

		internal static readonly MethodInfo WriteArrayHeader = typeof(MessagePackWriter).GetRuntimeMethod("WriteArrayHeader", new Type[1] { typeof(int) });

		internal static readonly MethodInfo WriteInt32 = typeof(MessagePackWriter).GetRuntimeMethod("Write", new Type[1] { typeof(int) });

		internal static readonly MethodInfo WriteNil = typeof(MessagePackWriter).GetRuntimeMethod("WriteNil", Type.EmptyTypes);
	}

	private const string ModuleName = "MessagePack.Resolvers.DynamicUnionResolver";

	public static readonly DynamicUnionResolver Instance;

	public static readonly MessagePackSerializerOptions Options;

	private static readonly Lazy<DynamicAssembly> DynamicAssembly;

	private static readonly Regex SubtractFullNameRegex;

	private static int nameSequence;

	private static readonly Type refMessagePackReader;

	private static readonly Type refKvp;

	private static readonly MethodInfo getFormatterWithVerify;

	private static readonly MethodInfo getResolverFromOptions;

	private static readonly Func<Type, MethodInfo> getSerialize;

	private static readonly Func<Type, MethodInfo> getDeserialize;

	private static readonly FieldInfo runtimeTypeHandleEqualityComparer;

	private static readonly ConstructorInfo intIntKeyValuePairConstructor;

	private static readonly ConstructorInfo typeMapDictionaryConstructor;

	private static readonly MethodInfo typeMapDictionaryAdd;

	private static readonly MethodInfo typeMapDictionaryTryGetValue;

	private static readonly ConstructorInfo keyMapDictionaryConstructor;

	private static readonly MethodInfo keyMapDictionaryAdd;

	private static readonly MethodInfo keyMapDictionaryTryGetValue;

	private static readonly MethodInfo objectGetType;

	private static readonly MethodInfo getTypeHandle;

	private static readonly MethodInfo intIntKeyValuePairGetKey;

	private static readonly MethodInfo intIntKeyValuePairGetValue;

	private static readonly ConstructorInfo invalidOperationExceptionConstructor;

	private static readonly ConstructorInfo objectCtor;

	static DynamicUnionResolver()
	{
		SubtractFullNameRegex = new Regex(", Version=\\d+.\\d+.\\d+.\\d+, Culture=\\w+, PublicKeyToken=\\w+");
		nameSequence = 0;
		refMessagePackReader = typeof(MessagePackReader).MakeByRefType();
		refKvp = typeof(KeyValuePair<int, int>).MakeByRefType();
		getFormatterWithVerify = typeof(FormatterResolverExtensions).GetRuntimeMethods().First((MethodInfo x) => x.Name == "GetFormatterWithVerify");
		getResolverFromOptions = typeof(MessagePackSerializerOptions).GetRuntimeProperty("Resolver").GetMethod;
		getSerialize = (Type t) => typeof(IMessagePackFormatter<>).MakeGenericType(t).GetRuntimeMethod("Serialize", new Type[3]
		{
			typeof(MessagePackWriter).MakeByRefType(),
			t,
			typeof(MessagePackSerializerOptions)
		});
		getDeserialize = (Type t) => typeof(IMessagePackFormatter<>).MakeGenericType(t).GetRuntimeMethod("Deserialize", new Type[2]
		{
			typeof(MessagePackReader).MakeByRefType(),
			typeof(MessagePackSerializerOptions)
		});
		runtimeTypeHandleEqualityComparer = typeof(RuntimeTypeHandleEqualityComparer).GetRuntimeField("Default");
		intIntKeyValuePairConstructor = typeof(KeyValuePair<int, int>).GetTypeInfo().DeclaredConstructors.First((ConstructorInfo x) => x.GetParameters().Length == 2);
		typeMapDictionaryConstructor = typeof(Dictionary<RuntimeTypeHandle, KeyValuePair<int, int>>).GetTypeInfo().DeclaredConstructors.First(delegate(ConstructorInfo x)
		{
			ParameterInfo[] parameters = x.GetParameters();
			return parameters.Length == 2 && parameters[0].ParameterType == typeof(int);
		});
		typeMapDictionaryAdd = typeof(Dictionary<RuntimeTypeHandle, KeyValuePair<int, int>>).GetRuntimeMethod("Add", new Type[2]
		{
			typeof(RuntimeTypeHandle),
			typeof(KeyValuePair<int, int>)
		});
		typeMapDictionaryTryGetValue = typeof(Dictionary<RuntimeTypeHandle, KeyValuePair<int, int>>).GetRuntimeMethod("TryGetValue", new Type[2]
		{
			typeof(RuntimeTypeHandle),
			refKvp
		});
		keyMapDictionaryConstructor = typeof(Dictionary<int, int>).GetTypeInfo().DeclaredConstructors.First(delegate(ConstructorInfo x)
		{
			ParameterInfo[] parameters = x.GetParameters();
			return parameters.Length == 1 && parameters[0].ParameterType == typeof(int);
		});
		keyMapDictionaryAdd = typeof(Dictionary<int, int>).GetRuntimeMethod("Add", new Type[2]
		{
			typeof(int),
			typeof(int)
		});
		keyMapDictionaryTryGetValue = typeof(Dictionary<int, int>).GetRuntimeMethod("TryGetValue", new Type[2]
		{
			typeof(int),
			typeof(int).MakeByRefType()
		});
		objectGetType = typeof(object).GetRuntimeMethod("GetType", Type.EmptyTypes);
		getTypeHandle = typeof(Type).GetRuntimeProperty("TypeHandle").GetGetMethod();
		intIntKeyValuePairGetKey = typeof(KeyValuePair<int, int>).GetRuntimeProperty("Key").GetGetMethod();
		intIntKeyValuePairGetValue = typeof(KeyValuePair<int, int>).GetRuntimeProperty("Value").GetGetMethod();
		invalidOperationExceptionConstructor = typeof(InvalidOperationException).GetTypeInfo().DeclaredConstructors.First(delegate(ConstructorInfo x)
		{
			ParameterInfo[] parameters = x.GetParameters();
			return parameters.Length == 1 && parameters[0].ParameterType == typeof(string);
		});
		objectCtor = typeof(object).GetTypeInfo().DeclaredConstructors.First((ConstructorInfo x) => x.GetParameters().Length == 0);
		Instance = new DynamicUnionResolver();
		Options = new MessagePackSerializerOptions(Instance);
		DynamicAssembly = new Lazy<DynamicAssembly>(() => new DynamicAssembly("MessagePack.Resolvers.DynamicUnionResolver"));
	}

	private DynamicUnionResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}

	private static TypeInfo BuildType(Type type)
	{
		TypeInfo typeInfo = type.GetTypeInfo();
		UnionAttribute[] array = (from x in typeInfo.GetCustomAttributes<UnionAttribute>()
			orderby x.Key
			select x).ToArray();
		if (array.Length == 0)
		{
			return null;
		}
		if (!typeInfo.IsInterface && !typeInfo.IsAbstract)
		{
			throw new MessagePackDynamicUnionResolverException("Union can only be interface or abstract class. Type:" + type.Name);
		}
		HashSet<int> hashSet = new HashSet<int>();
		HashSet<Type> hashSet2 = new HashSet<Type>();
		UnionAttribute[] array2 = array;
		foreach (UnionAttribute unionAttribute in array2)
		{
			if (!hashSet.Add(unionAttribute.Key))
			{
				throw new MessagePackDynamicUnionResolverException("Same union key has found. Type:" + type.Name + " Key:" + unionAttribute.Key);
			}
			if (!hashSet2.Add(unionAttribute.SubType))
			{
				throw new MessagePackDynamicUnionResolverException("Same union subType has found. Type:" + type.Name + " SubType: " + unionAttribute.SubType);
			}
		}
		Type type2 = typeof(IMessagePackFormatter<>).MakeGenericType(type);
		using (MonoProtection.EnterRefEmitLock())
		{
			TypeBuilder typeBuilder = DynamicAssembly.Value.DefineType("MessagePack.Formatters." + SubtractFullNameRegex.Replace(type.FullName, string.Empty).Replace(".", "_") + "Formatter" + Interlocked.Increment(ref nameSequence), TypeAttributes.Public | TypeAttributes.Sealed, null, new Type[1] { type2 });
			FieldBuilder fieldBuilder = null;
			FieldBuilder fieldBuilder2 = null;
			ConstructorBuilder constructorBuilder = typeBuilder.DefineConstructor(MethodAttributes.Public, CallingConventions.Standard, Type.EmptyTypes);
			fieldBuilder = typeBuilder.DefineField("typeToKeyAndJumpMap", typeof(Dictionary<RuntimeTypeHandle, KeyValuePair<int, int>>), FieldAttributes.Private | FieldAttributes.InitOnly);
			fieldBuilder2 = typeBuilder.DefineField("keyToJumpMap", typeof(Dictionary<int, int>), FieldAttributes.Private | FieldAttributes.InitOnly);
			ILGenerator iLGenerator = constructorBuilder.GetILGenerator();
			BuildConstructor(type, array, constructorBuilder, fieldBuilder, fieldBuilder2, iLGenerator);
			MethodBuilder methodBuilder = typeBuilder.DefineMethod("Serialize", MethodAttributes.Public | MethodAttributes.Final | MethodAttributes.Virtual | MethodAttributes.HideBySig | MethodAttributes.VtableLayoutMask, null, new Type[3]
			{
				typeof(MessagePackWriter).MakeByRefType(),
				type,
				typeof(MessagePackSerializerOptions)
			});
			ILGenerator iLGenerator2 = methodBuilder.GetILGenerator();
			BuildSerialize(type, array, methodBuilder, fieldBuilder, iLGenerator2);
			MethodBuilder methodBuilder2 = typeBuilder.DefineMethod("Deserialize", MethodAttributes.Public | MethodAttributes.Final | MethodAttributes.Virtual | MethodAttributes.HideBySig | MethodAttributes.VtableLayoutMask, type, new Type[2]
			{
				refMessagePackReader,
				typeof(MessagePackSerializerOptions)
			});
			ILGenerator iLGenerator3 = methodBuilder2.GetILGenerator();
			BuildDeserialize(type, array, methodBuilder2, fieldBuilder2, iLGenerator3);
			return typeBuilder.CreateTypeInfo();
		}
	}

	private static void BuildConstructor(Type type, UnionAttribute[] infos, ConstructorInfo method, FieldBuilder typeToKeyAndJumpMap, FieldBuilder keyToJumpMap, ILGenerator il)
	{
		il.EmitLdarg(0);
		il.Emit(OpCodes.Call, objectCtor);
		il.EmitLdarg(0);
		il.EmitLdc_I4(infos.Length);
		il.Emit(OpCodes.Ldsfld, runtimeTypeHandleEqualityComparer);
		il.Emit(OpCodes.Newobj, typeMapDictionaryConstructor);
		int num = 0;
		UnionAttribute[] array = infos;
		foreach (UnionAttribute unionAttribute in array)
		{
			il.Emit(OpCodes.Dup);
			il.Emit(OpCodes.Ldtoken, unionAttribute.SubType);
			il.EmitLdc_I4(unionAttribute.Key);
			il.EmitLdc_I4(num);
			il.Emit(OpCodes.Newobj, intIntKeyValuePairConstructor);
			il.EmitCall(typeMapDictionaryAdd);
			num++;
		}
		il.Emit(OpCodes.Stfld, typeToKeyAndJumpMap);
		il.EmitLdarg(0);
		il.EmitLdc_I4(infos.Length);
		il.Emit(OpCodes.Newobj, keyMapDictionaryConstructor);
		int num2 = 0;
		array = infos;
		foreach (UnionAttribute unionAttribute2 in array)
		{
			il.Emit(OpCodes.Dup);
			il.EmitLdc_I4(unionAttribute2.Key);
			il.EmitLdc_I4(num2);
			il.EmitCall(keyMapDictionaryAdd);
			num2++;
		}
		il.Emit(OpCodes.Stfld, keyToJumpMap);
		il.Emit(OpCodes.Ret);
	}

	private static void BuildSerialize(Type type, UnionAttribute[] infos, MethodBuilder method, FieldBuilder typeToKeyAndJumpMap, ILGenerator il)
	{
		Label label = il.DefineLabel();
		Label label2 = il.DefineLabel();
		il.EmitLdarg(2);
		il.Emit(OpCodes.Brtrue_S, label);
		il.Emit(OpCodes.Br, label2);
		il.MarkLabel(label);
		LocalBuilder local = il.DeclareLocal(typeof(IFormatterResolver));
		il.EmitLdarg(3);
		il.EmitCall(getResolverFromOptions);
		il.EmitStloc(local);
		LocalBuilder local2 = il.DeclareLocal(typeof(KeyValuePair<int, int>));
		il.EmitLoadThis();
		il.EmitLdfld(typeToKeyAndJumpMap);
		il.EmitLdarg(2);
		il.EmitCall(objectGetType);
		il.EmitCall(getTypeHandle);
		il.EmitLdloca(local2);
		il.EmitCall(typeMapDictionaryTryGetValue);
		il.Emit(OpCodes.Brfalse, label2);
		il.EmitLdarg(1);
		il.EmitLdc_I4(2);
		il.EmitCall(MessagePackWriterTypeInfo.WriteArrayHeader);
		il.EmitLdarg(1);
		il.EmitLdloca(local2);
		il.EmitCall(intIntKeyValuePairGetKey);
		il.EmitCall(MessagePackWriterTypeInfo.WriteInt32);
		Label label3 = il.DefineLabel();
		var array = infos.Select((UnionAttribute x) => new
		{
			Label = il.DefineLabel(),
			Attr = x
		}).ToArray();
		il.EmitLdloca(local2);
		il.EmitCall(intIntKeyValuePairGetValue);
		il.Emit(OpCodes.Switch, array.Select(x => x.Label).ToArray());
		il.Emit(OpCodes.Br, label3);
		var array2 = array;
		foreach (var anon in array2)
		{
			il.MarkLabel(anon.Label);
			il.EmitLdloc(local);
			il.Emit(OpCodes.Call, getFormatterWithVerify.MakeGenericMethod(anon.Attr.SubType));
			il.EmitLdarg(1);
			il.EmitLdarg(2);
			if (anon.Attr.SubType.GetTypeInfo().IsValueType)
			{
				il.Emit(OpCodes.Unbox_Any, anon.Attr.SubType);
			}
			else
			{
				il.Emit(OpCodes.Castclass, anon.Attr.SubType);
			}
			il.EmitLdarg(3);
			il.Emit(OpCodes.Callvirt, getSerialize(anon.Attr.SubType));
			il.Emit(OpCodes.Br, label3);
		}
		il.MarkLabel(label3);
		il.Emit(OpCodes.Ret);
		il.MarkLabel(label2);
		il.EmitLdarg(1);
		il.EmitCall(MessagePackWriterTypeInfo.WriteNil);
		il.Emit(OpCodes.Ret);
	}

	private static void BuildDeserialize(Type type, UnionAttribute[] infos, MethodBuilder method, FieldBuilder keyToJumpMap, ILGenerator il)
	{
		Label label = il.DefineLabel();
		il.EmitLdarg(1);
		il.EmitCall(MessagePackReaderTypeInfo.TryReadNil);
		il.Emit(OpCodes.Brfalse_S, label);
		il.Emit(OpCodes.Ldnull);
		il.Emit(OpCodes.Ret);
		il.MarkLabel(label);
		LocalBuilder local = il.DeclareLocal(typeof(IFormatterResolver));
		il.EmitLdarg(2);
		il.EmitCall(getResolverFromOptions);
		il.EmitStloc(local);
		Label label2 = il.DefineLabel();
		ArgumentField argumentField = new ArgumentField(il, 1);
		argumentField.EmitLdarg();
		il.EmitCall(MessagePackReaderTypeInfo.ReadArrayHeader);
		il.EmitLdc_I4(2);
		il.Emit(OpCodes.Beq_S, label2);
		il.Emit(OpCodes.Ldstr, "Invalid Union data was detected. Type:" + type.FullName);
		il.Emit(OpCodes.Newobj, invalidOperationExceptionConstructor);
		il.Emit(OpCodes.Throw);
		il.MarkLabel(label2);
		LocalBuilder local2 = il.DeclareLocal(typeof(int));
		argumentField.EmitLdarg();
		il.EmitCall(MessagePackReaderTypeInfo.ReadInt32);
		il.EmitStloc(local2);
		if (!IsZeroStartSequential(infos))
		{
			Label label3 = il.DefineLabel();
			il.EmitLdarg(0);
			il.EmitLdfld(keyToJumpMap);
			il.EmitLdloc(local2);
			il.EmitLdloca(local2);
			il.EmitCall(keyMapDictionaryTryGetValue);
			il.Emit(OpCodes.Brtrue_S, label3);
			il.EmitLdc_I4(-1);
			il.EmitStloc(local2);
			il.MarkLabel(label3);
		}
		LocalBuilder local3 = il.DeclareLocal(type);
		Label label4 = il.DefineLabel();
		il.Emit(OpCodes.Ldnull);
		il.EmitStloc(local3);
		il.Emit(OpCodes.Ldloc, local2);
		var array = infos.Select((UnionAttribute x) => new
		{
			Label = il.DefineLabel(),
			Attr = x
		}).ToArray();
		il.Emit(OpCodes.Switch, array.Select(x => x.Label).ToArray());
		argumentField.EmitLdarg();
		il.EmitCall(MessagePackReaderTypeInfo.Skip);
		il.Emit(OpCodes.Br, label4);
		var array2 = array;
		foreach (var anon in array2)
		{
			il.MarkLabel(anon.Label);
			il.EmitLdloc(local);
			il.EmitCall(getFormatterWithVerify.MakeGenericMethod(anon.Attr.SubType));
			il.EmitLdarg(1);
			il.EmitLdarg(2);
			il.EmitCall(getDeserialize(anon.Attr.SubType));
			if (anon.Attr.SubType.GetTypeInfo().IsValueType)
			{
				il.Emit(OpCodes.Box, anon.Attr.SubType);
			}
			il.Emit(OpCodes.Stloc, local3);
			il.Emit(OpCodes.Br, label4);
		}
		il.MarkLabel(label4);
		il.Emit(OpCodes.Ldloc, local3);
		il.Emit(OpCodes.Ret);
	}

	private static bool IsZeroStartSequential(UnionAttribute[] infos)
	{
		for (int i = 0; i < infos.Length; i++)
		{
			if (infos[i].Key != i)
			{
				return false;
			}
		}
		return true;
	}
}
