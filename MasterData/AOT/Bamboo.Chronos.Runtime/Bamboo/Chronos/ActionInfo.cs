using System;

namespace Bamboo.Chronos;

internal sealed class ActionInfo : BaseActionInfo
{
	private static readonly Type TYPE = TypeCache<ActionInfo>.TYPE;

	public Action Action;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
	}

	public override void Execute()
	{
		Action?.Invoke();
	}
}
internal sealed class ActionInfo<T> : BaseActionInfo
{
	private static readonly Type TYPE = TypeCache<ActionInfo<T>>.TYPE;

	public Action<T> Action;

	public T Arg;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg = default;
	}

	public override void Execute()
	{
		Action?.Invoke(Arg);
	}
}
internal sealed class ActionInfo<T1, T2> : BaseActionInfo
{
	private static readonly Type TYPE = TypeCache<ActionInfo<T1, T2>>.TYPE;

	public Action<T1, T2> Action;

	public T1 Arg1;

	public T2 Arg2;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg1 = default;
		Arg2 = default;
	}

	public override void Execute()
	{
		Action?.Invoke(Arg1, Arg2);
	}
}
internal sealed class ActionInfo<T1, T2, T3> : BaseActionInfo
{
	private static readonly Type TYPE = TypeCache<ActionInfo<T1, T2, T3>>.TYPE;

	public Action<T1, T2, T3> Action;

	public T1 Arg1;

	public T2 Arg2;

	public T3 Arg3;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg1 = default;
		Arg2 = default;
		Arg3 = default;
	}

	public override void Execute()
	{
		Action?.Invoke(Arg1, Arg2, Arg3);
	}
}
internal sealed class ActionInfo<T1, T2, T3, T4> : BaseActionInfo
{
	private static readonly Type TYPE = TypeCache<ActionInfo<T1, T2, T3, T4>>.TYPE;

	public Action<T1, T2, T3, T4> Action;

	public T1 Arg1;

	public T2 Arg2;

	public T3 Arg3;

	public T4 Arg4;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg1 = default;
		Arg2 = default;
		Arg3 = default;
		Arg4 = default;
	}

	public override void Execute()
	{
		Action?.Invoke(Arg1, Arg2, Arg3, Arg4);
	}
}
