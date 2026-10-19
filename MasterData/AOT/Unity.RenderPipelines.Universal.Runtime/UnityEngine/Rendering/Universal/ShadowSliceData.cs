namespace UnityEngine.Rendering.Universal;

public struct ShadowSliceData
{
	public Matrix4x4 viewMatrix;

	public Matrix4x4 projectionMatrix;

	public Matrix4x4 shadowTransform;

	public int offsetX;

	public int offsetY;

	public int resolution;

	public ShadowSplitData splitData;

	public void Clear()
	{
		viewMatrix = Matrix4x4.identity;
		projectionMatrix = Matrix4x4.identity;
		shadowTransform = Matrix4x4.identity;
		offsetX = (offsetY = 0);
		resolution = 1024;
	}
}
