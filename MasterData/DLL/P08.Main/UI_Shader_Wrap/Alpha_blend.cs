using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class Alpha_blend : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _Brightness = Shader.PropertyToID("_Brightness");

		public static readonly int _Contrast = Shader.PropertyToID("_Contrast");

		public static readonly int _MainColor = Shader.PropertyToID("_MainColor");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _MainAlpha_ST = Shader.PropertyToID("_MainAlpha_ST");

		public static readonly int _MainPannerX = Shader.PropertyToID("_MainPannerX");

		public static readonly int _MainPannerY = Shader.PropertyToID("_MainPannerY");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");
	}

	public float _Brightness = 1f;

	public float _Contrast = 1f;

	public Color _MainColor = Color.white;

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Vector4 _MainAlpha_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _MainPannerX;

	public float _MainPannerY;

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
			_material.SetVector(ShaderID._MainAlpha_ST, _MainAlpha_ST);
			_material.SetFloat(ShaderID._MainPannerX, _MainPannerX);
			_material.SetFloat(ShaderID._MainPannerY, _MainPannerY);
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
