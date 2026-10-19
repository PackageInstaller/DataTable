using System;

namespace Bamboo.Chronos;

internal sealed class UpdateActionInfo : BaseUpdateActionInfo
{
	private static readonly Type TYPE = TypeCache<UpdateActionInfo>.TYPE;

	public Action<int> Action;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
	}

	public override void Execute(int thousandth)
	{
		Action?.Invoke(thousandth);
	}
}
internal sealed class UpdateActionInfo<T> : BaseUpdateActionInfo
{
	private static readonly Type TYPE = TypeCache<UpdateActionInfo<T>>.TYPE;

	public Action<T, int> Action;

	public T Arg;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg = default;
	}

	public override void Execute(int thousandth)
	{
		Action?.Invoke(Arg, thousandth);
	}
}
internal sealed class UpdateActionInfo<T1, T2> : BaseUpdateActionInfo
{
	private static readonly Type TYPE = TypeCache<UpdateActionInfo<T1, T2>>.TYPE;

	public Action<T1, T2, int> Action;

	public T1 Arg1;

	public T2 Arg2;

	public override Type Type => TYPE;

	public override void Recycle()
	{
		Action = null;
		Arg1 = default;
		Arg2 = default;
	}

	public override void Execute(int thousandth)
	{
		Action?.Invoke(Arg1, Arg2, thousandth);
	}
}
internal sealed class UpdateActionInfo<T1, T2, T3> : BaseUpdateActionInfo
{
	private static readonly Type TYPE = TypeCache<UpdateActionInfo<T1, T2, T3>>.TYPE;

	public Action<T1, T2, T3, int> Action;

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

	public override void Execute(int thousandth)
	{
		Action?.Invoke(Arg1, Arg2, Arg3, thousandth);
	}
}
