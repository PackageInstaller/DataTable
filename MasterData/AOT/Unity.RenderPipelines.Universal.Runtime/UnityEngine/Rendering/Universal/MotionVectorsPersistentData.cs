namespace UnityEngine.Rendering.Universal;

internal sealed class MotionVectorsPersistentData
{
	private Matrix4x4 m_ViewProjection;

	private Matrix4x4 m_PreviousViewProjection;

	private int m_LastFrameIndex;

	private float m_PrevAspectRatio;

	internal int lastFrameIndex => m_LastFrameIndex;

	internal Matrix4x4 viewProjection => m_ViewProjection;

	internal Matrix4x4 previousViewProjection => m_PreviousViewProjection;

	internal MotionVectorsPersistentData()
	{
		m_ViewProjection = Matrix4x4.identity;
		m_PreviousViewProjection = Matrix4x4.identity;
		m_LastFrameIndex = -1;
		m_PrevAspectRatio = -1f;
	}

	public void Update(ref CameraData cameraData)
	{
		bool flag = m_PrevAspectRatio != cameraData.aspectRatio;
		if ((m_LastFrameIndex != Time.frameCount) | flag)
		{
			Matrix4x4 matrix4x = GL.GetGPUProjectionMatrix(cameraData.GetProjectionMatrix(), renderIntoTexture: true) * cameraData.GetViewMatrix();
			m_PreviousViewProjection = (flag ? matrix4x : m_ViewProjection);
			m_ViewProjection = matrix4x;
			m_LastFrameIndex = Time.frameCount;
			m_PrevAspectRatio = cameraData.aspectRatio;
		}
	}
}
