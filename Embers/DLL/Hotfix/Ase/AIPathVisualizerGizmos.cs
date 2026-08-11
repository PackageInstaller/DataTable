using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class AIPathVisualizerGizmos(PathInterpolator path)
{
	private PathInterpolator interpolator;

	private float m_SphereRadius = 0.2f;

	private Color m_PathLineColor = Color.green;

	private Color m_PathPointColor = Color.cyan;

	private List<Vector3> pathBuffer = new List<Vector3>();

	private Vector3 offset = new Vector3(0f, 0.2f, 0f);

	public void DrawGizmos()
	{
		if ((Object)(object)DrawDebugTools.Instance == null || !DrawDebugTools.Instance.m_DDTSettings.m_EnableAgentPathVisualization || interpolator == null || !interpolator.valid)
		{
			return;
		}
		if (interpolator.remainingDistance > 0f)
		{
			pathBuffer.Clear();
			interpolator.GetRemainingPath(pathBuffer);
			for (int i = 0; i < pathBuffer.Count; i++)
			{
				Vector3 vector = pathBuffer[i] + offset;
				DrawDebugTools.DrawSphere(vector, m_SphereRadius, 4, m_PathPointColor, 0f);
				if (i < pathBuffer.Count - 1)
				{
					Vector3 vector2 = pathBuffer[i + 1] + offset;
					DrawDebugTools.DrawLine(vector, vector2, m_PathLineColor, 0f);
				}
			}
		}
		DrawDebugTools.DrawString3D(interpolator.endPoint + Vector3.up * 1f, $"{interpolator.remainingDistance:F2}", (TextAnchor)4, Color.white, 1f, 0f);
	}
}
