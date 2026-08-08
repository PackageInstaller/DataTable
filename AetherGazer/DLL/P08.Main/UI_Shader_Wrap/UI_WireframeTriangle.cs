using UnityEngine;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class UI_WireframeTriangle : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _RandomFaceColor = Shader.PropertyToID("_RandomFaceColor");

		public static readonly int _TriangleScale = Shader.PropertyToID("_TriangleScale");

		public static readonly int _VertexOffset = Shader.PropertyToID("_VertexOffset");

		public static readonly int _VertexOffsetSpeed = Shader.PropertyToID("_VertexOffsetSpeed");

		public static readonly int _FaceColor = Shader.PropertyToID("_FaceColor");

		public static readonly int _WireColor = Shader.PropertyToID("_WireColor");

		public static readonly int _Thickness = Shader.PropertyToID("_Thickness");

		public static readonly int _Smoothness = Shader.PropertyToID("_Smoothness");

		public static readonly int _NoiseScale = Shader.PropertyToID("_NoiseScale");

		public static readonly int _NoiseSpeed = Shader.PropertyToID("_NoiseSpeed");
	}

	[Range(0f, 1f)]
	public float _RandomFaceColor = 1f;

	public float _TriangleScale;

	[Range(0f, 1f)]
	public float _VertexOffset = 1f;

	[Range(0f, 10f)]
	public float _VertexOffsetSpeed = 1f;

	public Color _FaceColor = Color.white;

	public Color _WireColor = Color.white;

	[Range(0f, 100f)]
	public float _Thickness = 1f;

	[Range(0f, 10f)]
	public float _Smoothness = 0.2f;

	[Range(0f, 1f)]
	public float _NoiseScale;

	[Range(0f, 200f)]
	public float _NoiseSpeed = 1f;

	private Material _material;

	private Graphic m_Graphic;

	public Graphic graphic => m_Graphic ?? (m_Graphic = GetComponent<Graphic>());

	private void OnEnable()
	{
		if ((bool)graphic)
		{
			graphic.SetMaterialDirty();
		}
	}

	private void OnDisable()
	{
		if ((bool)graphic)
		{
			graphic.SetMaterialDirty();
		}
	}

	public Material GetModifiedMaterial(Material baseMaterial)
	{
		if (!base.enabled)
		{
			return baseMaterial;
		}
		if (_material == null || _material.shader != baseMaterial.shader)
		{
			_material = new Material(baseMaterial);
			_material.CopyPropertiesFromMaterial(baseMaterial);
		}
		return _material;
	}

	private void LateUpdate()
	{
		UpdateMaterial();
	}

	internal void UpdateMaterial()
	{
		if (!(_material == null))
		{
			_material.SetFloat(ShaderID._RandomFaceColor, _RandomFaceColor);
			_material.SetFloat(ShaderID._TriangleScale, _TriangleScale);
			_material.SetFloat(ShaderID._VertexOffset, _VertexOffset);
			_material.SetFloat(ShaderID._VertexOffsetSpeed, _VertexOffsetSpeed);
			_material.SetColor(ShaderID._FaceColor, _FaceColor);
			_material.SetColor(ShaderID._WireColor, _WireColor);
			_material.SetFloat(ShaderID._Thickness, _Thickness);
			_material.SetFloat(ShaderID._Smoothness, _Smoothness);
			_material.SetFloat(ShaderID._NoiseScale, _NoiseScale);
			_material.SetFloat(ShaderID._NoiseSpeed, _NoiseSpeed);
		}
	}
}
