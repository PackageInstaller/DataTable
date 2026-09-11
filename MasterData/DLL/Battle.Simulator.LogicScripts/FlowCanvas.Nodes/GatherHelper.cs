using Config;

namespace FlowCanvas.Nodes;

public class GatherHelper
{
	public static bool TryGetBeGatherValue(SimEntity pSimEntity, out int pValue)
	{
		pValue = 0;
		if (pSimEntity == null || !pSimEntity.hasEntityConfig)
		{
			return false;
		}
		bool attributeWithIntName = AttributeProcessor.GetAttributeWithIntName(pSimEntity.entityBlackboard.var.mAttributeID, 2219, out var baseValue, out var _, out var _);
		pValue = (int)baseValue;
		if (!attributeWithIntName)
		{
			charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(pSimEntity.entityConfig.mId);
			pValue = config.BeGatherValue;
		}
		return true;
	}
}
