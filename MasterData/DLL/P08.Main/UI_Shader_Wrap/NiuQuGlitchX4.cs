using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class NiuQuGlitchX4 : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _UseUIAlphaClip = Shader.PropertyToID("_UseUIAlphaClip");

		public static readonly int _NumOfExtralChannelNoise = Shader.PropertyToID("_NumOfExtralChannelNoise");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _Desaturate = Shader.PropertyToID("_Desaturate");

		public static readonly int _NoiseStrength = Shader.PropertyToID("_NoiseStrength");

		public static readonly int _NoiseSeed = Shader.PropertyToID("_NoiseSeed");

		public static readonly int _Segment = Shader.PropertyToID("_Segment");

		public static readonly int _UVOffset1 = Shader.PropertyToID("_UVOffset1");

		public static readonly int _Color1 = Shader.PropertyToID("_Color1");

		public static readonly int _Desaturate1 = Shader.PropertyToID("_Desaturate1");

		public static readonly int _NoiseStrength1 = Shader.PropertyToID("_NoiseStrength1");

		public static readonly int _NoiseSeed1 = Shader.PropertyToID("_NoiseSeed1");

		public static readonly int _Segment1 = Shader.PropertyToID("_Segment1");

		public static readonly int _UVOffset2 = Shader.PropertyToID("_UVOffset2");

		public static readonly int _Color2 = Shader.PropertyToID("_Color2");

		public static readonly int _Desaturate2 = Shader.PropertyToID("_Desaturate2");

		public static readonly int _NoiseStrength2 = Shader.PropertyToID("_NoiseStrength2");

		public static readonly int _NoiseSeed2 = Shader.PropertyToID("_NoiseSeed2");

		public static readonly int _Segment2 = Shader.PropertyToID("_Segment2");

		public static readonly int _UVOffset3 = Shader.PropertyToID("_UVOffset3");

		public static readonly int _Color3 = Shader.PropertyToID("_Color3");

		public static readonly int _Desaturate3 = Shader.PropertyToID("_Desaturate3");

		public static readonly int _NoiseStrength3 = Shader.PropertyToID("_NoiseStrength3");

		public static readonly int _NoiseSeed3 = Shader.PropertyToID("_NoiseSeed3");

		public static readonly int _Segment3 = Shader.PropertyToID("_Segment3");

		public static readonly int _UVOffset4 = Shader.PropertyToID("_UVOffset4");

		public static readonly int _Color4 = Shader.PropertyToID("_Color4");

		public static readonly int _Desaturate4 = Shader.PropertyToID("_Desaturate4");

		public static readonly int _NoiseStrength4 = Shader.PropertyToID("_NoiseStrength4");

		public static readonly int _NoiseSeed4 = Shader.PropertyToID("_NoiseSeed4");

		public static readonly int _Segment4 = Shader.PropertyToID("_Segment4");
	}

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public float _ColorMask = 15f;

	public float _UseUIAlphaClip;

	private int _NumOfExtralChannelNoise = -1;

	public Color _Color = Color.white;

	[Range(0f, 1f)]
	public float _Desaturate;

	[Range(0f, 1f)]
	public float _NoiseStrength;

	[Range(0f, 1f)]
	public float _NoiseSeed;

	public float _Segment = 50f;

	public Vector2 _UVOffset1 = new Vector2(0f, 0f);

	public Color _Color1 = Color.white;

	[Range(0f, 1f)]
	public float _Desaturate1;

	[Range(0f, 1f)]
	public float _NoiseStrength1;

	[Range(0f, 1f)]
	public float _NoiseSeed1;

	public float _Segment1 = 50f;

	public Vector2 _UVOffset2 = new Vector2(0f, 0f);

	public Color _Color2 = Color.white;

	[Range(0f, 1f)]
	public float _Desaturate2;

	[Range(0f, 1f)]
	public float _NoiseStrength2;

	[Range(0f, 1f)]
	public float _NoiseSeed2;

	public float _Segment2 = 50f;

	public Vector2 _UVOffset3 = new Vector2(0f, 0f);

	public Color _Color3 = Color.white;

	[Range(0f, 1f)]
	public float _Desaturate3;

	[Range(0f, 1f)]
	public float _NoiseStrength3;

	[Range(0f, 1f)]
	public float _NoiseSeed3;

	public float _Segment3 = 50f;

	public Vector2 _UVOffset4 = new Vector2(0f, 0f);

	public Color _Color4 = Color.white;

	[Range(0f, 1f)]
	public float _Desaturate4;

	[Range(0f, 1f)]
	public float _NoiseStrength4;

	[Range(0f, 1f)]
	public float _NoiseSeed4;

	public float _Segment4 = 50f;

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
			if (_NumOfExtralChannelNoise < 0)
			{
				_NumOfExtralChannelNoise = Mathf.RoundToInt(_material.GetFloat(ShaderID._NumOfExtralChannelNoise));
			}
			_material.SetVector(ShaderID._MainTex_ST, _MainTex_ST);
			_material.SetFloat(ShaderID._ColorMask, _ColorMask);
			_material.SetFloat(ShaderID._UseUIAlphaClip, _UseUIAlphaClip);
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetFloat(ShaderID._Desaturate, _Desaturate);
			_material.SetFloat(ShaderID._NoiseStrength, _NoiseStrength);
			_material.SetFloat(ShaderID._NoiseSeed, _NoiseSeed);
			_material.SetFloat(ShaderID._Segment, _Segment);
			_material.SetVector(ShaderID._UVOffset1, _UVOffset1);
			_material.SetColor(ShaderID._Color1, _Color1);
			_material.SetFloat(ShaderID._Desaturate1, _Desaturate1);
			_material.SetFloat(ShaderID._NoiseStrength1, _NoiseStrength1);
			_material.SetFloat(ShaderID._NoiseSeed1, _NoiseSeed1);
			_material.SetFloat(ShaderID._Segment1, _Segment1);
			if (_NumOfExtralChannelNoise >= 2)
			{
				_material.SetVector(ShaderID._UVOffset2, _UVOffset2);
				_material.SetColor(ShaderID._Color2, _Color2);
				_material.SetFloat(ShaderID._Desaturate2, _Desaturate2);
				_material.SetFloat(ShaderID._NoiseStrength2, _NoiseStrength2);
				_material.SetFloat(ShaderID._NoiseSeed2, _NoiseSeed2);
				_material.SetFloat(ShaderID._Segment2, _Segment2);
			}
			if (_NumOfExtralChannelNoise >= 3)
			{
				_material.SetVector(ShaderID._UVOffset3, _UVOffset3);
				_material.SetColor(ShaderID._Color3, _Color3);
				_material.SetFloat(ShaderID._Desaturate3, _Desaturate3);
				_material.SetFloat(ShaderID._NoiseStrength3, _NoiseStrength3);
				_material.SetFloat(ShaderID._NoiseSeed3, _NoiseSeed3);
				_material.SetFloat(ShaderID._Segment3, _Segment3);
			}
			if (_NumOfExtralChannelNoise >= 4)
			{
				_material.SetVector(ShaderID._UVOffset4, _UVOffset4);
				_material.SetColor(ShaderID._Color4, _Color4);
				_material.SetFloat(ShaderID._Desaturate4, _Desaturate4);
				_material.SetFloat(ShaderID._NoiseStrength4, _NoiseStrength4);
				_material.SetFloat(ShaderID._NoiseSeed4, _NoiseSeed4);
				_material.SetFloat(ShaderID._Segment4, _Segment4);
			}
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
