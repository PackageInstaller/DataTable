using System.Collections.Generic;

namespace AdventureBehaviour;

public class SearchData
{
	public List<LogicEntity> searchResult = new List<LogicEntity>(10);

	public int frameCount;

	public SearchData()
	{
		frameCount = LockStepManager.frameCount;
	}

	public void ResetData()
	{
		searchResult?.Clear();
		frameCount = LockStepManager.frameCount;
	}
}
