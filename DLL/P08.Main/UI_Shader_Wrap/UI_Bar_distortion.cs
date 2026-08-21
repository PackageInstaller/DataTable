using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class UI_Bar_distortion : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _Debug = Shader.PropertyToID("_Debug");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _BoundRange = Shader.PropertyToID("_BoundRange");

		public static readonly int _BoundSoft = Shader.PropertyToID("_BoundSoft");

		public static readonly int _DistortFactor = Shader.PropertyToID("_DistortFactor");

		public static readonly int _MaskVerticalPosition = Shader.PropertyToID("_MaskVerticalPosition");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");
	}

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _Debug;

	public Color _Color = Color.white;

	[Range(0f, 1f)]
	public float _BoundRange = 0.13f;

	[Range(0.002f, 100f)]
	public float _BoundSoft = 38.6f;

	[Range(0f, 0.2f)]
	public float _DistortFactor = 0.2f;

	public float _MaskVerticalPosition = 0.58f;

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
			_material.SetFloat(ShaderID._Debug, _Debug);
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetFloat(ShaderID._BoundRange, _BoundRange);
			_material.SetFloat(ShaderID._BoundSoft, _BoundSoft);
			_material.SetFloat(ShaderID._DistortFactor, _DistortFactor);
			_material.SetFloat(ShaderID._MaskVerticalPosition, _MaskVerticalPosition);
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
