using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class UI_Rhythm : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _NoiseTex_ST = Shader.PropertyToID("_NoiseTex_ST");

		public static readonly int _NoiseRotation = Shader.PropertyToID("_NoiseRotation");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _BackGroundColor = Shader.PropertyToID("_BackGroundColor");

		public static readonly int _UorV = Shader.PropertyToID("_UorV");

		public static readonly int _Invert = Shader.PropertyToID("_Invert");

		public static readonly int _FixAlpha = Shader.PropertyToID("_FixAlpha");

		public static readonly int _Offset = Shader.PropertyToID("_Offset");

		public static readonly int _Amplititude = Shader.PropertyToID("_Amplititude");

		public static readonly int _Space = Shader.PropertyToID("_Space");

		public static readonly int _Transition = Shader.PropertyToID("_Transition");

		public static readonly int _Transition2 = Shader.PropertyToID("_Transition2");

		public static readonly int _Row = Shader.PropertyToID("_Row");

		public static readonly int _Speed = Shader.PropertyToID("_Speed");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _MainPlusTex_ST = Shader.PropertyToID("_MainPlusTex_ST");

		public static readonly int _MainPlusRotation = Shader.PropertyToID("_MainPlusRotation");

		public static readonly int _ColorPlus = Shader.PropertyToID("_ColorPlus");

		public static readonly int _ColorPlusIntensity = Shader.PropertyToID("_ColorPlusIntensity");

		public static readonly int _MainPlusStrength = Shader.PropertyToID("_MainPlusStrength");
	}

	[Header("Noise")]
	public Vector4 _NoiseTex_ST = new Vector4(1f, 1f, 0f, 0f);

	[Range(0f, 360f)]
	public float _NoiseRotation;

	[ColorUsage(true, true)]
	public Color _Color = Color.white;

	[ColorUsage(true, true)]
	public Color _BackGroundColor = Color.white;

	public float _UorV;

	public float _Invert;

	public float _FixAlpha;

	public float _Offset;

	public float _Amplititude = 1f;

	[Range(0f, 1f)]
	public float _Space = 0.1f;

	[Range(0f, 1f)]
	public float _Transition = 0.1f;

	[Range(0f, 1f)]
	public float _Transition2 = 0.1f;

	public float _Row = 20f;

	public float _Speed = 1f;

	public float _ColorMask = 15f;

	[Header("MainPlus")]
	public Vector4 mainPlusTex_ST = new Vector4(1f, 1f, 0f, 0f);

	[Range(0f, 360f)]
	public float mainPlusRotation;

	public Color colorPlus = Color.white;

	[Range(0f, 5f)]
	public float colorPlusIntensity = 1f;

	[Range(0f, 1f)]
	public float mainPlusStrength;

	private Material _material;

	private Graphic m_Graphic;

	private Vector4 lastNoiseTex_ST = new Vector4(1f, 1f, 0f, 0f);

	private float lastNoiseRotation;

	private Color lastColor = Color.white;

	private Color lastBackGroundColor = Color.white;

	private float lastUorV;

	private float lastInvert;

	private float lastFixAlpha;

	private float lastOffset;

	private float lastAmplititude = 1f;

	private float lastSpace = 0.1f;

	private float lastTransition = 0.1f;

	private float lastTransition2 = 0.1f;

	private float lastRow = 20f;

	private float lastSpeed = 1f;

	private float lastColorMask = 15f;

	private Vector4 lastMainPlusTex_ST;

	private float lastMainPlusRotation;

	private Color lastColorPlus;

	private float lastColorPlusIntensity;

	private float lastMainPlusStrength;

	private bool isForceUpdate;

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
			isForceUpdate = true;
		}
		return _material;
	}

	private void LateUpdate()
	{
		UpdateMaterial();
	}

	private bool NoiseDirty()
	{
		if (lastNoiseRotation != _NoiseRotation || lastColor != _Color || lastBackGroundColor != _BackGroundColor || lastUorV != _UorV || lastInvert != _Invert || lastFixAlpha != _FixAlpha || lastOffset != _Offset || lastAmplititude != _Amplititude || lastSpace != _Space || lastTransition != _Transition || lastTransition2 != _Transition2 || lastRow != _Row || lastSpeed != _Speed || lastColorMask != _ColorMask)
		{
			lastNoiseRotation = _NoiseRotation;
			lastColor = _Color;
			lastBackGroundColor = _BackGroundColor;
			lastUorV = _UorV;
			lastInvert = _Invert;
			lastFixAlpha = _FixAlpha;
			lastOffset = _Offset;
			lastAmplititude = _Amplititude;
			lastSpace = _Space;
			lastTransition = _Transition;
			lastTransition2 = _Transition2;
			lastRow = _Row;
			lastSpeed = _Speed;
			lastColorMask = _ColorMask;
			return true;
		}
		return false;
	}

	private bool MainPlusDirty()
	{
		if (lastMainPlusTex_ST != mainPlusTex_ST || lastMainPlusRotation != mainPlusRotation || lastMainPlusStrength != mainPlusStrength || lastColorPlus != colorPlus || lastColorPlusIntensity != colorPlusIntensity)
		{
			lastMainPlusTex_ST = mainPlusTex_ST;
			lastMainPlusRotation = mainPlusRotation;
			lastMainPlusStrength = mainPlusStrength;
			lastColorPlus = colorPlus;
			lastColorPlusIntensity = colorPlusIntensity;
			return true;
		}
		return false;
	}

	internal void UpdateMaterial()
	{
		if (!(_material == null))
		{
			if (NoiseDirty() || isForceUpdate)
			{
				_material.SetVector(ShaderID._NoiseTex_ST, _NoiseTex_ST);
				_material.SetColor(ShaderID._Color, _Color);
				_material.SetColor(ShaderID._BackGroundColor, _BackGroundColor);
				_material.SetFloat(ShaderID._UorV, _UorV);
				_material.SetFloat(ShaderID._Invert, _Invert);
				_material.SetFloat(ShaderID._FixAlpha, _FixAlpha);
				_material.SetFloat(ShaderID._Offset, _Offset);
				_material.SetFloat(ShaderID._Amplititude, _Amplititude);
				_material.SetFloat(ShaderID._Space, _Space);
				_material.SetFloat(ShaderID._Transition, _Transition);
				_material.SetFloat(ShaderID._Transition2, _Transition2);
				_material.SetFloat(ShaderID._Row, _Row);
				_material.SetFloat(ShaderID._Speed, _Speed);
				_material.SetFloat(ShaderID._ColorMask, _ColorMask);
			}
			if (MainPlusDirty() || isForceUpdate)
			{
				_material.SetVector(ShaderID._MainPlusTex_ST, mainPlusTex_ST);
				_material.SetFloat(ShaderID._MainPlusRotation, mainPlusRotation);
				_material.SetColor(ShaderID._ColorPlus, colorPlus);
				_material.SetFloat(ShaderID._ColorPlusIntensity, colorPlusIntensity);
				_material.SetFloat(ShaderID._MainPlusStrength, mainPlusStrength);
			}
			Image image = graphic as Image;
			if (image != null)
			{
				Vector4 value = (image.overrideSprite ? DataUtility.GetOuterUV(image.overrideSprite) : new Vector4(0f, 0f, 1f, 1f));
				value.z -= value.x;
				value.w -= value.y;
				_material.SetVector(ShaderID._SpriteParams, value);
			}
			isForceUpdate = false;
		}
	}
}
