using UnityEngine;

public class QWFurnitureAttachComponent
{
	public Transform host;

	public Transform client;

	public Vector3 offset = Vector3.zero;

	public Vector3 scale = Vector3.one;

	public Quaternion rotation = Quaternion.identity;

	public void Tick()
	{
		UpdatePos();
	}

	private void UpdatePos()
	{
		if ((bool)host && (bool)client)
		{
			Matrix4x4 matrix4x = Matrix4x4.TRS(offset, rotation, scale);
			Matrix4x4 matrix4x2 = host.localToWorldMatrix * matrix4x;
			client.transform.position = matrix4x2.MultiplyPoint3x4(Vector3.zero);
			client.transform.rotation = Quaternion.LookRotation(matrix4x2.MultiplyVector(Vector3.forward), matrix4x2.MultiplyVector(Vector3.up));
			client.transform.localScale = Vector3.Scale(scale, host.localScale);
		}
	}
}
