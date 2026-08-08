using System;

namespace Packages.P08Base;

internal abstract class CommonData
{
	public Node<CommonData> node;

	public string key;

	public object target;

	public Action destroyAction;

	public abstract Type type { get; }

	public abstract void Reset();
}
