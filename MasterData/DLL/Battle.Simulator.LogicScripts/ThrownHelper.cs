using Config;

public class ThrownHelper
{
	public static bool TryGetThrownCollisionCheckInfo(int timelineID, int collisionCheckIndex, out ThrownCollisionCheckInfo thrownCollisionCheckInfo)
	{
		thrownCollisionCheckInfo = null;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(timelineID);
		if (config == null)
		{
			return false;
		}
		if (config.ThrownCollisionCheckInfoList.Count <= 0)
		{
			return false;
		}
		if (collisionCheckIndex < 0 || collisionCheckIndex >= config.ThrownCollisionCheckInfoList.Count)
		{
			return false;
		}
		thrownCollisionCheckInfo = config.ThrownCollisionCheckInfoList.get_Item(collisionCheckIndex);
		return true;
	}
}
