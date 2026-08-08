using System.Runtime.InteropServices;

namespace Mono;

[StructLayout(LayoutKind.Sequential, Size = 1)]
internal struct ValueTuple
{
}
internal struct ValueTuple<T1>
{
	public T1 Item1;
}
internal struct ValueTuple<T1, T2>
{
	public T1 Item1;

	public T2 Item2;
}
internal struct ValueTuple<T1, T2, T3>
{
	public T1 Item1;

	public T2 Item2;

	public T3 Item3;
}
internal struct ValueTuple<T1, T2, T3, T4>
{
	public T1 Item1;

	public T2 Item2;

	public T3 Item3;

	public T4 Item4;
}
internal struct ValueTuple<T1, T2, T3, T4, T5>
{
	public T1 Item1;

	public T2 Item2;

	public T3 Item3;

	public T4 Item4;

	public T5 Item5;
}
