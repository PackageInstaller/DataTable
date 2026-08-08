using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class UI_Sequeue_Animation_add : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _MainTex_ST = Shader.PropertyToID("_MainTex_ST");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _Column = Shader.PropertyToID("_Column");

		public static readonly int _Row = Shader.PropertyToID("_Row");

		public static readonly int _Speed = Shader.PropertyToID("_Speed");

		public static readonly int _ColorMask = Shader.PropertyToID("_ColorMask");

		public static readonly int _CurrentFrame = Shader.PropertyToID("_CurrentFrame");
	}

	public Vector4 _MainTex_ST = new Vector4(1f, 1f, 0f, 0f);

	public Color _Color = Color.white;

	public float _Column = 1f;

	public float _Row = 1f;

	public float _Speed = 1f;

	public float _ColorMask = 15f;

	public float _CurrentFrame;

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
			_material.SetFloat(ShaderID._Column, _Column);
			_material.SetFloat(ShaderID._Row, _Row);
			_material.SetFloat(ShaderID._Speed, _Speed);
			_material.SetFloat(ShaderID._ColorMask, _ColorMask);
			_material.SetFloat(ShaderID._CurrentFrame, _CurrentFrame);
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
