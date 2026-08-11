using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class GoldBodyShaderColorData : GoldBodyShaderDataBase
{
	private Color _value;

	public static GoldBodyShaderColorData Create(Material material, string name, Color value)
	{
		GoldBodyShaderColorData goldBodyShaderColorData = ReferencePool.Acquire<GoldBodyShaderColorData>();
		goldBodyShaderColorData._material = material;
		goldBodyShaderColorData._name = name;
		goldBodyShaderColorData._value = value;
		return goldBodyShaderColorData;
	}

	public static GoldBodyShaderColorData CreateOri(Material material, string name)
	{
		GoldBodyShaderColorData goldBodyShaderColorData = ReferencePool.Acquire<GoldBodyShaderColorData>();
		goldBodyShaderColorData._material = material;
		goldBodyShaderColorData._name = name;
		goldBodyShaderColorData._value = material.GetColor(name);
		return goldBodyShaderColorData;
	}

	public Color GetValue()
	{
		return _value;
	}

	public override string ToString()
	{
		return $"材质球 :{_material.name},颜色参数:{_name}, 颜色值:({_value.r},{_value.g},{_value.b},{_value.a})";
	}

	public override void ApplyValue()
	{
		_material.SetColor(_name, _value);
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public override void Clear()
	{
		_material = null;
		_name = string.Empty;
		_value = default(Color);
	}
}
