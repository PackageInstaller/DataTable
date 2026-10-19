namespace System.Threading;

internal struct SparselyPopulatedArrayAddInfo<T> where T : class
{
	private SparselyPopulatedArrayFragment<T> _source;

	private int _index;

	internal SparselyPopulatedArrayFragment<T> Source => _source;

	internal int Index => _index;

	internal SparselyPopulatedArrayAddInfo(SparselyPopulatedArrayFragment<T> source, int index)
	{
		_source = source;
		_index = index;
	}
}
