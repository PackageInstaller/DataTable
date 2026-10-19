using UnityEngine;
using UnityEngine.UI;

public class ModifyImageMaterialBlock : MonoBehaviour
{
	private MaterialPropertyBlock propertyBlock;

	private Image image;

	private Material materialInstance;

	public float _Cut;

	[SerializeField]
	private bool _enableMaskTillingOffset;

	[SerializeField]
	private Vector4 _maskTillingOffset;

	[SerializeField]
	private bool _enableColor;

	[SerializeField]
	private Color _color;

	[SerializeField]
	[Range(0f, 1f)]
	private float colorAlpha = 1f;

	private Color currentColor;

	private float _previousCut;

	private void Start()
	{
		image = GetComponent<Image>();
		materialInstance = new Material(image.material);
		image.material = materialInstance;
		_Cut = materialInstance.GetFloat("_Cut");
		_previousCut = _Cut;
		currentColor = materialInstance.GetColor("_Color");
		colorAlpha = currentColor.a;
	}

	private void Update()
	{
		if (Mathf.Abs(_Cut - _previousCut) > 0.001f)
		{
			materialInstance.SetFloat("_Cut", _Cut);
			_previousCut = _Cut;
			image.SetMaterialDirty();
		}
		if (Mathf.Abs(currentColor.a - colorAlpha) > 0.001f)
		{
			currentColor.a = colorAlpha;
			materialInstance.SetColor("_Color", currentColor);
			image.SetMaterialDirty();
		}
		if (_enableMaskTillingOffset)
		{
			materialInstance.SetTextureScale("_Mask", new Vector2(_maskTillingOffset.x, _maskTillingOffset.y));
			materialInstance.SetTextureOffset("_Mask", new Vector2(_maskTillingOffset.z, _maskTillingOffset.w));
			image.SetMaterialDirty();
		}
		if (_enableColor)
		{
			materialInstance.SetColor("_Color", _color);
			image.SetMaterialDirty();
		}
	}

	private void OnDestroy()
	{
		if (materialInstance != null)
		{
			if (Application.isPlaying)
			{
				Object.Destroy(materialInstance);
			}
			else
			{
				Object.DestroyImmediate(materialInstance);
			}
		}
	}
}
