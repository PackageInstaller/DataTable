using UnityEngine;
using UnityEngine.UI;

namespace UI_Shader_Wrap;

[ExecuteAlways]
[RequireComponent(typeof(CanvasRenderer))]
[RequireComponent(typeof(RectTransform))]
public class UI_Curve : MonoBehaviour, IMaterialModifier
{
	private class ShaderID
	{
		public static readonly int _Color = Shader.PropertyToID("_Color");

		public static readonly int _BackGroundColor = Shader.PropertyToID("_BackGroundColor");

		public static readonly int _Rate = Shader.PropertyToID("_Rate");

		public static readonly int _PointCount = Shader.PropertyToID("_PointCount");

		public static readonly int _Points = Shader.PropertyToID("_Points");
	}

	public Color _Color = Color.white;

	public Color _BackGroundColor = new Color(0f, 0f, 0f, 0f);

	[SerializeField]
	public int pointsCount;

	[SerializeField]
	public Vector4[] points = new Vector4[10];

	private Material _material;

	private Graphic m_Graphic;

	private RectTransform m_RectTransform;

	public Graphic graphic => m_Graphic ?? (m_Graphic = GetComponent<Graphic>());

	public RectTransform rectTransform => m_RectTransform ?? (m_RectTransform = GetComponent<RectTransform>());

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
			_material.SetColor(ShaderID._BackGroundColor, _BackGroundColor);
			_material.SetFloat(ShaderID._Rate, rectTransform.rect.width / rectTransform.rect.height);
			_material.SetInt(ShaderID._PointCount, pointsCount);
			_material.SetVectorArray(ShaderID._Points, points);
		}
	}
}
