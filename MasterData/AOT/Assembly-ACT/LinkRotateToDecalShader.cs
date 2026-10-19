using System;
using UnityEngine;

public class LinkRotateToDecalShader : MonoBehaviour
{
	private new int tag;

	private Renderer renderer;

	private Vector4 rotate;

	private void OnEnable()
	{
		tag = Shader.PropertyToID("_ParentRotate");
		renderer = GetComponent<Renderer>();
	}

	private void Update()
	{
		rotate = transform.eulerAngles * (MathF.PI / 180f);
		renderer.material.SetVector(tag, rotate);
	}
}
