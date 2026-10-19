namespace UnityEngine.UI;

public interface LoopScrollMultiDataSource
{
	void ProvideData(ILoopScrollDataSource transform, int index);
}
