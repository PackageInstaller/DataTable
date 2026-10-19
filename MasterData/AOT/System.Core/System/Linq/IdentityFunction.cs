namespace System.Linq;

internal class IdentityFunction<TElement>
{
	public static Func<TElement, TElement> Instance => (TElement x) => x;
}
