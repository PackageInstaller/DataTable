using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class NiuQuGlitch : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");

		public static readonly int _NoiseStrength = Shader.PropertyToID("_NoiseStrength");

		public static readonly int _NoiseSeed = Shader.PropertyToID("_NoiseSeed");

		public static readonly int _Segment = Shader.PropertyToID("_Segment");
	}

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Color _Color = Color.white;

	public float _ColorMask = 15f;

	public float _UseUIAlphaClip;

	[Range(0f, 1f)]
	public float _NoiseStrength;

	[Range(0f, 1f)]
	public float _NoiseSeed;

	public float _Segment = 50f;

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
			_material.SetVector(ShaderID._MainTex_ST, _MainTex_ST);
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetFloat(ShaderID._ColorMask, _ColorMask);
			_material.SetFloat(ShaderID._UseUIAlphaClip, _UseUIAlphaClip);
			_material.SetFloat(ShaderID._NoiseStrength, _NoiseStrength);
			_material.SetFloat(ShaderID._NoiseSeed, _NoiseSeed);
			_material.SetFloat(ShaderID._Segment, _Segment);
			Image image = graphic as Image;
			if (image != null)
			{
				Vector4 value = (image.overrideSprite ? DataUtility.GetOuterUV(image.overrideSprite) : new Vector4(0f, 0f, 1f, 1f));
				value.z -= value.x;
				value.w -= value.y;
				_material.SetVector(ShaderID._SpriteParams, value);
			}
		}
	}
}
