using UnityEngine;

[ExecuteAlways]
public class BottleLiquid : MonoBehaviour
{
	[Range(0f, 1f)]
	public float LiquidHigh;

	public float FadeSpeed = 5f;

	private Bounds bounds;

	private Renderer meshRenderer;

	private MaterialPropertyBlock materialPropertyBlock;

	private Vector4 LiquidShaking;

	private Vector3 OldPosition;

	private void OnEnable()
	{
		meshRenderer = GetComponent<Renderer>();
		materialPropertyBlock = new MaterialPropertyBlock();
		if (meshRenderer != null)
		{
			OldPosition = meshRenderer.bounds.center;
		}
		LiquidShaking = new Vector4(1f, 0f, 0f, 0f);
	}

	private void Update()
	{
		if (meshRenderer != null)
		{
			bounds = meshRenderer.bounds;
			float value = bounds.size.y * LiquidHigh + bounds.center.y - bounds.extents.y;
			materialPropertyBlock.SetFloat("_LiquidHeight", value);
			Vector3 center = meshRenderer.bounds.center;
			materialPropertyBlock.SetVector("_LiquidFocus", center);
			Vector3 vector = center - OldPosition;
			vector = vector.normalized * Mathf.Min(vector.magnitude, 1f);
			Vector3 normalized = new Vector3(vector.x, 0f, vector.z).normalized;
			float magnitude = vector.magnitude;
			new Vector4(normalized.x, normalized.y, normalized.z, magnitude);
			LiquidShaking.w *= Mathf.Exp((0f - Time.deltaTime) * FadeSpeed);
			Vector3 vector2 = new Vector3(LiquidShaking.x, LiquidShaking.y, LiquidShaking.z) * LiquidShaking.w + normalized * magnitude;
			vector2 /= Mathf.Max(LiquidShaking.w + magnitude, 0.001f);
			LiquidShaking = new Vector4(vector2.x, vector2.y, vector2.z, LiquidShaking.w + magnitude);
			materialPropertyBlock.SetVector("_LiquidShaking", LiquidShaking);
			OldPosition = center;
			meshRenderer.SetPropertyBlock(materialPropertyBlock);
		}
	}
}
