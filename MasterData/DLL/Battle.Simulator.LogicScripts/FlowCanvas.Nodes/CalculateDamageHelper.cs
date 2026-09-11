namespace FlowCanvas.Nodes;

public class CalculateDamageHelper
{
	public static int GetAttributeID(int attributeID, SimEntity simEntity)
	{
		if (attributeID != -1)
		{
			return attributeID;
		}
		if (simEntity != null && simEntity.hasEntityBlackboard)
		{
			return simEntity.entityBlackboard.var.mAttributeID;
		}
		return -1;
	}
}
