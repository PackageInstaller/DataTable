using System;

namespace Bamboo.Chronos;

internal sealed class CompleteActionInfo : BaseCompleteActionInfo
{
	private static readonly Type TYPE = TypeCache<CompleteActionInfo>.TYPE;

	public Action<bool> Action;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
	}

	public override void Execute(bool isBreak)
	{
		Action?.Invoke(isBreak);
	}
}
internal sealed class CompleteActionInfo<T> : BaseCompleteActionInfo
{
	private static readonly Type TYPE = TypeCache<CompleteActionInfo<T>>.TYPE;

	public Action<T, bool> Action;

	public T Arg;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg = default;
	}

	public override void Execute(bool isBreak)
	{
		Action?.Invoke(Arg, isBreak);
	}
}
internal sealed class CompleteActionInfo<T1, T2> : BaseCompleteActionInfo
{
	private static readonly Type TYPE = TypeCache<CompleteActionInfo<T1, T2>>.TYPE;

	public Action<T1, T2, bool> Action;

	public T1 Arg1;

	public T2 Arg2;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg1 = default;
		Arg2 = default;
	}

	public override void Execute(bool isBreak)
	{
		Action?.Invoke(Arg1, Arg2, isBreak);
	}
}
internal sealed class CompleteActionInfo<T1, T2, T3> : BaseCompleteActionInfo
{
	private static readonly Type TYPE = TypeCache<CompleteActionInfo<T1, T2, T3>>.TYPE;

	public Action<T1, T2, T3, bool> Action;

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

	public override void Execute(bool isBreak)
	{
		Action?.Invoke(Arg1, Arg2, Arg3, isBreak);
	}
}
