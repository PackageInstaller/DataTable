using System;

public class QWBodyDitherComponent
{
	private Action<float> OnDitherChanged;

	private float ditherRatio;

	private QWAgent parent;

	public void Init(QWAgent agent)
	{
		parent = agent;
		QWBodyDitherSystem.Instance.RegisterEntity(this);
		ditherRatio = 1f;
	}

	public void RegisterDitherChange(Action<float> act)
	{
		OnDitherChanged = act;
	}

	public void DispatchDitherChange(float ratio)
	{
		if (ditherRatio != ratio)
		{
			ditherRatio = ratio;
			OnDitherChanged?.Invoke(ditherRatio);
		}
	}

	public QWAgent GetAgent()
	{
		return parent;
	}

	public void Dispose()
	{
		OnDitherChanged = null;
		QWBodyDitherSystem.Instance.RemoveEntity(this);
	}
}
