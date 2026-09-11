using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class Tong_jichu_AB_2_Mask : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _MainTex_IsSingleChannel = Shader.PropertyToID("_MainTex_IsSingleChannel");

		public static readonly int _MainTex_IsPolarCoordinates = Shader.PropertyToID("_MainTex_IsPolarCoordinates");

		public static readonly int _World_Mask_Offset = Shader.PropertyToID("_World_Mask_Offset");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _MainTex_U = Shader.PropertyToID("_MainTex_U");

		public static readonly int _MainTex_U_X = Shader.PropertyToID("_MainTex_U_X");

		public static readonly int _MainTex_V = Shader.PropertyToID("_MainTex_V");

		public static readonly int _MainTex_V_Y = Shader.PropertyToID("_MainTex_V_Y");

		public static readonly int _MainTex_Ang = Shader.PropertyToID("_MainTex_Ang");

		public static readonly int _MainTex_Offset_ST = Shader.PropertyToID("_MainTex_Offset_ST");

		public static readonly int _MainTex_Offset_Speed = Shader.PropertyToID("_MainTex_Offset_Speed");

		public static readonly int _MainTex_Offset_Adjust = Shader.PropertyToID("_MainTex_Offset_Adjust");

		public static readonly int _MainTex_OffsetAsMainTexUV = Shader.PropertyToID("_MainTex_OffsetAsMainTexUV");

		public static readonly int _MainTex_Mask_IsSingleChannel = Shader.PropertyToID("_MainTex_Mask_IsSingleChannel");

		public static readonly int _MainTex_Mask_ST = Shader.PropertyToID("_MainTex_Mask_ST");

		public static readonly int _World_Mask = Shader.PropertyToID("_World_Mask");

		public static readonly int _World_Mask_View = Shader.PropertyToID("_World_Mask_View");

		public static readonly int _MainTex_Mask_U = Shader.PropertyToID("_MainTex_Mask_U");

		public static readonly int _MainTex_Mask_U_Z = Shader.PropertyToID("_MainTex_Mask_U_Z");

		public static readonly int _MainTex_Mask_V = Shader.PropertyToID("_MainTex_Mask_V");

		public static readonly int _MainTex_Mask_V_W = Shader.PropertyToID("_MainTex_Mask_V_W");

		public static readonly int _MainTex_Mssk_Ang = Shader.PropertyToID("_MainTex_Mssk_Ang");

		public static readonly int _MainTex_Mask_2_IsSingleChannel = Shader.PropertyToID("_MainTex_Mask_2_IsSingleChannel");

		public static readonly int _MainTex_Mask_2_ST = Shader.PropertyToID("_MainTex_Mask_2_ST");

		public static readonly int _World_Mask_2 = Shader.PropertyToID("_World_Mask_2");

		public static readonly int _World_Mask_View_2 = Shader.PropertyToID("_World_Mask_View_2");

		public static readonly int _MainTex_Mask_2_U = Shader.PropertyToID("_MainTex_Mask_2_U");

		public static readonly int _MainTex_Mask_2_U_X2 = Shader.PropertyToID("_MainTex_Mask_2_U_X2");

		public static readonly int _MainTex_Mask_2_V = Shader.PropertyToID("_MainTex_Mask_2_V");

		public static readonly int _MainTex_Mask_2_V_Y2 = Shader.PropertyToID("_MainTex_Mask_2_V_Y2");

		public static readonly int _MainTex_Mask_2_Ang = Shader.PropertyToID("_MainTex_Mask_2_Ang");

		public static readonly int _MainTex_UVadd_IsSingleChannel = Shader.PropertyToID("_MainTex_UVadd_IsSingleChannel");

		public static readonly int _MainTex_UVadd_ST = Shader.PropertyToID("_MainTex_UVadd_ST");

		public static readonly int _World_Mask_3 = Shader.PropertyToID("_World_Mask_3");

		public static readonly int _World_Mask_View_3 = Shader.PropertyToID("_World_Mask_View_3");

		public static readonly int _MainTex_UVadd_Intensity = Shader.PropertyToID("_MainTex_UVadd_Intensity");

		public static readonly int _MainTex_UVadd_Intensity_Y2 = Shader.PropertyToID("_MainTex_UVadd_Intensity_Y2");

		public static readonly int _MainTex_UVadd_U = Shader.PropertyToID("_MainTex_UVadd_U");

		public static readonly int _MainTex_UVadd_U_Z2 = Shader.PropertyToID("_MainTex_UVadd_U_Z2");

		public static readonly int _MainTex_UVadd_V = Shader.PropertyToID("_MainTex_UVadd_V");

		public static readonly int _MainTex_UVadd_V_W2 = Shader.PropertyToID("_MainTex_UVadd_V_W2");

		public static readonly int _MainTex_UVadd_Ang = Shader.PropertyToID("_MainTex_UVadd_Ang");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");
	}

	[ColorUsage(true, true)]
	public Color _Color = Color.white;

	public float _MainTex_IsSingleChannel;

	public float _MainTex_IsPolarCoordinates;

	public float _World_Mask_Offset;

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _MainTex_U;

	public float _MainTex_U_X;

	public float _MainTex_V;

	public float _MainTex_V_Y;

	[Range(0f, 360f)]
	public float _MainTex_Ang;

	public Vector4 _MainTex_Offset_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _MainTex_Offset_Speed;

	public float _MainTex_Offset_Adjust;

	public float _MainTex_OffsetAsMainTexUV;

	public float _MainTex_Mask_IsSingleChannel;

	public Vector4 _MainTex_Mask_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _World_Mask;

	public float _World_Mask_View;

	public float _MainTex_Mask_U;

	public float _MainTex_Mask_U_Z;

	public float _MainTex_Mask_V;

	public float _MainTex_Mask_V_W;

	[Range(0f, 360f)]
	public float _MainTex_Mssk_Ang;

	public float _MainTex_Mask_2_IsSingleChannel;

	public Vector4 _MainTex_Mask_2_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _World_Mask_2;

	public float _World_Mask_View_2;

	public float _MainTex_Mask_2_U;

	public float _MainTex_Mask_2_U_X2;

	public float _MainTex_Mask_2_V;

	public float _MainTex_Mask_2_V_Y2;

	[Range(0f, 360f)]
	public float _MainTex_Mask_2_Ang;

	public float _MainTex_UVadd_IsSingleChannel;

	public Vector4 _MainTex_UVadd_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _World_Mask_3;

	public float _World_Mask_View_3;

	public float _MainTex_UVadd_Intensity;

	public float _MainTex_UVadd_Intensity_Y2;

	public float _MainTex_UVadd_U;

	public float _MainTex_UVadd_U_Z2;

	public float _MainTex_UVadd_V;

	public float _MainTex_UVadd_V_W2;

	[Range(0f, 360f)]
	public float _MainTex_UVadd_Ang;

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
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetFloat(ShaderID._MainTex_IsSingleChannel, _MainTex_IsSingleChannel);
			_material.SetFloat(ShaderID._MainTex_IsPolarCoordinates, _MainTex_IsPolarCoordinates);
			_material.SetFloat(ShaderID._World_Mask_Offset, _World_Mask_Offset);
			_material.SetVector(ShaderID._MainTex_ST, _MainTex_ST);
			_material.SetFloat(ShaderID._MainTex_U, _MainTex_U);
			_material.SetFloat(ShaderID._MainTex_U_X, _MainTex_U_X);
			_material.SetFloat(ShaderID._MainTex_V, _MainTex_V);
			_material.SetFloat(ShaderID._MainTex_V_Y, _MainTex_V_Y);
			_material.SetFloat(ShaderID._MainTex_Ang, _MainTex_Ang);
			_material.SetVector(ShaderID._MainTex_Offset_ST, _MainTex_Offset_ST);
			_material.SetFloat(ShaderID._MainTex_Offset_Speed, _MainTex_Offset_Speed);
			_material.SetFloat(ShaderID._MainTex_Offset_Adjust, _MainTex_Offset_Adjust);
			_material.SetFloat(ShaderID._MainTex_OffsetAsMainTexUV, _MainTex_OffsetAsMainTexUV);
			_material.SetFloat(ShaderID._MainTex_Mask_IsSingleChannel, _MainTex_Mask_IsSingleChannel);
			_material.SetVector(ShaderID._MainTex_Mask_ST, _MainTex_Mask_ST);
			_material.SetFloat(ShaderID._World_Mask, _World_Mask);
			_material.SetFloat(ShaderID._World_Mask_View, _World_Mask_View);
			_material.SetFloat(ShaderID._MainTex_Mask_U, _MainTex_Mask_U);
			_material.SetFloat(ShaderID._MainTex_Mask_U_Z, _MainTex_Mask_U_Z);
			_material.SetFloat(ShaderID._MainTex_Mask_V, _MainTex_Mask_V);
			_material.SetFloat(ShaderID._MainTex_Mask_V_W, _MainTex_Mask_V_W);
			_material.SetFloat(ShaderID._MainTex_Mssk_Ang, _MainTex_Mssk_Ang);
			_material.SetFloat(ShaderID._MainTex_Mask_2_IsSingleChannel, _MainTex_Mask_2_IsSingleChannel);
			_material.SetVector(ShaderID._MainTex_Mask_2_ST, _MainTex_Mask_2_ST);
			_material.SetFloat(ShaderID._World_Mask_2, _World_Mask_2);
			_material.SetFloat(ShaderID._World_Mask_View_2, _World_Mask_View_2);
			_material.SetFloat(ShaderID._MainTex_Mask_2_U, _MainTex_Mask_2_U);
			_material.SetFloat(ShaderID._MainTex_Mask_2_U_X2, _MainTex_Mask_2_U_X2);
			_material.SetFloat(ShaderID._MainTex_Mask_2_V, _MainTex_Mask_2_V);
			_material.SetFloat(ShaderID._MainTex_Mask_2_V_Y2, _MainTex_Mask_2_V_Y2);
			_material.SetFloat(ShaderID._MainTex_Mask_2_Ang, _MainTex_Mask_2_Ang);
			_material.SetFloat(ShaderID._MainTex_UVadd_IsSingleChannel, _MainTex_UVadd_IsSingleChannel);
			_material.SetVector(ShaderID._MainTex_UVadd_ST, _MainTex_UVadd_ST);
			_material.SetFloat(ShaderID._World_Mask_3, _World_Mask_3);
			_material.SetFloat(ShaderID._World_Mask_View_3, _World_Mask_View_3);
			_material.SetFloat(ShaderID._MainTex_UVadd_Intensity, _MainTex_UVadd_Intensity);
			_material.SetFloat(ShaderID._MainTex_UVadd_Intensity_Y2, _MainTex_UVadd_Intensity_Y2);
			_material.SetFloat(ShaderID._MainTex_UVadd_U, _MainTex_UVadd_U);
			_material.SetFloat(ShaderID._MainTex_UVadd_U_Z2, _MainTex_UVadd_U_Z2);
			_material.SetFloat(ShaderID._MainTex_UVadd_V, _MainTex_UVadd_V);
			_material.SetFloat(ShaderID._MainTex_UVadd_V_W2, _MainTex_UVadd_V_W2);
			_material.SetFloat(ShaderID._MainTex_UVadd_Ang, _MainTex_UVadd_Ang);
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
