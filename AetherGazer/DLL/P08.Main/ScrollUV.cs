using UnityEngine;

public class ScrollUV : MonoBehaviour
{
	public float scrollSpeedX = 0.5f;

	public float scrollSpeedY = 0.5f;

	private Material material;

	private void Start()
	{
		material = GetComponent<Renderer>().material;
	}

	private void Update()
	{
		float x = Time.time * scrollSpeedX;
		float y = Time.time * scrollSpeedY;
		material.mainTextureOffset = new Vector2(x, y);
	}
}
