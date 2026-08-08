using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class WaterFloaterManager : MonoBehaviour
{
	private static class ShaderIds
	{
		internal static readonly int WaveSpeed = Shader.PropertyToID("_WaveSpeed");

		internal static readonly int WaveHeight = Shader.PropertyToID("_WaveHeight");

		internal static readonly int WaveSteepness = Shader.PropertyToID("_WaveSteepness");

		internal static readonly int WaveCount = Shader.PropertyToID("_WaveCount");

		internal static readonly int WaveDirection = Shader.PropertyToID("_WaveDirection");

		internal static readonly int WaveNormalStr = Shader.PropertyToID("_WaveNormalStr");

		internal static readonly int WaveDistance = Shader.PropertyToID("_WaveDistance");
	}

	[NonSerialized]
	public float WaveSpeed;

	[NonSerialized]
	public float WaveHeight;

	[NonSerialized]
	public float WaveSteepness;

	[NonSerialized]
	public float WaveCount;

	[NonSerialized]
	public Vector4 WaveDirection;

	[NonSerialized]
	public float WaveNormalStr;

	[NonSerialized]
	public float WaveDistance;

	private bool _inited;

	private Renderer _renderer;

	private List<Material> _materials;

	private void GetRenderer()
	{
		if (_inited)
		{
			return;
		}
		_inited = true;
		Renderer component = GetComponent<Renderer>();
		if (!(component != null))
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < component.sharedMaterials.Length; i++)
		{
			if (component.sharedMaterials[i] == null)
			{
				Debug.LogError(base.gameObject.name + "'s " + component.name + " is missing some material");
			}
			else
			{
				flag = flag || isWaterShader(component.sharedMaterials[i].shader);
			}
		}
		if (flag)
		{
			_renderer = component;
		}
	}

	public List<Material> GetMaterials(Renderer renderer)
	{
		if (_materials == null)
		{
			_materials = new List<Material>();
		}
		_materials.Clear();
		if (!Application.isPlaying)
		{
			renderer.GetSharedMaterials(_materials);
		}
		else
		{
			renderer.GetMaterials(_materials);
		}
		return _materials;
	}

	private void ReadMaterials()
	{
		List<Material> materials = GetMaterials(_renderer);
		if (materials.Count > 0)
		{
			Material material = materials[0];
			WaveSpeed = material.GetFloat(ShaderIds.WaveSpeed);
			WaveHeight = material.GetFloat(ShaderIds.WaveHeight);
			WaveSteepness = material.GetFloat(ShaderIds.WaveSteepness);
			WaveCount = material.GetFloat(ShaderIds.WaveCount);
			WaveDirection = material.GetVector(ShaderIds.WaveDirection);
			WaveNormalStr = material.GetFloat(ShaderIds.WaveNormalStr);
			WaveDistance = material.GetFloat(ShaderIds.WaveDistance);
		}
	}

	private static bool isWaterShader(Shader shader)
	{
		if (shader == null || !shader.name.Contains("Water"))
		{
			return false;
		}
		return true;
	}

	private void Start()
	{
		GetRenderer();
	}

	private void Update()
	{
		ReadMaterials();
	}
}
