using System;
using ACT.Event;
using ACT.Game;
using Newtonsoft.Json.Linq;

namespace ACT.World.Asset;

[Serializable]
public class MissionCheck : IInteractVerification, IDataToBake
{
	public int missionId;

	public int subMissionId;

	bool IInteractVerification.Verify(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		if (G.localPlayer.TryGetMission(missionId, out var mission))
		{
			if (subMissionId >= 0)
			{
				return mission.SubMissionId == subMissionId;
			}
			return true;
		}
		return false;
	}

	public void Bake(object baker)
	{
	}

	public JToken ToToken()
	{
		return new JObject
		{
			{ "missionId", missionId },
			{ "subMissionId", subMissionId }
		};
	}
}
