using System.Collections.Generic;
using ACT.Game;
using Fundamental;

namespace ACT.Drama;

public class KeyPointCondition : BaseCondition
{
	public List<KeyPointState> keyPointStates = new List<KeyPointState>();

	public override bool Check()
	{
		_ = G.localPlayer.Achievements.Info.ConversationKeyPoints;
		return Singleton<ConversationManager>.instance.HaveKeyPoints(keyPointStates);
	}
}
