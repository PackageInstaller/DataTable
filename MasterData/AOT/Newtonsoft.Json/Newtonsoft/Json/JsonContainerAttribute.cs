using System;
using Newtonsoft.Json.Serialization;

namespace Newtonsoft.Json;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, AllowMultiple = false)]
public abstract class JsonContainerAttribute : Attribute
{
	internal bool? _isReference;

	internal bool? _itemIsReference;

	internal ReferenceLoopHandling? _itemReferenceLoopHandling;

	internal TypeNameHandling? _itemTypeNameHandling;

	private Type? _namingStrategyType;

	private object[]? _namingStrategyParameters;

	public string? Id { set; }

	public Type? ItemConverterType { get; }

	public object[]? ItemConverterParameters { get; }

	public Type? NamingStrategyType => _namingStrategyType;

	public object[]? NamingStrategyParameters => _namingStrategyParameters;

	internal NamingStrategy? NamingStrategyInstance { get; set; }

	protected JsonContainerAttribute()
	{
	}

	protected JsonContainerAttribute(string id)
	{
		Id = id;
	}
}
