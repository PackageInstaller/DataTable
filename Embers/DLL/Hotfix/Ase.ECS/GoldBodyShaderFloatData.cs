using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class GoldBodyShaderFloatData : GoldBodyShaderDataBase
{
	private float _value;

	public static GoldBodyShaderFloatData Create(Material material, string name, float value)
	{
		GoldBodyShaderFloatData goldBodyShaderFloatData = ReferencePool.Acquire<GoldBodyShaderFloatData>();
		goldBodyShaderFloatData._material = material;
		goldBodyShaderFloatData._name = name;
		goldBodyShaderFloatData._value = value;
		return goldBodyShaderFloatData;
	}

	public static GoldBodyShaderFloatData CreateOri(Material material, string name)
	{
		GoldBodyShaderFloatData goldBodyShaderFloatData = ReferencePool.Acquire<GoldBodyShaderFloatData>();
		goldBodyShaderFloatData._material = material;
		goldBodyShaderFloatData._name = name;
		goldBodyShaderFloatData._value = material.GetFloat(name);
		return goldBodyShaderFloatData;
	}

	public float GetValue()
	{
		return _value;
	}

	public override void ApplyValue()
	{
		_material.SetFloat(_name, _value);
	}

	public override string ToString()
	{
		return $"材质球 :{_material.name},浮点数参数:{_name}, 浮点数值:({_value})";
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public override void Clear()
	{
		_material = null;
		_name = string.Empty;
		_value = 0f;
	}
}
