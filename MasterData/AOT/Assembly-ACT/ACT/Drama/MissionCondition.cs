using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using UnityEngine;

namespace ACT.Drama;

public class MissionCondition : BaseCondition
{
	public int id;

	public override bool Check()
	{
		if (G.localPlayer.Missions.Find((MissionState x) => (float)x.Id == Mathf.Floor(id / 100) && (x.CompletedSubmissions.ContainsKey(id) || x.Finished)) != null)
		{
			return true;
		}
		return false;
	}
}
