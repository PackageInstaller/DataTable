namespace FlowCanvas.Nodes;

public class FlowCanvasLogicFuncHelper
{
	public static void CopyAllAttributeToOther(SimContext simContext, int srcEntityID, int dstEntityID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(srcEntityID);
		SimEntity entityWithEntityID2 = simContext.GetEntityWithEntityID(dstEntityID);
		AttributeProcessor.DeepCopyAttributeToOther(entityWithEntityID, entityWithEntityID2);
	}

	public static bool RandomEvent(int p)
	{
		if (DRandom.Random(100u) < p)
		{
			return true;
		}
		return false;
	}
}
