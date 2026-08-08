using System;

internal struct UpdateVisibleInternalLogic
{
	private bool visible;

	public Action OnEnterVisible;

	public Action OnExitVisible;

	public Action<float> OnVisibleUpdate;

	public Action<float> OnInvisibleUpdate;

	public bool justEnterVisible { get; private set; }

	public bool justExitVisible { get; private set; }

	public void UpdateVisible(bool visible, float dt)
	{
		if (visible && !this.visible)
		{
			OnEnterVisible?.Invoke();
			justEnterVisible = true;
		}
		else if (!visible && this.visible)
		{
			OnExitVisible?.Invoke();
			justExitVisible = true;
		}
		this.visible = visible;
		if (visible)
		{
			OnVisibleUpdate?.Invoke(dt);
		}
		else
		{
			OnInvisibleUpdate?.Invoke(dt);
		}
		justEnterVisible = false;
		justExitVisible = false;
	}
}
