namespace UnityEngine.Rendering.Universal;

public class DLSSPreparePass : ScriptableRenderPass
{
	private float m_HistoryResetDeltaTime;

	internal Vector4 frameJitter { get; private set; }

	public DLSSPreparePass()
	{
		profilingSampler = new ProfilingSampler("DLSSPreparePass");
		renderPassEvent = RenderPassEvent.DLSSPreparePass;
		targetCount = 0u;
	}

	internal void Setup(DLSSFeature.Settings settings)
	{
		m_HistoryResetDeltaTime = settings.historyResetDeltaTime;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
	}

	private float GetDeltaTime()
	{
		return Time.deltaTime;
	}

	private static bool IsValidProjectionMatrix(Matrix4x4 matrix)
	{
		if (Mathf.Abs(matrix.m00) > 1E-05f)
		{
			return Mathf.Abs(matrix.m11) > 1E-05f;
		}
		return false;
	}
}
