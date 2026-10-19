using System;

namespace Google.Protobuf.Reflection;

public sealed class GeneratedClrTypeInfo
{
	private static readonly string[] EmptyNames = new string[0];

	private static readonly GeneratedClrTypeInfo[] EmptyCodeInfo = new GeneratedClrTypeInfo[0];

	private static readonly Extension[] EmptyExtensions = new Extension[0];

	public Type ClrType { get; private set; }

	public MessageParser Parser { get; }

	public string[] PropertyNames { get; }

	public Extension[] Extensions { get; }

	public string[] OneofNames { get; }

	public GeneratedClrTypeInfo[] NestedTypes { get; }

	public Type[] NestedEnums { get; }

	public GeneratedClrTypeInfo(Type clrType, MessageParser parser, string[] propertyNames, string[] oneofNames, Type[] nestedEnums, Extension[] extensions, GeneratedClrTypeInfo[] nestedTypes)
	{
		NestedTypes = nestedTypes ?? EmptyCodeInfo;
		NestedEnums = nestedEnums ?? ReflectionUtil.EmptyTypes;
		ClrType = clrType;
		Extensions = extensions ?? EmptyExtensions;
		Parser = parser;
		PropertyNames = propertyNames ?? EmptyNames;
		OneofNames = oneofNames ?? EmptyNames;
	}

	public GeneratedClrTypeInfo(Type clrType, MessageParser parser, string[] propertyNames, string[] oneofNames, Type[] nestedEnums, GeneratedClrTypeInfo[] nestedTypes)
		: this(clrType, parser, propertyNames, oneofNames, nestedEnums, null, nestedTypes)
	{
	}

	public GeneratedClrTypeInfo(Type[] nestedEnums, Extension[] extensions, GeneratedClrTypeInfo[] nestedTypes)
		: this(null, null, null, null, nestedEnums, extensions, nestedTypes)
	{
	}

	public GeneratedClrTypeInfo(Type[] nestedEnums, GeneratedClrTypeInfo[] nestedTypes)
		: this(null, null, null, null, nestedEnums, nestedTypes)
	{
	}
}
