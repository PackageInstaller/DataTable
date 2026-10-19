using DG.Tweening;
using UnityEngine;

namespace ACT.Battle;

public class SimpleMaterialOcclusion : MonoBehaviour, IOcclusionCallback
{
	public MeshRenderer meshRenderer;

	public string colorName = "_BaseColor";

	public Color normal = Color.white;

	public Color alpha = Color.clear;

	public float duration = 0.5f;

	private Color GetColor()
	{
		return meshRenderer.material.GetColor(colorName);
	}

	private void SetColor(Color color)
	{
		meshRenderer.material.SetColor(colorName, color);
	}

	public void OnOcclusionEnter()
	{
		DOTween.To(GetColor, SetColor, alpha, duration);
	}

	public void OnOcclusionExit()
	{
		DOTween.To(GetColor, SetColor, normal, duration);
	}
}
