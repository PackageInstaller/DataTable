using UnityEngine;
using UnityEngine.UI;

public class QTEResurrectBlackSetting : MonoBehaviour
{
	public Slider slider;

	public GameObject materialGameObject;

	private Material material;

	public float minValue = -0.2f;

	public float maxValue = 0.15f;

	private void Awake()
	{
		if (materialGameObject != null)
		{
			material = materialGameObject.GetComponent<Renderer>().material;
		}
	}

	private void Update()
	{
		if (!(material == null))
		{
			Vector2 textureOffset = material.GetTextureOffset("_MaskTex");
			textureOffset.y = slider.value * (maxValue - minValue) + minValue;
			material.SetTextureOffset("_MaskTex", textureOffset);
		}
	}
}
