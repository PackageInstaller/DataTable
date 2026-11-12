using System;

[Serializable]
public class tempActorHeartStonInfo
{
	public int actorId;

	public int stoneHeartLv;

	public void LoadFrom(tempActorHeartStonInfo other)
	{
		actorId = other.actorId;
		stoneHeartLv = other.stoneHeartLv;
	}
}
