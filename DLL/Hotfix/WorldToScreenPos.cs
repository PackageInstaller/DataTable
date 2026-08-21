using UnityEngine;

[ExecuteAlways]
public class WorldToScreenPos : MonoBehaviour
{
	[SerializeField]
	private Material material;

	[SerializeField]
	private Transform targetTrans;

	private static readonly int centerX = Shader.PropertyToID("_RadialCenterX");

	private static readonly int centerY = Shader.PropertyToID("_RadialCenterY");

	private Vector3 lastPos;

	private void Start()
	{
		if (!(material == null) && !(targetTrans == null) && material.HasProperty(centerX) && material.HasProperty(centerY))
		{
			lastPos = targetTrans.transform.position;
			SetData();
		}
	}

	private void OnEnable()
	{
		if (!(material == null) && !(targetTrans == null) && material.HasProperty(centerX) && material.HasProperty(centerY))
		{
			lastPos = targetTrans.transform.position;
			SetData();
		}
	}

	private void Update()
	{
		if (!(material == null) && !(targetTrans == null) && material.HasProperty(centerX) && material.HasProperty(centerY) && Vector3.Distance(lastPos, targetTrans.transform.position) > 0.01f)
		{
			SetData();
		}
	}

	private void SetData()
	{
		Vector3 vector = Camera.main.WorldToScreenPoint(targetTrans.position);
		material.SetFloat("_RadialCenterX", vector.x / (float)Camera.main.pixelWidth);
		material.SetFloat("_RadialCenterY", vector.y / (float)Camera.main.pixelHeight);
		lastPos = targetTrans.transform.position;
	}
}
