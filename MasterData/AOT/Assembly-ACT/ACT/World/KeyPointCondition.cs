using ACT.Drama;
using Fundamental;

namespace ACT.World;

public class KeyPointCondition : ILoadCondition
{
	public int keyPointId;

	public bool Return()
	{
		return Singleton<ConversationManager>.instance.HaveKeyPoint(keyPointId);
	}
}
