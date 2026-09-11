using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
public class Alpha_UI_Wave : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _SpriteParams = Shader.PropertyToID("_SpriteParams");

		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _TileAndOffset = Shader.PropertyToID("_TileAndOffset");

		public static readonly int _SecondAndThirdUVOffset = Shader.PropertyToID("_SecondAndThirdUVOffset");
	}

	public Color _Color = Color.white;

	public Vector4 _TileAndOffset = new Vector4(1f, 1f, 0f, 0f);

	public Vector4 _SecondAndThirdUVOffset = new Vector4(0.1f, 0f, 0.3f, 0f);

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

	private void Update()
	{
		UpdateMaterial();
	}

	internal void UpdateMaterial()
	{
		if (!(_material == null))
		{
			_material.SetColor(ShaderID._Color, _Color);
			_material.SetVector(ShaderID._TileAndOffset, _TileAndOffset);
			_material.SetVector(ShaderID._SecondAndThirdUVOffset, _SecondAndThirdUVOffset);
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
