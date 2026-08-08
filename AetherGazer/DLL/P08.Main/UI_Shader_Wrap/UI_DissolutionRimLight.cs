using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class UI_DissolutionRimLight : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _MaskTex_ST = Shader.PropertyToID("_MaskTex_ST");

		public static readonly int _MaskTex2_ST = Shader.PropertyToID("_MaskTex2_ST");

		public static readonly int _OneMinus = Shader.PropertyToID("_OneMinus");

		public static readonly int _Dissolution = Shader.PropertyToID("_Dissolution");

		public static readonly int _DissolutionSmooth = Shader.PropertyToID("_DissolutionSmooth");

		public static readonly int _DissolutionSmooth2 = Shader.PropertyToID("_DissolutionSmooth2");

		public static readonly int _DissolutionColor = Shader.PropertyToID("_DissolutionColor");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");
	}

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Color _Color = Color.white;

	public Vector4 _MaskTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Vector4 _MaskTex2_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _OneMinus;

	[Range(-2f, 2f)]
	public float _Dissolution = 1f;

	[Range(0.001f, 10f)]
	public float _DissolutionSmooth = 1f;

	[Range(0.001f, 10f)]
	public float _DissolutionSmooth2 = 1f;

	[ColorUsage(true, true)]
	public Color _DissolutionColor = Color.white;

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
			_material.SetVector(ShaderID._MainTex_ST, _MainTex_ST);
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetVector(ShaderID._MaskTex_ST, _MaskTex_ST);
			_material.SetVector(ShaderID._MaskTex2_ST, _MaskTex2_ST);
			_material.SetFloat(ShaderID._OneMinus, _OneMinus);
			_material.SetFloat(ShaderID._Dissolution, _Dissolution);
			_material.SetFloat(ShaderID._DissolutionSmooth, _DissolutionSmooth);
			_material.SetFloat(ShaderID._DissolutionSmooth2, _DissolutionSmooth2);
			_material.SetColor(ShaderID._DissolutionColor, _DissolutionColor);
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
