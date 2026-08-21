namespace FlowCanvas.Nodes;

public class AstrolabeSuitFlowCanvasHelper
{
	public static bool CheckAstrolabeSuitEnable(SimContext simContext, int entityID, int astrolabeSuitID)
	{
		int num = 2023;
		int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityID);
		for (int i = 0; i < 27; i++)
		{
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, num + i, out var baseValue, out var _, out var _);
			if (baseValue == 0L)
			{
				break;
			}
			if (baseValue == astrolabeSuitID)
			{
				return true;
			}
		}
		return false;
	}

	public static bool CheckAstrolabeSuitEnableWithIntName(SimContext simContext, int entityID, int astrolabeSuitID)
	{
		AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityID), astrolabeSuitID, out var baseValue, out var _, out var _);
		if (baseValue != 0L)
		{
			return true;
		}
		return false;
	}
}
