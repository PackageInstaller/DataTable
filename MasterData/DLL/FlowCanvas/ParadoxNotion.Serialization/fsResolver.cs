using System;
using System.Collections.Generic;
using Cinemachine;
using Config;
using MessagePack;
using MessagePack.Formatters;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using UnityEngine;
using UnityEngine.UI;

namespace ParadoxNotion.Serialization;

public sealed class fsResolver : IFormatterResolver
{
	public static readonly fsResolver Instance = new fsResolver();

	private Dictionary<Type, object> FormatterMap = new Dictionary<Type, object>
	{
		{
			typeof(GraphSerializationData),
			new fsGraphFormatter()
		},
		{
			typeof(Int),
			new IntFormatter()
		},
		{
			typeof(Int?),
			new StaticNullableFormatter<Int>(new IntFormatter())
		},
		{
			typeof(SimVar),
			new SimVarFormatter()
		},
		{
			typeof(Int3),
			new Int3Formatter()
		},
		{
			typeof(GameObject),
			new UnityGameObjectFormatter()
		},
		{
			typeof(UnityEngine.Object),
			new UnityObjectFormatter()
		},
		{
			typeof(Image),
			new UnityObjectFormatter()
		},
		{
			typeof(Text),
			new UnityObjectFormatter()
		},
		{
			typeof(CinemachineBlendDefinition),
			new CinemachineBlendDefinitionFormatter()
		},
		{
			typeof(BlackboardSource),
			new fsBlackboardFormatter()
		},
		{
			typeof(List<Int3>),
			new ListFormatter<Int3>()
		},
		{
			typeof(List<RoleType>),
			new ListFormatter<RoleType>()
		},
		{
			typeof(List<BuffClass>),
			new ListFormatter<BuffClass>()
		},
		{
			typeof(List<AbilityDetailClass>),
			new ListFormatter<AbilityDetailClass>()
		},
		{
			typeof(List<GameObject>),
			new ListFormatter<GameObject>()
		},
		{
			typeof(Dictionary<int, int>),
			new DictionaryFormatter<int, int>()
		},
		{
			typeof(Dictionary<int, string>),
			new DictionaryFormatter<int, string>()
		},
		{
			typeof(Dictionary<int, Vector3>),
			new DictionaryFormatter<int, Vector3>()
		},
		{
			typeof(Dictionary<int, List<GameObject>>),
			new DictionaryFormatter<int, List<GameObject>>()
		},
		{
			typeof(BBParameter<List<int>>),
			new BBParameterFormatter<List<int>>()
		},
		{
			typeof(BBParameter<List<float>>),
			new BBParameterFormatter<List<float>>()
		},
		{
			typeof(BBParameter<List<string>>),
			new BBParameterFormatter<List<string>>()
		},
		{
			typeof(BBParameter<Dictionary<int, int>>),
			new BBParameterFormatter<Dictionary<int, int>>()
		},
		{
			typeof(BBParameter<Dictionary<int, string>>),
			new BBParameterFormatter<Dictionary<int, string>>()
		},
		{
			typeof(BBParameter<Dictionary<int, Vector3>>),
			new BBParameterFormatter<Dictionary<int, Vector3>>()
		},
		{
			typeof(BBParameter<Dictionary<int, List<GameObject>>>),
			new BBParameterFormatter<Dictionary<int, List<GameObject>>>()
		},
		{
			typeof(BBParameter<int>),
			new BBParameterFormatter<int>()
		},
		{
			typeof(BBParameter<float>),
			new BBParameterFormatter<float>()
		},
		{
			typeof(BBParameter<bool>),
			new BBParameterFormatter<bool>()
		},
		{
			typeof(BBParameter<string>),
			new BBParameterFormatter<string>()
		},
		{
			typeof(BBParameter<Int3>),
			new BBParameterFormatter<Int3>()
		},
		{
			typeof(BBParameter<List<Int3>>),
			new BBParameterFormatter<List<Int3>>()
		},
		{
			typeof(BBParameter<AttributeName>),
			new BBParameterFormatter<AttributeName>()
		},
		{
			typeof(BBParameter<BuffClass>),
			new BBParameterFormatter<BuffClass>()
		},
		{
			typeof(BBParameter<RoleType>),
			new BBParameterFormatter<RoleType>()
		},
		{
			typeof(BBParameter<E_SpawnType>),
			new BBParameterFormatter<E_SpawnType>()
		},
		{
			typeof(BBParameter<E_HitRecover>),
			new BBParameterFormatter<E_HitRecover>()
		},
		{
			typeof(BBParameter<E_HitRecoverStatus>),
			new BBParameterFormatter<E_HitRecoverStatus>()
		},
		{
			typeof(BBParameter<EntityVarName>),
			new BBParameterFormatter<EntityVarName>()
		},
		{
			typeof(BBParameter<UnityEngine.Object>),
			new BBParameterFormatter<UnityEngine.Object>()
		},
		{
			typeof(BBParameter<Vector3>),
			new BBParameterFormatter<Vector3>()
		},
		{
			typeof(BBParameter<GameObject>),
			new BBParameterFormatter<GameObject>()
		},
		{
			typeof(BBParameter<Image>),
			new BBParameterFormatter<Image>()
		},
		{
			typeof(BBParameter<Text>),
			new BBParameterFormatter<Text>()
		},
		{
			typeof(BBParameter<CinemachineBlendDefinition>),
			new BBParameterFormatter<CinemachineBlendDefinition>()
		},
		{
			typeof(BBParameter<KeyCode>),
			new BBParameterFormatter<KeyCode>()
		},
		{
			typeof(BBParameter<List<bool>>),
			new BBParameterFormatter<List<bool>>()
		},
		{
			typeof(BBParameter<DeathTimeType>),
			new BBParameterFormatter<DeathTimeType>()
		},
		{
			typeof(BBParameter<List<GameObject>>),
			new BBParameterFormatter<List<GameObject>>()
		}
	};

	internal object GetFormatter(Type t)
	{
		if (FormatterMap.TryGetValue(t, out var value))
		{
			return value;
		}
		Debug.LogError(t.FullName + " fromatter is not found!!");
		return null;
	}

	private fsResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		try
		{
			if (typeof(T).IsEnum)
			{
				return new GenericEnumFormatter<T>();
			}
			return (IMessagePackFormatter<T>)GetFormatter(typeof(T));
		}
		catch (Exception ex)
		{
			Debug.LogError(typeof(T).FullName + " : " + ex.Message);
			throw;
		}
	}
}
