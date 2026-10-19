using System;
using ACT.Game.Data;

namespace ACT.Game;

[Serializable]
public class LocalMissionState
{
	public int id;

	public bool finished;

	public int subId;

	public MissionState ToPB()
	{
		return new MissionState
		{
			Id = id,
			Ready = true,
			Finished = finished,
			SubMissionId = subId
		};
	}
}
