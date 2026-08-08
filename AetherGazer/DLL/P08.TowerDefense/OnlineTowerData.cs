public class OnlineTowerData : IFramePooledObject
{
	public bool[] isSelect;

	public int[] id;

	public void OnEnterPool()
	{
		isSelect = null;
		id = null;
	}

	public void OnResetData()
	{
		isSelect = new bool[3];
		id = new int[3];
	}
}
