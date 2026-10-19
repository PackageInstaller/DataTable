namespace Bamboo.Chronos;

internal abstract class BaseUpdateActionInfo : TypeRecycle
{
	public abstract void Execute(int thousandth);
}
