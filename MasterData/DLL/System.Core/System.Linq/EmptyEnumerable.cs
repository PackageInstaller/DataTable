namespace System.Linq;

internal class EmptyEnumerable<TElement>
{
	public static readonly TElement[] Instance = new TElement[0];
}
