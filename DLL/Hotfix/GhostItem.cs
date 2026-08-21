using System.Collections.Generic;
using UnityEngine;

public class GhostItem : MonoBehaviour
{
	public float duration;

	public float deleteTime;

	public List<GhostItem> items;

	public string propertyType;

	public string propertyName;

	public AnimationCurve ColorTintCurve;

	public MeshRenderer meshRenderer;

	public Mesh BakedSkinMesh;

	protected void OnDestroy()
	{
		if (BakedSkinMesh != null)
		{
			Object.Destroy(BakedSkinMesh);
			BakedSkinMesh = null;
		}
	}

	private void Update()
	{
		float num = deleteTime - Time.time;
		if (num <= 0f)
		{
			items.Remove(this);
			Object.Destroy(base.gameObject);
		}
		else if ((bool)meshRenderer.GetMaterial() && !string.IsNullOrEmpty(propertyName) && propertyName.Length != 0 && meshRenderer.GetMaterial().HasProperty(propertyName))
		{
			if (propertyType == "Color")
			{
				Color color = meshRenderer.GetMaterial().GetColor(propertyName);
				color.a *= ColorTintCurve.Evaluate(1f - num / duration);
				meshRenderer.GetMaterial().SetColor(propertyName, color);
			}
			else if (propertyType == "Float")
			{
				meshRenderer.GetMaterial().SetFloat(propertyName, ColorTintCurve.Evaluate(1f - num / duration));
			}
		}
	}
}
