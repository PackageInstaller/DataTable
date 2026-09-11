using UnityEngine;

public class EarlyWarningEffectController : MonoBehaviour
{
	public int Key;

	public EffectController EffectCtrl;

	public Vector3 Offset = Vector3.zero;

	public Vector3 Rotation = Vector3.zero;

	public float Duration = 1f;

	public bool IsInward;

	public WarningManager m_WarningManager;

	public WarningManager m_WarningManager2;

	public AnimationCurve m_Progress = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f));

	[GradientUsage(true)]
	public Gradient m_KeepEdgeColor = new Gradient();

	[GradientUsage(true)]
	public Gradient m_KeepStaticColor = new Gradient();

	[GradientUsage(true)]
	public Gradient m_KeepColor = new Gradient();

	public float m_FlashTime = 0.5f;

	[GradientUsage(true)]
	public Gradient m_FlashEdgeColor = new Gradient();

	[GradientUsage(true)]
	public Gradient m_FlashStaticColor = new Gradient();

	[GradientUsage(true)]
	public Gradient m_FlashColor = new Gradient();

	public LineRenderer m_LineRenderer;

	public AnimationCurve m_KeepMultiperParam = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 0f));

	public AnimationCurve m_FlashMultiperParam = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 0f));

	private void Update()
	{
		if (EffectCtrl != null)
		{
			UpdateEffect(EffectCtrl.mSimulatorTime, Duration, m_WarningManager, IsInward);
			if (m_WarningManager2 != null)
			{
				UpdateEffect(EffectCtrl.mSimulatorTime, Duration, m_WarningManager2, IsInward);
			}
		}
	}

	public void UpdateEffect(float time, float during, WarningManager m_WarningManager, bool isInward)
	{
		if (m_WarningManager != null)
		{
			float num = during - m_FlashTime;
			float value = time / num;
			value = Mathf.Clamp01(value);
			if (isInward)
			{
				m_WarningManager.Scale = 1f - m_Progress.Evaluate(value);
			}
			else
			{
				m_WarningManager.Scale = m_Progress.Evaluate(value);
			}
			m_WarningManager.EdgeCOL = m_KeepEdgeColor.Evaluate(value);
			m_WarningManager.StaticCol = m_KeepStaticColor.Evaluate(value);
			m_WarningManager.Color = m_KeepColor.Evaluate(value);
			if (time >= num)
			{
				value = (time - num) / m_FlashTime;
				value = Mathf.Clamp01(value);
				m_WarningManager.EdgeCOL = m_FlashEdgeColor.Evaluate(value);
				m_WarningManager.StaticCol = m_FlashStaticColor.Evaluate(value);
				m_WarningManager.Color = m_FlashColor.Evaluate(value);
			}
		}
		if (m_LineRenderer != null)
		{
			float num2 = during - m_FlashTime;
			float value2 = time / num2;
			value2 = Mathf.Clamp01(value2);
			m_LineRenderer.widthMultiplier = m_KeepMultiperParam.Evaluate(value2);
			m_LineRenderer.sharedMaterial.color = m_KeepColor.Evaluate(value2);
			if (time >= num2)
			{
				value2 = (time - num2) / m_FlashTime;
				value2 = Mathf.Clamp01(value2);
				m_LineRenderer.widthMultiplier = m_FlashMultiperParam.Evaluate(value2);
				m_LineRenderer.sharedMaterial.color = m_FlashColor.Evaluate(value2);
			}
		}
	}

	public void Stop()
	{
		EffectCtrl.Stop();
	}

	internal void HideRenderer(bool v)
	{
		if (m_LineRenderer != null)
		{
			m_LineRenderer.enabled = !v;
		}
		if (m_WarningManager != null)
		{
			m_WarningManager.Hide(v);
		}
		if (m_WarningManager2 != null)
		{
			m_WarningManager2.Hide(v);
		}
	}
}
