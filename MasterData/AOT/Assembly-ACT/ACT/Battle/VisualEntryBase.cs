using System;

namespace ACT.Battle;

public abstract class VisualEntryBase
{
	public int _priority;

	public Guid Id { get; } = Guid.NewGuid();

	public abstract void Show();

	public abstract void Hide();
}
