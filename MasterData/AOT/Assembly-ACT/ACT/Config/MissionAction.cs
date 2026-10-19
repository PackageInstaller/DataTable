using System;

namespace ACT.Config;

[Serializable]
public class MissionAction
{
	public readonly int id;

	public readonly int enumID;

	public readonly bool onlyInMissionWorld;

	public readonly string param = "";

	public MissionAction(int id, int enumID, bool onlyInMissionWorld, string param)
	{
		this.id = id;
		this.enumID = enumID;
		this.onlyInMissionWorld = onlyInMissionWorld;
		this.param = param;
	}
}
