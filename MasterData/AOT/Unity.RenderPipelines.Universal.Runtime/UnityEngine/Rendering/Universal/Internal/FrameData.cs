namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class FrameData
{
	private bool m_IsFirstFrame;

	private int m_LastFrameActive;

	private Matrix4x4 m_viewProjectionMatrix;

	private Matrix4x4 m_PreviousViewProjectionMatrix;

	private Matrix4x4 m_ViewMatrix;

	private Matrix4x4 m_PreviousViewMatrix;

	private Matrix4x4 m_ProjectionMatrix;

	private Matrix4x4 m_PreviousProjectionMatrix;

	internal bool isFirstFrame
	{
		get
		{
			return m_IsFirstFrame;
		}
		set
		{
			m_IsFirstFrame = value;
		}
	}

	internal int lastFrameActive
	{
		get
		{
			return m_LastFrameActive;
		}
		set
		{
			m_LastFrameActive = value;
		}
	}

	internal Matrix4x4 viewProjectionMatrix
	{
		get
		{
			return m_viewProjectionMatrix;
		}
		set
		{
			m_viewProjectionMatrix = value;
		}
	}

	internal Matrix4x4 previousViewProjectionMatrix
	{
		get
		{
			return m_PreviousViewProjectionMatrix;
		}
		set
		{
			m_PreviousViewProjectionMatrix = value;
		}
	}

	internal Matrix4x4 viewMatrix
	{
		get
		{
			return m_ViewMatrix;
		}
		set
		{
			m_ViewMatrix = value;
		}
	}

	internal Matrix4x4 previousViewMatrix
	{
		get
		{
			return m_PreviousViewMatrix;
		}
		set
		{
			m_PreviousViewMatrix = value;
		}
	}

	internal Matrix4x4 projectionMatrix
	{
		get
		{
			return m_ProjectionMatrix;
		}
		set
		{
			m_ProjectionMatrix = value;
		}
	}

	internal Matrix4x4 previousProjectionMatrix
	{
		get
		{
			return m_PreviousProjectionMatrix;
		}
		set
		{
			m_PreviousProjectionMatrix = value;
		}
	}

	internal FrameData()
	{
		m_IsFirstFrame = true;
		m_LastFrameActive = -1;
		m_viewProjectionMatrix = Matrix4x4.identity;
		m_PreviousViewProjectionMatrix = Matrix4x4.identity;
		m_ViewMatrix = Matrix4x4.identity;
		m_PreviousViewMatrix = Matrix4x4.identity;
		m_ProjectionMatrix = Matrix4x4.identity;
		m_PreviousProjectionMatrix = Matrix4x4.identity;
	}

	internal Matrix4x4 GetSkyMotionReprojectionMatrix()
	{
		Matrix4x4 matrix4x = RemoveViewTranslation(m_ViewMatrix);
		Matrix4x4 matrix4x2 = RemoveViewTranslation(m_PreviousViewMatrix);
		return m_PreviousProjectionMatrix * matrix4x2 * matrix4x.transpose * m_ProjectionMatrix.inverse;
	}

	private static Matrix4x4 RemoveViewTranslation(Matrix4x4 viewMatrix)
	{
		viewMatrix.m03 = 0f;
		viewMatrix.m13 = 0f;
		viewMatrix.m23 = 0f;
		return viewMatrix;
	}
}
