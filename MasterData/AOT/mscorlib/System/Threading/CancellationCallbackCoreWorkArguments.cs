namespace System.Threading;

internal struct CancellationCallbackCoreWorkArguments(SparselyPopulatedArrayFragment<CancellationCallbackInfo> currArrayFragment, int currArrayIndex)
{
	internal SparselyPopulatedArrayFragment<CancellationCallbackInfo> _currArrayFragment = currArrayFragment;

	internal int _currArrayIndex = currArrayIndex;
}
