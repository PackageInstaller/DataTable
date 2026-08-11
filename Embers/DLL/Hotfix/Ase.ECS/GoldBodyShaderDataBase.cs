using System;
using System.Collections.Generic;
using System.Reflection;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public abstract class GoldBodyShaderDataBase : IReference
{
	private static readonly Dictionary<string, Type> AllShaderDataTypes = new Dictionary<string, Type>
	{
		{
			"_GoldLightColor",
			typeof(GoldBodyShaderColorData)
		},
		{
			"_GoldOrEdge",
			typeof(GoldBodyShaderFloatData)
		},
		{
			"_GoldLightSize",
			typeof(GoldBodyShaderFloatData)
		}
	};

	protected Material _material;

	protected string _name;

	public Material Material => _material;

	public string Name => _name;

	public static List<GoldBodyShaderDataBase> CreateOriginalDatas(Material material)
	{
		List<GoldBodyShaderDataBase> list = new List<GoldBodyShaderDataBase>();
		foreach (KeyValuePair<string, Type> allShaderDataType in AllShaderDataTypes)
		{
			GoldBodyShaderDataBase goldBodyShaderDataBase = CreateOri(allShaderDataType.Key, new object[2] { material, allShaderDataType.Key });
			if (goldBodyShaderDataBase != null)
			{
				list.Add(goldBodyShaderDataBase);
			}
		}
		return list;
	}

	public static GoldBodyShaderDataBase Create(string name, object[] constructorArgs)
	{
		if (constructorArgs == null || constructorArgs.Length == 0)
		{
			throw new ArgumentException("参数不对");
		}
		AllShaderDataTypes.TryGetValue(name, out var value);
		if (value == null)
		{
			return null;
		}
		return CreateGoldBodyShaderDataClass<GoldBodyShaderDataBase>(value, "Create", constructorArgs);
	}

	private static GoldBodyShaderDataBase CreateOri(string name, object[] constructorArgs)
	{
		if (constructorArgs == null || constructorArgs.Length == 0)
		{
			throw new ArgumentException("参数不对");
		}
		AllShaderDataTypes.TryGetValue(name, out var value);
		if (value == null)
		{
			return null;
		}
		return CreateGoldBodyShaderDataClass<GoldBodyShaderDataBase>(value, "CreateOri", constructorArgs);
	}

	private static T CreateGoldBodyShaderDataClass<T>(Type type, string methodName, object[] constructorArgs)
	{
		MethodInfo method = type.GetMethod(methodName, BindingFlags.Static | BindingFlags.Public);
		if (method == null)
		{
			throw new ArgumentException($"not find static method 'Create' in class {type}.");
		}
		if (method.GetParameters().Length != constructorArgs.Length)
		{
			throw new ArgumentException($"Parameters list length doesn't match. {type}");
		}
		return (T)method.Invoke(null, constructorArgs);
	}

	public abstract void ApplyValue();

	public abstract void OnDispose();

	public virtual void Clear()
	{
	}
}
