using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class Fresnel : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _Brightness = Shader.PropertyToID("_Brightness");

		public static readonly int _Contrast = Shader.PropertyToID("_Contrast");

		public static readonly int _MainColor = Shader.PropertyToID("_MainColor");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _MaskTex_ST = Shader.PropertyToID("_MaskTex_ST");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _EmissiveIntensity = Shader.PropertyToID("_EmissiveIntensity");

		public static readonly int _FresnelStrength = Shader.PropertyToID("_FresnelStrength");

		public static readonly int _InvertFresnel = Shader.PropertyToID("_InvertFresnel");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");
	}

	public float _Brightness;

	public float _Contrast = 1f;

	public Color _MainColor = Color.white;

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Vector4 _MaskTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Color _Color = Color.white;

	[Range(0f, 5f)]
	public float _EmissiveIntensity = 0.5f;

	[Range(0f, 10f)]
	public float _FresnelStrength = 0.5f;

	public float _InvertFresnel;

	public float _ColorMask = 15f;

	public float _UseUIAlphaClip;

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
			_material.SetFloat(ShaderID._Brightness, _Brightness);
			_material.SetFloat(ShaderID._Contrast, _Contrast);
			_material.SetColor(ShaderID._MainColor, _MainColor);
			_material.SetVector(ShaderID._MainTex_ST, _MainTex_ST);
			_material.SetVector(ShaderID._MaskTex_ST, _MaskTex_ST);
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetFloat(ShaderID._EmissiveIntensity, _EmissiveIntensity);
			_material.SetFloat(ShaderID._FresnelStrength, _FresnelStrength);
			_material.SetFloat(ShaderID._InvertFresnel, _InvertFresnel);
			_material.SetFloat(ShaderID._ColorMask, _ColorMask);
			_material.SetFloat(ShaderID._UseUIAlphaClip, _UseUIAlphaClip);
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
